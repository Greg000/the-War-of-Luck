modifier_heroic_particle_lua = class({})

function modifier_heroic_particle_lua:GetEffectName()
    return "particles/econ/items/legion/legion_fallen/legion_fallen_press.vpcf"
end

function modifier_heroic_particle_lua:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end