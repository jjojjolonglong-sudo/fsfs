# fsfs — 시티 오브 레트로 (옷갈아입히기에서 발전한 마을 게임)

fsfs 저장소에서 일할 때 읽는 안내서예요. 사용자와 일하는 방식, 공용 파일(mnmn), 커밋·푸시 규칙은 상위 폴더의 공통 `CLAUDE.md`를 따르고, 여기에는 fsfs만의 내용을 적어요. (이 파일을 fsfs 저장소 맨 위에 `CLAUDE.md`라는 이름으로 두세요.)

## fsfs에서 특히 지킬 것
- UI 정렬·테두리·여백에 매우 예민해요. 화면을 건드리면 스크린샷(deviceScaleFactor 2)으로 직접 확인하고 "한 번에" 맞춰 주세요.
- 이미지를 잘라 낼 때는 가장자리에 흰 여백이 남지 않게. AI 업스케일(Real-ESRGAN 류)은 쓰지 않아요.
- 게임 화면은 1920×1080 기준으로 `#game`(1380×1080)을 고정 배치해요. 배치 비율을 함부로 바꾸지 마세요.
- 마을 지도 3장(`map-town1~3.webp`)은 repo에 있고, 장소 안쪽 그림 등은 R2에 있어요(작업 환경에서 안 열릴 수 있어요).

## 저장소
- `index.html` 한 파일이 게임 전체예요. GitHub Pages로 서비스해요.
- 공용 스크립트와 소리는 mnmn 저장소(`config.js`, `fonts.v1.js`, `media.v1/v2.js`, `mvtape.v1.js`, `click.wav`, `get.wav`)에서 불러와요.

## 값이 어디에 있나 (가장 중요)
1. **앱 코드(`index.html`)** — 규칙·공식·고정 기능. 고치려면 파일을 고쳐요.
2. **테이블(Supabase `fsfs_*`)** — 의상·장소·인물·행동·이벤트·아이템 같은 내용물. 인앱 관리자 화면에서 편집해요. **테이블에 값이 있으면 코드의 기본값(`WORLD` 등)을 덮어써요.**
3. **세이브** — 브라우저 `localStorage` + `fsfs_save`(슬롯 5개, `user_id,slot`으로 upsert). `G`에 새 필드를 추가하면 **`normG()`에 기본값을 꼭 넣어요** (옛 세이브가 깨지지 않게).
- 자세한 지도는 claude.ai 문서 "fsfs 값 관리 지도"에 있어요. 값이 어디 있는지가 바뀌는 작업을 하면 사용자에게 알려서 그 문서도 같이 갱신해요.

## 다른 앱 데이터 (읽기 전용)
- 같은 Supabase 프로젝트, 같은 로그인이에요.
- bkbk → 서점·도서관·선반의 책(완독한 책만, `bkLoad()`)
- mvmv → 영화관·비디오(`mvLoad()`)
- lvlv → 인물(NPC) 자동 동기화
- cdcd → 음악
- mgwg → 배달 가게·디저트 이름(`mgwLoad()`)
- wkwk → 대작가 출간작(`wkLoad()`)
- 다른 앱의 테이블은 fsfs에서 고치지 않아요. 수정은 그 앱에서만.
- 이미지(표지·썸네일)는 mnmn 방식: 해시 16자 키 → `MEDIA_BASE/o/images/<해시>.webp`.

## 코드 안내 (`index.html`에서 찾을 이름)
- 흐름: `renderWorld()`(화면), `actionsAt(pid)`(장소의 행동), `doAction(a)`(`a.kind`별 분기), `applyActions()`(코드 기본 + DB 행동 합치기, DB 우선), `pass(분)`(시간), `earn(돈)`, `after()`(후처리).
- 행동 종류(`kind`): normal, group(묶음), closet, call, bagfood, shrine, shop, status, delivery, onlineshop, mybooks(선반), soon …
- 배달·택배: `G.dlv`(주문) → `checkDlv()` → `G.wait`(집에 도착해 기다림) → 집에 있으면 `collectWait()`가 가방(`G.bag`)·옷장(`G.owned`)에 넣어요. 집 밖이면 "[메시지] 주문하신 음식/물건이 도착했어요." 알림만 떠요.
- 옷장 요금: 입어보기는 열 때, 염색·모양·스타일링은 닫을 때 바뀐 게 있을 때만 받아요(`CL.fee`, `closeCl()`).
- 서점: `openBookShop()` — bkbk 완독 책 + wkwk 출간작. 최근 30일(현실 날짜, KST) 안에 출간된 책은 "신간" 코너. 책 id가 `wk:`로 시작하면 대작가의 책이고 필명만 보여요. 게임 속 날짜(2027-03-01 시작)와는 무관해요. 접속·로그인 때 새 신간이 있으면 알림(`wkAnnounce()`, `G.wkSeen`).
- 선반 `openMixShelf()`, 계절 효과 `fx*` 함수들, 세이브 `saveGame()`·`cloudPut()`·`syncSave()`.
- NPC 집: 장소 유형 `npchome`(남의 집 현관)·`npcroom`(초대받은 방). 장소에 `owners`(집주인 NPC id 배열)와 `enter_aff`(초대 호감도, 기본 20)가 있어요(`fsfs_npc_home.sql`). 현관→하위 장소는 `homeGate()`가 막아요: 집주인이 그 집(현관·방)에 있어야 하고, 주인의 호감도 ≥ `enter_aff`여야 들어가요. 차 마시기(`visit_tea`)·자고 가기(`stay_over`)는 행동 테이블의 호감도 조건으로 조절해요. 집주인이 나타나는 시간은 NPC 출몰 일정으로 정해요.
- 야외 설정은 모든 장소(하위 장소 포함)에서 `outdoor`로 켜요. 영화관 포스터 전시관(`posterhall`)은 들어가면 포스터가 바로 열려요(`.mvp` 127px). 기록된 장면이 없는 영화는 `blackout()` 후 "재밌게 봤다" 류 문구를 띄워요.
- 인물 `role`: `fan`(덕질 인물), `author`(대작가 — 일정·직장·썸네일 없이 어디에도 안 나타나는 숨은 인물, `fsfs_author.sql`로 만들어요).

## 하지 않기로 한 것
이장·광고판·속보 신문, 마을 위를 걸어 다니는 NPC 아바타, 허기 파라미터(에너지만 사용), 식당·카페에서 먹는 행동, 하루 자면 들어오는 기본 수입(돈은 행동으로만).

## 고친 뒤 확인
1. `index.html`에서 가장 큰 `<script>`를 떼어 `node --check`로 문법 확인.
2. Playwright(크로미움)로 열어서 `pageerror`가 없는지 확인하고, 건드린 기능을 직접 눌러 봐요. 화면을 바꿨으면 스크린샷으로 정렬 확인.
3. 새 SQL은 `fsfs_<이름>.sql`로 만들고 여러 번 실행해도 안전하게(`if not exists`, `on conflict`) 써요. 사용자가 Supabase SQL Editor에서 직접 실행해요.
4. 값 위치나 규칙이 바뀌면 이 파일과 "fsfs 값 관리 지도"를 갱신해요.
