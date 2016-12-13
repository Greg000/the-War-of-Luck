--[[
	Author: Noya
	Date: 14.01.2015.
	Applies a Lifesteal modifier if the attacked target is not a building and not a mechanical unit
]]
function VampiricAuraApply( event )
	-- Variables
	local attacker = event.attacker
	local target = event.target
	print(target)
	local ability = event.ability

	if target.GetInvulnCount == nil  then
		ability:ApplyDataDrivenModifier(attacker, attacker, "modifier_agitation_steal2", {duration = 0.03})
	end
end