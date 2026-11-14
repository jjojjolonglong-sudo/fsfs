-- fsfs_arcade.sql — 오락실 미니게임(인형 뽑기·두더지 잡기·룰렛 가차) · 인형 · 퍼즐 조각 봉지 (2026-11-15). 여러 번 실행해도 안전해요.
-- 1) 오락실 행동: 「인형 뽑기」를 미니게임으로 바꾸고, 두더지 잡기·룰렛 가차를 더해요 (값·시간은 관리자 > 행동에서 바꿔요)
update fsfs_action set kind='claw', descr='집게가 인형 한가운데에 왔을 때 내려 보세요.' where code='claw' and kind='normal';
insert into fsfs_action(code,name,icon,descr,kind,time_cost,time_min,energy,money,cond,effects,sort) values
 ('mole','두더지 잡기','🔨','20초 동안 튀어나오는 두더지를 잡아요. 많이 잡으면 선물이 있어요.','mole',1,5,0,-500,'{}','{}',71),
 ('gacha','룰렛 가차','🎰','룰렛을 돌려 인형·조각 봉지·잡동사니를 뽑아요.','gacha',1,5,0,-1000,'{}','{}',72) on conflict (code) do nothing;
insert into fsfs_place_type_action(type_code,action_code,sort) values ('t_arcade','mole',5),('t_arcade','gacha',6) on conflict do nothing;
-- 2) 인형 (effects.doll: 1 = 흔함, 숫자가 클수록 드물어요). 지금은 이모지예요. 관리자 > 아이템에서 고쳐요
insert into fsfs_goods(kind,name,descr,icon,consume,effects,sort)
select 'misc',v.n,'오락실에서 뽑은 인형. 장식장에 놓을 수 있어요.',v.i,false,jsonb_build_object('doll',v.r),300+v.s
from (values ('곰 인형','🧸',1,0),('토끼 인형','🐰',1,1),('강아지 인형','🐶',1,2),('고양이 인형','🐱',1,3),('병아리 인형','🐥',1,4),('개구리 인형','🐸',1,5),('펭귄 인형','🐧',2,6),('판다 인형','🐼',2,7),('여우 인형','🦊',2,8),('문어 인형','🐙',2,9),('공룡 인형','🦖',3,10),('유니콘 인형','🦄',3,11)) v(n,i,r,s)
where not exists (select 1 from fsfs_goods g where g.name=v.n);
-- 3) 퍼즐 조각 봉지 (effects.pz: 받는 즉시 뜯어서 5~10조각이 돼요). 문방구에서도 팔아요
insert into fsfs_goods(kind,name,descr,icon,consume,effects,sort)
select 'misc','퍼즐 조각 봉지','퍼즐 조각이 5~10개 들어 있어요. 받으면 바로 뜯어요.','🧩',false,'{"pz":1}',320 where not exists (select 1 from fsfs_goods where effects ? 'pz');
insert into fsfs_source(goods_id,type,params,conditions,sort)
select g.id,'shop','{"shop":"모든 문방구","price":2500}','{}',0 from fsfs_goods g where g.effects ? 'pz' and not exists (select 1 from fsfs_source s where s.goods_id=g.id);
