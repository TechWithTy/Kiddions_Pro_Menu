require("scripts/global")



local function PlyVeh(veh)
	for i=0,31 do ply=player.get_player_ped(i)if ply then if ply:get_current_vehicle()==veh then return true end end end return false
end

local function TeleportPedsToPlayer(ply,dead)
	if ply==nil then return end pos2=ply:get_position()sleep(0.1)pos1=ply:get_position() disX=(pos1.x-pos2.x)disY=(pos1.y-pos2.y)disZ=(pos1.z-pos2.z)
	for ped in replayinterface.get_peds() do if ped and ped:get_pedtype()>3 then if not ped:is_in_vehicle() then
		ped:set_position(ply:get_position()+vector3(2*disX,2*disY,disZ))end end end
end

local function ExplodePlayer(ply)
	if ply==nil then return end pos2=ply:get_position()sleep(0.1)pos1=ply:get_position() disX=(pos1.x-pos2.x)disY=(pos1.y-pos2.y)disZ=(pos1.z-pos2.z)
	if localplayer:is_in_vehicle() then currentvehicle=localplayer:get_current_vehicle() end
	for veh in replayinterface.get_vehicles() do if not currentvehicle or currentvehicle~=veh then
		if not PlyVeh(veh) then acc=veh:get_acceleration() veh:set_acceleration(0) veh:set_rotation(vector3(0,0,180))
		veh:set_health(-1) veh:set_position(ply:get_position()+vector3(disX,disY,disZ)) veh:set_acceleration(acc) end end end
end
 
local function LaunchPlayer(ply)
	if ply==nil then return end pos2=ply:get_position() sleep(0.1) pos1=ply:get_position()
	disX=(pos1.x-pos2.x) disY=(pos1.y-pos2.y) disZ=(pos1.z-pos2.z) local currentvehicle = nil 
	if localplayer:is_in_vehicle() then currentvehicle = localplayer:get_current_vehicle() end
	for veh in replayinterface.get_vehicles() do if not currentvehicle or currentvehicle~=veh then
		if not PlyVeh(veh) then acc=veh:get_acceleration() veh:set_acceleration(0) veh:set_rotation(vector3(0,0,0))
		veh:set_gravity(-100) veh:set_position(ply:get_position()+vector3(2.5*disX, 2.5*disY, disZ-5)) veh:set_acceleration(acc) end end end
	sleep(1) for veh in replayinterface.get_vehicles() do if not currentvehicle or currentvehicle ~= veh then veh:set_gravity(9.8) end end
end
 
local function SlamPlayer(ply)
	if ply==nil then return end pos2=ply:get_position() sleep(0.1) pos1=ply:get_position()
	local currentvehicle=nil disX=(pos1.x-pos2.x) disY=(pos1.y-pos2.y) disZ=(pos1.z-pos2.z)
	if localplayer:is_in_vehicle() then currentvehicle=localplayer:get_current_vehicle() end
	for veh in replayinterface.get_vehicles() do if not currentvehicle or currentvehicle ~= veh then
		if not PlyVeh(veh) then acc=veh:get_acceleration() veh:set_acceleration(0) veh:set_rotation(vector3(0,0,0))
			veh:set_gravity(10000) veh:set_position(ply:get_position()+vector3(5*disX, 5*disY, disZ + 100)) veh:set_acceleration(acc) end end end
	sleep(1) for veh in replayinterface.get_vehicles() do if not currentvehicle or currentvehicle ~= veh then
		if not ply:get_current_vehicle() or ply:get_current_vehicle() ~= veh then veh:set_gravity(9.8) end end end
end

local function lpBmb()
	ind=globals.get_int(CrVO+27+6)  SlPl=player.get_player_ped(ind)  globals.set_int(CrVO+27+6, 0)
	while SlPl~=nil and globals.get_int(CrVO+27+76)~=2 do
		CrVh(joaat("kosatka"),vector3(505,780,205))
		TeleportPedsToPlayer(SlPl)sleep(0.5) 	ExplodePlayer(SlPl)sleep(1.5)
		if not player.get_player_ped(ind)then return end if globals.get_int(CrVO+27+76)and globals.get_int(CrVO+27+76)==2 then return end
		LaunchPlayer(SlPl)sleep(3)
		CrVh(joaat("alkonost"),vector3(505,780,205))
		if not player.get_player_ped(ind)then return end if globals.get_int(CrVO+27+76)and globals.get_int(CrVO+27+76)==2 then return end
		ExplodePlayer(SlPl)sleep(0.5)			SlamPlayer(SlPl)sleep(1.5)			
		if not player.get_player_ped(ind)then return end if globals.get_int(CrVO+27+76)and globals.get_int(CrVO+27+76)==2 then return end
		ExplodePlayer(SlPl)sleep(0.5)			ExplodePlayer(SlPl)sleep(0.5)		ExplodePlayer(SlPl)sleep(1.5)
	end
end

local function Shoot(ply)
	if player.get_player_ped():is_in_vehicle()then pos1=player.get_player_ped():get_current_vehicle():get_position()
	Rota=player.get_player_ped():get_current_vehicle():get_rotation()else
	pos1=player.get_player_ped():get_position()Rota=player.get_player_ped():get_rotation()end	pos2=ply:get_position()

	sH=math.sqrt((pos2.x-pos1.x)^2+(pos2.y-pos1.y)^2)	hi=pos2.z-pos1.z
	Dist=math.sqrt(((pos2.x-pos1.x)^2)+((pos2.y-pos1.y)^2)+((pos2.z-pos1.z)^2))if Dist>1500 then return end
	
	if pos2.x>pos1.x and pos2.y>pos1.y then Qd=1 elseif pos2.x<pos1.x and pos2.y>pos1.y then Qd=2 elseif
	pos2.x<pos1.x and pos2.y<pos1.y then Qd=3 elseif pos2.x>pos1.x and pos2.y<pos1.y then Qd=4 end if not Qd then return false end
	if Qd==1 or Qd==3 then sA=math.sqrt((pos2.x-pos1.x)^2)else sA=math.sqrt((pos2.y-pos1.y)^2)end
	Ang=math.acos(sA/sH) if Qd>1 then Rad=Ang+(Qd-2)*1.57 else Rad=Ang+4.71 end if Rad>3.14 then Rad=Rad-6.28 end  --+(1500-Dist)/80000
	
	if player.get_player_ped():is_in_vehicle()then P=math.acos(sH/Dist) if hi<0 then P=-P end  --+(1500-Dist)/40000
			--print("In Veh")	--print(math.sqrt((Rad-Rota.x)^2)..", "..math.sqrt((P-Rota.z)^2) )--Rad.." and "..P
		if math.sqrt((Rad-Rota.x)^2)<(1500-Dist)/200000 and math.sqrt((P-Rota.z)^2)<0.05 then menu.send_key_press(keyNum0)end
	else
			--print(math.sqrt((Rad-player.get_player_ped():get_rotation().x)^2)..", "..(1500-Dist)/10000000 )		--Rad.." and "..P
		if math.sqrt((Rad-player.get_player_ped():get_rotation().x)^2)<(1500-Dist)/200000 then menu.send_key_press(keyNum0)end end
end


menu.register_hotkey(155, lpBmb)

local function Bot()
	inde=globals.get_int(CrVOx)
	while(true)do
		if globals.get_int(CrVOy)==0 or not player.get_player_ped(inde)or player.get_player_ped(inde)==player.get_player_ped()then
			globals.set_int(CrVOy,0)return end
		if player.get_player_ped():is_in_vehicle()then Shoot(player.get_player_ped(inde))
		elseif flag(78)then Shoot(player.get_player_ped(inde))end 
	end
end
menu.register_hotkey(156, Bot)
