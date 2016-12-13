require("lib/timers")

if DD_buff == nil then
  DD_buff = class({})
end

function DD_buff:Attach (team)
    local units =  FindUnitsInRadius(team, Vector(0,0,0), nil, 15000, 1, 63, 0, 0, false)
        for _, unit in pairs(units) do
                
                unit:AddNewModifier(unit, nil, "modifier_dd_lua", {duration = 30})
        end
end