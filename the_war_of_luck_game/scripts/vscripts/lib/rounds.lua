require("lib/Voting")
require("lib/score")
if Rounds == nil then
	Rounds = class({})
end

if Rounds.rounds_number == nil then
    Rounds.rounds_number = 0
end

if Rounds.deadHeroCount == nil then
    Rounds.deadHeroCount = {}
end

function Rounds:UpdateRounds()
    Rounds.TotalRound = Voting:GetTotalRoundsNumber()
    Rounds.rounds_number = Rounds.rounds_number + 1 
    CustomGameEventManager:Send_ServerToAllClients( "luckywar_update_rounds", {rounds_number = Rounds.rounds_number, TotalRound = Rounds.TotalRound} )
end


function Rounds:CheckAllRoundsOver()
    local totalRounds = Voting:GetTotalRoundsNumber()
    if totalRounds == Rounds.rounds_number then
        return false
    else
        return true
    end
end 

function Rounds:ShouldStartNewRound( keys )
    local deadUnit = EntIndexToHScript(keys.entindex_killed)
    local deadHeroCount = self.deadHeroCount
    if deadHeroCount[deadUnit:GetTeamNumber()] == nil then deadHeroCount[deadUnit:GetTeamNumber()] = 0 end
    if deadUnit:IsHero() then
        deadHeroCount[deadUnit:GetTeamNumber()] = deadHeroCount[deadUnit:GetTeamNumber()] + 1 
            if deadHeroCount[deadUnit:GetTeamNumber()] == PlayerResource:GetPlayerCountForTeam(deadUnit:GetTeamNumber()) then --check whether all heroes in the team have died.
                --check if all rounds have run over, if not , update rounds number and score on UI.NOTE:The current round needs to be updated before round check.
                Rounds:UpdateRounds()
                Score:UpdateScore(deadUnit:GetOpposingTeamNumber())  
                if Rounds:CheckAllRoundsOver() then
                    Rounds.deadHeroCount = {}
                    return true
                else
                    local winner = Score:GetWinner()
                    GameRules:SetGameWinner(winner)
                    GameRules:Defeated() 
                end

        
            end
    end
    return false
end