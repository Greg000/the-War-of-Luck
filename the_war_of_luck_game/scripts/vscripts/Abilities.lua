

function Attack_Reflection(keys)
	local target = keys.attacker
	local caster = keys.caster
	local damage = keys.DamageTaken*0.5
 	
 		if RollPercentage(10) then
			print(attacker)	
			ApplyDamage({ victim = target, attacker = caster, damage = damage,	damage_type = DAMAGE_TYPE_MAGICAL })
		end

end


function Suiside_effect(keys)
	local Hero = keys.caster
	local ori = Hero:GetAbsOrigin()
	ParticleManager:CreateParticle("particles/units/heroes/hero_nevermore/nevermore_shadowraze.vpcf", 1, Hero) 
	ParticleManager:CreateParticle("particles/units/heroes/hero_techies/techies_suicide_base.vpcf", 1, Hero) 
	Hero:AddNewModifier(hero, nil, "modifier_kill", {duration = 1})


	
end

function Regeneration_buff(keys)
	local time = 0
	local targets = keys.target_entities
	ability = keys.ability
	GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("Regeneration_buff_timer"),
			function ()
				
				if time < 8 then
					print("Success")
					for i,j in pairs (targets) do
						print("inside")
						ability:ApplyDataDrivenModifier(j, j, "modifier_Regeneration", {duration = 10000}) 
						

						if IsValidEntity(unit) and unit:IsAlive() then  
                         	local damageTable = {victim=j,    
                                                 attacker=caster,        
                                                 damage=keys.ability:GetLevelSpecialValueFor("Heal", 1),      
                                                 damage_type=keys.ability:GetAbilityDamageType()}   
                           	ApplyDamage(damageTable) 
                        end

					end

					time = time + 0.5
					return 1
				else
					return nil
				end
			end,
			0.5)	
end

function SummonNecro(keys)
	local caster = keys.caster
	local ori = caster:GetAbsOrigin()
	local Units = FindUnitsInRadius(caster:GetTeamNumber(), ori, nil, 50000, 0, 0, 0, 0, false) 
	local vec = caster:GetForwardVector()
	local SummonLoc = ori + vec*100
	local UnitsCount = table.getn(Units)
	local SummonCount = 9 - UnitsCount
	local Necro = {}
	for i = 1,SummonCount do
		Necro[i] = CreateUnitByName("necro_archer", SummonLoc, true, caster, caster, 1) 
		Necro[i]:SetModelScale(0.01)
		local posi = Necro[i]:GetAbsOrigin()
		ParticleManager:CreateParticle("particles/skills/necro_summonstart.vpcf", 0, Necro[i]) 
	end

end

function Necro_Scale(keys)
	local SummonedNecro = {}
	print("1111")
	SummonedNecro = Entities:FindAllByModel("models/creeps/item_creeps/i_creep_necro_archer/necro_archer.vmdl")
	for i = 1,table.getn(SummonedNecro) do
		print(SummonedNecro[i])
		print(table.getn(SummonedNecro))
		SummonedNecro[i]:SetModelScale(0.5)
	end
end


function Lazer_Effect(keys)
	local caster = keys.caster
	local CasterPosi = caster:GetAbsOrigin()
	local vec = caster:GetForwardVector()
	local TargetPosi = CasterPosi + vec*5000

	local LazerBeam = ParticleManager:CreateParticle("particles/skills/lazer/lazer2ray_team.vpcf", 0,caster)
	ParticleManager:SetParticleControl(LazerBeam,03,TargetPosi)
end

function FireStep(keys)
	local caster = keys.caster
	local posi = caster:GetAbsOrigin()
	local fire = ParticleManager:CreateParticle("particles/skills/firesteps_revised/firestep.vpcf",0,caster)
	ParticleManager:SetParticleControl(fire, 11, Vector(1,0,0))
	FireStep_times = 0
	GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("FireStep_timer"),
		function ()
				if FireStep_times < 7 then
					ParticleManager:SetParticleControl(fire, 0, caster:GetAbsOrigin()) 
					FireStep_times = FireStep_times+1
					local damageTable = {victim=caster,
                                         attacker=caster,
                                         damage=20,        
                                         damage_type=keys.ability:GetAbilityDamageType()} 
                	ApplyDamage(damageTable) 

                	FireStep_times = FireStep_times +0.2
                	return 1

            	else
            		return nil
                end
		end,
		0.2)

end

function Forced_Attack(keys)
	local target = keys.target
	local caster = keys.caster
	local ability = keys.ability
	print(target)
	ability:ApplyDataDrivenModifier(target, target, "modifier_forced_attack_count", {duration = 10000})

	target:SetModifierStackCount("modifier_forced_attack_count",target,4)

end

function Forced_Attack_Remove(keys)
	local attacker = keys.attacker
	print(attacker)
	local caster = keys.caster
	local ability = keys.ability
	local currentStack = attacker:GetModifierStackCount("modifier_forced_attack_count",attacker)
	if currentStack-1 > 0 then 
		attacker:SetModifierStackCount("modifier_forced_attack_count",attacker,currentStack-1)
	end	
	if currentStack-1 == 0 then
		attacker:RemoveModifierByName("modifier_forced_attack_count") 
	end
end

function Forced_Attack_Check(keys)
	local targets = keys.target_entities
	for _,i in pairs(targets) do
		if i:FindModifierByName("modifier_forced_attack_count") then
			print("111")
			local damageTable = {victim=i,
                                         attacker=i,
                                         damage=2000,        
                                         damage_type=keys.ability:GetAbilityDamageType()} 
                	ApplyDamage(damageTable) 

		end
	end
end

function Defence_start(keys)
	local caster = keys.caster
	local ability = caster:FindAbilityByName("Defence")
	local abilityCasting = caster:FindAbilityByName("Defence_casting")
	abilityCasting:SetHidden(true)
	ability:SetHidden(false)
	ability:SetLevel(1)
	ability:ToggleAbility()

end
 

 function Defence_end(keys)
 	local caster = keys.caster
 	local ability = caster:FindAbilityByName("Defence")
 	local abilityCasting = caster:FindAbilityByName("Defence_casting")
 	abilityCasting:SetHidden(false)
 	ability:SetHidden(true)

 	-- body
 end

 function FallingSword(keys)
 	local caster = keys.caster
 	local ability = keys.ability
 	local point = ability:GetCursorPosition()
 	local casterPosi = caster:GetAbsOrigin()
 	local vec = point - casterPosi
 	local StartingPosi = casterPosi + vec:Normalized() * 100
 	local TargetPoint = StartingPosi + vec:Normalized() * 1000
 	print(point)
 	local particle = keys.particle

 	local FallingSword = ParticleManager:CreateParticle(keys.particle, PATTACH_WORLDORIGIN, caster)
 	ParticleManager:SetParticleControl(FallingSword,0,Vector(StartingPosi.x,StartingPosi.y,128))
 	ParticleManager:SetParticleControl(FallingSword,1,Vector(TargetPoint.x,TargetPoint.y,128))

 	

 end

 function FallingSword_Explosion(keys)
 	local times = 1
 	local caster = keys.caster
 	local ability = keys.ability
 	local point = ability:GetCursorPosition()
 	local casterPosi = caster:GetAbsOrigin()
 	local vec = point - casterPosi
 	local StartingPosi = casterPosi + vec:Normalized() * 100
 	local TargetPoint = StartingPosi + vec:Normalized() * 1000
 	GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("Fallinsword_timer"),
 		function ()
 			if times < 10 then
 				local explosionPosi = casterPosi + caster:GetForwardVector():Normalized() *(100+times*100)
 				local explosion = ParticleManager:CreateParticle("particles/ice_strike/fallling_sword_explosion2.vpcf", PATTACH_WORLDORIGIN, caster)
 				ParticleManager:SetParticleControl(explosion,0,Vector(explosionPosi.x,explosionPosi.y,128))

 				times = times +1
 				return 0.05

 			else return nil

 			end

 		end,0.05)
 	--finish firing the effect. And then do the damage.

 	--[[local units = FindUnitsInLine(caster:GetTeamNumber(),StartingPosi,TargetPoint,nil, 80,ability:GetAbilityTargetTeam(),ability:GetAbilityTargetType(), ability:GetAbilityTargetFlags())
 	print(table.getn(units))
 	
 	for i,unit in pairs(units) do
 			print(unit)
 			local damageTable = {victim=unit,
                                attacker = caster,
                                damage = ability:GetLevelSpecialValueFor("Falling_Sword_Damage", (ability:GetLevel() -1)),        
                                damage_type = ability:GetAbilityDamageType()} 
                	ApplyDamage(damageTable) 
     

 	end--]]
 end


function Spinning(keys)
	-- forword:speed is propotional to the distance to the targetpoint
	-- backword: speed is propotional to the distance to the targetpoint

	local caster = keys.caster
	local casterPosi = caster:GetAbsOrigin()
	local ability = keys.ability
	local targetPosi = ability:GetCursorPosition()
	local vDis = targetPosi - casterPosi 
	local vec = vDis:Normalized()
	local nDis = vDis:Length2D() 
	local time = 0
	local distance = 0
	local SpinningBlade = ParticleManager:CreateParticle(keys.particle, PATTACH_ABSORIGIN  , caster)
	local Isforward = true
	GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("Fallinsword_timer"),
		function ()
			--forward moving part
			if time <= 0.5 then
				SpeedConstant =(-time*time + 1*time)/0.25
				distance = nDis*SpeedConstant
			
				Reach = casterPosi + distance * vec
				ParticleManager:SetParticleControl(SpinningBlade,0,Vector(Reach.x,Reach.y,128))
				time = time+0.01

				--scanning units part	
				local units = FindUnitsInRadius(caster:GetTeamNumber(), Reach, nil, 150, ability:GetAbilityTargetTeam(), ability:GetAbilityTargetType(), ability:GetAbilityTargetFlags(), 0, false)	
				for i,unit in pairs(units) do
					if unit.hit ~= true then
						local damageTable = {victim=unit,
                                         attacker=caster,
                                         damage=50,        
                                         damage_type=keys.ability:GetAbilityDamageType()} 
                		ApplyDamage(damageTable) 

                		ability:ApplyDataDrivenModifier(caster, unit, "modifier_Spinning_buff", {duration = 4})

                		unit.hit = true
                	end

				end


				return 0.01
			else
				--[[local currentCasterPosi = caster:GetAbsOrigin()
				local vbackDistance = currentCasterPosi - Reach
				local nbackDistance = vbackDistance:Length2D()
				print(Reach)
				local vdirection = currentCasterPosi - Reach
				local leap = 20000/(nbackDistance)*vdirection:Normalized()
				Reach = Reach + leap]]--
				local time_b = time - 0.5
				local acc = 2*nDis/0.25/0.5
				local speed = time_b*acc
				--first get the speed fumula
				local currentCasterPosi = caster:GetAbsOrigin()
				local vbackDistance = currentCasterPosi - Reach
				local leap = 0.01 * speed * vbackDistance:Normalized()
				Reach = Reach +leap
				time =time + 0.01
				ParticleManager:SetParticleControl(SpinningBlade,0,Vector(Reach.x,Reach.y,128))

				--scanning units part(backward)	
				local units_b = FindUnitsInRadius(caster:GetTeamNumber(), Reach, nil, 150, ability:GetAbilityTargetTeam(), ability:GetAbilityTargetType(), ability:GetAbilityTargetFlags(), 0, false)	
				for i,unit in pairs(units_b) do
					if unit.hit_b ~= true then
						local damageTable = {victim=unit,
                                         attacker=caster,
                                         damage=50,        
                                         damage_type=keys.ability:GetAbilityDamageType()} 
                		ApplyDamage(damageTable)
                		EmitSoundOn("sounds/weapons/hero/beastmaster/attack02.vsnd",unit) 

                		ability:ApplyDataDrivenModifier(caster, unit, "modifier_Spinning_buff", {duration = 4})

                		unit.hit_b = true
                	end

				end

				
				if vbackDistance:Length2D() < 50 then
					local units_end = FindUnitsInRadius(caster:GetTeamNumber(), Reach, nil, 5000, ability:GetAbilityTargetTeam(), ability:GetAbilityTargetType(), ability:GetAbilityTargetFlags(), 0, false)	
					for i,unit in pairs(units_end) do
						unit.hit = nil
					end

					ParticleManager:DestroyParticle(SpinningBlade,true)
					return nil
				end

				
				return 0.01

			end
		end,0.01)
end

--[[function Entangling(keys)
	local times = 1
 	local caster = keys.caster
 	local ability = keys.ability
 	local point = ability:GetCursorPosition()
 	local casterPosi = caster:GetAbsOrigin()
 	local vec = point - casterPosi
 	local StartingPosi = casterPosi + vec:Normalized() * 100
 	local TargetPoint = StartingPosi + vec:Normalized() * 1000
 	GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("Entangling_timer"),
 		function ()
 			if times < 10 then
 				local explosionPosi = casterPosi + caster:GetForwardVector():Normalized() *(100+times*100)
 				local explosion = ParticleManager:CreateParticle(keys.particle, PATTACH_WORLDORIGIN, caster)
 				ParticleManager:SetParticleControl(explosion,0,Vector(explosionPosi.x,explosionPosi.y,128))

 				times = times +1
 				return 0.05

 			else return nil

 			end

 		end,0.05)

end]]--


function Demon(keys)
	local caster_point = keys.caster:GetAbsOrigin()
	local target_point = keys.target_points[1]
	
	local caster_point_temp = Vector(caster_point.x, caster_point.y, 0)
	local target_point_temp = Vector(target_point.x, target_point.y, 0)
	
	local point_difference_normalized = (target_point_temp - caster_point_temp):Normalized() 
	keys.caster:EmitSound("Hero_Invoker.ChaosMeteor.Cast")
	keys.caster:EmitSound("Hero_Invoker.ChaosMeteor.Loop")

	--Create a particle effect consisting of the meteor falling from the sky and landing at the target point.
	--local meteor_fly_original_point = (target_point + Vector (0, 0, 1000))  --Start the meteor in the air in a place where it'll be moving the same speed when flying and when rolling.
	local Demon_falling_effect = ParticleManager:CreateParticle(keys.particle, PATTACH_ABSORIGIN, keys.caster)
	ParticleManager:SetParticleControl(Demon_falling_effect, 0, target_point)
end

function Demon_Summon(keys)
	local effect_point = keys.target_points[1]
	local caster = keys.caster
	print(effect_point)
	local Golem = CreateUnitByName("Demon Golem", effect_point, true, caster, caster:GetOwner(), caster:GetTeamNumber()) 

	local owner = caster:GetPlayerOwnerID()
	print(owner)
	Golem:SetControllableByPlayer(owner,false)
end

function Purge_Start(keys)
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	
	if caster:GetTeamNumber() == target:GetTeamNumber() then
		target:Purge(false,true,true,false,false)
	else
		target:Purge(true,false,true,false,false)
		ability:ApplyDataDrivenModifier(caster,target,"modifier_Purge_buff",{})
	end
end

function Insight(keys)
	local center_point = keys.target_points[1]
	local radius = keys.radius
	local start_point = Vector(center_point.x - radius, center_point.y, center_point.z)
	local times = 0
	GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("Insight_timer"),
		function ()
			if  times < 36 then
				start_point = RotatePosition(center_point,QAngle(0,15,0),start_point) 
				opposite_point = RotatePosition(center_point,QAngle(0,180,0),start_point) 

				local Insight_Glow = ParticleManager:CreateParticle(keys.particle, PATTACH_CUSTOMORIGIN, caster)
				local Insight_Glow_op = ParticleManager:CreateParticle(keys.particle, PATTACH_CUSTOMORIGIN, caster)
				ParticleManager:SetParticleControl(Insight_Glow, 0 , start_point )
				ParticleManager:SetParticleControl(Insight_Glow_op, 0 , opposite_point )

				times = times+1

				return 0.1

			else 
				return nil

			end
		end,0.1)
end


function TestHero( keys )
	local caster = keys.caster
	local target_point = keys.target_points[1]
	CreateUnitByName("Test_Hero", target_point, true, nil, nil, 2) 

	-- body
end

function Frost_Aura( keys )
	local caster = keys.caster
	local target = keys.target
	local target_hp = target:GetMaxHealth()
	print(target_hp)
	local ability = keys.ability
	local aura_damage_persentage= ability:GetLevelSpecialValueFor("aura_damage_persentage", (ability:GetLevel() - 1))
	local damage = target_hp * aura_damage_persentage
	local damage_table = {}

	print(damage)
	damage_table.attacker = caster
	damage_table.victim = target
	damage_table.damage_type = DAMAGE_TYPE_PURE
	damage_table.ability = ability
	damage_table.damage = damage/100
	damage_table.damage_flags = DOTA_DAMAGE_FLAG_HPLOSS -- Doesnt trigger abilities and items that get disabled by damage

	ApplyDamage(damage_table)
end

function Test()
	ShowMessage("??????????") 
end


function Last_Wishes_Effect( keys )
	local targets = keys.target_entities
	local caster = keys.caster
	local particle = keys.particle
	for i,unit in pairs(targets) do
		local HealEffect = ParticleManager:CreateParticle(particle, 8, unit)
		ParticleManager:SetParticleControl(HealEffect,1,unit:GetAbsOrigin())
		ParticleManager:SetParticleControl(HealEffect,0,caster:GetAbsOrigin())
	end
end

function Revenge( keys )
	print("Revenge executed")
	local caster = keys.caster
	local target = keys.target
	local currentHpPercent = caster:GetHealthPercent()  
	if currentHpPercent < 15 then
		target:ApplyDataDrivenModifier("modifier_Revenge_debuff",target,{})

	else Warning("Here is a warning")

	end
end

function Dismember(keys)
	local victim = keys.target
	local ability = keys.ability
	local targetCount = ability:GetLevelSpecialValueFor("targetCount",0)
	if victim:FindModifierByName("modifier_dismember_stack") == nil  then
			ability:ApplyDataDrivenModifier(victim, victim, "modifier_dismember_stack", {})
			victim:SetModifierStackCount("modifier_dismember_stack",victim, 1)
	else
		local currentStack = victim:GetModifierStackCount("modifier_dismember_stack",victim)
		victim:SetModifierStackCount("modifier_dismember_stack",victim, currentStack+1)

		if currentStack+1 == targetCount then 
			ability:ApplyDataDrivenModifier(victim, victim, "modifier_dismember_debuff", {})
			victim:RemoveModifierByName("modifier_dismember_stack")
		end
	end

end

function Earth_baseAttack( keys )
	local caster = keys.caster
	caster:StartGesture(ACT_DOTA_CAST_ABILITY_2)
end

function Earth_baseAttack_Landed(keys)
	local caster = keys.caster
	local ability = keys.ability
	local target = keys.target
	local GroupTargets = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, 500, ability:GetAbilityTargetTeam(), ability:GetAbilityTargetType(), ability:GetAbilityTargetFlags(), 0, false)	
	print("Groupcount="..table.getn(GroupTargets))
	local damage = caster:GetAttackDamage()
	if table.getn(GroupTargets) > 3 then
		local ran1 = nil
		local ran2 = nil
		local ran3 = nil
		local lock1= 1
		local lock2 =1
		local lock3 =1
		while ran1 == nil or GroupTargets[ran1] == target do
			ran1 = RandomInt(1,table.getn(GroupTargets))
			print("ran1="..ran1)
			lock1 = lock1+1
			if lock1 > 10 then
				break
			end
		end

		while ran2 == nil or ran2 == ran1 or GroupTargets[ran2] == target  do
			ran2 = RandomInt(1,table.getn(GroupTargets))
			print("ran2="..ran2)
			lock2 = lock2+1
			if lock2 > 10 then
				break
			end
		end 

		while ran3 == nil or ran3 == ran1 or ran3 == ran2 or GroupTargets[ran3] == target do
			ran3 = RandomInt(1,table.getn(GroupTargets))
			print("ran3="..ran3)
			lock3 = lock3+1
			if lock3 > 10 then
				break
			end
		end

		ApplyDamage({ victim = GroupTargets[ran1], attacker = caster, damage = damage*0.3,	damage_type = DAMAGE_TYPE_PHYSICAL })
		ApplyDamage({ victim = GroupTargets[ran2], attacker = caster, damage = damage*0.3,	damage_type = DAMAGE_TYPE_PHYSICAL })
		ApplyDamage({ victim = GroupTargets[ran3], attacker = caster, damage = damage*0.3,	damage_type = DAMAGE_TYPE_PHYSICAL })

	else 
		for _,unit in pairs(GroupTargets) do
			if unit ~= target then
				ApplyDamage({ victim = unit, attacker = caster, damage = damage*0.3,	damage_type = DAMAGE_TYPE_PHYSICAL })
			end
		end
	end

	--above finishes the damage part, now handle the effect part

	local aftershock = ParticleManager:CreateParticle("particles/econ/items/earthshaker/egteam_set/hero_earthshaker_egset/earthshaker_aftershock_egset.vpcf", 1, caster)
	ParticleManager:SetParticleControl(aftershock, 01 , Vector(200,0,0) )


end

function Earth_Pull(keys)
	local caster = keys.caster	
	local target = keys.target
	local ability = keys.ability
	local PullTargets = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, 350, 2, ability:GetAbilityTargetType(), ability:GetAbilityTargetFlags(), 0, false)
	for _,unit in pairs(PullTargets) do
		if unit ~= caster  then
			local vPull =  unit:GetAbsOrigin() - caster:GetAbsOrigin()
			unit:AddNewModifier(nil, nil, "modifier_phased", {duration=1})
			unit:SetAbsOrigin(caster:GetAbsOrigin()+ vPull:Normalized()*50) 
		end
	end

	local pushTargets = FindUnitsInRadius(caster:GetTeamNumber(), target:GetAbsOrigin(), nil, 350, 2, ability:GetAbilityTargetType(), ability:GetAbilityTargetFlags(), 0, false)
	for _,unit in pairs(pushTargets) do
		if unit ~= target then
			local vPush = unit:GetAbsOrigin() - target:GetAbsOrigin()
			unit:AddNewModifier(nil, nil, "modifier_phased", {duration=1})
			unit:SetAbsOrigin(target:GetAbsOrigin()+ vPush:Normalized()*350)
		end
	end


end

function Snowstorm(keys)
	local point = keys.target_points[1]
	local caster = keys.caster
	local ability = keys.ability
	local particle = keys.particle
	local explosion = keys.explosion
	local snowstorm = ParticleManager:CreateParticle(particle, PATTACH_WORLDORIGIN, caster )
	ParticleManager:SetParticleControl(snowstorm, 0, point)
	ParticleManager:SetParticleControl(snowstorm, 1, Vector(750,0,0))

	local times = 0
	GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("snowstorm_timer"),
		function ()
		if times < 22 then
			local len = RandomInt(50,750)
			local vec = RandomVector(len)
			local targetposi = point + vec/1.75
			local ex = ParticleManager:CreateParticle(explosion, PATTACH_WORLDORIGIN,caster)
			ParticleManager:SetParticleControl(ex, 0, targetposi)
			times = times+1
			--particle

			local targets = FindUnitsInRadius(caster:GetTeamNumber(), point, nil, 750, 2, ability:GetAbilityTargetType(), ability:GetAbilityTargetFlags(), 0, false)
			for _,unit in pairs(targets) do
				local damageTable = {victim=unit,    
                                                 attacker=caster,        
                                                 damage=keys.ability:GetLevelSpecialValueFor("Damage", 0),      
                                                 damage_type=keys.ability:GetAbilityDamageType()}   
                           	ApplyDamage(damageTable)
            end


			return 0.33
		end
		end,0.33)
end

function Cyclone_lift( keys )
	local caster = keys.caster
	local maxHeight = keys.maxHeight
	local target = keys.target

	local times = 0
	GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("Cyclone_timer"),
		function ( )
			if times < 5 then
				local currentPosi = target:GetAbsOrigin()
				target:SetAbsOrigin(Vector(currentPosi.x,currentPosi.	y,currentPosi.z + maxHeight/10))
			end
			times = times+1
		return 0.03
		end,0.03)
	
end

function Cyclone_drop( keys )
	local caster = keys.caster
	local maxHeight = keys.maxHeight
	local target = keys.target

	local times = 0
	GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("Cyclone_timer"),
		function ( )
			if times < 5 then
				local currentPosi = target:GetAbsOrigin()
				target:SetAbsOrigin(Vector(currentPosi.x,currentPosi.y,currentPosi.z - maxHeight/10))
			end
			times = times+1
		return 0.03
		end,0.03)
	
end

function Cyclone_Rotate( keys )
	local target = keys.target
	local ability = keys.ability
	local duration = ability:GetLevelSpecialValueFor("duration", ability:GetLevel()-1)
	local rounds = math.ceil(duration)
	local angle = rounds * 360 /(duration*30)
	print(angle)
	local times = 0
	Timers:CreateTimer(function()
		if times < duration*30 then
			target:SetForwardVector(RotatePosition(Vector(0,0,0), QAngle(0, angle, 0), target:GetForwardVector()))
			times = times + 1
      		return 1/30
		else
			return nil
    	end
	end
  )
	
end

function Suicide (keys)
	local ability = keys.ability
	local caster = keys.caster
	local particle = keys.particle
	local suicide_effect = ParticleManager:CreateParticle(particle,PATTACH_WORLDORIGIN,caster)
	ParticleManager:SetParticleControl(suicide_effect,0,caster:GetAbsOrigin())
	--particle
	local times = 0
	GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("Suicide_timer"),
		function()
			if times < 1 then
				print("11111")
				times = times +1

				return 1
			else
				local targets = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, 200, 2, ability:GetAbilityTargetType(), ability:GetAbilityTargetFlags(), 0, false)
				for _,unit in pairs(targets) do
					local currentHp = unit:GetHealth()
					print(currentHp)
					local damageTable = {victim=unit,    
                             attacker=caster,        
                             damage = currentHp * 0.3333333,
                             damage_type=keys.ability:GetAbilityDamageType()}   
        			ApplyDamage(damageTable)
        		end

        		return nil
       		end
       	end,1)



	

end

function Suicide_damage (keys)
	local caster = keys.caster
	local targets = keys.target_entities
	local percentage = key.ability:GetLevelSpecialValueFor("percentage", keys.ability:GetLevel()-1) / 100
	for _,unit in pairs(targets) do
		local currentHp = unit:GetHealth()
		print(currentHp)
		local damageTable = {victim=unit,    
                             attacker=caster,        
                             damage = currentHp * 0.3333333,
                             damage_type=keys.ability:GetAbilityDamageType()}   
        ApplyDamage(damageTable)
    end 
end

function Shadow_Strike(keys)
	local target = keys.target
	local caster = keys.caster
	local ability = keys.ability
	local vDis = target:GetAbsOrigin() - caster:GetAbsOrigin()
	if ability:IsCooldownReady() then 	
		local dummy = CreateUnitByName("Dark Knight_clone",target:GetAbsOrigin()+vDis,true,caster:GetOwner(),caster:GetOwner(),caster:GetTeamNumber())
		dummy:SetForwardVector(-vDis)
		ability:ApplyDataDrivenModifier(caster,dummy,"modifier_Shadow_Strike_illusion",{})
		
		dummy:SetForceAttackTarget(target)
		dummy:StartGesture(ACT_DOTA_ATTACK)
		ability:StartCooldown(2)
		EmitSoundOn("sounds/weapons/hero/terrorblade/reflection.vsnd",dummy)

		local times = 0
		GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("shadow_strike_timer"),
			function()
				if times < 9 then
					times = times +1
					return 0.1
				else
					dummy:AddNewModifier(caster, ability, "modifier_illusion", { duration = 0.01, outgoing_damage = 100, incoming_damage = 0 })
					return nil
				end
			end,0.1)
	end

	
	
end


function Dark_Form( keys )
	local caster = keys.caster 
	--caster:StartGestureWithPlaybackRate( ACT_DOTA_SPAWN, 0.8 )  

	local times = 0
	--[[GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("shadow_form_timer"),
		function()
			if times < 9 then
				print(caster:GetMaxHealth())
				caster:SetMaxHealth(caster:GetMaxHealth()+60)
				print(caster:GetMaxHealth())
				times = times +1
				return 0.1 
			end
		end,0.1)]]--
	caster:SetMaxHealth(caster:GetMaxHealth()+600)
	caster:SetHealth(caster:GetHealth()+600)
end

function Dark_Form_end( keys )
	local caster = keys.caster
	local percent = caster:GetHealthPercent()
	caster:SetMaxHealth(caster:GetMaxHealth()-600)
	caster:SetHealth(caster:GetMaxHealth()*percent)
end

function Invisibility ( keys )
	local caster = keys.caster 
	caster:AddNewModifier(caster, nil, "modifier_invisible",{duration = 3})
end

function Invisibility_CD ( keys )
	local caster = keys.caster
	local ability = keys.ability
	ability:StartCooldown(10)
	caster:RemoveModifierByName("modifier_invisible")
end

function Strafe( keys )
	local Strafe_Exe = {}
		function Strafe_Exe.new ( caster,EndPosi,ability)
			local Particle = ParticleManager:CreateParticle("particles/skills/strafe/bullet.vpcf",1,caster)
			ParticleManager:SetParticleControl(Particle, 1, EndPosi)
			

			local times = 0
			local bHit = false
			GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("Strafe_exe_timer"),
				function()
					if bHit ~= true and times < 30 then					
						local currentPosi = caster:GetAbsOrigin()+50*times*(EndPosi-caster:GetAbsOrigin()):Normalized()
						local units = FindUnitsInRadius(caster:GetTeamNumber(), currentPosi , nil, 15, ability:GetAbilityTargetTeam(), ability:GetAbilityTargetType(), ability:GetAbilityTargetFlags(), 0, false)
						if units[1] ~= nil then
							local victim = units[1]
							ParticleManager:CreateParticle("particles/skills/strafe/blood.vpcf",9,victim)
							EmitSoundOn("Hero_Sniper.AssassinateDamage", victim)
							ApplyDamage({victim = victim, attacker = caster, damage = 50,	damage_type = DAMAGE_TYPE_MAGICAL })
							bHit = true
							ParticleManager:DestroyParticle(Particle, true)
						end
						
						times = times+1
						return 1/30
					end	
				end,0)
		end




	local point = keys.target_points[1]
	local v = Vector(point.x,point.y,0)
	local caster = keys.caster
	local ability = keys.ability
	local projectile_particle = keys.particle
	local distance = ability:GetLevelSpecialValueFor("Distance", 0)
	local path_radius = ability:GetLevelSpecialValueFor("Radius",0)
	local nVelocity = ability:GetLevelSpecialValueFor("velocity",0)
	local visionRadius = ability:GetLevelSpecialValueFor("vision",0)

	local basicVector = (point - caster:GetAbsOrigin()):Normalized()


	local times = 0
	GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("Strafe_timer1"),
		function ()
			if times ==  0 then 
				local EndPosi = RotatePosition(caster:GetAbsOrigin(),QAngle(0,-30,0),caster:GetAbsOrigin()+basicVector*1500)
				Strafe_Exe.new(caster, EndPosi,ability)
				EmitSoundOn("Hero_Sniper.ShrapnelShoot", caster)
				times = times +1
				return 0.07
			end

			if times == 1 then 
				local EndPosi = RotatePosition(caster:GetAbsOrigin(),QAngle(0,-15,0),caster:GetAbsOrigin()+basicVector*1500)
				Strafe_Exe.new(caster, EndPosi,ability)
				EmitSoundOn("Hero_Sniper.ShrapnelShoot", caster)
				times = times +1
				return 0.07
			end

			if times == 2 then 
				local EndPosi = RotatePosition(caster:GetAbsOrigin(),QAngle(0,0,0),caster:GetAbsOrigin()+basicVector*1500)
				Strafe_Exe.new(caster, EndPosi,ability)
				EmitSoundOn("Hero_Sniper.ShrapnelShoot", caster)
				times = times +1
				return 0.07
			end
			
			if times == 3 then
				local EndPosi = RotatePosition(caster:GetAbsOrigin(),QAngle(0,15,0),caster:GetAbsOrigin()+basicVector*1500)
				Strafe_Exe.new(caster, EndPosi,ability)
				EmitSoundOn("Hero_Sniper.ShrapnelShoot", caster)
				times = times +1
				return 0.07
			end
			
			if times == 4 then
				local EndPosi = RotatePosition(caster:GetAbsOrigin(),QAngle(0,30,0),caster:GetAbsOrigin()+basicVector*1500)
				Strafe_Exe.new(caster, EndPosi,ability)
				EmitSoundOn("Hero_Sniper.ShrapnelShoot", caster)
				times = times +1
				return 0.07
			end
			
			if times == 1 then 
				return nil
			end
		end,0.07)
end

function Mechanical_Armor( keys )
	LinkLuaModifier("modifier_mechanical_armor", LUA_MODIFIER_MOTION_NONE )
	local caster = keys.caster 
	local ability = keys.ability
	caster:AddNewModifier(caster, ability, "modifier_mechanical_armor", {})
end

function Desprado ( keys )
	local caster = keys.caster
	local ability = keys.ability
	local friendunits = FindUnitsInRadius(caster:GetTeamNumber(), currentPosi , nil, 300, ability:GetAbilityTargetTeam(), ability:GetAbilityTargetType(), ability:GetAbilityTargetFlags(), 0, false)
	local unitscount = table.getn(friendunits)
	if unitscount > 0 and unitscount <= 2 then
		caster:RemoveModifierByName("modifier_Desprado_0")
		caster:RemoveModifierByName("modifier_Desprado_3andless")
		ability:ApplyDataDrivenModifier(caster, caster, "modifier_Desprado_3andless", {})
	end 

	if unitscount == 0 then
		caster:RemoveModifierByName("modifier_Desprado_0")
		caster:RemoveModifierByName("modifier_Desprado_3andless")
		ability:ApplyDataDrivenModifier(caster,caster,"modifier_Desprado_0",{})
	end
end

function Heroic (keys)
	print("Added")
	LinkLuaModifier( "modifier_heroic_lua", LUA_MODIFIER_MOTION_NONE )
	local caster = keys.caster
	caster:AddNewModifier(caster, nil, "modifier_heroic_lua", {})
end
lock = 0
function Heroic_particle(keys)
	local caster = keys.caster
	local healthPercent = caster:GetHealthPercent()

	if healthPercent < 17 then
		if lock == 0 then
			press = ParticleManager:CreateParticle("particles/econ/items/legion/legion_fallen/legion_fallen_press.vpcf", 1, caster)
			Timers:CreateTimer(function()
				ParticleManager:SetParticleControlOrientation(press, 1, caster:GetForwardVector(),caster:GetRightVector(), caster:GetUpVector())
     		 return 0.03
    		end)

			lock =  lock + 1
		end
	end
end

function Heroic_particle_Removal(keys)
	print("Removal")
	ParticleManager:DestroyParticle(press, false)
end

function Take_the_Head( keys )
    
	local caster = keys.caster
	local target = keys.target
	local currentPosi = caster:GetAbsOrigin()
	local targetPosi =  target:GetAbsOrigin()
	local healthPercent = caster:GetHealthPercent()
	local ability = keys.ability
	ability.speed = ability:GetLevelSpecialValueFor("speed", ability:GetLevel()-1)
	ability.gap = ability.speed / 30
	ability.direction = (targetPosi - currentPosi):Normalized()
	ability.traveled_distance = 0
	ability.final_distance = (currentPosi - targetPosi):Length2D() - 205

	keys.ability:ApplyDataDrivenModifier(caster, caster, "modifier_disarmed", {})	
	
end

function Take_the_Head_Motion ( keys )
	local caster = keys.target
	local ability = keys.ability

	-- Move the caster while the distance traveled is less than the original distance upon cast
	if ability.traveled_distance < ability.final_distance then
		caster:SetAbsOrigin(caster:GetAbsOrigin() + ability.direction * ability.gap)
		ability.traveled_distance = ability.traveled_distance + ability.gap
	else
		-- Remove the motion controller once the distance has been traveled
		caster:InterruptMotionControllers(false)
		ability:ApplyDataDrivenModifier(caster, caster, "modifier_damage_bonus", {})
		caster:RemoveModifierByName("modifier_disarmed")
	end
end	

function Take_the_Head_Buff ( keys )
	local caster = keys.caster
	caster:RemoveModifierByName("modifier_damage_bonus")
end

function Rain_of_Arrows( keys )
	local point = keys.target_points[1]
	local caster = keys.caster
	local ability = keys.ability
	local vec = RandomVector(RandomInt(50,200))
	local newVec = point + vec
	local top_point = Vector(newVec.x,newVec.y, 1800)
	
--[[]	local z_distance = top_point.z-point.z
	local forward_distance = vec:Length2D()

	local new_z_distance = - forward_distance
	local new_2d_point = point + vec:Normalized()*z_distance
	local new_3d_point = Vector(new_2d_point.x,new_2d_point.y,point.z + new_z_distance)]]--

	local cp2_low = point + (top_point-point):Normalized()*110										
	local cp3_high = point + (top_point-point):Normalized()*130

	local arrows = ParticleManager:CreateParticle("particles/skills/rain_of_arrows/rain_of_arrows_final.vpcf",PATTACH_WORLDORIGIN,caster)
	ParticleManager:SetParticleControl(arrows, 0, point)
	ParticleManager:SetParticleControl(arrows, 1, top_point)
	ParticleManager:SetParticleControl(arrows, 4, Vector(300,300,300))
	ParticleManager:SetParticleControl(arrows, 5, Vector(1,0,0))
	ParticleManager:SetParticleControl(arrows, 2, Vector(cp2_low.x,cp2_low.y,cp2_low.z))
	ParticleManager:SetParticleControl(arrows, 3, Vector(cp3_high.x,cp3_high.y,cp3_high.z))
	


	local times = 0
	Timers:CreateTimer(1.3, function()
	  if times < 4 then 
      	local units = FindUnitsInRadius(caster:GetTeamNumber(), point, nil, 300, ability:GetAbilityTargetTeam(), ability:GetAbilityTargetType(), ability:GetAbilityTargetFlags(), 0, false)	
		for _,unit in pairs(units) do
			damageTable = {victim=unit,    
                           attacker=caster,        
                           damage=keys.ability:GetLevelSpecialValueFor("damage", ability:GetLevel()-1),      
                           damage_type=keys.ability:GetAbilityDamageType()}   
			ApplyDamage(damageTable)

			
		end
		caster:EmitSound("Hero_LegionCommander.Overwhelming.Location")
      	times = times+1
		return 1.0
	  else 
	  	return nil
      end
  end)
end

function Rain_of_Arrows_flag ( keys )
	local point = key.target_points[1]
	local caster = keys.caster

	local vec = RandomVector(RandomInt(100, 300))
	local newVec = point + vec
	local flag = ParticleManager:CreateParticle("particles/skills/rain_of_arrows/rain_of_arrows_flag.vpcf", PATTACH_WORLDORIGIN,caster)
	ParticleManager:SetParticleControl(flag, 0, point)
	ParticleManager:SetParticleControl(flag, 1, Vector(newVec.x,newVec.y, 1000))
end
	

function Jade_Skin( keys )
	local caster = keys.caster 
	caster:SetModelScale(0.6)
	caster:StartGestureWithPlaybackRate(ACT_DOTA_IDLE,1)
end

function Jade_Attack ( keys )
	print("attack")
	local caster = keys.caster
	caster:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK,1.6)
end

function Fire_Array ( keys )
	local caster = keys.caster
	local ability = keys.ability
	local point = keys.target_points[1]
	local vdirection = (point - caster:GetAbsOrigin()):Normalized()
	
	local times = 0
	Timers:CreateTimer(function()
		if times < 3 then
			local posi = caster:GetAbsOrigin() + vdirection*250*(times+1)
			local fire = ParticleManager:CreateParticle(keys.particle, PATTACH_WORLDORIGIN, caster)
			ParticleManager:SetParticleControl(fire, 0, posi)
			
			local units = FindUnitsInRadius(caster:GetTeamNumber(), posi, nil, 300, 2, ability:GetAbilityTargetType(), ability:GetAbilityTargetFlags(), 0, false)
			for _,unit in pairs(units) do
				print("damage")
				print(unit:GetUnitName())
				local damageTable = {
					victim=unit,    
                	attacker=caster,        
                	damage=keys.ability:GetLevelSpecialValueFor("damage", ability:GetLevel()-1),      
                	damage_type=keys.ability:GetAbilityDamageType()}   
                ApplyDamage(damageTable) 
				print(keys.ability:GetLevelSpecialValueFor("damage", ability:GetLevel()-1))
			end

			caster:EmitSound("Hero_SkeletonKing.Hellfire_Blast")
			
			times = times + 1

      	return 0.3
		
		else
			return nil
		end
    end
  )
end

function blade_xxx_effect ( keys )
	local caster = keys.caster
	local targets = keys.target_entities
	local particle_m = keys.particle_m
	local particle_n = keys.particle_n
	for _,unit in pairs(targets) do
		--[[if unit:IsMechanical() then 
			ParticleManager:CreateParticle(keys.particle_m, 0, unit)
		else]]--
			ParticleManager:CreateParticle(keys.particle_n, 9, unit)
		--end
	end
end

function Blade_Dance_Gesture (keys)
	local caster = keys.caster
	caster:StartGesture(ACT_DOTA_CAST_ABILITY_1)
	Timers:CreateTimer(0,function()
      caster:StartGestureWithPlaybackRate(ACT_DOTA_OVERRIDE_ABILITY_1, 1)
      return nil
    end)
	Timers:CreateTimer(0.5,function()
      caster:RemoveGesture(ACT_DOTA_OVERRIDE_ABILITY_1)
      return nil
    end)
end

function Capture( keys )
    local caster = keys.caster
    local ability = keys.ability
    local point = keys.target_points[1]
    local speed = ability:GetSpecialValueFor("projectile_speed")
    local radius = ability:GetSpecialValueFor("radius")
    local duration = ability:GetSpecialValueFor("duration")
    local particleName = "particles/units/heroes/hero_meepo/meepo_earthbind_projectile_fx.vpcf"

    local projectile = ParticleManager:CreateParticle(particleName, PATTACH_CUSTOMORIGIN, caster)
    ParticleManager:SetParticleControl(projectile, 0, caster:GetAttachmentOrigin(caster:ScriptLookupAttachment("attach_attack1")))
    ParticleManager:SetParticleControl(projectile, 1, point)
    ParticleManager:SetParticleControl(projectile, 2, Vector(speed, 0, 0))
    ParticleManager:SetParticleControl(projectile, 3, point)

    local distanceToTarget = (caster:GetAbsOrigin() - point):Length2D()
    local time = distanceToTarget/speed
    Timers:CreateTimer(time, function()
        ParticleManager:DestroyParticle(projectile, false)
        
        local units = FindUnitsInRadius(caster:GetTeamNumber(), point, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC+DOTA_UNIT_TARGET_HERO, 0, 0, false)
        for _,enemy in pairs(units) do
            enemy:EmitSound("Hero_Meepo.Earthbind.Target")
            ability:ApplyDataDrivenModifier(caster, enemy, "modifier_capture", {duration=duration})
        end
    end)
end

function Iron_Flesh( keys )
	local caster = keys.caster
	local ability = keys.ability
	ability:ApplyDataDrivenModifier(caster, caster, "modifier_Iron_Flesh", {})
end