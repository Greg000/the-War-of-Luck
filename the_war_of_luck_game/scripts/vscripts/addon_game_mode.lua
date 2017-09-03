-- Generated from template
require("lib/notifications")
require("functions")
require("rune_system")
require("SummonUnits")
require("lib/Voting")
require("lib/rounds")
require("lib/score")
require("lib/test_mode")
if LuckyWarGameMode == nil then
	LuckyWarGameMode = class({})
end


Guardians = {}

Global_Game_State = 0
        -- 0 represent default
        -- 1 represent in battle
        -- 2 represent gap



function Precache( context )
	--[[
		Precache things we know we'll use.  Possible file types include (but not limited to):
			PrecacheResource( "model", "*.vmdl", context )models/creeps/neutral_creeps/n_creep_gnoll/n_creep_gnoll_frost.vmd
			PrecacheResource( "soundfile", "*.vsndevts", context )
			PrecacheResource( "particle", "*.vpcf", context )
			PrecacheResource( "particle_folder", "particles/folder", context )
	]]
	PrecacheResource( "creep_gnoll_frost", "models/creeps/neutral_creeps/n_creep_gnoll/n_creep_gnoll_frost.vmdl", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_omniknight/omniknight_repel_buff.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_phantom_assassin/phantom_assassin_stifling_dagger.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_phantom_assassin/phantom_assassin_stifling_dagger_debuff.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_nevermore/nevermore_death.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_shadow_demon/shadow_demon_soul_catcher_debuff.vpcf", context )
	PrecacheResource( "particle", "particles/skills/necro_Summonstart.vpcf", context )
	PrecacheResource( "particle", "particles/econ/items/techies/techies_arcana/techies_suicide_flame.vpcf", context )
	PrecacheResource( "particle", "particles/skills/strafe/bullet.vpcf", context )
        PrecacheResource( "particle", "particles/testparticle.vpcf", context )
        PrecacheResource( "particle", "particles/basic_effects/runes/haste/haste_dummy.vpcf", context )
        PrecacheResource( "particle", "particles/basic_effects/runes/doubledamage/dd_dummy.vpcf", context )
        PrecacheResource( "particle", "particles/basic_effects/runes/haste/thundergods_wrath.vpcf", context )
        PrecacheResource( "particle", "particles/basic_effects/runes/doubledamage/dd_gain.vpcf", context )
        PrecacheResource( "particle", "particles/skills/commander_base_attack/spear.vpcf", context )
        PrecacheResource( "particle", "particles/skills/rain_of_arrows/rain_of_arrows_final.vpcf", context )
        PrecacheResource( "particle", "particles/units/heroes/hero_brewmaster/brewmaster_hurl_boulder.vpcf", context )
        PrecacheResource( "particle", "particles/econ/items/phantom_assassin/phantom_assassin_weapon_runed_scythe/phantom_assassin_attack_blur_crit_runed_scythe.vpcf", context )
        PrecacheResource( "particle", "particles/skills/rain_of_arrows/rain_of_arrows_flag.vpcf", context )
        PrecacheResource( "particle", "particles/econ/items/legion/legion_fallen/legion_fallen_press.vpcf", context )     
        PrecacheResource( "particle", "particles/units/heroes/hero_tidehunter/tidehunter_gush_upgrade.vpcf", context )
        PrecacheResource( "particle", "particles/skills/hammer/hammer_skeletonking_hellfireblast.vpcf", context )
        PrecacheResource( "particle", "particles/skills/entangling_shot/entangling_shot.vpcf", context )
        PrecacheResource( "particle", "particles/units/heroes/hero_magnataur/magnataur_shockwave.vpcf", context )
        PrecacheResource( "particle", "particles/units/heroes/hero_nyx_assassin/nyx_assassin_impale.vpcf", context )
        PrecacheResource( "particle_folder", "particles/skills", context )


        PrecacheResource( "particle", "particles/skills/mechanical_armor/70percent.vpcf", context )
        PrecacheResource( "soundfile", "sounds/weapons/hero/beastmaster/attack02.vsnd", context )
        PrecacheResource( "particle", "particles/basic_effects/teleport/tepelport.vpcf", context )
        PrecacheResource( "particle", "particles/basic_effects/teleport/flash.vpcf", context )
        
        PrecacheResource( "particle", "particles/units/heroes/hero_crystalmaiden/maiden_base_attack.vpcf", context )
        PrecacheResource( "particle", "particles/units/heroes/hero_batrider/batrider_base_attack.vpcf", context )
        PrecacheResource( "particle", "particles/econ/items/shadow_fiend/sf_desolation/sf_base_attack_desolation.vpcf", context )
        PrecacheResource( "particle", "particles/units/heroes/hero_huskar/huskar_base_attack.vpcf", context )
        PrecacheResource( "particle", "particles/units/heroes/hero_morphling/morphling_base_attack.vpcf", context )
        PrecacheResource( "particle", "particles/units/heroes/hero_oracle/oracle_base_attack.vpcf", context )
        PrecacheResource( "particle", "particles/units/heroes/hero_windrunner/windrunner_base_attack.vpcf", context )
        PrecacheResource( "particle", "particles/units/heroes/hero_templar_assassin/templar_assassin_base_attack.vpcf", context )
        PrecacheResource( "particle", "particles/units/heroes/hero_tinker/tinker_base_attack.vpcf", context )
        PrecacheResource( "particle", "particles/neutral_fx/gnoll_base_attack.vpcf", context )  
        PrecacheResource( "particle", "particles/units/heroes/hero_brewmaster/brewmaster_hurl_boulder.vpcf", context )  
        PrecacheResource( "particle", "particles/neutral_fx/ghost_frost_attack.vpcf", context )  
        PrecacheResource( "particle", "particles/units/heroes/hero_sniper/sniper_base_attack.vpcf", context )  
        PrecacheResource( "particle", "particles/units/heroes/hero_visage/visage_familiar_base_attack.vpcf", context )  
        PrecacheResource( "particle", "particles/units/heroes/hero_furion/furion_base_attack.vpcf", context )  
        PrecacheResource( "particle", "particles/units/heroes/hero_dragon_knight/dragon_knight_elder_dragon_fire.vpcf", context )  
        PrecacheResource( "particle", "particles/skills/arrow_of_light/arrow_of_light.vpcf", context )  
        PrecacheResource( "particle", "particles/units/heroes/hero_rubick/rubick_base_attack.vpcf", context )
        
        
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_earthshaker.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_beastmaster.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_troll_warlord.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_crystalmaiden.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_lina.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_ember_spirit.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_nevermore.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_huskar.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_pudge", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_items.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_juggernaut.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_nevermore.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_nightstalker.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_terrorblade.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_sniper.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_rattletrap.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_clinkz.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_legion_commander.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_obsidian_destroyer.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_creeps.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_skeletonking.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_phantom_assassin.vsndevts", context )        
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_chaos_knight.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_crystalmaiden.vsndevts", context )  
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_bounty_hunter.vsndevts", context )   
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_tidehunter.vsndevts", context ) 
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_morphling.vsndevts", context ) 
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_enchantress.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_meepo.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_pugna.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_razor.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_invoker.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_antimage.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_alchemist.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_bane.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_jakiro.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_terrorblade.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_tinker.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_centaur.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_magnataur.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_ogre_magi.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_tusk.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_ursa.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_axe.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_slark.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_nyx_assassin.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_oracle.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/fast_freeze.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/mana_void_modified.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/magic_well_cast.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_windrunner.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_furion.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_dragon_knight.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_rubick.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_keeper_of_the_light.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_puck.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/magic_sphere_cast.vsndevts", context )
        PrecacheResource( "model", "models/heroes/morphling/morphling.vmdl", context )
end

function PrecacheEveryThingFromKV( context )
         local kv_files = {"scripts/npc/npc_units_custom.txt","scripts/npc/npc_abilities_custom.txt","scripts/npc/npc_heroes_custom.txt","scripts/npc/npc_abilities_override.txt","npc_items_custom.txt"}
         for _, kv in pairs(kv_files) do
                 local kvs = LoadKeyValues(kv)
                 if kvs then
                         print("BEGIN TO PRECACHE RESOURCE FROM: ", kv)
                         PrecacheEverythingFromTable( context, kvs)
                 end
         end
 end

 function PrecacheEverythingFromTable( context, kvtable)
         for key, value in pairs(kvtable) do
                 if type(value) == "table" then
                         PrecacheEverythingFromTable( context, value )
                 else
                         if string.find(value, "vpcf") then
                                 PrecacheResource( "particle",value, context)
                                 print("PRECACHE PARTICLE RESOURCE", value)
                         end
                         if string.find(value, "vmdl") then         
                                 PrecacheResource( "model",value, context)
                                 print("PRECACHE MODEL RESOURCE", value)
                         end
                         if string.find(value, "vsndevts") then
                                 PrecacheResource( "soundfile",value, context)
                                 print("PRECACHE SOUND RESOURCE", value)
                         end
                 end
         end           
 end

-- Create the game mode when we activate
function Activate()
        
	GameRules.Event = LuckyWarGameMode()
	GameRules.Event:InitGameMode()
        
end

function LuckyWarGameMode:InitGameMode()
	print( "Template addon is loaded." )
	GameRules:GetGameModeEntity():SetThink( "OnThink", self, "GlobalThink", 2 )
        
        ListenToGameEvent("player_chat", Dynamic_Wrap(LuckyWarGameMode, "OnPlayerChat"), self)
	ListenToGameEvent("entity_killed", Dynamic_Wrap(LuckyWarGameMode, "OnEntityKilled"), self)
        ListenToGameEvent("game_rules_state_change", Dynamic_Wrap(LuckyWarGameMode,"OnGameRulesStateChange"), self)--listen to game state
        ListenToGameEvent("player_spawn", Dynamic_Wrap(LuckyWarGameMode,"OnPlayerSpawn"), self)
        ListenToGameEvent("dota_player_pick_hero",Dynamic_Wrap(LuckyWarGameMode,"OnPlayerPickHero"),self)
        CustomGameEventManager:RegisterListener("testmode_hero_selected",Dynamic_Wrap(LuckyWarGameMode,'testmode_hero_selected'))
        CustomGameEventManager:RegisterListener("testmode_creep_selected",Dynamic_Wrap(LuckyWarGameMode,'testmode_creep_selected'))
        event = CustomGameEventManager:RegisterListener("SetLevel",Dynamic_Wrap(LuckyWarGameMode,'SetLevel'))
        
        GameRules:GetGameModeEntity():SetFogOfWarDisabled(true)
	GameRules:GetGameModeEntity():SetExecuteOrderFilter( Dynamic_Wrap(LuckyWarGameMode, "FilterExecuteOrder" ), self )
        GameRules:GetGameModeEntity():SetDamageFilter( Dynamic_Wrap(LuckyWarGameMode, "Damagefilter_main" ), self )
        GameRules:GetGameModeEntity():SetCameraDistanceOverride(1800)
	--Initialize OrderFilter

        --[[GameRules:SetHeroSelectionTime(5.0)
        GameRules:SetCustomGameSetupRemainingTime(0.0)
        GameRules:SetPreGameTime( 20)--set the pregame time]]--

        SummonUnits:Precache()

        

end

-- Evaluate the state of the game
function LuckyWarGameMode:OnThink()

        --StartCreatingRunes()

	if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		--print( "Template addon script is running." )
	elseif GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME then
		return nil
	end
	return 1
end

function LuckyWarGameMode:OnEntityKilled( keys )
        local deadUnit = EntIndexToHScript(keys.entindex_killed)

        if TestMode:IsTestMode() == true then
                return
        end

        if Rounds:ShouldStartNewRound( keys) ==  true then
                SummonUnits:Invulnerability(deadUnit)
                SummonUnits:KillRemnant(deadUnit)
                --all units have been removed, now start a new round.
                        for i = 0, DOTA_MAX_TEAM_PLAYERS do
                                if PlayerResource:IsValidPlayer(i) then
                                        Timers:CreateTimer(5, function()
                                                --keys.player_id = i
                                                SummonUnits:SummonHeroesandCreeps(i)
                                                return nil
                                                end)
                                end
                        end     
        end  
end

function LuckyWarGameMode:Damagefilter_main( filterTable)
        if LuckyWarGameMode:Damagefilter_heroic(filterTable) and LuckyWarGameMode:Damagefilter_network(filterTable) then
                return true
        else
                return false
        end
end
function LuckyWarGameMode:Damagefilter_heroic( filterTable)
        local attackerIndex = filterTable["entindex_attacker_const"]
	local victimIndex = filterTable["entindex_victim_const"]
        if attackerIndex == nil then
                return true
        end 
        local attacker = EntIndexToHScript(attackerIndex)
        local victim = EntIndexToHScript(victimIndex)
        if victim:GetUnitName() == "npc_dota_hero_legion_commander" then
 
                if attacker:IsHero() == true   then
                        return true
                else
                        local ability = victim:FindAbilityByName("Heroic")
                        if victim:GetHealthPercent() < ability:GetLevelSpecialValueFor("percentage", ability:GetLevel() - 1) then
                                return false
                        else 
                                return true
                        end
                end
        else
                return true
        end
end 

function LuckyWarGameMode:Damagefilter_network( filterTable)
        

        local dummy = _G.network_dummy
        local attackerIndex = filterTable["entindex_attacker_const"]
	local victimIndex = filterTable["entindex_victim_const"]
        

        local victim = EntIndexToHScript(victimIndex)
        local attacker = nil
        if attackerIndex ~= nil then
                attacker = EntIndexToHScript(attackerIndex)
        end
        if victim:FindModifierByName("modifier_network") == nil then
                return true
        else

        if attacker == dummy then
                return true
        end

                local ability = victim:FindModifierByName("modifier_network"):GetAbility()
                local caster = ability:GetCaster()
                local reduction_ratio = ability:GetLevelSpecialValueFor("reduction_ratio", ability:GetLevel() - 1) / 100
                local other_units= FindUnitsInRadius(victim:GetTeamNumber(), victim:GetAbsOrigin(), nil, 2000, 1, ability:GetAbilityTargetType(), ability:GetAbilityTargetFlags(), 0, false)
                local other_units_in_network = {}
                for _,unit in pairs(other_units) do
                        if unit:FindModifierByName("modifier_network") ~= nil then
                                table.insert(other_units_in_network, unit)
                        end
                end
                local number_in_network = table.getn(other_units_in_network)
                for _,unit in pairs(other_units_in_network) do
                        local damageTable = {victim = unit,    
                                                 attacker =     dummy,        
                                                 damage = filterTable["damage"] * reduction_ratio / number_in_network,    
                                                 damage_type = DAMAGE_TYPE_PURE,
                                                 ability = ability}
                        ApplyDamage(damageTable)
                        --print("damageTable",damageTable.damage)
                end

                filterTable["damage"] = filterTable["damage"] * (1 - reduction_ratio)
 
                return true
        end
end 

function LuckyWarGameMode:FilterExecuteOrder( filterTable )
        local f = filterTable
        if f.order_type ==  DOTA_UNIT_ORDER_MOVE_TO_POSITION then --recognizes order type
                local unit = EntIndexToHScript(f.units["0"])
                if unit:FindModifierByName("modifier_ChaosStrike_buff") then --checks whether the unit has the buff.
                        local v = Vector(f.position_x,f.position_y,f.position_z)
                        local r_v = RotatePosition(unit:GetAbsOrigin(),QAngle(0,180,0),v) --rotates the target point.
                        --map bound.
                        if r_v.x > GetWorldMaxX() then
                                r_v.x = GetWorldMaxX()
                        end
                        if r_v.x < GetWorldMinX() then
                                r_v.x = GetWorldMinX()
                        end
                        if r_v.y > GetWorldMaxY() then
                                r_v.y = GetWorldMaxY()
                        end
                        if r_v.y < GetWorldMinY() then
                                r_v.y = GetWorldMinY()
                        end
                        --put new values into the table.
                        f.position_x = r_v.x
                        f.position_y = r_v.y
                end
        end
        return true
end
 

function LuckyWarGameMode:OnGameRulesStateChange( keys )
    print("OnGameRulesStateChange")
 
    --gets game state
    local newState = GameRules:State_Get()
 
    --game begins
    if newState==DOTA_GAMERULES_STATE_GAME_IN_PROGRESS  then
        
        for i = 0, DOTA_MAX_TEAM_PLAYERS  do
                if PlayerResource:IsValidPlayer(i) then
                        SummonUnits:SummonHeroesandCreeps(i)
                end
        end

        GameRules:GetGameModeEntity():SetTopBarTeamValue(DOTA_TEAM_GOODGUYS,10)
        GameRules:GetGameModeEntity():SetTopBarTeamValuesOverride(true)
        CustomGameEventManager:Send_ServerToAllClients( "luckywar_toggle_vote", {visible = false} )
    	--sends notifications to all players.
    	Notifications:TopToAll(
    		{
    			text = "Round Starts!",
    			duration = 5,
    			class = nil, 
    			style={color="red", ["font-size"]="60px"},
    			continue= true
    		})

    	--gives ability points to all heroes
        for _,unit in pairs ( Entities:FindAllByName( "npc_dota_hero*")) do
            unit:SetAbilityPoints(10)
        end

        --display round number on client PUI
        CustomGameEventManager:Send_ServerToAllClients( "luckywar_initiate_rounds_number", {TotalRound = Voting:GetTotalRoundsNumber()} )

    end



    if newState == DOTA_GAMERULES_STATE_PRE_GAME    then
        LinkLuaModifier("modifier_dd_lua", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier( "modifier_fountain_regeneration_lua", "modifier_fountain_regeneration_lua.lua", LUA_MODIFIER_MOTION_NONE )
        LinkLuaModifier( "modifier_invulneral_lua", LUA_MODIFIER_MOTION_NONE )
        
        --regists necessary modifiers
        SummonUnits:Allocate()
              
        --StartVotingTimer(15)

              
    end
end





function LuckyWarGameMode:OnPlayerSpawn( keys )
        print(keys.userid)
        -- body
end


function TeleportEnemy( DiedUnit )
    local EnemyTeamNum = DiedUnit:GetOpposingTeamNumber()
    local Units = FindUnitsInRadius(DiedUnit:GetTeamNumber(), DiedUnit:GetAbsOrigin(), nil, 50000, 2, 63, 0, 0, false) --find all the enemy units


    --abvoe codes finish the effect, then play the message
    local times = 0
            GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("Teleporting_timer"),
                function ()
                    if times < 10 then
                        local messageinfo = {
                        message = tostring(10-times), 
                        duration = 0.8
                        }
                        FireGameEvent("show_center_message",messageinfo)

                        if times == 1 then 
                            print("???")
                            for i,unit in pairs(Units) do
                                if unit:IsAlive() then--make sure the unit is alive
                                    ParticleManager:CreateParticle("particles/basic_effects/teleport/tepelport.vpcf",1,unit)-- fire the effect
                                end
                            end
                        end

                        if times == 5 then
                            for i,unit in pairs(Units) do
                                if unit:IsAlive()  then--make sure the unit is alive
                                   local flash = ParticleManager:CreateParticle("particles/basic_effects/teleport/flash.vpcf",8,unit)
                                   ParticleManager:SetParticleControl(flash,0,unit:GetAbsOrigin())
                                   unit:AddNoDraw()

                                end
                            end
                        end

                    

                         times = times +1
                        return 1

                    elseif times == 10 then
                        for i,unit in pairs(Units) do
                                if unit:IsAlive()  then--make sure the unit is alive
                                   unit:RemoveSelf()
                                end
                            end
                        SummonUnits()
                        return nil
                    end





                end,1)
end

function StartCreatingRunes () -- rune system is temporarily abolished.
        if  times == nil then
                times = 0
        end
        
        if Global_Game_State == 1 and times < 30 then
                times = times +1

        
       
        
        elseif Global_Game_State == 2 or times == 30 then
                times = nil
        end



        if Global_Game_State == 1 and times == 20 then
                local runeTable = {
                        [1] = 1,
                        [2] = 2,
                        [3] = 1,
                        [4] = 2
                }
                for _,ent in pairs(Entities:FindAllByName("rune*")) do
                        local index = RandomInt(1, table.getn(runeTable))
                        print("index:",runeTable[index])
                        rune_system:Create(runeTable[index],ent)
                        table.remove(runeTable,index)
                end
               --[[] print("20")
                local ent_dd = Entities:FindByName(nil,"rune2")
                print(ent_dd)
                local ent_haste =  Entities:FindByName(nil,"rune3")
                local dd =  ParticleManager:CreateParticle("particles/basic_effects/runes/doubledamage/dd_dummy.vpcf", 8, nil)
                local haste = ParticleManager:CreateParticle("particles/basic_effects/runes/haste/haste_dummy.vpcf",8, nil)
                ParticleManager:SetParticleControl(haste, 0, ent_haste:GetAbsOrigin())        
                ParticleManager:SetParticleControl(dd, 0, ent_dd:GetAbsOrigin())          

                -- then set the explosion effect
                ParticleManager:SetParticleControl(dd, 2,Vector(800,0,0))   
                ParticleManager:SetParticleControl(haste, 2,Vector(800,0,0))]]
            
        end
end     


function LuckyWarGameMode:OnPlayerPickHero(keys)
    --[[local hero = EntIndexToHScript(keys.heroindex)
	local pID = hero:GetPlayerID()
        print("playeridjune",pID)
	local player = hero:GetPlayerOwner()
    if player.InitialPick ~= false then
        DeepPrintTable(keys)
        print("HeroPicked")
        SummonUnits:Allocate(keys)
    end
        player.InitialPick = false]]--
end

--[[function LuckyWarGameMode:RemoveWearables(keys)
        DeepPrintTable(keys)
        local player = EntIndexToHScript(keys.player)
        local hero = player:GetAssignedHero()
         print("Hiding Wearables")
 --hero:AddNoDraw() -- Doesn't work on classname dota_item_wearable

        hero.wearableNames = {} -- In here we'll store the wearable names to revert the change
        hero.hiddenWearables = {} -- Keep every wearable handle in a table, as its way better to iterate than in the MovePeer system
        local model = hero:FirstMoveChild()
        while model ~= nil do
        if model:GetClassname() ~= "" and model:GetClassname() == "dota_item_wearable" then
            local modelName = model:GetModelName()
            if string.find(modelName, "invisiblebox") == nil then
             -- Add the original model name to revert later
             table.insert(hero.wearableNames,modelName)
             print("Hidden "..modelName.."")

             -- Set model invisible
             model:SetModel("models/development/invisiblebox.vmdl")
             table.insert(hero.hiddenWearables,model)
            end
        end
        model = model:NextMovePeer()
        if model ~= nil then
         print("Next Peer:" .. model:GetModelName())
        end
    end
end]]--

function LuckyWarGameMode:SetLevel(Level)
        local ButtonIndex = Level["key1"]
        Voting:NewVote(ButtonIndex)
        print(Level["key1"])
end

function  StartVotingTimer(maxTime)
        print("starttimer")
        Timers:CreateTimer(function()
        if maxTime >= 0 then
                CustomGameEventManager:Send_ServerToAllClients( "luckywar_start_timer", {time = maxTime} )
                maxTime = maxTime -1
                print(maxTime)
                return 1.0
        else 
                CustomGameEventManager:Send_ServerToAllClients("luckywar_toggle_vote",{visible = false})
                Voting:ReturnVoteResult()
        end
    end
  )

end

function LuckyWarGameMode:testmode_hero_selected(data)
        SummonUnits:New_Hero_Testmode(data.hero_index,data.player_id)
end

function LuckyWarGameMode:testmode_creep_selected(data)
        SummonUnits:New_Creep_Testmode(data.creep_index,data.player_id)
end

function LuckyWarGameMode:OnPlayerChat( data )
        if TestMode:IsTestMode() ~= true then
                print(data.text)
                if data.text == "enabletestmode" or data.text == "郭神牛逼" then
                        Notifications:TopToAll(
    		        {
    			        text = "Testmode Enabled",
    			        duration = 5,
    			        class = nil, 
    			        style={color="white", ["font-size"]="30px"},
    			        continue= false
    		        })
                        TestMode:InitializeTestMode();
                        CustomGameEventManager:Send_ServerToAllClients( "luckywar_test_mode_enabled", {} )
                end
                
        end    
end