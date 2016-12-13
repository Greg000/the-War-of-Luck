modifier_heroic_lua = class({})
local lock = 0
function modifier_heroic_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}
 
	return funcs
end

function modifier_heroic_lua:IsHidden()
    local caster = self:GetCaster()
    local healthPercent = caster:GetHealthPercent()
    if healthPercent < 17 then 
        return false
    else
        return true
    end
end


function modifier_heroic_lua:GetModifierAttackRangeBonus()
    local caster = self:GetCaster()
    local healthPercent = caster:GetHealthPercent()
    if IsServer() then 
        if healthPercent < 17 then
	        return (( 500 - 128 ) * -1 )
        end 
 	end 
 	return 0 
end



function modifier_heroic_lua:GetModifierPhysicalArmorBonus()
    local caster = self:GetCaster()
    local healthPercent = caster:GetHealthPercent()

    if IsServer() then
        if healthPercent < 17 then
            return 0
            
        end
    end
end