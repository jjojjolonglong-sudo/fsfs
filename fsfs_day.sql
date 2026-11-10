-- fsfs_day.sql (2026-11-10) — 다이어리 「하루 기록」 영구 보관
-- 한 판(세이브의 G.gid)마다, 게임 속 하루마다 한 줄. 세이브(G.dy)에는 최근 며칠만 두고 나머지는 여기서 읽어요.
create table if not exists public.fsfs_day (
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  gid text not null,            -- 한 판의 고유 번호 (새 게임마다 새로 생겨요)
  day integer not null,         -- 게임 속 날짜 번호 (G.day)
  data jsonb not null,          -- {e:[[분,글,횟수]],p:[장소],w:[인물],i:번 돈,o:쓴 돈,x:[날씨]}
  updated_at timestamptz not null default now(),
  primary key (user_id, gid, day)
);
alter table public.fsfs_day enable row level security;
drop policy if exists fsfs_day_own on public.fsfs_day;
create policy fsfs_day_own on public.fsfs_day for all to authenticated
  using (user_id = (select auth.uid())) with check (user_id = (select auth.uid()));
