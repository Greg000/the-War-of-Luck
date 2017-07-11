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
				[19] = "Ghost"
		
				

				}

	--[[local HeroTable = {
				[1] = "Crystal Maiden"
			--	[2] = "Crystal Maiden",
				--[3] = "Ember"

				}
	--]]
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
		[10] = "npc_dota_hero_oracle"
	}


	
end




function SummonUnits:Allocate(keys) -- move the hero to the target position.
	DeepPrintTable(keys)
	local pID = keys.player_id
	local target_entity = nil
	local team = PlayerResource:GetTeam(pID)
	if team == 2 then --Radiant
		local r_player_count = PlayerResource:GetPlayerCountForTeam(team) -- check how many players, i.e. how many heroes needs to move.
		for i = 1, r_player_count + 1 do 
			if self.hero_entities[i].occupied ~= true then --if the position is occupied by another hero?
				target_entity = self.hero_entities[i]
				self.hero_entities[i].occupied = true
				self:SummonCreepsWithHero(i,team,keys) -- create creeps first, in case of the situation that PID can't funtion correctly.
				break -- if the hero has a place to go, then jumps out.
			else
				i = i+1
			end
		end
	end
		
		
	--Dire, same as above.
	if team == 3 then --Radiant
		local r_player_count = PlayerResource:GetPlayerCountForTeam(team) -- check how many players, i.e. how many heroes needs to move.
		for i = 1, r_player_count + 1 do 
			if self.d_hero_entities[i].occupied ~= true then --if the position is occupied by another hero?
				target_entity = self.d_hero_entities[i]
				self.d_hero_entities[i].occupied = true
				self:SummonCreepsWithHero(i,team,keys) -- create creeps first, in case of the situation that PID can't funtion correctly.
				break -- if the hero has a place to go, then jumps out.
			else
				i = i+1
			end
		end
	end
	local heroName = SummonUnits:GetRandomHeroName()	
	newHero = PlayerResource:ReplaceHeroWith(pID, heroName, 0, 0)
	newHero:SetAbsOrigin(target_entity:GetAbsOrigin())
	newHero:SetAbilityPoints(10)
	
end

function SummonUnits:ReAllocate(keys) -- respawns a new hero when the next round starts.
	local hero = EntIndexToHScript(keys.entindex_killed)
	local pID = hero:GetPlayerID()
	local target_entity = nil
	local team = hero:GetTeamNumber()

	--radiant
	if team == 2 then
		local r_player_count = PlayerResource:GetPlayerCountForTeam(team)
		for i = 1, r_player_count+1 do 
			if self.hero_entities[i].occupied ~= true then
				target_entity = self.hero_entities[i]
				self.hero_entities[i].occupied = true
				Timers:CreateTimer(0.2, function ()
						self:R_SummonCreepsWithHero(i,team,keys) -- uses a different function because keys are different.
					return nil
				end
				)
			break --jumps out.
			else
				i = i+1
			end
		end

	--dire
	elseif team == 3 then
		local d_player_count = PlayerResource:GetPlayerCountForTeam(team)
		for i = 1, d_player_count+1 do 
			if self.d_hero_entities[i].occupied ~= true then
				target_entity = self.d_hero_entities[i]
				self.d_hero_entities[i].occupied = true
				Timers:CreateTimer(0.2, function ()
						self:R_SummonCreepsWithHero(i,team,keys)
					return nil
			end
				)
			break
			else
				i = i+1
			end
		end
	end

    local heroName = self.hero[RandomInt(1, table.getn(self.hero))] -- chooses a random hero.
	newHero = PlayerResource:ReplaceHeroWith(pID, heroName, 0, 0)
	newHero:SetAbsOrigin(target_entity:GetAbsOrigin())
	
end


function SummonUnits:SummonCreepsWithHero (Index,team,keys)
	local unitToSummon = self.UnitsTable[RandomInt(1, table.getn(self.UnitsTable))]
	local pID = keys.player_id 
	local passedid = keys.player_id
	local player = PlayerResource:GetPlayer(pID)
	player.creepName = unitToSummon
	if team == 2 then
		CreepEntities = self.r_Ent[Index] -- gets 6 entities(which represents the position).
		for _,ent in pairs(CreepEntities) do
			local creep = CreateUnitByName(unitToSummon, ent:GetAbsOrigin(), true, player, player, 2)

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
		for _,ent in pairs(CreepEntities) do
			local creep = CreateUnitByName(unitToSummon, ent:GetAbsOrigin(), true, player, player, 3)

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


function SummonUnits:R_SummonCreepsWithHero (Index,team,keys)
	local unitToSummon = self.UnitsTable[RandomInt(1, table.getn(self.UnitsTable))]
	local hero = EntIndexToHScript(keys.entindex_killed)
	local pID = hero:GetPlayerID() 
	local player = hero:GetPlayerOwner()
	local playerOwnerId = hero:GetPlayerOwnerID()
	hero.creepName = unitToSummon

	if team == 2 then
		CreepEntities = self.r_Ent[Index]
		for _,ent in pairs(CreepEntities) do
			local creep = CreateUnitByName(unitToSummon, ent:GetAbsOrigin(), true, player, player, 2)
			creep:SetControllableByPlayer(playerOwnerId, false)
			creep:SetForwardVector(Vector(0,-1,0))
		end
		PlayerResource:SetCameraTarget(pID, CreepEntities[1])
	elseif team == 3 then
		CreepEntities = self.d_Ent[Index]
		for _,ent in pairs(CreepEntities) do
			local creep = CreateUnitByName(unitToSummon, ent:GetAbsOrigin(), true, player, player, 3)
			creep:SetControllableByPlayer(playerOwnerId, false)
			creep:SetForwardVector(Vector(0,1,0))
		end
		PlayerResource:SetCameraTarget(pID, CreepEntities[1])
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

function SummonUnits:GetRandomHeroName()
	local heroName = self.hero[RandomInt(1, table.getn(self.hero))] -- chooses a random hero.
	return heroName
end

function SummonUnits:TestPID(keys)
	Say(nil, tostring(keys.player_id), true)
end