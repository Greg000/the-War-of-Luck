require("lib/test_mode")

if SummonUnits == nil then
	SummonUnits = class({})
end

function SummonUnits:Precache()
	self.r_Ent={
				[1]=Entities:FindAllByName("path_creep1*"),
				[2]=Entities:FindAllByName("path_creep2*"),
				[3]=Entities:FindAllByName("path_creep3*"),
				[4]=Entities:FindAllByName("path_creep4*"),
				[5]=Entities:FindAllByName("path_creep5*")
	}
	
	self.d_Ent={
				[1]=Entities:FindAllByName("d_path_creep1*"),
				[2]=Entities:FindAllByName("d_path_creep2*"),
				[3]=Entities:FindAllByName("d_path_creep3*"),
				[4]=Entities:FindAllByName("d_path_creep4*"),
				[5]=Entities:FindAllByName("d_path_creep5*")

	}
				 

self.UnitsTable = {
				[1] = "Dark Spirit",
				[2] = "Bounty Hunter",
				[3] = "Rock",
				[4] = "Warrior",
				[5] = "Pudge",
				[6] = "Earth",
				[7] = "Clockwerk",
				[8] = "Satyr",
				[9] = "Jade",
				[10] = "Ursa",
				[11] = "Slark",
				[12] = "Phantom Assassin",
				[13] = "Fighter of Madness",
				[14] = "Rhino Warrior",
				[15] = "Centaur",
				[16] = "Ogre Thug",
				[17] = "Ogre Bruiser",
				[18] = "Giant Wolf",
				[19] = "Ghost",
				[20] = "Tusk",
				[21] = "Rifleman",
				[22] = "Gargoyle",
				[23] = "Nyx Assassin",
				[24] = "Satyr_b",
				[25] = "Nature's Prophet"
}


				


	self.hero_entities = {
		[1] = Entities:FindByName(nil,"path_hero1"),
		[2] = Entities:FindByName(nil,"path_hero2"),
		[3] = Entities:FindByName(nil,"path_hero3"),
		[4] = Entities:FindByName(nil,"path_hero4"),
		[5] = Entities:FindByName(nil,"path_hero5")
	}

	for _,entity in pairs(self.hero_entities) do
		entity.occupied = false
	end

	self.d_hero_entities = {
		[1] = Entities:FindByName(nil,"d_path_hero1"),
		[2] = Entities:FindByName(nil,"d_path_hero2"),
		[3] = Entities:FindByName(nil,"d_path_hero3"),
		[4] = Entities:FindByName(nil,"d_path_hero4"),
		[5] = Entities:FindByName(nil,"d_path_hero5")
	}

	for _,entity in pairs(self.d_hero_entities) do
		entity.occupied = false
	end

	self.hero = {
		[1] = "npc_dota_hero_crystal_maiden",	
		[2] = "npc_dota_hero_legion_commander",
		[3] = "npc_dota_hero_ember_spirit",	
		[4] = "npc_dota_hero_abaddon",		
		[5] = "npc_dota_hero_kunkka",		
		[6] = "npc_dota_hero_windrunner",	
		[7] = "npc_dota_hero_abyssal_underlord",
		[8] = "npc_dota_hero_templar_assassin",
		[9] = "npc_dota_hero_tinker",
		[10] = "npc_dota_hero_oracle",
		[11] = "npc_dota_hero_dragon_knight",
		[12] = "npc_dota_hero_rubick"
	}
end



function SummonUnits:Allocate() -- move the hero to the target position.
	for i = 0, DOTA_MAX_TEAM_PLAYERS do
        if PlayerResource:IsValidPlayer(i) then
        	local pID = i
			local player = PlayerResource:GetPlayer(pID)
			local target_entity = nil
			local team = PlayerResource:GetTeam(pID)
			if team == 2 then --Radiant
				local r_player_count = PlayerResource:GetPlayerCountForTeam(team) -- check how many players, i.e. how many heroes needs to move.
				for i = 1, r_player_count + 1 do 
					if self.hero_entities[i].occupied ~= true then --if the position is occupied by another hero?
						player.respawn_index = i
						self.hero_entities[i].occupied = true
					--self:SummonCreepsWithHero(i,team,keys) -- create creeps first, in case of the situation that PID can't funtion correctly.
						break -- if the hero has a place to go, then jumps out.
					else
						i = i + 1
					end
				end
			end
		
		
			--Dire, same as above.
			if team == 3 then --Radiant
				local d_player_count = PlayerResource:GetPlayerCountForTeam(team) -- check how many players, i.e. how many heroes needs to move.
				for i = 1, d_player_count + 1 do 
					if self.d_hero_entities[i].occupied ~= true then --if the position is occupied by another hero?
						player.respawn_index = i
						self.d_hero_entities[i].occupied = true
					--self:SummonCreepsWithHero(i,team,keys) -- create creeps first, in case of the situation that PID can't funtion correctly.
						break -- if the hero has a place to go, then jumps out.
					else
						i = i + 1
					end
				end
			end
		end
	end	                           
end

function SummonUnits:SummonHeroesandCreeps(pID)
	local player = PlayerResource:GetPlayer(pID)
	local respawn_index = player.respawn_index
	local team = PlayerResource:GetTeam(pID)
	local target_entity = nil
	if team == 2 then
		target_entity = self.hero_entities[respawn_index]
	elseif team == 3 then
		target_entity = self.d_hero_entities[respawn_index]
	end
	self:SummonCreepsWithHero(respawn_index,team,pID)

	local newHeroName = SummonUnits:GetNewHero(IsTestMode,pID)
	--[[while (newHeroName == oldHeroName) do
		newHeroName = SummonUnits:GetRandomHeroName()
	end]]--
	newHero = PlayerResource:ReplaceHeroWith(pID, newHeroName, 0, 0)
	newHero:SetAbsOrigin(target_entity:GetAbsOrigin())
	SummonUnits:ResetSkills(pID)
	newHero:SetAbilityPoints(10)
	newHero:SetRespawnsDisabled(true)
end

function SummonUnits:SummonCreepsWithHero (Index,team,pID)
	local IsTestMode = TestMode:IsTestMode()
	SummonUnits:GetCreepName(IsTestMode,pID)
	local player = PlayerResource:GetPlayer(pID)
	player.ownedCreeps = {}
	local unitToSummon = player.AssignedCreep
	if team == 2 then
		CreepEntities = self.r_Ent[Index] -- gets 6 entities(which represents the position).
		for i,ent in pairs(CreepEntities) do
			local creep = CreateUnitByName(unitToSummon, ent:GetAbsOrigin(), true, player, player, 2)
			player.ownedCreeps[i] = creep
			creep:SetControllableByPlayer(pID, false)
			creep:SetForwardVector(Vector(0,-1,0))
		end
		Timers:CreateTimer(0.1, function()
			PlayerResource:SetCameraTarget(pID, CreepEntities[1]) -- semmingly out of function. 
      		return nil
    	end
  		)

	elseif team == 3 then
		CreepEntities = self.d_Ent[Index] -- gets 6 entities(which represents the position).
		for i,ent in pairs(CreepEntities) do
			local creep = CreateUnitByName(unitToSummon, ent:GetAbsOrigin(), true, player, player, 3)
			player.ownedCreeps[i] = creep
			creep:SetControllableByPlayer(pID, false)
			creep:SetForwardVector(Vector(0,1,0))
		end
		Timers:CreateTimer(0.1, function()
			PlayerResource:SetCameraTarget(pID, CreepEntities[1]) -- semmingly out of function. 
      		return nil
    	end
  		)
	end
end

function SummonUnits:Invulnerability(deadUnit) --freezes all the remining targets.
	local units = FindUnitsInRadius(deadUnit:GetTeamNumber(), Vector(0,0,0), nil, 20000, 2, 63, 0, 0, false)
	for _,unit in pairs(units) do
		unit:AddNewModifier(unit, nil, "modifier_invulneral_lua", {})
		Timers:CreateTimer(4.5, function()
			if unit:IsHero() == false then
		 		unit:RemoveSelf()
			end
		 end)
	end
end

function SummonUnits:KillRemnant(deadUnit) -- kills all units of the losing team.
	local units = FindUnitsInRadius(deadUnit:GetTeamNumber(), Vector(0,0,0), nil, 20000, 1, 63, 0, 0, false)
	for _,unit in pairs(units) do
		print(unit:GetUnitName())
		unit:ForceKill(false)
	end
end

function SummonUnits:GetNewHero(IsTestMode,pID)
	if IsTestMode then
		local player = PlayerResource:GetPlayer(pID)
		local originalHero = player:GetAssignedHero()
		return originalHero:GetUnitName()
	else
		local heroName = self.hero[RandomInt(1, table.getn(self.hero))] -- chooses a random hero.
		return heroName
	end
end

function SummonUnits:GetCreepName(IsTestMode,pID)
	local player = PlayerResource:GetPlayer(pID)
	if IsTestMode and player.AssignedCreep ~= nil then
		return
	end

	local player = PlayerResource:GetPlayer(pID)
	local creepName = self.UnitsTable[RandomInt(1, table.getn(self.UnitsTable))] 
	player.AssignedCreep = creepName
end


function SummonUnits:TestPID(keys)
	Say(nil, tostring(keys.player_id), true)
end

function SummonUnits:ResetSkills(pID)

	local player = PlayerResource:GetPlayer(pID)
	local hero = player:GetAssignedHero()
	for i = 0, hero:GetAbilityCount() do
		if hero:GetAbilityByIndex(i) ~= nil then
			hero:GetAbilityByIndex(i):SetLevel(0)
			print(hero:GetAbilityByIndex(i):GetAbilityName(),i)
			if hero:GetAbilityByIndex(i):GetAbilityName() == "dragon_form"  then
				Timers:CreateTimer(0.03, function()
					hero:GetAbilityByIndex(i):SetLevel(1)
					return nil
				end)
				
			end
		end

	end
end

function SummonUnits:New_Hero_Testmode(hero_index,pID)
	local player = PlayerResource:GetPlayer(pID)
	local respawn_index = player.respawn_index
	local team = PlayerResource:GetTeam(pID)
	local target_entity = nil
	if team == 2 then
		target_entity = self.hero_entities[respawn_index]
	elseif team == 3 then
		target_entity = self.d_hero_entities[respawn_index]
	end
	local newHeroName = self.hero[hero_index]

	newHero = PlayerResource:ReplaceHeroWith(pID, newHeroName, 0, 0)
	newHero:SetAbsOrigin(target_entity:GetAbsOrigin())
	SummonUnits:ResetSkills(pID)
	newHero:SetAbilityPoints(10)
	newHero:SetRespawnsDisabled(true)
end

function SummonUnits:New_Creep_Testmode(creep_index,pID)
	local player = PlayerResource:GetPlayer(pID)
	local Index = player.respawn_index
	local team = PlayerResource:GetTeam(pID)
	for _,creep in pairs(player.ownedCreeps) do
		if creep:IsAlive() then
			creep:RemoveSelf()
		end
	end

	local unitToSummon = self.UnitsTable[creep_index]
	print("unitToSummon",creep_index)
	if team == 2 then
		CreepEntities = self.r_Ent[Index] -- gets 6 entities(which represents the position).
		for i,ent in pairs(CreepEntities) do
			local creep = CreateUnitByName(unitToSummon, ent:GetAbsOrigin(), true, player, player, 2)
			player.ownedCreeps[i] = creep
			creep:SetControllableByPlayer(pID, false)
			creep:SetForwardVector(Vector(0,-1,0))
		end
		Timers:CreateTimer(0.1, function()
			PlayerResource:SetCameraTarget(pID, CreepEntities[1]) -- semmingly out of function. 
      		return nil
    	end
  		)

	elseif team == 3 then
		CreepEntities = self.d_Ent[Index] -- gets 6 entities(which represents the position).
		for i,ent in pairs(CreepEntities) do
			local creep = CreateUnitByName(unitToSummon, ent:GetAbsOrigin(), true, player, player, 3)
			player.ownedCreeps[i] = creep
			creep:SetControllableByPlayer(pID, false)
			creep:SetForwardVector(Vector(0,1,0))
		end
		Timers:CreateTimer(0.1, function()
			PlayerResource:SetCameraTarget(pID, CreepEntities[1]) -- semmingly out of function. 
      		return nil
    	end
  		)
	end
end