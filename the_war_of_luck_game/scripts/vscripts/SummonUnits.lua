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
				[5] = "Swordsman",
				[6] = "Pudge",
				[7] = "Earth",
				[8] = "Clockwerk",
				[9] = "Satyr",
				[10] = "Jade",
				[11] = "Ursa",
				[12] = "Slark",
				[13] = "Phantom Assassin",
				[14] = "Fighter of Madness",
				[15] = "Jade"
				
		


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




function SummonUnits:Allocate(keys) -- move the hero to the target position.
	local pID = keys.player
	print("pp0",pID)
	local hero = EntIndexToHScript(keys.heroindex)
	local target_entity = nil
	local team = hero:GetTeamNumber()
	if team == 2 then --Radiant
		local r_player_count = PlayerResource:GetPlayerCountForTeam(team) -- check how many players, i.e. how many heroes needs to move.
		for i = 1, r_player_count+1 do 
			if self.hero_entities[i].occupied ~= true then --if the position is occupied by another hero?
				target_entity = self.hero_entities[i]
				self.hero_entities[i].occupied = true
				Timers:CreateTimer(0.2, function ()
					hero:SetAbsOrigin(target_entity:GetAbsOrigin())
					self:SummonCreepsWithHero(i,team,keys) -- once the hero is done, summons creeps in the respective area. 
					return nil
				end
				)
				break -- if the hero has a place to go, then jumps out.
			else
				i = i+1
			end
		end

		
		
		
	--Dire, same as above.
	elseif team == 3 then 
		local d_player_count = PlayerResource:GetPlayerCountForTeam(team)
		for i = 1, d_player_count+1 do 
			if self.d_hero_entities[i].occupied ~= true then
				target_entity = self.d_hero_entities[i]
				self.d_hero_entities[i].occupied = true
				Timers:CreateTimer(0.2, function ()
						self:SummonCreepsWithHero(i,team,keys)
						hero:SetAbsOrigin(target_entity:GetAbsOrigin())
					return nil
				end
				)
				break
			else
				i = i+1
			end
		end
	
		
	end
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
	local hero = EntIndexToHScript(keys.heroindex)
	local pID = hero:GetPlayerID() 
	local player = hero:GetPlayerOwner()
	local playerOwnerId = hero:GetPlayerOwnerID()
	hero.creepName = unitToSummon

	if team == 2 then
		CreepEntities = self.r_Ent[Index] -- gets 6 entities(which represents the position).
		for _,ent in pairs(CreepEntities) do
			local creep = CreateUnitByName(unitToSummon, ent:GetAbsOrigin(), true, player, player, 2)
			creep:SetControllableByPlayer(playerOwnerId, false)
			creep:SetForwardVector(Vector(0,-1,0))
		end
		Timers:CreateTimer(0.1, function()
			PlayerResource:SetCameraTarget(pID, CreepEntities[1]) -- semmingly out of function. 
      		return nil
    	end
  		)

	elseif team == 3 then
		CreepEntities = self.d_Ent[Index]
		for _,ent in pairs(CreepEntities) do
			local creep = CreateUnitByName(unitToSummon, ent:GetAbsOrigin(), true, player, player, 3)
			creep:SetControllableByPlayer(playerOwnerId, false)
			creep:SetForwardVector(Vector(0,1,0))
		end
		Timers:CreateTimer(0.1, function()
			PlayerResource:SetCameraTarget(playerOwnerId, CreepEntities[1])
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
		 	unit:RemoveSelf()
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

