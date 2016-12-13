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
				--[[[1] = "Dark Spirit",
				[2] = "Gnoll Assassin",
				[3] = "Rock",
				[4] = "Warrior",
				[5] = "Swordman",
				[6] = "Pudge",
				[7] = "Earth",
				[8] = "Clockwreck",
				[9] = "Satyr"
				[10] = "Jade"]]--
				[1] = "Ursa"
			
				
		


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
		[1] = "npc_dota_hero_wisp",
		[2] = "npc_dota_hero_juggernaut",
		[3] = "npc_dota_hero_crystal_maiden",
		[4] = "npc_dota_hero_legion_commander",
		[5] = "npc_dota_hero_ember_spirit",
		[6] = "npc_dota_hero_abaddon" 
	}

	
end

function SummonUnits:Allocate(keys)
	local pID = keys.player
	print("pp0",pID)
	local hero = EntIndexToHScript(keys.heroindex)
	local target_entity = nil
	local team = hero:GetTeamNumber()
	if team == 2 then
		local r_player_count = PlayerResource:GetPlayerCountForTeam(team)
		for i = 1, r_player_count+1 do 
			if self.hero_entities[i].occupied ~= true then
				target_entity = self.hero_entities[i]
				self.hero_entities[i].occupied = true
				self:SummonCreepsWithHero(i,team,pID)
				break
			else
				i = i+1
			end
		end
		local player = EntIndexToHScript(pID)
    	local hero = player:GetAssignedHero()
		hero:SetAbsOrigin(target_entity:GetAbsOrigin())

	elseif team == 3 then 
		local d_player_count = PlayerResource:GetPlayerCountForTeam(team)
		for i = 1, d_player_count+1 do 
			if self.d_hero_entities[i].occupied ~= true then
				target_entity = self.d_hero_entities[i]
				self.d_hero_entities[i].occupied = true
				self:SummonCreepsWithHero(i,team,pID)
				break
			else
				i = i+1
			end
		end
		local player = EntIndexToHScript(pID)
    	local hero = player:GetAssignedHero()
		hero:SetAbsOrigin(target_entity:GetAbsOrigin())
	end
end

function SummonUnits:ReAllocate(keys)
	local hero = EntIndexToHScript(keys.entindex_killed)
	local pID = hero:GetPlayerID()
	print("pp",pID)
	local target_entity = nil
	local team = hero:GetTeamNumber()
	print("dead","team",team)
	if team == 2 then
		local r_player_count = PlayerResource:GetPlayerCountForTeam(team)
		for i = 1, r_player_count+1 do 
			if self.hero_entities[i].occupied ~= true then
				target_entity = self.hero_entities[i]
				self.hero_entities[i].occupied = true
				self:R_SummonCreepsWithHero(i,team,pID)
			break
			else
				i = i+1
			end
		end

	elseif team == 3 then
		local d_player_count = PlayerResource:GetPlayerCountForTeam(team)
		for i = 1, d_player_count+1 do 
			if self.d_hero_entities[i].occupied ~= true then
				target_entity = self.d_hero_entities[i]
				self.d_hero_entities[i].occupied = true
				self:SummonCreepsWithHero(i,team,pID)
				break
			else
				i = i+1
			end
		end
	end
    local heroName = self.hero[RandomInt(1, table.getn(self.hero))]
	print(table.getn(self.hero))
	print("heroname",heroName)
	newHero = PlayerResource:ReplaceHeroWith(pID, heroName, 0, 0)
	newHero:SetAbsOrigin(target_entity:GetAbsOrigin())
	
end


function SummonUnits:SummonCreepsWithHero (Index,team,pID)
	local unitToSummon = self.UnitsTable[RandomInt(1, table.getn(self.UnitsTable))]
	local player = EntIndexToHScript(pID)
    local hero = player:GetAssignedHero()
	local playerOwnerId = hero:GetPlayerOwnerID()
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


function SummonUnits:R_SummonCreepsWithHero (Index,team,pID)
	local unitToSummon = self.UnitsTable[RandomInt(1, table.getn(self.UnitsTable))]
	local player = PlayerResource:GetPlayer(pID)
    local hero = player:GetAssignedHero()
	local playerOwnerId = hero:GetPlayerOwnerID()
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

function SummonUnits:Invulnerability(deadUnit)
	local units = FindUnitsInRadius(deadUnit:GetTeamNumber(), Vector(0,0,0), nil, 20000, 2, 63, 0, 0, false)
	for _,unit in pairs(units) do
		print(unit:GetUnitName())
		unit:AddNewModifier(unit, nil, "modifier_invulneral_lua", {})
		 Timers:CreateTimer(4.5, function()
		 	unit:RemoveSelf()
		 end)
	end
end

function SummonUnits:KillRemnant(deadUnit)
	local units = FindUnitsInRadius(deadUnit:GetTeamNumber(), Vector(0,0,0), nil, 20000, 1, 63, 0, 0, false)
	for _,unit in pairs(units) do
		print(unit:GetUnitName())
		unit:ForceKill(false)
	end
end

