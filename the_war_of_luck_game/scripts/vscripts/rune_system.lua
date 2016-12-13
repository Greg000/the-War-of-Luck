require("lib/timers")

if rune_system == nil then
    rune_system = class({})
end


function rune_system:Red_Rune (ent)
        local ori = ent:GetAbsOrigin()
        local Unitswithin = FindUnitsInRadius(2, ori, nil, 366.6, 3, 63, 0, 0, false) 
                
        local UnitsInBox = {}

        for _,unit in pairs(Unitswithin) do
            local center = ent:GetAbsOrigin()
            local unitCenter = unit:GetAbsOrigin()

            if math.abs(center.x-unitCenter.x) < 260 and math.abs(center.y-unitCenter.y) < 260 then
                        table.insert(UnitsInBox,unit)
            end
        end

                       
        local luckyunit = UnitsInBox[RandomInt(1, table.getn(UnitsInBox))]
        if luckyunit ~= nil then
            local team = luckyunit:GetTeamNumber()
            
            local units = FindUnitsInRadius(team, Vector(0,0,0), nil, 15000, 2, 63, 0, 0, false)

            for _, unit in pairs(units) do
                    local  origin = unit:GetAbsOrigin()
                    local thunder = ParticleManager:CreateParticle("particles/basic_effects/runes/haste/thundergods_wrath.vpcf",0,unit)
                    ParticleManager:SetParticleControl(thunder, 0,Vector(origin.x, origin.y, 1000) )
                    ParticleManager:SetParticleControl(thunder, 1,Vector(origin.x, origin.y, origin.z+128)  )
            end

            Notifications:TopToAll({text=GetTeamName(luckyunit:GetTeamNumber()).." ",style={color="red"},duration=5,continue = false})
            Notifications:TopToAll({text="Got the ",style={color="white"},duration=5,continue = true})
            Notifications:TopToAll({text="Red Rune!",style={color="red"},duration=5,continue = true})
        end
end

function rune_system:Blue_Rune (ent)
        local ori = ent:GetAbsOrigin()
        local Unitswithin = FindUnitsInRadius(2, ori, nil, 366.6, 3, 63, 0, 0, false) 
                
        local UnitsInBox = {}

        for _,unit in pairs(Unitswithin) do
            local center = ent:GetAbsOrigin()
            local unitCenter = unit:GetAbsOrigin()

            if math.abs(center.x-unitCenter.x) < 260 and math.abs(center.y-unitCenter.y) < 260 then
                        table.insert(UnitsInBox,unit)
            end
        end

                       
        local luckyunit = UnitsInBox[RandomInt(1, table.getn(UnitsInBox))]
        if luckyunit ~= nil then 
            local team = luckyunit:GetTeamNumber()

            local units =  FindUnitsInRadius(team, Vector(0,0,0), nil, 15000, 1, 63, 0, 0, false)
            for _, unit in pairs(units) do
                local  origin = unit:GetAbsOrigin()
                local dd_gain = ParticleManager:CreateParticle("particles/basic_effects/runes/doubledamage/dd_gain.vpcf",PATTACH_ROOTBONE_FOLLOW ,unit)
                ParticleManager:SetParticleControl(dd_gain, 1,Vector(80,0,0)  )
                unit:AddNewModifier(unit, nil, "modifier_dd_lua", {duration = 30})
            end

            Notifications:TopToAll({text=GetTeamName(luckyunit:GetTeamNumber()).." ",style={color="red"},duration=5,continue = false})
            Notifications:TopToAll({text="Got the ",style={color="white"},duration=5,continue = true})
            Notifications:TopToAll({text="Blue Rune!",style={color="blue"},duration=5,continue = true})
        end
end
        
function rune_system:Create(runeNum,ent)
    if runeNum == 1 then
        local dd =  ParticleManager:CreateParticle("particles/basic_effects/runes/doubledamage/dd_dummy.vpcf", 8, nil)
        ParticleManager:SetParticleControl(dd, 0, ent:GetAbsOrigin())
        ParticleManager:SetParticleControl(dd, 2,Vector(800,0,0)) 
        
        Timers:CreateTimer({
            endTime = 10, -- when this timer should first execute, you can omit this if you want it to run first on the next frame
            callback = function()
                            rune_system:Blue_Rune(ent)
                        end
             })

    elseif runeNum == 2 then
         local haste = ParticleManager:CreateParticle("particles/basic_effects/runes/haste/haste_dummy.vpcf",8, nil)
        ParticleManager:SetParticleControl(haste, 0, ent:GetAbsOrigin())  
        ParticleManager:SetParticleControl(haste, 2,Vector(800,0,0)) 

        Timers:CreateTimer({
            endTime = 10, -- when this timer should first execute, you can omit this if you want it to run first on the next frame
            callback = function()
                            rune_system:Red_Rune(ent)
                        end
             })
    end
end