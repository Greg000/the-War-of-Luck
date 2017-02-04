function OnStartTouch(trigger)
	local 	activator = trigger.activator
	activator:AddNewModifier(activator,nil, "modifier_fountain_regeneration_lua", {}) 
end
 
function OnEndTouch(trigger)
	local activator = trigger.activator
	activator:RemoveModifierByName("modifier_fountain_regeneration_lua")
end