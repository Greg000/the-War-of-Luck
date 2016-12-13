blade_dance_lua = class ({})
LinkLuaModifier("modifier_mechanical_armor", LUA_MODIFIER_MOTION_NONE)



function blade_dance_lua:GetBehavior()
    local caster = self:GetCaster()
    local modifier = caster:AddNewModifier( self:GetCaster(), nil, "modifier_mechanical_armor", {} )
    print(modifier)
    return DOTA_ABILITY_BEHAVIOR_PASSIVE
end



