-- Generated from template
require("lib/notifications")
require("functions")
require("rune_system")
require("SummonUnits")
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
        PrecacheResource( "particle", "particles/units/heroes/hero_morphling/morphling_base_attack.vpcf", context )
        
       

        PrecacheResource( "particle", "particles/skills/mechanical_armor/70percent.vpcf", context )
        PrecacheResource( "soundfile", "sounds/weapons/hero/beastmaster/attack02.vsnd", context )
        PrecacheResource( "particle", "particles/basic_effects/teleport/tepelport.vpcf", context )
        PrecacheResource( "particle", "particles/econ/items/shadow_fiend/sf_desolation/sf_base_attack_desolation.vpcf", context )
        PrecacheResource( "particle", "particles/units/heroes/hero_huskar/huskar_base_attack.vpcf", context )
        PrecacheResource( "particle", "particles/basic_effects/teleport/flash.vpcf", context )
    
         PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_earthshaker.vsndevts", context )
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
        CustomGameEventManager:RegisterListener("LevelUp",Dynamic_Wrap(LuckyWarGameMode, 'LevelUp1'))--UIUIUIUIUI
end

function LuckyWarGameMode:InitGameMode()
	print( "Template addon is loaded." )
	GameRules:GetGameModeEntity():SetThink( "OnThink", self, "GlobalThink", 2 )

	ListenToGameEvent("entity_killed", Dynamic_Wrap(LuckyWarGameMode, "OnEntityKilled"), self)
        ListenToGameEvent("game_rules_state_change", Dynamic_Wrap(LuckyWarGameMode,"OnGameRulesStateChange"), self)--listen to game state
        ListenToGameEvent("player_spawn", Dynamic_Wrap(LuckyWarGameMode,"OnPlayerSpawn"), self)
        ListenToGameEvent("dota_player_pick_hero",Dynamic_Wrap(LuckyWarGameMode,"OnPlayerPickHero"),self)

        

	GameRules:GetGameModeEntity():SetExecuteOrderFilter( Dynamic_Wrap(LuckyWarGameMode, "FilterExecuteOrder" ), self )
        GameRules:GetGameModeEntity():SetDamageFilter( Dynamic_Wrap(LuckyWarGameMode, "Damagafilter_heroic" ), self )
        GameRules:GetGameModeEntity():SetCameraDistanceOverride(1800)
	--Initialize OrderFilter

        GameRules:SetHeroSelectionTime(5.0)
        GameRules:SetCustomGameSetupRemainingTime(0.0)
        GameRules:SetPreGameTime( 5.0)--set the pregame time

        SummonUnits:Precache()

        

end

-- Evaluate the state of the game
function LuckyWarGameMode:OnThink()

        StartCreatingRunes()

	if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		--print( "Template addon script is running." )
	elseif GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME then
		return nil
	end
	return 1
end

function LuckyWarGameMode:OnEntityKilled( keys )
        local deadUnit = EntIndexToHScript(keys.entindex_killed)
        if deadHeroCount == nil then deadHeroCount = {} end
        if deadHeroCount[deadUnit:GetTeamNumber()] == nil then deadHeroCount[deadUnit:GetTeamNumber()] = 0 end
        if deadUnit:IsHero() then
                deadHeroCount[deadUnit:GetTeamNumber()] = deadHeroCount[deadUnit:GetTeamNumber()] +1
                if deadHeroCount[deadUnit:GetTeamNumber()] == PlayerResource:GetPlayerCountForTeam(deadUnit:GetTeamNumber()) then
                        for i = 0,10 do
                                if PlayerResource:IsValidPlayer(i) then
                                        SummonUnits:Invulnerability(deadUnit)
                                        SummonUnits:KillRemnant(deadUnit)
                                        Timers:CreateTimer(5, function()
                                                local pID = deadUnit:GetPlayerID()
                                                print("bigPid",pID)
                                                SummonUnits:Precache()

                                                for pID = 0,9 do
                                                        print(pID, PlayerResource:IsValidPlayer(pID))
                                                        if PlayerResource:IsValidPlayer(pID) then
                                                                DeepPrintTable( keys )
                                                                SummonUnits:ReAllocate( keys )
                                                        end
                                                end
                                                print("huanyingxiong")
                                                deadHeroCount = nil
                                        return nil
                                        end)
                                end
                        end
                end
        end      
end

function LuckyWarGameMode:Damagafilter_heroic( filterTable)
        local attackerIndex = filterTable["entindex_attacker_const"]
	local victimIndex = filterTable["entindex_victim_const"]
        if attackerIndex then
                local attacker = EntIndexToHScript(attackerIndex)
        end
        local victim = EntIndexToHScript(victimIndex)
        if victim:GetUnitName() == "Commander" then
                if attacker:FindModifierByName("modifier_HeroFlag") ~= nil  then
                        return true
                else
                        if victim:GetHealthPercent() < 17 then
                                return false
                        else 
                                return true
                        end
                end
        else
                return true
        end
end 
function LuckyWarGameMode:FilterExecuteOrder( filterTable )
--DeepPrintTable(filterTable)  --多用这个来print各种表，能学会挺多，下面比如什么position_x 都在这个filterTable里，print一下就知道这里面有什么了
        local f = filterTable
        --对lua不熟悉的人注意一下，“=”并不是“复制粘贴”，这里我们更改了f这个table的值，其实也就更改了filterTable，在c语言里面来说大概就是复制了一个指针，而不是复制了一个数组，这里这样写只是为了少打几个字 -_-||
        
 
        if f.order_type ==  DOTA_UNIT_ORDER_MOVE_TO_POSITION then --如果下达的指令类型是移动到某个地点（这个常量表也在一楼的wiki上能查到，网页按Ctrl + F是搜索）
                local unit = EntIndexToHScript(f.units["0"]) --单位
                if unit:FindModifierByName("modifier_ChaosStrike_buff") then --在这种情况下这个单位就是移动的单位，查找他是否有上面那个技能的debuff
                        local v = Vector(f.position_x,f.position_y,f.position_z)
                        local r_v = RotatePosition(unit:GetAbsOrigin(),QAngle(0,180,0),v) --把v这个坐标围绕unit的位置坐标在水平面上旋转180°
                        --以下这些是防止新生成的坐标超出了地图的界限
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
--更改原来的指令指向的坐标
                        f.position_x = r_v.x
                        f.position_y = r_v.y
                end
        end
        return true--对于return有三种情况，一种false，就等于指令被过滤不生效（本例子情况下就是点击了移动但是不移动），一种是true，并且不做更改，等于没有过滤器一样，还有一种就是上面那样更改了表中的几个值再返回true，那么生效的就是更改后的指令（本例子情况下就是移动了，但是移动的目的地变了）
end
 

function LuckyWarGameMode:OnGameRulesStateChange( keys )
    print("OnGameRulesStateChange")
 
    --获取游戏进度
    local newState = GameRules:State_Get()
 
    --游戏开始
    if newState==DOTA_GAMERULES_STATE_GAME_IN_PROGRESS  then
        print(PlayerResource:GetPlayerCount())
        for pID = 0,9 do
                print(pID, PlayerResource:IsValidPlayer(pID))
                if PlayerResource:IsValidPlayer(pID) then
                        --SummonUnits(pID)
                end
        end
        --SummonUnits()
        for _,unit in pairs ( Entities:FindAllByName( "npc_dota_hero*")) do
            unit:SetAbilityPoints(6)
        end

        for _,unit in pairs( Entities:FindAllByName("Lucky Guardian")) do
                local team = unit:GetTeamNumber()
                Guardians[team] = unit
        end
    end



    if newState == DOTA_GAMERULES_STATE_PRE_GAME    then
        LinkLuaModifier("modifier_dd_lua", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier( "modifier_fountain_regeneration_lua", "modifier_fountain_regeneration_lua.lua", LUA_MODIFIER_MOTION_NONE )
        LinkLuaModifier( "modifier_invulneral_lua", LUA_MODIFIER_MOTION_NONE )
        
        --regist necessary modifiers


         for _,unit in pairs ( Entities:FindAllByName( "npc_dota_hero*")) do
            for i = 0,20 do
            local  ability =  unit:GetAbilityByIndex(i)
                if ability ~= nil then

                    if ability:GetAbilityName() == "Initialization" then

                        ability:UpgradeAbility(true)
                        ability:CastAbility()
                        break
                    end
                end
            end
         end

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

function StartCreatingRunes ()
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


function LuckyWarGameMode:LevelUp1(args)
        print(args["key1"])
        local pID = args["key1"]
        local hero = PlayerResource:GetSelectedHeroEntity(pID)
        local newHero = HeroList:GetHero(1)
        PlayerResource:ReplaceHeroWith(pID, "npc_dota_hero_juggernaut", 0, 0)
end

function LuckyWarGameMode:OnPlayerPickHero(keys)
        local hero = EntIndexToHScript(keys.heroindex)
	local pID = hero:GetPlayerID() 
	local player = hero:GetPlayerOwner()
        if player.InitialPick ~= false then
                DeepPrintTable(keys)
                print("HeroPicked")
                SummonUnits:Allocate(keys)
        end

        player.InitialPick = false

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