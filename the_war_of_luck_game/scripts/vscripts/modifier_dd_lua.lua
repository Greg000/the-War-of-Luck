modifier_dd_lua = class({})


function modifier_dd_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL
	}
 
	return funcs
end

function modifier_dd_lua:GetModifierProcAttack_BonusDamage_Physical()
    local current = self:GetCaster():GetAttackDamage()
    print(current)
    local bonus = current *0.5
    return bonus
end

function modifier_dd_lua:GetTexture()
    return "rune_doubledamage"
end

function modifier_dd_lua:GetEffectName()
    return "particles/basic_effects/runes/doubledamage/rune_doubledamage_owner.vpcf"
end