-- 길 위(숨겨진 고정 장소) + 우연한 마주침 이벤트 (여러 번 실행해도 안전해요)
-- 장소 코드 road: 지도에 나오지 않고, 이동 도중 가끔 열리는 이벤트의 배경이에요. 장소 표에서 그림을 올릴 수 있어요.
insert into public.fsfs_place(code,name,icon,descr,x,y,type_code,outdoor)
select 'road','길 위','🚶','어딘가로 가는 길 위예요. 우연히 누군가를 만날지도 몰라요.',50,50,'road',true
where not exists(select 1 from public.fsfs_place where code='road');

insert into public.fsfs_event(code,title,enabled,repeat_mode,chance,priority,note,cond,scene,effects)
select 'rd_umbrella','[길 위] 처마 밑에서',true,'daily',100,0,'비 오는 날 · 우산을 나눠 쓰는 이웃',$j${"place": "road", "npc": null, "ranges": [], "slots": [], "from": null, "to": null, "bday": null, "aff": [], "wx": "rain"}$j$::jsonb,$j$[{"t": "갑자기 빗줄기가 굵어져서 가까운 처마 밑으로 뛰어들었다."}, {"t": "옆에 서 있던 사람이 우산을 반쯤 기울여 주었다."}, {"choices": [{"t": "고맙습니다, 같이 쓸게요", "aff": {}, "reply": [{"t": "“어차피 가는 방향이 같네요.” 잠깐 같은 우산 아래에서 걸었다."}]}, {"t": "괜찮아요, 곧 그칠 거예요", "aff": {}, "reply": [{"t": "“그럼 그칠 때까지 같이 기다려요.” 처마 끝으로 떨어지는 빗방울을 한참 구경했다."}]}]}, {"t": "젖은 소매에서 은근하게 비 냄새가 났다."}]$j$::jsonb,$j${"give": [], "money": 0, "aff": []}$j$::jsonb
where not exists(select 1 from public.fsfs_event where code='rd_umbrella');

insert into public.fsfs_event(code,title,enabled,repeat_mode,chance,priority,note,cond,scene,effects)
select 'rd_puddle','[길 위] 물웅덩이',true,'daily',100,0,'비 오는 날 · 신발이 젖을까?',$j${"place": "road", "npc": null, "ranges": [], "slots": [], "from": null, "to": null, "bday": null, "aff": [], "wx": "rain", "tod": "day"}$j$::jsonb,$j$[{"t": "길 한가운데에 커다란 물웅덩이가 고여 있다."}, {"choices": [{"t": "폴짝 뛰어넘는다", "aff": {}, "reply": [{"t": "아슬아슬하게 착지했다. 신발 끝이 살짝 젖었지만 기분은 좋다."}]}, {"t": "빙 돌아서 간다", "aff": {}, "reply": [{"t": "조금 돌아갔지만 발은 뽀송하다. 웅덩이 위로 하늘이 비쳤다."}]}]}]$j$::jsonb,$j${"give": [], "money": 0, "aff": []}$j$::jsonb
where not exists(select 1 from public.fsfs_event where code='rd_puddle');

insert into public.fsfs_event(code,title,enabled,repeat_mode,chance,priority,note,cond,scene,effects)
select 'rd_neon','[길 위] 번진 네온',true,'daily',100,0,'비 오는 밤 · 젖은 길 위의 불빛',$j${"place": "road", "npc": null, "ranges": [], "slots": [], "from": null, "to": null, "bday": null, "aff": [], "wx": "rain", "tod": "night"}$j$::jsonb,$j$[{"t": "젖은 길바닥 위로 간판 불빛이 길게 번져 있다."}, {"t": "분홍, 파랑, 노랑. 걸을 때마다 발밑에서 색이 부서졌다."}, {"t": "이런 밤은 일부러 천천히 걷고 싶어진다."}]$j$::jsonb,$j${"give": [], "money": 0, "aff": []}$j$::jsonb
where not exists(select 1 from public.fsfs_event where code='rd_neon');

insert into public.fsfs_event(code,title,enabled,repeat_mode,chance,priority,note,cond,scene,effects)
select 'rd_blossom','[길 위] 벚꽃 길',true,'daily',100,0,'봄 벚꽃철 · 사진 찍어 달라는 사람',$j${"place": "road", "npc": null, "ranges": [], "slots": [], "from": "03-25", "to": "04-15", "bday": null, "aff": [], "wx": "clear"}$j$::jsonb,$j$[{"t": "길가에 늘어선 벚나무에서 꽃잎이 눈처럼 흩날린다."}, {"t": "휴대폰을 든 사람이 쭈뼛쭈뼛 다가왔다. “저, 사진 한 장만 찍어 주실 수 있어요?”"}, {"choices": [{"t": "네, 찍어 드릴게요", "aff": {}, "reply": [{"t": "“하나, 둘, 셋!” 꽃잎이 한창 떨어지는 순간을 잡았다. “와, 잘 나왔다! 고마워요!”"}]}, {"t": "죄송해요, 제가 급해서요", "aff": {}, "reply": [{"t": "“아, 괜찮아요!” 그 사람은 웃으며 다른 사람을 찾아 걸어갔다."}]}]}, {"t": "머리 위에 내려앉은 꽃잎 하나를 한참 뒤에야 털어 냈다."}]$j$::jsonb,$j${"give": [], "money": 0, "aff": []}$j$::jsonb
where not exists(select 1 from public.fsfs_event where code='rd_blossom');

insert into public.fsfs_event(code,title,enabled,repeat_mode,chance,priority,note,cond,scene,effects)
select 'rd_leaves','[길 위] 낙엽 소리',true,'daily',100,0,'가을 · 낙엽 밟는 길',$j${"place": "road", "npc": null, "ranges": [], "slots": [], "from": "10-10", "to": "11-25", "bday": null, "aff": [], "tod": "day"}$j$::jsonb,$j$[{"t": "길 가득 낙엽이 쌓여 있다. 한 발 디딜 때마다 바삭, 소리가 난다."}, {"choices": [{"t": "일부러 낙엽 많은 쪽으로 걷는다", "aff": {}, "reply": [{"t": "바삭바삭. 어릴 때처럼 괜히 신이 난다."}]}, {"t": "조용히 지나간다", "aff": {}, "reply": [{"t": "소리가 나지 않게 가장자리로 걸었다. 낙엽도 쉬고 싶겠지."}]}]}]$j$::jsonb,$j${"give": [], "money": 0, "aff": []}$j$::jsonb
where not exists(select 1 from public.fsfs_event where code='rd_leaves');

insert into public.fsfs_event(code,title,enabled,repeat_mode,chance,priority,note,cond,scene,effects)
select 'rd_snowman','[길 위] 작은 눈사람',true,'daily',100,0,'눈 오는 날',$j${"place": "road", "npc": null, "ranges": [], "slots": [], "from": null, "to": null, "bday": null, "aff": [], "wx": "snow"}$j$::jsonb,$j$[{"t": "골목 담 위에 손바닥만 한 눈사람이 줄지어 서 있다."}, {"t": "돌멩이로 눈을 박은 눈사람들이 다 같이 이쪽을 보고 있는 것 같다."}, {"choices": [{"t": "하나 더 만들어 놓는다", "aff": {}, "reply": [{"t": "주운 나뭇가지를 꽂아 팔을 달아 주었다. 눈사람 행렬이 한 명 늘었다."}]}, {"t": "구경만 한다", "aff": {}, "reply": [{"t": "사진을 찍듯 눈으로 담았다. 내일이면 녹아 있겠지."}]}]}]$j$::jsonb,$j${"give": [], "money": 0, "aff": []}$j$::jsonb
where not exists(select 1 from public.fsfs_event where code='rd_snowman');

insert into public.fsfs_event(code,title,enabled,repeat_mode,chance,priority,note,cond,scene,effects)
select 'rd_cat','[길 위] 가로등 아래 고양이',true,'daily',100,0,'밤 · 길고양이',$j${"place": "road", "npc": null, "ranges": [], "slots": [], "from": null, "to": null, "bday": null, "aff": [], "tod": "night"}$j$::jsonb,$j$[{"t": "가로등 아래에 고양이 한 마리가 앉아 있다."}, {"t": "눈이 마주치자 고양이는 느릿하게 눈을 깜빡였다."}, {"choices": [{"t": "천천히 눈을 깜빡여 준다", "aff": {}, "reply": [{"t": "고양이가 만족스럽다는 듯 꼬리를 한 번 흔들더니 어둠 속으로 사라졌다."}]}, {"t": "조용히 지나간다", "aff": {}, "reply": [{"t": "고양이는 신경도 쓰지 않고 그루밍을 시작했다."}]}]}]$j$::jsonb,$j${"give": [], "money": 0, "aff": []}$j$::jsonb
where not exists(select 1 from public.fsfs_event where code='rd_cat');

insert into public.fsfs_event(code,title,enabled,repeat_mode,chance,priority,note,cond,scene,effects)
select 'rd_coin','[길 위] 접힌 지폐',true,'daily',100,0,'낮 · 길에서 1,000원 줍기',$j${"place": "road", "npc": null, "ranges": [], "slots": [], "from": null, "to": null, "bday": null, "aff": [], "tod": "day"}$j$::jsonb,$j$[{"t": "보도블록 틈에 접힌 종이가 끼어 있다. 펼쳐 보니 천 원짜리 지폐다."}, {"t": "주변을 둘러봤지만 주인은 보이지 않는다. 일단 주머니에 넣었다."}]$j$::jsonb,$j${"give": [], "money": 1000, "aff": []}$j$::jsonb
where not exists(select 1 from public.fsfs_event where code='rd_coin');

insert into public.fsfs_event(code,title,enabled,repeat_mode,chance,priority,note,cond,scene,effects)
select 'rd_flyer','[길 위] 전단지',true,'daily',100,0,'낮 · 전단지를 나눠 주는 사람',$j${"place": "road", "npc": null, "ranges": [], "slots": [], "from": null, "to": null, "bday": null, "aff": [], "tod": "day"}$j$::jsonb,$j$[{"t": "길모퉁이에서 전단지를 나눠 주는 사람과 눈이 마주쳤다."}, {"choices": [{"t": "받는다", "aff": {}, "reply": [{"t": "“감사합니다!” 상대가 활짝 웃었다. 새로 생긴 가게 쿠폰이었다. 언젠가 쓸 일이 있겠지."}]}, {"t": "손을 저으며 지나간다", "aff": {}, "reply": [{"t": "“좋은 하루 보내세요!” 등 뒤로 밝은 목소리가 따라왔다."}]}]}]$j$::jsonb,$j${"give": [], "money": 0, "aff": []}$j$::jsonb
where not exists(select 1 from public.fsfs_event where code='rd_flyer');

insert into public.fsfs_event(code,title,enabled,repeat_mode,chance,priority,note,cond,scene,effects)
select 'rd_ask','[길 위] 길 묻는 사람',true,'daily',100,0,'낮 · 길을 묻는 여행객',$j${"place": "road", "npc": null, "ranges": [], "slots": [], "from": null, "to": null, "bday": null, "aff": [], "tod": "day"}$j$::jsonb,$j$[{"t": "캐리어를 끈 사람이 두리번거리다 말을 걸었다. “저기, 혹시 이 근처 역이 어디예요?”"}, {"choices": [{"t": "아는 대로 알려 준다", "aff": {}, "reply": [{"t": "“저쪽으로 쭉 가다가 신호등에서 왼쪽이에요.” 상대가 몇 번이나 고개를 숙였다. “정말 고마워요!”"}]}, {"t": "저도 잘 몰라요", "aff": {}, "reply": [{"t": "“앗, 괜찮아요.” 그 사람은 지도 앱을 켜며 걸어갔다. 괜히 미안해졌다."}]}]}]$j$::jsonb,$j${"give": [], "money": 0, "aff": []}$j$::jsonb
where not exists(select 1 from public.fsfs_event where code='rd_ask');

insert into public.fsfs_event(code,title,enabled,repeat_mode,chance,priority,note,cond,scene,effects)
select 'rd_bench','[길 위] 잠깐 벤치',true,'daily',100,0,'에너지가 낮을 때',$j${"place": "road", "npc": null, "ranges": [], "slots": [], "from": null, "to": null, "bday": null, "aff": [], "enMax": 30}$j$::jsonb,$j$[{"t": "다리가 무겁다. 길가에 놓인 벤치가 유난히 반갑다."}, {"t": "잠깐 앉아 하늘을 올려다보았다. 구름이 느리게 흘러간다."}, {"t": "조금 쉬었더니 다시 걸을 만하다."}]$j$::jsonb,$j${"give": [], "money": 0, "aff": []}$j$::jsonb
where not exists(select 1 from public.fsfs_event where code='rd_bench');

insert into public.fsfs_event(code,title,enabled,repeat_mode,chance,priority,note,cond,scene,effects)
select 'rd_dawn','[길 위] 새벽 거리',true,'daily',100,0,'새벽 · 조용한 길',$j${"place": "road", "npc": null, "ranges": [[0, 330]], "slots": [], "from": null, "to": null, "bday": null, "aff": [], "tod": "night"}$j$::jsonb,$j$[{"t": "이 시간의 거리는 이상하리만큼 조용하다."}, {"t": "멀리서 첫차 소리가 들렸다. 하늘 끝이 아주 조금 푸르러지는 것 같다."}, {"t": "이런 길은 어쩐지 혼자 걷기에 딱 좋다."}]$j$::jsonb,$j${"give": [], "money": 0, "aff": []}$j$::jsonb
where not exists(select 1 from public.fsfs_event where code='rd_dawn');

insert into public.fsfs_event(code,title,enabled,repeat_mode,chance,priority,note,cond,scene,effects)
select 'rd_bread','[길 위] 붕어빵 냄새',true,'daily',100,0,'늦가을~겨울 · 밤',$j${"place": "road", "npc": null, "ranges": [], "slots": [], "from": "11-15", "to": "02-28", "bday": null, "aff": [], "tod": "night"}$j$::jsonb,$j$[{"t": "어디선가 달콤하고 고소한 냄새가 흘러왔다. 골목 끝에 붕어빵 포장마차가 서 있다."}, {"choices": [{"t": "냄새만 맡아도 행복하다", "aff": {}, "reply": [{"t": "한참 서서 김이 피어오르는 걸 구경했다. 배가 슬쩍 꼬르륵했다."}]}, {"t": "다음에 꼭 사 먹어야지", "aff": {}, "reply": [{"t": "머릿속에 지도를 그려 두었다. 이 골목, 이 모퉁이."}]}]}]$j$::jsonb,$j${"give": [], "money": 0, "aff": []}$j$::jsonb
where not exists(select 1 from public.fsfs_event where code='rd_bread');

insert into public.fsfs_event(code,title,enabled,repeat_mode,chance,priority,note,cond,scene,effects)
select 'rd_bike','[길 위] 쌩 지나가는 자전거',true,'daily',100,0,'맑은 낮',$j${"place": "road", "npc": null, "ranges": [], "slots": [], "from": null, "to": null, "bday": null, "aff": [], "tod": "day", "wx": "clear"}$j$::jsonb,$j$[{"t": "뒤에서 “따르릉!” 하는 소리와 함께 자전거가 쌩 하고 지나갔다."}, {"t": "자전거를 탄 아이가 뒤를 돌아보며 손을 흔들었다. 얼떨결에 손을 마주 흔들었다."}]$j$::jsonb,$j${"give": [], "money": 0, "aff": []}$j$::jsonb
where not exists(select 1 from public.fsfs_event where code='rd_bike');

insert into public.fsfs_event(code,title,enabled,repeat_mode,chance,priority,note,cond,scene,effects)
select 'rd_sky','[길 위] 예쁜 하늘',true,'daily',100,0,'맑은 낮 · 구름',$j${"place": "road", "npc": null, "ranges": [], "slots": [], "from": null, "to": null, "bday": null, "aff": [], "tod": "day", "wx": "clear"}$j$::jsonb,$j$[{"t": "고개를 들었더니 하늘이 눈부시게 파랗다."}, {"t": "솜사탕 같은 구름이 천천히 모양을 바꾸고 있다. 걷다 말고 한참을 올려다보았다."}]$j$::jsonb,$j${"give": [], "money": 0, "aff": []}$j$::jsonb
where not exists(select 1 from public.fsfs_event where code='rd_sky');
