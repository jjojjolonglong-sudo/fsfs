-- fsfs_more2.sql — 장소·행동 더하기, 만물상(잡동사니 바꾸기), 고양이 출몰 넓히기 (2026-11-15). 여러 번 실행해도 안전해요.
-- 1) 새 장소 유형
insert into fsfs_place_type(code,name,icon,sort) values ('t_river','강변','🌊',70),('t_alley','골목','🏮',71),('t_view','전망대','🔭',72),('t_junk','만물상','🧺',73),('t_comic','만화방','📖',74),('t_tarot','타로집','🔮',75),('t_garden','꽃밭','🌻',76),('t_stall','포장마차','🍢',77) on conflict (code) do nothing;
-- 2) 새 행동 (값·시간·장면은 관리자 > 행동에서 고쳐요)
insert into fsfs_action(code,name,icon,descr,kind,time_cost,time_min,energy,money,cond,effects,scene,sort) values
 ('river_walk','강변 걷기','🚶','','normal',1,30,-8,0,'{}','{}','[{"t":"물소리를 따라 걸었다. 생각이 물처럼 흘러갔다."}]',81),
 ('river_stone','물수제비 뜨기','🪨','','normal',1,15,2,0,'{}','{}','[{"t":"납작한 돌을 골라 던졌다. 퐁, 퐁, 퐁. 세 번 튀었다."}]',82),
 ('river_sit','강물 바라보기','🌊','','normal',1,30,8,0,'{}','{}','[{"t":"윤슬이 반짝였다. 아무것도 하지 않는 시간이 지나갔다."}]',83),
 ('alley_wander','골목 구경하기','🏮','','normal',1,20,0,0,'{}','{}','[{"t":"간판 불빛 사이를 천천히 걸었다. 어디선가 고소한 냄새가 났다."}]',84),
 ('alley_snack','길거리 간식 사 먹기','🍡','','normal',1,15,8,-2500,'{}','{}','[{"t":"뜨거운 걸 호호 불어 가며 먹었다. 이런 건 서서 먹어야 맛있다."}]',85),
 ('view_look','풍경 내려다보기','🔭','','normal',1,30,6,0,'{}','{}','[{"t":"동네가 손바닥만 하게 보였다. 저기 어디쯤이 우리 집이다."}]',86),
 ('view_shout','야호 외치기','📣','','normal',1,10,4,0,'{}','{}','[{"t":"「야호—」 조금 늦게 메아리가 돌아왔다. 괜히 웃음이 났다."}]',87),
 ('junk_swap','잡동사니 바꾸기','🧺','모아 둔 잡동사니를 퍼즐 조각 봉지나 인형으로 바꾸거나 팔아요.','junkshop',1,0,0,0,'{}','{}','[]',88),
 ('comic_read','만화책 보기','📖','','normal',1,60,10,-2000,'{}','{}','[{"t":"한 권만 보려고 했는데 정신을 차려 보니 다섯 권째였다."}]',89),
 ('comic_ramen','라면 먹으며 만화 보기','🍜','','normal',1,60,18,-4500,'{}','{}','[{"t":"만화방 라면은 왜 더 맛있을까. 국물 한 방울도 남기지 않았다."}]',90),
 ('tarot','타로 보기','🔮','카드를 한 장 뽑아 오늘의 한마디를 들어요.','fortune',1,20,0,-5000,'{}','{}','[]',91),
 ('garden_look','꽃 구경하기','🌼','','normal',1,20,5,0,'{}','{}','[{"t":"이름 모를 꽃 앞에 한참 쪼그려 앉아 있었다."}]',92),
 ('garden_water','꽃에 물 주기','💧','','normal',1,15,-3,0,'{}','{}','[{"t":"물뿌리개를 기울이자 흙냄새가 올라왔다. 잘 자라렴."}]',93),
 ('stall_eat','어묵 먹고 가기','🍢','','normal',1,15,10,-2000,'{}','{}','[{"t":"종이컵에 국물을 가득 받았다. 손끝부터 따뜻해졌다."}]',94),
 ('stall_chat','포장마차에서 한잔','🍶','','normal',1,60,3,-12000,'{"aff":[{"min":0,"npc":"*"}],"daily":false,"slots":[],"ranges":[]}','{"aff":[{"v":2,"npc":"*"}],"eph":0}','[{"t":"비닐 천막 아래서 이런저런 이야기를 했다. 김이 모락모락 올랐다."}]',95),
 ('cafe_alone','혼자 커피 마시기','☕','','normal',1,40,6,-4500,'{}','{}','[{"t":"창가 자리에 앉아 지나가는 사람들을 구경했다."}]',96),
 ('cvs_ramen','컵라면 먹고 가기','🍜','','normal',1,15,8,-1500,'{}','{}','[{"t":"3분을 기다리는 동안 창밖을 봤다. 편의점 컵라면은 배신하지 않는다."}]',97),
 ('roof_sky','하늘 올려다보기','☁️','','normal',1,30,7,0,'{}','{}','[{"t":"난간에 기대 하늘을 올려다봤다. 구름이 천천히 모양을 바꿨다."}]',98),
 ('bus_ride','버스 타고 한 바퀴','🚌','','normal',1,40,4,-1200,'{}','{}','[{"t":"맨 뒷자리에 앉아 동네를 한 바퀴 돌았다. 창밖이 영화처럼 지나갔다."}]',99),
 ('seesaw','시소 타기','🛝','','normal',1,10,2,0,'{}','{}','[{"t":"혼자 타는 시소는 올라가지 않는다. 그래도 한 번 앉아 봤다."}]',100),
 ('stretch','스트레칭하기','🤸','','normal',1,15,3,0,'{}','{}','[{"t":"팔다리를 쭉 늘였다. 어디선가 뚝 소리가 났다."}]',101),
 ('paper_gacha','종이 뽑기','🎟','문방구 앞 뽑기판. 무엇이 나올지 몰라요.','gacha',1,5,0,-500,'{}','{}','[]',102),
 ('laundry_wait','세탁기 돌아가는 것 구경하기','🫧','','normal',1,20,5,0,'{}','{}','[{"t":"빙글빙글 도는 빨래를 멍하니 봤다. 이상하게 마음이 편해진다."}]',103),
 ('pc_ramen','PC방 라면 먹기','🍜','','normal',1,20,12,-3500,'{}','{}','[{"t":"게임 화면을 보며 후루룩. 키보드에 국물이 튈 뻔했다."}]',104)
on conflict (code) do nothing;
insert into fsfs_place_type_action(type_code,action_code,sort) values
 ('t_river','river_walk',0),('t_river','river_stone',1),('t_river','river_sit',2),('t_alley','alley_wander',0),('t_alley','alley_snack',1),('t_view','view_look',0),('t_view','view_shout',1),
 ('t_junk','junk_swap',0),('t_comic','comic_read',0),('t_comic','comic_ramen',1),('t_tarot','tarot',0),('t_garden','garden_look',0),('t_garden','garden_water',1),('t_stall','stall_eat',0),('t_stall','stall_chat',1),
 ('cafe','cafe_alone',5),('tmw3koaln','cvs_ramen',5),('t_rooftop','roof_sky',5),('t_station','bus_ride',5),('t_playground','seesaw',5),('tsports','stretch',5),('park','garden_look',5),('t_stationery','paper_gacha',5),('t_laundry','laundry_wait',5),('t_pcroom','pc_ramen',5)
on conflict do nothing;
-- 3) 새 장소 (위치는 대충 잡은 값이에요. 관리자 > 마을에서 옮겨 주세요)
insert into fsfs_place(code,name,type_code,town,x,y,descr,open_ranges,sort,outdoor,cat) values
 ('p_river2','강변 산책로','t_river','town2',30,90,'물소리가 들리는 산책로예요.','[]',60,true,true),
 ('p_junk2','만물상','t_junk','town2',93,58,'없는 것 빼고 다 있어요. 잡동사니도 받아 줘요.','[[600,1140]]',61,true,true),
 ('p_garden2','동네 꽃밭','t_garden','town2',25,72,'누군가 정성껏 가꾸는 꽃밭이에요.','[]',62,true,true),
 ('p_comic2','까치 만화방','t_comic','town2',74,41,'책장 가득 만화책, 구석엔 라면 끓는 냄새.','[[600,1380]]',63,false,false),
 ('p_alley1','네온 뒷골목','t_alley','town1',41,56,'간판 불빛이 겹겹이 걸린 좁은 골목이에요.','[]',64,true,true),
 ('p_stall1','달빛 포장마차','t_stall','town1',66,84,'해가 지면 주황색 천막에 불이 켜져요.','[[1020,1439]]',65,true,true),
 ('p_tarot1','별자리 타로','t_tarot','town1',68,36,'보라색 커튼 너머에서 카드를 뽑아요.','[[780,1320]]',66,false,false),
 ('p_view3','뒷산 전망대','t_view','town3',62,30,'동네가 한눈에 내려다보여요.','[]',67,true,true),
 ('p_garden3','학교 텃밭','t_garden','town3',28,28,'상추와 방울토마토, 가장자리엔 꽃이 자라요.','[]',68,true,true),
 ('p_alley3','먹자골목','t_alley','town3',76,56,'하굣길 발걸음을 붙잡는 골목이에요.','[]',69,true,true)
on conflict (code) do nothing;
-- 4) 야외인데 야외 표시가 빠져 있던 곳 + 야외 장소는 모두 고양이가 올 수 있게
update fsfs_place set outdoor=true where code='pmvuky4zu' and not outdoor;
update fsfs_place set cat=true where outdoor and not cat and type_code<>'road';
-- 5) 고양이 일정: 고양이 출몰을 꺼 둔 가게(빵집·편의점·카페·꽃집·서점·식당·성소)를 가리키던 줄을 새 야외 장소로 바꾸고, 고양이마다 갈 곳을 한 군데씩 더해요
with m(old,n1,n2) as (values ('bakery','p_junk2','p_garden2'),('convenience','p_station2','p_river2'),('cafe','p_park_pond','p_park_play'),('flower','p_garden2','p_river2'),('bookstore','p_junk2','p_alley1'),('restaurant','p_alley1','p_stall1'),('pmw2z1u1r','p_alley3','p_garden3'),('pmw4mo587','p_view3','p_school_roof')),
c as (select n.id, coalesce(nullif(regexp_replace(n.code,'\D','','g'),''),'0')::int k, n.sched from fsfs_npc n where n.role='cat' and jsonb_typeof(n.sched)='array'),
r as (select c.id, jsonb_agg(case when m.old is null then e.x else jsonb_set(e.x,'{p}',to_jsonb(case when (c.k+e.o)%2=0 then m.n1 else m.n2 end)) end order by e.o) s
      from c, jsonb_array_elements(c.sched) with ordinality e(x,o) left join m on m.old=e.x->>'p' group by c.id)
update fsfs_npc n set sched=r.s from r where r.id=n.id and r.s is distinct from n.sched;
with x(i,p) as (values (0,'p_dept_roof'),(1,'p_office_roof'),(2,'p_school_roof'),(3,'p_amuse3'),(4,'p_view3'),(5,'p_stall1'),(6,'p_river2'),(7,'p_alley3'),(8,'p_garden3'),(9,'p_alley1')),
c as (select n.id, coalesce(nullif(regexp_replace(n.code,'\D','','g'),''),'0')::int k from fsfs_npc n where n.role='cat' and jsonb_typeof(n.sched)='array')
update fsfs_npc n set sched=n.sched||jsonb_build_array(jsonb_build_object('a',case when x.p='p_stall1' then 1080 else 540+(c.k%5)*120 end,'b',case when x.p='p_stall1' then 1380 else 840+(c.k%5)*120 end,'p',x.p))
from c join x on x.i=c.k%10 where c.id=n.id and not exists (select 1 from jsonb_array_elements(n.sched) e where e->>'p'=x.p);
