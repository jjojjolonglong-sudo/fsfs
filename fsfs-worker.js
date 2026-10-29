// fsfs 업로드 Worker — 쓰기 전용 (읽기는 R2 공개 주소로 직접 불러요)
// [Cloudflare 대시보드 설정]
//  - 바인딩: R2 버킷 연결, 변수 이름은 BUCKET
//  - 변수: SUPABASE_URL, SUPABASE_ANON_KEY, ALLOWED_ORIGINS(선택, 쉼표로 구분한 개발자 모드 주소)
const KEY = /^items\/[0-9a-f-]{36}\/(game|hires|thumb)\.[0-9a-f]{8}\.(webp|png)$/;
const TYPES = ['image/webp', 'image/png'];
const MAX = 5 * 1024 * 1024;

export default {
  async fetch(req, env) {
    const url = new URL(req.url);
    const origin = req.headers.get('Origin') || '';
    const allow = (env.ALLOWED_ORIGINS || '').split(',').map(s => s.trim()).filter(Boolean);
    const cors = {
      'Access-Control-Allow-Origin': allow.length ? (allow.includes(origin) ? origin : allow[0]) : '*',
      'Access-Control-Allow-Methods': 'GET,PUT,DELETE,OPTIONS',
      'Access-Control-Allow-Headers': 'Authorization,Content-Type',
      'Vary': 'Origin',
    };
    const out = (body, status = 200) =>
      new Response(JSON.stringify(body), { status, headers: { ...cors, 'Content-Type': 'application/json' } });

    if (req.method === 'OPTIONS') return new Response(null, { status: 204, headers: cors });

    // 관리자 확인: 사용자 토큰으로 fsfs_admin을 조회해서 본인 행이 나오면 관리자
    const auth = req.headers.get('Authorization') || '';
    if (!auth.startsWith('Bearer ')) return out({ error: '로그인이 필요해요' }, 401);
    const r = await fetch(env.SUPABASE_URL + '/rest/v1/fsfs_admin?select=user_id', {
      headers: { apikey: env.SUPABASE_ANON_KEY, Authorization: auth },
    });
    const rows = r.ok ? await r.json() : [];
    if (rows.length !== 1) return out({ error: '관리자만 사용할 수 있어요' }, 403);

    const key = url.searchParams.get('key') || '';

    if (url.pathname === '/upload' && req.method === 'PUT') {
      if (!KEY.test(key)) return out({ error: '허용되지 않는 파일 경로' }, 400);
      const ct = (req.headers.get('Content-Type') || '').split(';')[0];
      if (!TYPES.includes(ct)) return out({ error: 'webp/png만 올릴 수 있어요' }, 415);
      const buf = await req.arrayBuffer();
      if (buf.byteLength > MAX) return out({ error: '파일이 너무 커요 (최대 5MB)' }, 413);
      await env.BUCKET.put(key, buf, {
        httpMetadata: { contentType: ct, cacheControl: 'public, max-age=31536000, immutable' },
      });
      return out({ key });
    }

    if (url.pathname === '/asset' && req.method === 'DELETE') {
      if (!KEY.test(key)) return out({ error: '허용되지 않는 파일 경로' }, 400);
      await env.BUCKET.delete(key);
      return out({ deleted: key });
    }

    if (url.pathname === '/list' && req.method === 'GET') {
      const res = await env.BUCKET.list({ prefix: 'items/', cursor: url.searchParams.get('cursor') || undefined });
      return out({ keys: res.objects.map(o => o.key), truncated: res.truncated, cursor: res.cursor });
    }

    return out({ error: 'not found' }, 404);
  },
};
