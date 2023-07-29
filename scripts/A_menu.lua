require("scripts/global")

local function wEp()if localplayer:get_current_weapon()then return true end return false end

local Flgs,FLx={},{18,32,33,35,52,58,60,62,71,72,73,76,78,100,104,122,125,140,166,170,184,187,223,224,241,253,276,281,292,301,314,331,410,423,429,421}
Flgs[18]="Can Punch>"						Flgs[32]="Can Fly Thru Windscreen>"			Flgs[33]="Dies By Ragdoll>"					Flgs[35]="Helmet>"
Flgs[52]="No Collision>"					Flgs[58]="Is Shooting>"						Flgs[60]="Is On Ground>"					Flgs[62]="No Collide>"
Flgs[71]="Dead>"							Flgs[72]="Is Sniper Scope Active>"			Flgs[73]="Super Dead>"						Flgs[76]="Is In Air>"
Flgs[78]="Is Aiming>"						Flgs[100]="Drunk>"							Flgs[104]="No Ragdoll,Not Playing Anim>"	Flgs[122]="No Player Melee>"
Flgs[125]="NmMessage466>"					Flgs[140]="Can Attack Friendlies>"			Flgs[166]="Injured Limp>"					Flgs[170]="Injured Limp2>"
Flgs[184]="Disable Shuffling2Driver Seat>"	Flgs[187]="Injured Down>"					Flgs[223]="Shrink>"							Flgs[224]="Melee Combat>"
Flgs[241]="Disable Stopping VehEngine>"		Flgs[253]="Is On Stairs>"					Flgs[276]="Has One Leg On Ground>"			Flgs[281]="No Writhe>"
Flgs[292]="Freeze>"							Flgs[301]="Is Still>"						Flgs[314]="No Ped Melee>"					Flgs[331]="Ped Switching Weapon>"
Flgs[410]="Alpha>"							Flgs[423]="Disable Prop KnockOff>"			Flgs[429]="Disable Starting VehEngine>"		Flgs[421]="Flaming Footprints>"

Fast={"_CHAR_ABILITY_1_UNLCK","_CHAR_ABILITY_2_UNLCK","_CHAR_ABILITY_3_UNLCK","_CHAR_FM_ABILITY_1_UNLCK","_CHAR_FM_ABILITY_2_UNLCK","_CHAR_FM_ABILITY_3_UNLCK"}


local function Veh() if localplayer:is_in_vehicle() then return localplayer:get_current_vehicle() else return nil end end

local function PLA()if localplayer:is_in_vehicle() then return Veh():get_number_plate_text()else return "" end end

local original_max_health = 0.0
local function GetUndeadOffradar()
	if not localplayer then return nil end max_health = localplayer:get_max_health() return max_health < 100.0
end
local function SetUndeadOffradar(value)
	if value == nil or localplayer == nil then return end if value then max_health = localplayer:get_max_health()
		if max_health >= 100.0 then original_max_health = max_health end localplayer:set_max_health(0.0) else
		if original_max_health >= 100 then localplayer:set_max_health(original_max_health) else localplayer:set_max_health(328.0) end end
end
local function ToggleUndeadOffradar()
	value = GetUndeadOffradar() if value ~= nil then SetUndeadOffradar(not value) end
end
menu.register_hotkey(UOR, ToggleUndeadOffradar)

local bT,WR,LR=0,0,0
local function OnWeaponChanged(oldWeapon, newWeapon)
	if newWeapon~=nil then NAME=localplayer:get_current_weapon():get_name_hash()
		if NAME==joaat("weapon_hominglauncher") then newWeapon:set_range(1500) elseif NAME==joaat("weapon_raypistol") then
			newWeapon:set_heli_force(1075) newWeapon:set_ped_force(63) newWeapon:set_vehicle_force(1075) end
		if bT==0 then if NAME==joaat("weapon_stungun_mp") or NAME==joaat("weapon_stungun") then newWeapon:set_time_between_shots(1)
			elseif NAME==joaat("weapon_raypistol") then newWeapon:set_time_between_shots(0.5) end
			else newWeapon:set_time_between_shots(bT) end
		if WR~=0 then newWeapon:set_range(WR) else if NAME==joaat("weapon_raypistol") then newWeapon:set_range(1200)
			elseif NAME==joaat("weapon_stungun_mp") or NAME==joaat("weapon_stungun") then newWeapon:set_range(1000) end end
		if LR==0 then if NAME==joaat("weapon_hominglauncher") then newWeapon:set_lock_on_range(1500) end
			else newWeapon:set_lock_on_range(LR) end end
end
------
if WCD then menu.remove_callback(WCD) end local WCD=nil
if enable then local WCD = menu.register_callback('OnWeaponChanged', OnWeaponChanged) end

local function mxwep()
	localplayer:get_current_weapon():set_heli_force(60000) localplayer:get_current_weapon():set_ped_force(60000)
	localplayer:get_current_weapon():set_vehicle_force(60000) localplayer:get_current_weapon():set_time_between_shots(0.1)
	localplayer:get_current_weapon():set_range(2000) localplayer:get_current_weapon():set_lock_on_range(2000)
	localplayer:get_current_weapon():set_spread(0.2)
end
if WepTw~=nil then menu.register_hotkey(WepTw, mxwep) end

local TPF, TPU, TPD, enable3=nil, nil, nil, false
local function TPup()
	if not enable3 then return end newpos=localplayer:get_position()+vector3(0,0,2.5)
	if not localplayer:is_in_vehicle() then localplayer:set_position(newpos) else Veh():set_position(newpos) end
end
local function TPdn()
	if not enable3 then return end newpos=localplayer:get_position()+vector3(0,0,-2.5)
	if not localplayer:is_in_vehicle() then localplayer:set_position(newpos) else Veh():set_position(newpos) end
end
local function TPfr() if not enable3 then return end menu.teleport_forward() end
local function TPHk(e)
	if e then TPD=menu.register_hotkey(QTPd, TPdn) TPF=menu.register_hotkey(QTPf, TPfr) TPU=menu.register_hotkey(QTPu, TPup)
	else menu.remove_hotkey(TPD) menu.remove_hotkey(TPF) menu.remove_hotkey(TPU) end
end
------
local function TelePort() enable3=not enable3 TPHk(enable3) end
if TPH then menu.remove_hotkey(TPH) end local TPH=nil
if enable2 then TPH=menu.register_hotkey(QTP, TelePort) end
local function TPHkS(e)
	if e then TPH=menu.register_hotkey(QTP, TelePort) else if not TPD then
		menu.remove_hotkey(TPH) else menu.remove_hotkey(TPD) menu.remove_hotkey(TPF)
		menu.remove_hotkey(TPU) menu.remove_hotkey(TPH) end end
end

local AirB={nil,nil,nil,nil,nil,nil,nil}
local OlA,OlG,OlVeh=nil,nil,nil
local function VehicleTweaks()
	if localplayer:is_in_vehicle() then OlVeh=Veh()
		if Veh():get_acceleration()==0.05 then 
			if AirB[1] then Veh():set_acceleration(AirB[1])end if AirB[2] then Veh():set_up_shift(AirB[2])end
			if AirB[3] then Veh():set_down_shift(AirB[3])end if AirB[4] then Veh():set_initial_drag_coeff(AirB[4])end
			if AirB[5] then Veh():set_initial_drive_force(AirB[5])end if AirB[6] then Veh():set_gravity(AirB[6])end
			if AirB[7] then Veh():set_initial_drive_max_flat_velocity(AirB[7])end
			if not OlVeh:get_can_be_visibly_damaged() then OlVeh:set_can_be_visibly_damaged(true) end
			if OlVeh:get_window_collisions_disabled() then OlVeh:set_window_collisions_disabled(false) end
			if OlVeh:get_godmode() then OlVeh:set_godmode(false) end
			for i = 1,#AirB do AirB[i]=nil end
		elseif Veh():get_acceleration() < 0.1 and Veh():get_acceleration() >= 0 then
			AirB[1]=Veh():get_acceleration() AirB[2]=Veh():get_up_shift()
			AirB[3]=Veh():get_down_shift() AirB[4]=Veh():get_initial_drag_coeff()
			AirB[5]=Veh():get_initial_drive_force() AirB[6]=Veh():get_gravity()
			AirB[7]=Veh():get_initial_drive_max_flat_velocity()
			Veh():set_acceleration(0.05) Veh():set_up_shift(1.9)
			Veh():set_down_shift(1.8) Veh():set_initial_drag_coeff(0.1)
			Veh():set_initial_drive_force(0.05) Veh():set_gravity(12.5)
			Veh():set_initial_drive_max_flat_velocity(350)end		
		
		if Veh():get_acceleration()==0.59 then if OlA then Veh():set_acceleration(OlA) end
			if OlG then Veh():set_gravity(OlG) end if not OlVeh:get_can_be_visibly_damaged() then OlVeh:set_can_be_visibly_damaged(true) end
			if OlVeh:get_window_collisions_disabled() then OlVeh:set_window_collisions_disabled(false) end
			if OlVeh:get_godmode() then OlVeh:set_godmode(false) end OlA,OlG,OlVeh=nil,nil,nil
		elseif Veh():get_acceleration() < 0.59 and Veh():get_acceleration() > 0.1 then
			OlA=Veh():get_acceleration() OlG=Veh():get_gravity() OlV=Veh():get_can_be_visibly_damaged()
			Veh():set_acceleration(0.59) Veh():set_gravity(14.8) Veh():set_max_speed(220) end
			
		if Veh():get_acceleration()==40 then Veh():set_acceleration(OlA)
			if not OlVeh:get_can_be_visibly_damaged() then OlVeh:set_can_be_visibly_damaged(true) end
			if OlVeh:get_window_collisions_disabled() then OlVeh:set_window_collisions_disabled(false) end
			if OlVeh:get_godmode() then  OlVeh:set_godmode(false) end OlA,OlG,OlVeh=nil,nil,nil
		elseif  Veh():get_acceleration() < 40 and Veh():get_acceleration() > 5 then
			OlA=Veh():get_acceleration() Veh():set_acceleration(40) Veh():set_max_speed(220) end
	else if not OlVeh then return end if OlA then OlVeh:set_acceleration(OlA) end if OlG then OlVeh:set_gravity(OlG) end
		if not OlVeh:get_can_be_visibly_damaged() then OlVeh:set_can_be_visibly_damaged(true) end
		if OlVeh:get_window_collisions_disabled() then OlVeh:set_window_collisions_disabled(false) end
		if OlVeh:get_godmode() then  OlVeh:set_godmode(false) end OlA,OlG,OlVeh=nil,nil,nil end
end
if enable4 then menu.register_hotkey(VehTw, VehicleTweaks) end

local function RfB()
	if localplayer:is_in_vehicle() then a=0 while a==0 do
		if Veh():get_boost()==0 then menu.refill_boost() Veh():set_boost_enabled(true)
		else Start=Veh():get_boost() sleep(0.05) End=Veh():get_boost()
			if (End-Start)>=0 then menu.refill_boost() Veh():set_boost_enabled(true)end end
		a=1 end end
end
if RefB then menu.register_hotkey(RefB, RfB) end if RefB2 then menu.register_hotkey(RefB2, RfB) end

local function GD(v)
	if v then if not localplayer:get_godmode() then localplayer:set_godmode(true) end
		if not localplayer:get_no_ragdoll() then localplayer:set_no_ragdoll(true) end
		if not localplayer:get_seatbelt() then localplayer:set_seatbelt(true) end
	else if localplayer:get_godmode() then localplayer:set_godmode(false) end
		if localplayer:get_no_ragdoll() then localplayer:set_no_ragdoll(false) end
		if localplayer:get_seatbelt() then localplayer:set_seatbelt(false) end end
end
if GHk then menu.register_hotkey(GHk, function() GOD=localplayer:get_godmode() GD(not GOD) end) end

local function NoScratch()
	if localplayer:is_in_vehicle() then OlVeh=Veh()
		Veh():set_can_be_visibly_damaged(false) Veh():set_window_collisions_disabled(true) end
end
if VDmg then menu.register_hotkey(VDmg, NoScratch) end


local Horn=false
local WepCD=menu.add_submenu("Weapon CD and extras")
WepCD:add_toggle("Horn E",function()return Horn end,function(v)
	Horn=v if v then menu.send_key_down(69)else menu.send_key_up(69)end end)
WepCD:add_toggle("Undead offradar", GetUndeadOffradar, SetUndeadOffradar)

WepCD:add_toggle("CanYouStartEngine?",function()return not flag(429)end, function()sflag(429,not flag(429))end)

WepCD:add_bare_item("", function() if localplayer:is_in_vehicle()then return"                  Plate>"..PLA()else return""end end, null, null, null)
local PLindx=1
WepCD:add_array_item("Number Plate>", Plates, function()return PLindx end,function(t)PLindx=t if Veh()then Veh():set_number_plate_text(Plates[t])end
end)

local SM=WepCD:add_submenu("Num2↓,Shft↓,Nm2↑,Shft↑. end=Num2")
local High=0
SM:add_bare_item("", function()
	if localplayer and localplayer:is_in_vehicle()then vel=localplayer:get_current_vehicle():get_velocity()else vel=vector3(0,0,0) High=0 end
	S=math.sqrt(vel.x^2+vel.y^2+vel.z^2) if metric then speed=string.format("%.1f",S*3.6)else speed=string.format("%.1f",S*2.23694)end
	if tonumber(speed)>High then High=tonumber(speed) end
	return "Speed: "..(metric and speed.." Kmph".."|Max>"..High.." Kmph" or string.format("%.1f",speed).." Mph".."|Max>"..High.."Mph")
end,null,null,null)

WepCD:add_toggle("QuickFire-Atmzer,StnGun/Auto{}", function() return enable end, function()
	enable=not enable if enable then WCD=menu.register_callback('OnWeaponChanged', OnWeaponChanged)else menu.remove_callback(WCD) bT,WR,LR=0,0,0 end
end)

WepCD:add_float_range("{}Time Between Shots for all", 0.1, 0, 4, function()if wEp()then return localplayer:get_current_weapon():get_time_between_shots()end end, function(BtSh)
	bT=BtSh localplayer:get_current_weapon():set_time_between_shots(BtSh)
end)
WepCD:add_float_range("{}Weapon Range for all", 10, 0, 1500, function()if wEp()then return localplayer:get_current_weapon():get_range()end end, function(range)
	WR=range localplayer:get_current_weapon():set_range(range)
end)
WepCD:add_float_range("{}Lock-On Range", 10, 0, 1500, function()if wEp()then return localplayer:get_current_weapon():get_lock_on_range()end end, function(Lock)
	LR=Lock localplayer:get_current_weapon():set_lock_on_range(Lock)
end)
WepCD:add_action("Max All weaponstats", function() mxwep() end)


WepCD:add_action("                 _________Extras_________", function() end)
WepCD:add_toggle("QuickTP(NumDel)", function() return enable2 end, function() --Menu Toggle- Add/Remove Hotkey
	enable2=not enable2 TPHkS(enable2)
end)

WepCD:add_action("Make Nightclub Popular", function() stats.set_int("MP"..mpx().."_club_popularity", 1000) end)
WepCD:add_int_range("Kosatka Missile CD", 60000,0,60000, function()if localplayer then return globals.get_int(KMCD)end end, function(v) globals.set_int(KMCD, v) end)
WepCD:add_int_range("Kosatka Missile Range", 1000,0,20000, function()if localplayer then return globals.get_int(KMR)end end, function(v) globals.set_int(KMR, v) end)

WepCD:add_int_range("No. of Chllngs to Get Carmeet Prize", 1, 1, 100, function()if localplayer then
if stats.get_bool("MP"..mpx().."_CARMEET_PV_CHLLGE_CMPLT") then return 1 end return 0 end end, function(ChCn)
	stats.set_bool("MP"..mpx().."_CARMEET_PV_CHLLGE_CMPLT", true) stats.set_int("MP"..mpx().."_CARMEET_PV_CHLLGE_PRGSS", ChCn)
end)

local ReportsStats_submenu=WepCD:add_submenu("Reports Stats")
ReportsStats_submenu:add_action("                        _Read Only_",null)
ReportsStats_submenu:add_int_range("Griefing",0,0,0,function()if localplayer then return stats.get_int("MPPLY_GRIEFING")end end, function() end)
ReportsStats_submenu:add_int_range("Exploits",0,0,0,function()if localplayer then return stats.get_int("MPPLY_EXPLOITS")end end, function() end)
ReportsStats_submenu:add_int_range("Bug Exploits",0,0,0,function()if localplayer then return stats.get_int("MPPLY_GAME_EXPLOITS")end end, function() end)
ReportsStats_submenu:add_int_range("Text Chat:Annoying Me",0,0,0,function()if localplayer then return stats.get_int("MPPLY_TC_ANNOYINGME")end end, function() end)
ReportsStats_submenu:add_int_range("Text Chat:Using Hate Speech",0,0,0,function()if localplayer then return stats.get_int("MPPLY_TC_HATE")end end, function() end)
ReportsStats_submenu:add_int_range("Voice Chat:Annoying Me",0,0,0,function()if localplayer then return stats.get_int("MPPLY_VC_ANNOYINGME")end end, function() end)
ReportsStats_submenu:add_int_range("Voice Chat:Using Hate Speech",0,0,0,function()if localplayer then return stats.get_int("MPPLY_VC_HATE")end end, function() end)
ReportsStats_submenu:add_int_range("Offensive Language",0,0,0,function()if localplayer then return stats.get_int("MPPLY_OFFENSIVE_LANGUAGE")end end, function() end)	ReportsStats_submenu:add_int_range("Offensive Tagplate",0,0,0,function()if localplayer then return stats.get_int("MPPLY_OFFENSIVE_TAGPLATE")end end, function() end)
ReportsStats_submenu:add_int_range("Offensive Content",0,0,0,function()if localplayer then return stats.get_int("MPPLY_OFFENSIVE_UGC")end end, function() end)
ReportsStats_submenu:add_int_range("Bad Crew Name",0,0,0,function()if localplayer then return stats.get_int("MPPLY_BAD_CREW_NAME")end end, function() end)
ReportsStats_submenu:add_int_range("Bad Crew Motto",0,0,0,function()if localplayer then return stats.get_int("MPPLY_BAD_CREW_MOTTO")end end, function() end)
ReportsStats_submenu:add_int_range("Bad Crew Status",0,0,0,function()if localplayer then return stats.get_int("MPPLY_BAD_CREW_STATUS")end end, function() end)
ReportsStats_submenu:add_int_range("Bad Crew Emblem",0,0,0,function()if localplayer then return stats.get_int("MPPLY_BAD_CREW_EMBLEM")end end, function() end)
ReportsStats_submenu:add_int_range("Friendly",0,0,0,function()if localplayer then return stats.get_int("MPPLY_FRIENDLY")end end, function() end)
ReportsStats_submenu:add_int_range("Helpful",0,0,0,function()if localplayer then return stats.get_int("MPPLY_HELPFUL")end end, function() end)


local FLAGS=WepCD:add_submenu("Config Flags>")
for i=1,#FLx do if Flgs[FLx[i]]then FLAGS:add_toggle(Flgs[FLx[i]],function()if localplayer then return flag(FLx[i])end end,function()sflag(FLx[i],not flag(FLx[i]))end)end end

WepCD:add_toggle("Fast Run",function()for i=1,#Fast do if stats.get_int("MP"..mpx()..Fast[i])~=-1 then return false end end return true end,function()
	for i=1,#Fast do if stats.get_int("MP"..mpx()..Fast[i])~=-1 then stats.set_int("MP"..mpx()..Fast[i],-1)else stats.set_int("MP"..mpx()..Fast[i],0)end end
end)







local FC=menu.add_submenu("F. Clinton | CDs")

FC:add_action("Remove DAX Work CD",function()stats.set_int("MP"..mpx().."_XM22JUGGALOWORKCDTIMER",-1) end)

FC:add_action("Goto Dr. Dre Final Mission", function()
	stats.set_int("MP"..mpx().."_FIXER_STORY_BS", -1) stats.set_int("MP"..mpx().."_FIXER_STORY_STRAND", -1)
	stats.set_int("MP"..mpx().."_FIXER_STORY_COOLDOWN", -1)
end)

FC:add_int_range("Security mission cooldown",300000,0,300000, function()if localplayer then return globals.get_int(SMCD)end end, function(v)
	globals.set_int(SMCD, v)
end)
FC:add_int_range("Payphone hit cooldown",1200000,0,1200000, function()if localplayer then return globals.get_int(PHCD)end end, function(v)
	if value then globals.set_int(PHCD, v)end
end)
FC:add_int_range("AutoShop Vehicle CD",2880,0,2880, function()if localplayer then return globals.get_int(ASvCD)end end, function(v)
	globals.set_int(ASvCD, v)
end)
FC:add_int_range("Casino Works CD", 180000, 0, 180000, function()if localplayer then return globals.get_int(CsWCD)end end, function(v)
	globals.set_int(CsWCD, v)
end)
FC:add_int_range("CEO-Works CD", 300000, 0, 300000, function()if localplayer then return globals.get_int(CEOWCD)end end, function(v)
	globals.set_int(CEOWCD, v)
end)
FC:add_int_range("CEO-Headhunter CD", 600000, 0, 600000, function()if localplayer then return globals.get_int(CEOHCD)end end, function(v)
	globals.set_int(CEOHCD, v)
end)
FC:add_int_range("CEO-Asset Recovery CD", 600000, 0, 600000, function()if localplayer then return globals.get_int(CEOARCD)end end, function(v)
	globals.set_int(CEOARCD, v)
end)
FC:add_int_range("CEO-Airfreight CD", 600000, 0, 600000, function()if localplayer then return globals.get_int(CEOACD)end end, function(v)
	if v then globals.set_int(CEOACD, v)end
end)

local function refillInventory()
	stats.set_int("MP"..mpx().."_NO_BOUGHT_YUM_SNACKS", 30) stats.set_int("MP"..mpx().."_NO_BOUGHT_HEALTH_SNACKS", 15)
	stats.set_int("MP"..mpx().."_NO_BOUGHT_EPIC_SNACKS", 5) stats.set_int("MP"..mpx().."_NUMBER_OF_ORANGE_BOUGHT", 10)
	stats.set_int("MP"..mpx().."_NUMBER_OF_BOURGE_BOUGHT", 10) stats.set_int("MP"..mpx().."_NUMBER_OF_CHAMP_BOUGHT", 5)
	stats.set_int("MP"..mpx().."_CIGARETTES_BOUGHT", 20) stats.set_int("MP"..mpx().."_MP_CHAR_ARMOUR_5_COUNT", 10)
	stats.set_int("MP"..mpx().."_BREATHING_APPAR_BOUGHT", 20) if stats.get_int("MP"..mpx().."_SR_INCREASE_THROW_CAP") then 
	if localplayer:get_weapon_by_hash(joaat("slot_stickybomb")) then localplayer:get_weapon_by_hash(joaat("slot_stickybomb")):set_current_ammo(30) end
	if localplayer:get_weapon_by_hash(joaat("slot_smokegrenade")) then localplayer:get_weapon_by_hash(joaat("slot_smokegrenade")):set_current_ammo(30) end
	if localplayer:get_weapon_by_hash(joaat("slot_grenade")) then localplayer:get_weapon_by_hash(joaat("slot_grenade")):set_current_ammo(30) end
	if localplayer:get_weapon_by_hash(joaat("slot_molotov")) then localplayer:get_weapon_by_hash(joaat("slot_molotov")):set_current_ammo(30) end
	if localplayer:get_weapon_by_hash(joaat("slot_proxmine")) then localplayer:get_weapon_by_hash(joaat("slot_proxmine")):set_current_ammo(10) end
	if localplayer:get_weapon_by_hash(joaat("slot_pipebomb")) then localplayer:get_weapon_by_hash(joaat("slot_pipebomb")):set_current_ammo(15) end end
end
menu.register_hotkey(RefIn, refillInventory)

local function HEAL()
	if localplayer:get_armour()<50 then localplayer:set_armour(50) else if localplayer:get_health()<localplayer:get_max_health()/2 then
	localplayer:set_health(localplayer:get_health()+snack*3) elseif localplayer:get_health()<localplayer:get_max_health() then
	if localplayer:get_health()+snack<localplayer:get_max_health() then localplayer:set_health(localplayer:get_health()+snack) else
	localplayer:set_health(localplayer:get_max_health()) end end end
end if heal then menu.register_hotkey(heal, HEAL) end









if MinProt[2]==1.64 then
-- Protections by TeaTimeTea
local pro = WepCD:add_submenu("More Protections")
 
 
local function Text(text)
	pro:add_action(text, function() end)
end
 
 
Text("➫GTAv1.64 Protections")
Text("--")
local function CeoKick(bool)
	if bool then 
		globals.set_bool(1669984, true)
	elseif bool==nil then
		return globals.get_bool(1669984)
	else
		globals.set_bool(1669984, false)
	end
end
 
local function KickCrashes(bool)
	if bool then 
		globals.set_bool(1670036, true)
		globals.set_bool(1670051, true)
		globals.set_bool(1669951, true)
		globals.set_bool(1670028, true)
		globals.set_bool(1670238, true)
	elseif bool==nil then
		return globals.get_bool(1670036)
	else
		globals.set_bool(1670036, false)
		globals.set_bool(1670051, false)
		globals.set_bool(1669951, false)
		globals.set_bool(1670028, false)
		globals.set_bool(1670238, false)
	end
end
 
local function CeoBan(bool)
	if bool then 
		globals.set_bool(1670006, true)
	elseif bool==nil then
		return globals.get_bool(1670006)
	else
		globals.set_bool(1670006, false)
	end
end
 
local function SoundSpam(bool)
	if bool then 
		globals.set_bool(1669879, true)
		globals.set_bool(1670243, true)
		globals.set_bool(1669394, true)
		globals.set_bool(1670529, true)
		globals.set_bool(1670058, true)
		globals.set_bool(1669421, true)
	elseif bool==nil then
		return globals.get_bool(1669879)
	else
		globals.set_bool(1669879, false)
		globals.set_bool(1670243, false) 
		globals.set_bool(1669394, false) 
		globals.set_bool(1670529, false)
		globals.set_bool(1670058, false)
		globals.set_bool(1669421, false)
	end
end
 
local function InfiniteLoad(bool)
	if bool then 		
		globals.set_bool(1669947, true) 
		globals.set_bool(1670076, true)
	elseif bool==nil then
		return globals.get_bool(1669947)
	else
		globals.set_bool(1669947, false)
		globals.set_bool(1670076, false)
	end
end
 
 
local function Collectibles(bool)
	if bool then 
		globals.set_bool(1670208, true)
	elseif bool==nil then
		return globals.get_bool(1670208)
	else
		globals.set_bool(1670208, false)
	end
end
 
local function PassiveMode(bool)
	if bool then 
		globals.set_bool(1669996, true)
	elseif bool==nil then
		return globals.get_bool(1669996)
	else
		globals.set_bool(1669996, false)
	end
end
 
local function TransactionError(bool) 
	if bool then 
		globals.set_bool(1669797, true)
	elseif bool==nil then
		return globals.get_bool(1669797)
	else
		globals.set_bool(1669797, false)
	end
end
 
local function RemoveMoneyMessage(bool) 
	if bool then 
		globals.set_bool(1669880, true)
		globals.set_bool(1669426, true)
		globals.set_bool(1670057, true)
		globals.set_bool(1669428, true)
	elseif bool==nil then
		return globals.get_bool(1669880)
	else
		globals.set_bool(1669880, false)
		globals.set_bool(1669426, false)
		globals.set_bool(1670057, false)
		globals.set_bool(1669428, false)
	end
end
 
local function ExtraTeleport(bool) 
	if bool then 
		globals.set_bool(1669741, true) 
		globals.set_bool(1670138, true)
	elseif bool==nil then
		return globals.get_bool(1669741)
	else
		globals.set_bool(1669741, false) 
		globals.set_bool(1670138, false) 
	end
end
 
 
local function ClearWanted(bool) 
	if bool then 
		globals.set_bool(1669938, true)
	elseif bool==nil then
		return globals.get_bool(1669938)
	else
		globals.set_bool(1669938, false)
	end
end
 
local function OffTheRadar(bool) 
	if bool then 
		globals.set_bool(1669940, true)
	elseif bool==nil then
		return globals.get_bool(1669940)
	else
		globals.set_bool(1669940, false)
	end
end
 
local function SendCutscene(bool) 
	if bool then 
		globals.set_bool(1670198, true)
	elseif bool==nil then
		return globals.get_bool(1670198)
	else
		globals.set_bool(1670198, false)
	end
end
 
local function Godmode(bool) 
	if bool then 
		globals.set_bool(1669396, true)
	elseif bool==nil then
		return globals.get_bool(1669396)
	else
		globals.set_bool(1669396, false)
	end
end
 
local function PersonalVehicleDestroy(bool) 
	if bool then 
		globals.set_bool(1669480, true)
		globals.set_bool(1670063, true) 
		globals.set_bool(1669947, true)
	elseif bool==nil then
		return globals.get_bool(1669480)
		
	else
		globals.set_bool(1669480, false)
		globals.set_bool(1670063, false) 
		globals.set_bool(1669947, false) 
	end
end
local boolall=false
local function All(bool) 
	CeoKick(bool)
	CeoBan(bool)
	SoundSpam(bool)
	InfiniteLoad(bool)		--.
	PassiveMode(bool)
	TransactionError(bool)
	RemoveMoneyMessage(bool)
	ClearWanted(bool)
	OffTheRadar(bool)
	PersonalVehicleDestroy(bool)
	SendCutscene(bool)
	Godmode(bool)
	Collectibles(bool)
	ExtraTeleport(bool)		--.
	KickCrashes(bool)		--.
end
 
pro:add_toggle("Actived All", function()
	return boolall
end, function()
	boolall = not boolall
	All(boolall)
	
end)
Text("--")
pro:add_toggle("Block Some Kicks&&Crashes", function()
	return KickCrashes()
end, function(v)
	--boolskc = not bboolskc
	KickCrashes(v)
	
end)
pro:add_toggle("Block Ceo Kick", function()
	return CeoKick()
end, function(v)
	--boolktsp = not boolktsp
	CeoKick(v)
	
end)
 
pro:add_toggle("Block Ceo Ban", function()
	return CeoBan()
end, function(v)
	--boolcb = not boolcb
	CeoBan(v)
	
end)
 
pro:add_toggle("Block Sound Spam", function()
	return SoundSpam()
end, function(v)
	--boolsps = not boolsps
	SoundSpam(v)
	
end)
 
pro:add_toggle("Block Infinite Loadingscreen", function()
	return InfiniteLoad()
end, function(v)
	--boolil = not boolil
	InfiniteLoad(v)
	
end)
 
pro:add_toggle("Block Passive Mode", function()
	return PassiveMode()
end, function(v)
	--boolb = not boolb
	PassiveMode(v)
	
end)
 
pro:add_toggle("Block Transaction Error", function()
	return TransactionError()
end, function(v)
	--boolte = not boolte
	TransactionError(v)
	
end)
 
pro:add_toggle("Block Modded Notifys/SMS", function()
	return RemoveMoneyMessage()
end, function(v)
	--boolrm = not boolrm
	RemoveMoneyMessage(v)
	
end)
 
pro:add_toggle("Block Clear Wanted", function()
	return ClearWanted()
end, function(v)
	--boolclw = not boolclw
	ClearWanted(v)
	
end)
 
pro:add_toggle("Block Off The Radar", function()
	return OffTheRadar()
end, function(v)
	--boolotr = not boolotr
	OffTheRadar(v)
	
end)
 
pro:add_toggle("Block Personal Vehicle Destroy", function()
	return PersonalVehicleDestroy()
end, function(v)
	--boolpvd = not boolpvd
	PersonalVehicleDestroy(v)
	
end)
 
pro:add_toggle("Block Send to Cutscene", function()
	return SendCutscene()
end, function(v)
	--boolstc = not boolstc
	SendCutscene(v)
	
end)
 
pro:add_toggle("Block Remove Godmode", function()
	return Godmode()
end, function(v)
	--boolgod = not boolgod
	Godmode(v)
	
end)
 
pro:add_toggle("Block Give Collectibles", function()
	return Collectibles()
end, function(v)
	--boolgc = not boolgc
	Collectibles(v)
	
end)
 
pro:add_toggle("Block Cayo && Beach Teleport", function()
	return ExtraTeleport()
end, function(v)
	--boolcbt = not boolcbt
	ExtraTeleport(v)
	
end)
 
 

 
Text("--")
Text("Tutorial on https://dsc.gg/thorben_")
Text("Updated/Added by ➫ ΞΛZТΞΛ#3171/SLON")  
Text("--")

if MinProt[1] then
	ExtraTeleport(true)
	KickCrashes(true)
	InfiniteLoad(true)
end

end

