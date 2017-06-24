modifier_fountain_regeneration_lua = class({})

function modifier_fountain_regeneration_lua:DeclareFunctions()
        local funcs = {
        		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
                MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
                MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE
                
          
        }
 
        return funcs
end

function modifier_fountain_regeneration_lua:GetActivityTranslationModifiers( params )
        if self:GetParent() == self:GetCaster() then
                return "fountain_regeneration"
        end
 
        return 0
end


function modifier_fountain_regeneration_lua:GetModifierHealthRegenPercentage( params )
		self.f_reg_hp = 0
		print(self.f_reg_hp)
        return self.f_reg_hp
end
 
--------------------------------------------------------------------------------
 
function modifier_fountain_regeneration_lua:GetModifierTotalPercentageManaRegen( params )
		self.f_reg_mp = 1.5
        return self.f_reg_mp
end

function modifier_fountain_regeneration_lua:GetEffectName( params )
        return "particles/world_shrine/radiant_shrine_regen.vpcf"
end

function modifier_fountain_regeneration_lua:GetEffectAttachType( params)        
        return 1
end

function modifier_fountain_regeneration_lua:GetTexture( params)
        return "fountain_heal"
end