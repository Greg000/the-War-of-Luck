function OnStartTouch(trigger)
	print(trigger.activator)
	local 	activator = trigger.activator
	activator:AddNewModifier(activator,nil, "modifier_fountain_regeneration_lua", {}) 
end
 
function OnEndTouch(trigger)
 
	print(trigger.activator)
	print(trigger.caller)
 
end