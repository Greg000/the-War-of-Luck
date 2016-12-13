modifier_invulneral_lua = class({})

function modifier_invulneral_lua:CheckState()
	local state = {
	[MODIFIER_STATE_INVULNERABLE] = true,
    [MODIFIER_STATE_NIGHTMARED] = true
	}
 
	return state
end