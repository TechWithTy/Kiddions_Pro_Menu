


								--\\\\\\\\\\[[DEFAULT OPTIONS]]/////////--

--shapeshift.lua
Sx=1						--ShapeShift default Male/Female 1/2

--B_CayoSetup.lua
TTL=true					--CayoPericoHeist Total Take preferred Limit

--A_menu.lua

Plates={ "L1LBR4D4", "ERR0R404", "0N33CH4N", "N1GG3RRR","Y3SD4DDY","H0EH0EH0","SKMAD1CK", "SP4NKM3EE", "R0NGH0L3", "N0TA8TCH", "AHHHSH1T", "HIGHLIFE", "DEATHLRD", "SUPRAAAA", "H4X0R", "1D10T8TC", "L00KUP", "AD10S", "FCKUBTCH" }--number plates

MinProt={true,1.64}			--default [Teleport,Kicks&Crashes,stuckload] protection by TeaTimeTea/Slon, updated till
metric = true			--Speedometer
enable = false			--QuickFire default(on/off>true/false)
enable2 = true		--QuickTeleport Toggle function-inside WeaponCD&Extras(enable/disable>true/false)
enable4 = true		--VehAcclTweaksHotKey
heal,snack=18,15		--Distinct Heal Hotkey(=nil to disable) & the snack,  ALT key(18) ; "P's & Q's"=5, EgoChaser=15, Meteorite=10, eCola=9 
RefB,RefB2=69,88		--Refill Boost Hotkeys(=nil to disable),  E key , X key
GHk=116				--Godmode+ toggle hot key 144=NumLock 116=F5
UOR=120				--UndeadOffradar Toggle, F9
RefIn=107				--Refill Inventory, Numpad+
QTP=110				--QuickTP Toggle, Numpad Delete
	QTPf=38			--	TelePort Forward, Up Arrow key
	QTPu=39			--	TelePort Upward, Right Arrow key
	QTPd=37			--	TelePort Downward, Left Arrow key
WepTw=nil 			--Weapon maxTweaks Hotkey, =nil to disable & ='keycode' to enable
VehTw=192				--Vehicle Tweaks Toggle, `key(~)
	VDmg=114			--No scratch hotkey, F3

--Troll Menu.lua
Tsk=1 			--On Admin Detection; 1-DoARoundabout, 2-JoinPublic, 3-EmptySession
ChSs=nil			--ChangeSession Hotkey, nil to disable
EmSs=19 			--Pause|Break key	--EmptySession Hotkey, nil to disable
TRLHK = false  --ExplodeLoop hotkey default(on/off>true/false)
TL=105			--TrollLoop hotkey, Numpad9




									--\\\\\\\\\\[[GLOBALS AND LOCALS]]/////////--
					
CPTO=262145+29982			--v1.64 Cayo Primary Target take Value offset
CPCO=1977693+823+56			--v1.64 Cayo Player Cut offset
CBgC=262145+29732			--v1.64 Cayo Bag Capacity

HS0ST=47132					--v1.64 Cayo Secondary Target take value(local) ~41449
HS0SF=26746					--v1.64 Cayo Sewer Fence(local)
HS0CF=22032					--v1.64 Cayo Clone Fingerprint(local)
HS0CG=27985					--v1.64 Cut Glass(local)27988?
HS0VT=1716					--v1.64 Voltlab Target(local)
HS0VC=1717					--v1.64 Voltlab Current(local)←
					--~~~~~~~~~--

DTO=262145+28804+1			--v1.64 Casino Target value offset
DPCO=1970895+2325			--v1.64 Casino Player Cut offset

HSRT=22393					--v1.64 Casino Real Take(local)
HSFG=52962					--v1.64 Casino Finger Graft(local)
HSKP=54024					--v1.64 Casino Keypad(local)
HSVT=10098+37				--v1.64 Casino Vault Total(local)
HSVS=10098+7				--v1.64 Casino Vault Stat(local)
					--~~~~~~~~~--

DDCO=1966831+812+50			--v1.64 Doomsday Player Cut offset
APCO=1937658+3008			--v1.64 Apartment Player Cut offset

Beam=1400					--v1.64 D'Day Act III Beam puzzle(local) HS
Nodes=1539					--v1.64 D'Day Act I Server Nodes puzzle(local)
VLSI=11781					--v1.64 Apartment Fleeca Circuit Breaker(local)
					--~~~~~~~~~--

GTr=2639783+61				--v1.64 Trigger
GHs=2639783+48				--v1.64 PedHash
					--~~~~~~~~~--
					
SsTy=1575017				--v1.64 Session Type
SsTr=2683862				--v1.64 Session Trigger
CrVO=2694560				--v1.64 Create Vehicle Offset(partial)
CrVOx=CrVO+42		--           ^ ..X  for loop triggerAssist-playerid
CrVOy=CrVOx+1		--           ^ ..Y  for loop triggerAssist state
					--~~~~~~~~~--
					
GlO=262145					--(v1.64)Global offset
SMCD=GlO+31701				--(v1.64)Security Missions
PHCD=GlO+31781				--(v1.64)Payphone Hit
ASvCD=GlO+31126				--(v1.64)AutoShop Customer Vehicle cooldown
CsWCD=GlO+27254				--(v1.64)Casino works cooldown
CEOWCD=GlO+13081			--  (v1.64)CEO-Works cooldown
CEOARCD=GlO+12939			--  (v1.64)CEO-Asset Recovery cooldown
CEOHCD=GlO+15468			--  (v1.64)CEO-Headhunter cooldown
CEOACD=GlO+15449			--  (v1.64)CEO-Airfreight cooldown
KMCD=GlO+30187				--(v1.64)Kosatka Missile CD
KMR=GlO+30188				--(v1.64)Kosatka Missile Range
					--~~~~~~~~~--
					
					
					
					
--[[	if use_metric then mult=3.6 else mult=0.6214 end
		globals.set_string(2703735+2400+1+8, "AMCH_MPHN", 32)
		globals.set_int(   2703735+2400+1+3, math.floor(SPEED()*mult+0.5))
		globals.set_string(2703735+2400+1+21, "FM_AE_SORT_3", 16)
		globals.set_int(   2703735+2400+1+1, 11)
		globals.set_int(   2703735+2400+1+2, 1)			]]--



--\\\\\\\\\\[[COMMON FUNCTIONS AND VARIABLES]]/////////--
keyW,keyA,keyS,keyD,keyRCtrl,keyNum0=87,65,83,68,163,96
CtPerc={} CtPerc[-1]="0%" for i=2,39 do CtPerc[i]=((i+1)*5).."%"end

function null()end
function mpx()return stats.get_int("MPPLY_LAST_MP_CHAR")end
function HS()return script("fm_mission_controller")end
function HS0()return script("fm_mission_controller_2020")end

function flag(i,ped)if not ped then return player.get_player_ped():get_config_flag(i)else return ped:get_config_flag(i)end end
function sflag(i,v,ped)if not ped then player.get_player_ped():set_config_flag(i,v)else ped:set_config_flag(i,v)end end

function TP2(pos,rot)localplayer:set_position(pos)if rot then localplayer:set_rotation(rot)end end


function CrVh(Hash,pos,peg,paint,paint2)
	WP,WS=2,1 if not peg then peg=0 end if not paint then paint=-1 end if not paint2 then paint2=-1 end
	if Hash==joaat("oppressor2") then WP=2 elseif Hash==joaat("apc") or Hash==joaat("deluxo") then WP=-1
	elseif Hash==joaat("bombushka") then WP=1 elseif Hash==joaat("tampa3") or Hash==joaat("insurgent3") or Hash==joaat("halftrack") then WP=3
	elseif Hash==joaat("barrage") then WP=30 end
	globals.set_float(CrVO+7+0, pos.x) globals.set_float(CrVO+7+1, pos.y) globals.set_float(CrVO+7+2, pos.z)
	globals.set_int(CrVO+27+66, Hash)
	V=localplayer:get_nearest_vehicle() if V and V:get_position()==pos then V:set_position(pos+vector3(0,0,-100))end
	globals.set_int(CrVO+27+28, 1)  -- Weaponised ownerflag
	globals.set_int(CrVO+27+60, 1)
	globals.set_int(CrVO+27+95, 14) -- Ownerflag
	globals.set_int(CrVO+27+94, 2)  -- Personal car ownerflag
	globals.set_int(CrVO+3, peg)
	globals.set_int(CrVO+27+74, 1) globals.set_int(CrVO+27+75, 1) globals.set_int(CrVO+27+76, 0) --RGB Neon Amount 1-255 100%-0%
	globals.set_int(CrVO+27+60, 1) --landinggear/vehstate
	globals.set_int(CrVO+27+5, paint) globals.set_int(CrVO+27+6, paint2) -- default paintjob primary,secondary 0-120 (-1>>auto)
	globals.set_int(CrVO+27+7, -1)
	globals.set_int(CrVO+27+8, -1)
	globals.set_int(CrVO+27+19, 4)
	globals.set_int(CrVO+27+21, 4)  -- Engine (0-3)
	globals.set_int(CrVO+27+22, 3)
	globals.set_int(CrVO+27+23, 3)  -- Transmission (0-9)
	globals.set_int(CrVO+27+24, 58)
	globals.set_int(CrVO+27+26, 5)  -- Armor (0-18)
	globals.set_int(CrVO+27+27, 1)  -- Turbo (0-1)
	globals.set_int(CrVO+27+65, 2) -- Window tint 0-6
	globals.set_int(CrVO+27+69, -1) -- Wheel type
	globals.set_int(CrVO+27+33, -1) -- Wheel Selection
	globals.set_int(CrVO+27+25, 8)  -- Suspension (0-13)
	globals.set_int(CrVO+27+19, -1)
	globals.set_int(CrVO+27+15, WP) globals.set_int(CrVO+27+20, WS) -- primary,secondary weapon]
	globals.set_int(CrVO+5, 1)      -- SET('i',CarSpawn+0x1168, 1)  --can spawn flag must be odd
	globals.set_int(CrVO+2, 1)      -- SET('i',CarSpawn+0x1180, 1) --spawn toggle gets reset to 0 on car spawn
end