modifier_revenge_lua = class({})


function modifier_revenge_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE
	}
 
	return funcs
end

function modifier_revenge_lua:GetModifierTotalDamageOutgoing_Percentage()
	local outGoingPercent = self:GetAbility():GetSpecialValueFor( "outGoingPercent" )
	
	return outGoingPercent
end

function modifier_revenge_lua:IsDebuff()
	return true
end

function modifier_revenge_lua:IsPermanent()
	return true
end

function modifier_revenge_lua:IsPurgable()
	return  false
end

function modifier_revenge_lua:GetEffectName()
	return "particles/skills/revenge/regenge.vpcf"
end

function modifier_revenge_lua:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

