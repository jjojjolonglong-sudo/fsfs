-- fsfs_clothes_routes.sql (2026-11-10) — 올린 의상 55벌의 획득 경로 + 의상 이벤트 5개 + 공개 처리
-- 여러 번 실행해도 안전해요 (같은 옷·같은 종류의 경로가 이미 있으면 건너뜀). 이름으로 옷을 찾아요.

-- 1) 획득 경로
with r(name,type,params) as (values
 -- 기본 지급
 ('기본뒤','starter','{}'),('기본머리앞','starter','{}'),('셔츠','starter','{}'),('기본탱크탑','starter','{}'),
 ('베이직슬랙스','starter','{}'),('기본양말','starter','{}'),('로퍼','starter','{}'),
 -- 미용실: 「모양 바꾸기·스타일링하기」 값에 포함 (가격은 표시용)
 ('단발펌뒤','shop','{"shop":"모든 미용실","price":0}'),('단발펌앞','shop','{"shop":"모든 미용실","price":0}'),
 ('땋은머리뒤','shop','{"shop":"모든 미용실","price":0}'),('땋은머리앞','shop','{"shop":"모든 미용실","price":0}'),
 ('옆사베기뒤','shop','{"shop":"모든 미용실","price":0}'),('옆사베기앞','shop','{"shop":"모든 미용실","price":0}'),
 ('처피뱅미디움롱뒤','shop','{"shop":"모든 미용실","price":0}'),('처피뱅앞','shop','{"shop":"모든 미용실","price":0}'),
 ('하이포니테일뒤','shop','{"shop":"모든 미용실","price":0}'),('하이포니테일앞','shop','{"shop":"모든 미용실","price":0}'),
 -- 럭셔리 옷가게 (이름과 달리 작은 보세 가게)
 ('반팔티','shop','{"shop":"럭셔리 옷가게","price":12000}'),('후드','shop','{"shop":"럭셔리 옷가게","price":25000}'),
 ('박시줄무늬티','shop','{"shop":"럭셔리 옷가게","price":18000}'),('민소매크롭티','shop','{"shop":"럭셔리 옷가게","price":14000}'),
 ('줄무늬크롭쫄티','shop','{"shop":"럭셔리 옷가게","price":16000}'),('꽃무늬크롭블라우스','shop','{"shop":"럭셔리 옷가게","price":24000}'),
 ('데님스키니','shop','{"shop":"럭셔리 옷가게","price":28000}'),('에이라인반바지','shop','{"shop":"럭셔리 옷가게","price":19000}'),
 ('롤업반바지','shop','{"shop":"럭셔리 옷가게","price":17000}'),
 -- 백화점 브랜드 매장
 ('브이넥니트','shop','{"shop":"브랜드 매장","price":39000}'),('폴라니트','shop','{"shop":"브랜드 매장","price":42000}'),
 ('리본블라우스','shop','{"shop":"브랜드 매장","price":36000}'),('벨트슬랙스','shop','{"shop":"브랜드 매장","price":45000}'),
 ('기본재킷','shop','{"shop":"브랜드 매장","price":59000}'),('숏코트','shop','{"shop":"브랜드 매장","price":79000}'),
 ('반코트','shop','{"shop":"브랜드 매장","price":89000}'),
 -- 신발·모자·양말
 ('운동화','shop','{"shop":"모든 신발 가게","price":29000}'),('컨버스','shop','{"shop":"모든 신발 가게","price":35000}'),
 ('발목워커','shop','{"shop":"모든 신발 가게","price":49000}'),('어그부츠','shop','{"shop":"모든 신발 가게","price":55000}'),
 ('밀짚모자','shop','{"shop":"모든 모자 가게","price":15000}'),('털방울모자','shop','{"shop":"모든 모자 가게","price":12000}'),
 ('장목양말','shop','{"shop":"모든 편의점","price":3000}'),
 -- 온라인 쇼핑 (택배)
 ('차이니즈블라우스','online','{"price":33000,"days":3}'),('체크남방','online','{"price":27000,"days":2}'),
 ('짝짝이양말','online','{"price":4000,"days":2}'),
 -- 백화점 공동구매
 ('땡땡이블라우스','groupbuy','{"price":22000,"need":20,"ship_days":3}'),('데미지드베기','groupbuy','{"price":26000,"need":15,"ship_days":4}'),
 ('레이어드티','groupbuy','{"price":21000,"need":12,"ship_days":3}'),
 -- 백화점 한정판 오픈런
 ('가죽반바지','limited','{"price":69000,"stock":5,"open_hour":10}'),('줄무늬크롭셔츠','limited','{"price":48000,"stock":3,"open_hour":11}'),
 ('벨트스키니','limited','{"price":55000,"stock":4,"open_hour":10}'),
 -- 알바 단계 (그 알바를 3번 하면 2단계 · 직원 혜택)
 ('단가라','job','{"job":"카페 알바","rank":2}'),('멜빵반바지','job','{"job":"놀이공원 알바","rank":2}'),
 ('데미지드반바지','job','{"job":"공연장 알바","rank":2}'),
 -- 인물 선물 (호감도)
 ('크롭글자티','gift','{"npc":"조슈아","affinity":60}'),('크로스끈크롭티','gift','{"npc":"나나","affinity":60}')
)
insert into fsfs_source (item_id,type,params,sort)
select i.id,r.type,r.params::jsonb,0 from r join fsfs_item i on i.name=r.name
where not exists (select 1 from fsfs_source s where s.item_id=i.id and s.type=r.type);

-- 2) 의상을 주는 이벤트 (effects.give = 옷 id)
with e(code,title,rep,chance,pr,cond,scene,money,aff,gives) as (values
 ('cl_ringo_red','[링고 60] 무대 뒤의 빨간 머리','once',60,60,
  '{"place":"pconcert","npc":"lv_5f42ccdd","aff":[{"min":60,"npc":"lv_5f42ccdd"}],"tod":"night","slots":[],"ranges":[]}',
  '[{"t":"공연이 끝난 무대 뒤. 링고가 거울 앞에서 빨간 가발을 벗어 내게 내밀었다.","who":""},{"t":"약속은 필요 없어. 대신 이건 가져가. 너한테 더 잘 어울릴 테니까.","who":"lv_5f42ccdd"},{"t":"거울 속 내 머리가 무대 조명처럼 붉게 빛났다.","who":""}]',
  0,'[{"v":2,"npc":"lv_5f42ccdd"}]',array['레드숏컷뒤','레드숏컷앞']),
 ('cl_pai_beanie','[파이 30] 눈 오는 날의 털모자','once',70,30,
  '{"place":"flower","npc":"lv_0b9e28f1","aff":[{"min":30,"npc":"lv_0b9e28f1"}],"wx":"snow","slots":[],"ranges":[]}',
  '[{"t":"꽃집 유리문에 눈송이가 붙었다. 파이가 서랍에서 털방울이 달린 모자를 꺼냈다.","who":""},{"t":"멀리 갈 때 쓰려고 했는데… 너 귀가 빨개.","who":"lv_0b9e28f1"},{"t":"모자는 아직 따뜻했다.","who":""}]',
  0,'[{"v":2,"npc":"lv_0b9e28f1"}]',array['털방울모자']),
 ('cl_maxi_hood','[막시민 30] 비 오는 날 빌린 후드','once',70,30,
  '{"place":"cafe","npc":"lv_25137f68","aff":[{"min":30,"npc":"lv_25137f68"}],"wx":"rain","slots":[],"ranges":[]}',
  '[{"t":"카페 창밖으로 비가 쏟아졌다. 우산이 없다고 하자 막시민이 의자에 걸쳐 둔 후드를 툭 던졌다.","who":""},{"t":"난 귀찮은 놈이야. 돌려주러 오는 것도 귀찮으니까 그냥 가져. 에취!","who":"lv_25137f68"}]',
  0,'[{"v":2,"npc":"lv_25137f68"}]',array['후드']),
 ('cl_summer_hat','[여름] 공원 벤치의 밀짚모자','once',35,10,
  '{"place":"park","from":"06-20","to":"08-31","wx":"clear","tod":"day","slots":[],"ranges":[]}',
  '[{"t":"햇볕이 쨍한 오후, 벤치 위에 밀짚모자 하나가 놓여 있었다.","who":""},{"t":"한참을 기다려도 주인은 오지 않았다. 쪽지가 끼워져 있다. ‘필요한 사람이 가져가세요.’","who":""}]',
  0,'[]',array['밀짚모자']),
 ('cl_flea_socks','[정류장] 벼룩시장 좌판','once',30,5,
  '{"place":"p_station2","tod":"day","slots":[],"ranges":[]}',
  '[{"t":"정류장 옆에 작은 벼룩시장 좌판이 펼쳐져 있었다.","who":""},{"t":"짝이 안 맞는 양말 한 켤레가 이천 원. 이상하게 그게 제일 마음에 들었다.","who":""}]',
  -2000,'[]',array['짝짝이양말'])
)
insert into fsfs_event (code,title,enabled,repeat_mode,chance,priority,cond,scene,effects,note)
select e.code,e.title,true,e.rep,e.chance,e.pr,e.cond::jsonb,e.scene::jsonb,
 jsonb_build_object('money',e.money,'aff',e.aff::jsonb,'give',(select coalesce(jsonb_agg(i.id),'[]'::jsonb) from fsfs_item i where i.name=any(e.gives))),
 '의상 보상 이벤트 (fsfs_clothes_routes.sql)'
from e where not exists (select 1 from fsfs_event x where x.code=e.code);

-- 3) 모두 공개
update fsfs_item set is_published=true where is_published=false;
