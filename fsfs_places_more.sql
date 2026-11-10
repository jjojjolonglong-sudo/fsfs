-- fsfs_places_more.sql (2026-11-10) — 장소 유형·행동·장소·하위 장소·가게 물건 추가
-- 여러 번 실행해도 안전해요 (이미 있는 코드·이름은 건너뜀). 장소 위치(x,y)는 대충 잡아 둔 값이라 관리자 > 마을에서 옮겨 주세요.

-- 1) 장소 유형
insert into fsfs_place_type (code,name,icon,sort) values
 ('t_amuse','놀이공원','🎡',40),('t_arcade','오락실','👾',41),('t_karaoke','노래방','🎙',42),('t_photo','스티커 사진관','📸',43),
 ('t_bath','찜질방','♨️',44),('t_stationery','문방구','✏️',45),('t_record','레코드 가게','💿',46),('t_pcroom','PC방','🖥',47),
 ('t_snack','분식집','🍢',48),('t_laundry','빨래방','🫧',49),('t_rooftop','옥상','🌇',50),('t_pharmacy','약국','💊',51),
 ('t_playground','놀이터','🛝',52),('t_station','버스 정류장','🚏',53)
on conflict (code) do nothing;

-- 2) 행동
insert into fsfs_action (code,name,icon,descr,kind,time_min,energy,money,cond,effects,scene,sort) values
 ('ride_coaster','롤러코스터 타기','🎢','소리 지르면서 스트레스를 날려요.','normal',30,-10,-8000,'{}','{}','[{"t":"꼭대기에서 잠깐 멈춘 순간, 숨을 참았다. 그리고 세상이 뒤집혔다."}]',60),
 ('ride_wheel','관람차 타기','🎡','천천히 올라가 마을을 내려다봐요.','normal',30,5,-6000,'{}','{}','[{"t":"꼭대기에 오르자 동네 세 곳이 한눈에 들어왔다. 우리 집은 저쯤일까."}]',61),
 ('ride_carousel','회전목마 타기','🎠','빙글빙글, 음악에 맞춰 돌아요.','normal',20,3,-4000,'{}','{}','[{"t":"오르락내리락하는 말 위에서 괜히 웃음이 났다."}]',62),
 ('job_amuse','놀이공원 알바','🎈','풍선을 나눠 주고 줄을 정리해요. 4시간 · 하루 한 번 · 10~14시에 시작','normal',240,-25,34000,'{"daily":true,"ranges":[[600,840]]}','{}','[{"t":"풍선 백 개를 나눠 주고 나니 손에 고무 냄새가 뱄다."}]',63),
 ('arcade_play','오락 한 판','🕹','동전 하나로 한 판 해요.','normal',30,-3,-500,'{}','{}','[{"t":"마지막 목숨에서 끝판 왕을 만났다. GAME OVER. 동전을 하나 더 꺼냈다."}]',64),
 ('claw','인형 뽑기','🧸','될 듯 말 듯 집게를 내려요.','normal',10,0,-1000,'{}','{}','[{"t":"집게가 인형 귀를 스치고 지나갔다. 다음엔 될 것 같은데."}]',65),
 ('sing','노래 부르기','🎤','목청껏 한 시간 불러요.','normal',60,-5,-12000,'{}','{}','[{"t":"마이크를 잡으니 아는 노래가 다 생각났다. 점수는 98점."}]',66),
 ('sticker_photo','스티커 사진 찍기','📸','포즈를 잡고 찰칵, 꾸미기까지.','normal',15,0,-3000,'{}','{}','[{"t":"하나, 둘, 셋 — 찰칵. 눈 감은 사진이 제일 마음에 들었다."}]',67),
 ('bath','목욕하기','🛁','뜨끈한 탕에 몸을 담가요.','normal',60,15,-8000,'{}','{}','[{"t":"뜨거운 물에 들어가자 \"어어\" 소리가 절로 나왔다."}]',68),
 ('sauna_nap','찜질방에서 한숨 자기','😴','양머리를 하고 바닥에 누워 자요.','normal',120,20,0,'{}','{}','[{"t":"따뜻한 바닥에 누워 눈을 감았다. 누군가 계란 까는 소리가 들렸다."}]',69),
 ('listen_record','음반 들어보기','🎧','헤드폰을 끼고 시청용 음반을 들어요.','normal',30,3,0,'{}','{}','[{"t":"모르는 밴드의 B면 곡이 오늘따라 귀에 꽂혔다."}]',70),
 ('pc_play','PC방에서 놀기','🖥','한 시간 컴퓨터를 해요.','normal',60,-5,-1000,'{}','{}','[{"t":"채팅창에 \"ㅋㅋㅋ\"만 치다가 한 시간이 지났다."}]',71),
 ('laundry','빨래 돌리기','🫧','세탁기가 도는 걸 보며 기다려요.','normal',60,0,-3000,'{}','{}','[{"t":"동그란 창 너머로 빨래가 빙글빙글 돈다. 보고 있으면 이상하게 마음이 편하다."}]',72),
 ('rooftop_air','바람 쐬기','🌬','옥상 난간에 기대 바람을 맞아요.','normal',20,5,0,'{}','{}','[{"t":"높은 데서 부는 바람은 아래랑 냄새가 다르다."}]',73),
 ('swing','그네 타기','🛝','발을 굴러 높이 올라가요.','normal',15,3,0,'{}','{}','[{"t":"발끝이 하늘에 닿을 것 같았다. 어릴 때보다 그네가 작아졌다."}]',74),
 ('wait_bus','멍하니 앉아 있기','🚏','정류장 의자에 앉아 오가는 버스를 봐요.','normal',20,3,0,'{}','{}','[{"t":"버스가 세 대 지나갔다. 어느 것도 타지 않았다."}]',75)
on conflict (code) do nothing;

-- 3) 유형별 행동
insert into fsfs_place_type_action (type_code,action_code,sort) values
 ('t_amuse','ride_coaster',0),('t_amuse','ride_wheel',1),('t_amuse','ride_carousel',2),('t_amuse','shop',3),('t_amuse','job_amuse',4),
 ('t_arcade','arcade_play',0),('t_arcade','claw',1),
 ('t_karaoke','sing',0),
 ('t_photo','sticker_photo',0),
 ('t_bath','bath',0),('t_bath','sauna_nap',1),('t_bath','menu',2),
 ('t_stationery','shop',0),
 ('t_record','listen_record',0),('t_record','shop',1),
 ('t_pcroom','pc_play',0),
 ('t_snack','menu',0),('t_snack','meal_together',1),
 ('t_laundry','laundry',0),
 ('t_rooftop','rooftop_air',0),
 ('t_pharmacy','shop',0),
 ('t_playground','swing',0),('t_playground','bench',1),
 ('t_station','wait_bus',0)
on conflict do nothing;

-- 4) 장소 (상위 장소 → 하위 장소 순서. 하위 장소의 위치·동네는 상위 장소를 따라가요)
insert into fsfs_place (code,name,type_code,town,parent_code,x,y,open_ranges,outdoor,cat,descr,sort) values
 -- 네온타운 (town1)
 ('p_karaoke1','별빛 노래방','t_karaoke','town1',null,38,46,'[[1020,240]]',false,false,'방음이 잘 안 돼서 옆방 노래가 다 들려요.',10),
 ('p_bath1','네온 찜질방','t_bath','town1',null,70,40,'[]',false,false,'24시간 불이 꺼지지 않는 찜질방이에요.',11),
 ('p_record1','LP 레코드','t_record','town1',null,33,72,'[[720,1320]]',false,false,'먼지 냄새 나는 음반이 빼곡해요.',12),
 ('p_pharm1','네온 약국','t_pharmacy','town1',null,60,30,'[[540,1320]]',false,false,'야근하는 사람들이 박카스를 사 가요.',13),
 ('p_pcroom1','블루 PC방','t_pcroom','town1',null,44,20,'[]',false,false,'키보드 소리가 끊이지 않아요.',14),
 -- 비비타운 (town2)
 ('p_station2','비비 정류장','t_station','town2',null,30,62,'[]',true,true,'파란 의자 세 개가 놓인 버스 정류장이에요.',20),
 ('p_laundry2','코인 빨래방','t_laundry','town2',null,18,70,'[]',false,false,'섬유유연제 냄새가 포근해요.',21),
 ('p_stationery2','꼬마 문방구','t_stationery','town2',null,78,60,'[[540,1200]]',false,false,'불량식품과 스티커가 가득해요.',22),
 ('p_pharm2','비비 약국','t_pharmacy','town2',null,88,50,'[[540,1260]]',false,false,'친절한 약사님이 사탕을 하나씩 줘요.',23),
 -- 영타운 (town3)
 ('p_amuse3','드림랜드','t_amuse','town3',null,70,75,'[[600,1320]]',true,true,'멀리서도 관람차가 보이는 놀이공원이에요.',30),
 ('p_arcade3','용용 오락실','t_arcade','town3',null,25,25,'[[660,1380]]',false,false,'뿅뿅 소리와 동전 소리가 섞여요.',31),
 ('p_snack3','학교 앞 분식집','t_snack','town3',null,28,58,'[[660,1260]]',false,false,'떡볶이 국물이 끓는 냄새가 나요.',32),
 ('p_karaoke3','코인 노래방','t_karaoke','town3',null,62,40,'[[720,120]]',false,false,'한 곡에 오백 원, 학생들의 아지트예요.',33),
 ('p_stationery3','학교 앞 문방구','t_stationery','town3',null,33,68,'[[480,1140]]',false,false,'준비물은 여기서 다 살 수 있어요.',34)
on conflict (code) do nothing;

insert into fsfs_place (code,name,type_code,town,parent_code,x,y,open_ranges,outdoor,cat,descr,sort)
select v.code,v.name,v.type_code,p.town,v.parent_code,p.x,p.y,v.open_ranges::jsonb,v.outdoor,v.cat,v.descr,v.sort
from (values
 -- 오피스 타워
 ('p_office_roof','오피스 옥상','t_rooftop','pmw26stmr','[]',true,true,'담배 냄새와 한숨이 섞인 옥상이에요.',40),
 ('p_office_cafeteria','구내식당','restaurant','pmw26stmr','[[690,810]]',false,false,'점심시간에만 문을 여는 구내식당이에요.',41),
 ('p_office_cafe','1층 카페','cafe','pmw26stmr','[[450,1140]]',false,false,'출근길 줄이 가장 긴 카페예요.',42),
 -- 레트로 백화점
 ('p_dept_brand','브랜드 매장','clothes','pdept','[[630,1230]]',false,false,'반짝이는 조명 아래 신상이 걸려 있어요.',43),
 ('p_dept_food','식품관','store','pdept','[[630,1230]]',false,false,'시식 코너를 한 바퀴 돌 수 있어요.',44),
 ('p_dept_roof','옥상 정원','t_rooftop','pdept','[[630,1230]]',true,true,'백화점 꼭대기의 작은 정원이에요.',45),
 -- 비비마트
 ('p_mart_food','푸드코트','restaurant','pmw54oxxi','[[660,1200]]',false,false,'쟁반을 들고 자리를 찾아요.',46),
 ('p_mart_photo','스티커 사진관','t_photo','pmw54oxxi','[[600,1260]]',false,false,'꾸미기 펜이 다 말라 있어요.',47),
 -- 비비 공원
 ('p_park_play','놀이터','t_playground','park','[]',true,true,'모래밭과 그네가 있는 작은 놀이터예요.',48),
 ('p_park_pond','연못가','trest','park','[]',true,true,'잉어가 입을 뻐끔거려요.',49),
 -- 모두의 학교
 ('p_school_cafeteria','학생식당','restaurant','pmw2yor2w','[[690,1140]]',false,false,'오늘의 메뉴는 늘 비슷해요.',50),
 ('p_school_club','동아리방','trest','pmw2yor2w','[]',false,false,'낡은 소파와 기타 한 대가 있어요.',51),
 ('p_school_roof','학교 옥상','t_rooftop','pmw2yor2w','[]',true,true,'원래 출입 금지예요. 쉿.',52),
 ('p_school_shop','매점','tmw3koaln','pmw2yor2w','[[540,1080]]',false,false,'쉬는 시간마다 줄이 길어요.',53)
) as v(code,name,type_code,parent_code,open_ranges,outdoor,cat,descr,sort)
join fsfs_place p on p.code=v.parent_code
on conflict (code) do nothing;

-- 5) 새 가게에서 파는 물건 (같은 이름이 이미 있으면 건너뜀)
with g(name,kind,icon,consume,effects,descr,shop,price,sort) as (values
 ('스티커 세트','misc','🌟',false,'{}','반짝이 스티커 한 장. 어디에 붙일까요?','모든 문방구',500,200),
 ('줄공책','misc','📓',false,'{}','표지에 영어 문장이 적힌 공책.','모든 문방구',1000,201),
 ('편지지 세트','misc','✉️',false,'{}','봉투까지 들어 있는 편지지예요.','모든 문방구',1500,202),
 ('형광펜','misc','🖍',false,'{}','중요한 데에 밑줄을 그어요.','모든 문방구',800,203),
 ('불량식품','food','🍬',true,'{"energy":3,"memo":"혀가 파랗게 물들었어요."}','100원짜리의 추억.','모든 문방구',200,204),
 ('비타민','food','💊',true,'{"energy":5,"memo":"왠지 힘이 나는 것 같아요."}','하루 한 알.','모든 약국',3000,210),
 ('박카스','food','🧪',true,'{"energy":8,"memo":"피로야 가라!"}','작은 갈색 병.','모든 약국',700,211),
 ('반창고','misc','🩹',false,'{}','캐릭터 그림이 있는 반창고예요.','모든 약국',1000,212),
 ('떡볶이','food','🌶',true,'{"energy":15,"memo":"맵지만 멈출 수 없어요."}','빨간 국물이 자작한 떡볶이.','모든 분식집',3000,220),
 ('김밥','food','🍙',true,'{"energy":12,"memo":"꼬다리가 제일 맛있어요."}','은박지에 싼 김밥 한 줄.','모든 분식집',2000,221),
 ('순대','food','🫘',true,'{"energy":12,"memo":"소금에 콕 찍어 먹어요."}','간이랑 허파도 조금.','모든 분식집',2500,222),
 ('어묵꼬치','food','🍢',true,'{"energy":5,"memo":"국물 한 컵이 더 맛있어요."}','뜨끈한 국물도 같이 줘요.','모든 분식집',1000,223),
 ('식혜','food','🥤',true,'{"energy":6,"memo":"살얼음이 사각사각."}','찜질방에선 식혜죠.','모든 찜질방',2000,230),
 ('맥반석 계란','food','🥚',true,'{"energy":8,"memo":"이마에 깨면 국룰."}','갈색으로 구운 계란 두 알.','모든 찜질방',1500,231),
 ('솜사탕','food','🍭',true,'{"energy":6,"memo":"입에 넣자마자 사라져요."}','분홍 구름 같은 솜사탕.','모든 놀이공원',2000,240),
 ('츄러스','food','🥖',true,'{"energy":8,"memo":"설탕이 옷에 다 묻었어요."}','시나몬 설탕을 뿌린 츄러스.','모든 놀이공원',2500,241),
 ('놀이공원 머리띠','misc','🎀',false,'{}','여기서만 쓸 수 있는 용기.','모든 놀이공원',5000,242),
 ('공테이프','misc','📼',false,'{}','좋아하는 노래를 녹음해 둘까요?','모든 레코드 가게',1000,250),
 ('이어폰','misc','🎧',false,'{}','줄이 자꾸 엉켜요.','모든 레코드 가게',8000,251)
), ins as (
 insert into fsfs_goods (name,kind,icon,consume,effects,descr,sort)
 select name,kind,icon,consume,effects::jsonb,descr,sort from g where not exists (select 1 from fsfs_goods x where x.name=g.name)
 returning id,name)
insert into fsfs_source (goods_id,type,params,sort)
select ins.id,'shop',jsonb_build_object('shop',g.shop,'price',g.price),0 from ins join g on g.name=ins.name;
