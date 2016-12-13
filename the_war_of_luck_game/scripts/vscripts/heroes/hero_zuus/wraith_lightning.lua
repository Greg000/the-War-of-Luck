--首先找到弹射范围内的所有目标，建立table Targetswithin
--再对这一数组进行分析，建立所有未被击中过的单位的数组
--对这一数组进行位置排序，获得最近的单位
--弹射

function Wraith_Lightning_jump(keys)
	caster = keys.caster
	target = keys.caster
	ability = keys.ability
	jump_radius = ability:GetLevelSpecialValueFor("jump_radius", (ability:GetLevel() -1))
	jump_count = ability:GetLevelSpecialValueFor("jump_count", (ability:GetLevel() -1))
	if Targetswithin == nil then
		local Targetswithin = {}
	end

	if TargetsHitAlready == nil then
		local TargetsHitAlready = {}
	end

	if QualifiedTargets == nil then
		local QualifiedTargets = {}
	end

	if jump_count > 0 then

		TargetWithin = FindUnitsInRadius(caster:GetTeamNumber(), target:GetAbsOrigin(), nil, jump_radius, ability:GetAbilityTargetTeam(), ability:GetAbilityTargetType(), ability:GetAbilityTargetFlags(), 0, false)

		for i,unit in pairs(Targetswithin) do
			if unit.hit = nil then
				table.insert(QualifiedTargets, unit}
			end
		end		

		local closest = jump_radius
		local CurrentUnit = nil

		for i，qUnit in pairs(QualifiedTargets) do
			local TargetLoc = target:GetAbsOrigin()
			local qUnitLoc = qUnitLoc:GetAbsOrigin()
			local vDistance = TargetLoc - qUnitLoc
			local nDistance = (vDistance):Length2D()
			
			if nDistance < jump_radius then
				CurrentUnit = qUnit
				closest = nDistance
			end
		end

		if CurrentUnit ~= nil then
			local lightningBolt = ParticleManager:CreateParticle(keys.particle, PATTACH_WORLDORIGIN, target)
					ParticleManager:SetParticleControl(lightningBolt,0,Vector(target:GetAbsOrigin().x,target:GetAbsOrigin().y,target:GetAbsOrigin().z + target:GetBoundingMaxs().z ))   
					ParticleManager:SetParticleControl(lightningBolt,1,Vector(CurrentUnit:GetAbsOrigin().x,CurrentUnit:GetAbsOrigin().y,CurrentUnit:GetAbsOrigin().z + CurrentUnit:GetBoundingMaxs().z ))
					ability:ApplyDataDrivenModifier(caster, CurrentUnit, "modifier_arc_lightning_datadriven", {})
		else
			

end			