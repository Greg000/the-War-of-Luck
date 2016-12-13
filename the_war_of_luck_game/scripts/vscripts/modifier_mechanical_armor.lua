modifier_mechanical_armor = class({})


function modifier_mechanical_armor:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE
	}
 
	return funcs
end

function modifier_mechanical_armor:GetModifierTotalDamageOutgoing_Percentage()
    local caster = self:GetCaster()
	local outGoingPercent = caster:GetHealthPercent()-100
    if outGoingPercent < -30 and outGoingPercent > -70 then
        GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("mechenical_armor_timer"),
            function ()
                if caster:IsAlive() then
                    ParticleManager:CreateParticle("particles/skills/mechanical_armor/70percent.vpcf", 1, caster)
                    return 1.5
                else 
                    return nil
                end
            end,1.5)
    end

    if outGoingPercent < -70 then
        GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("mechenical_armor_timer2"),
            function ()
                if caster:IsAlive() then
                    ParticleManager:CreateParticle("particles/skills/mechanical_armor/30percent.vpcf", 1, caster)
                    return 1.5
                else 
                    return nil
                end
            end,1.5)
    end

	return outGoingPercent
end