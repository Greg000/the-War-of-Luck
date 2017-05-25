modifier_chemist_lua = class({})

function modifier_chemist_lua:OnDestroy()
    if IsServer() then
        print("1")
        local caster = self:GetParent()
        local max_hp = caster:GetMaxHealth()
        caster:SetMaxHealth(max_hp - 200)
        caster:SetBaseMaxHealth(max_hp -200)
    end
end

function modifier_chemist_lua:OnCreated()
    if IsServer() then
        print("1")
        local caster = self:GetParent()
        local max_hp = caster:GetMaxHealth()
        caster:SetMaxHealth(max_hp - 200)
        caster:SetBaseMaxHealth(max_hp -200)
    end
end

function modifier_chemist_lua:GetDuration()
    return 3
end