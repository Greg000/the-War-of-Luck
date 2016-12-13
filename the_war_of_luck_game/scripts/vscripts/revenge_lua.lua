revenge_lua = class ({})
LinkLuaModifier( "modifier_revenge_lua", LUA_MODIFIER_MOTION_NONE )
print(">>>>>")

function revenge_lua:CastFilterResultTarget( hTarget )
	local CurrentHpPerc = self:GetCaster():GetHealthPercent()
	if CurrentHpPerc < 15 then
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
	if CurrentHpPerc < 15 then
		return "#Error_Health_Percent_More_Than_15"
	end

	if self:GetCaster() == hTarget then
		return "#Error_Health_Percent_More_Than_15"
	end

	return ""
end

function revenge_lua:OnSpellStart( hTarget )
	hTarget:AddNewModifier(self:GetCaster(), nil, "modifier_revenge_lua" , {})
end