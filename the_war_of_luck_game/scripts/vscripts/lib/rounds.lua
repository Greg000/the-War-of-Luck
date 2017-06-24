require("lib/Voting")

if Rounds == nil then
	Rounds = class({})
end

if Rounds.rounds_number == nil then
    Rounds.rounds_number = 0
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