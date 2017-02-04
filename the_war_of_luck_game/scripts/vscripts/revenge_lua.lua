revenge_lua = class ({})
LinkLuaModifier( "modifier_revenge_lua", LUA_MODIFIER_MOTION_NONE )
print(">>>>>")

function revenge_lua:CastFilterResultTarget( hTarget )
	local CurrentHpPerc = self:GetCaster():GetHealthPercent()
	if CurrentHpPerc > 15 then
		return UF_FAIL_CUSTOM
	end

	if self:GetCaster() == hTarget then
		return UF_FAIL_CUSTOM
	end

	local nResult = UnitFilter( hTarget, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, self:GetCaster():GetTeamNumber() )
	if nResult ~= UF_SUCCESS then
		return nResult
	end

	return UF_SUCCESS
end


function revenge_lua:GetCustomCastErrorTarget( hTarget )
	local CurrentHpPerc = self:GetCaster():GetHealthPercent()
	if CurrentHpPerc > 15 then
		return "Health is more than 15%"
	end

	if self:GetCaster() == hTarget then
		return "#dota_hud_error_cant_cast_on_self"
	end

	return ""
end

function revenge_lua:OnSpellStart()
	local hCaster = self:GetCaster()
	local hTarget = self:GetCursorTarget()
	local targetPosition = hTarget:GetAbsOrigin()
	hTarget:AddNewModifier(self:GetCaster(), nil, "modifier_revenge_lua" , {})
	local particle = ParticleManager:CreateParticle("particles/items_fx/necronomicon_warrior_last_will.vpcf", 9, hCaster)
	ParticleManager:SetParticleControl(particle, 1, Vector(targetPosition.x,targetPosition.y,targetPosition.z + 100))
	EmitSoundOn("Hero_Pugna.NetherWard.Attack",hCaster) 
	hCaster:ForceKill(false)
end