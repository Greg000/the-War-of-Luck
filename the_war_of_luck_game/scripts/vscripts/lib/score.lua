if Score == nil then
	Score = class({})
end

if Score.radiant_score == nil then
    Score.radiant_score = 0
end

if Score.dire_score == nil then
    Score.dire_score = 0
end

function Score:UpdateScore(winner)
    if winner == DOTA_TEAM_GOODGUYS then
        Score.radiant_score = Score.radiant_score + 1
    else
        Score.dire_score = Score.dire_score + 1
    end

    CustomGameEventManager:Send_ServerToAllClients( "luckywar_update_score", {radiant_score = Score.radiant_score, dire_score = Score.dire_score} )

end


function Score:GetWinner()
    if Score.radiant_score > Score.dire_score then
        return DOTA_TEAM_GOODGUYS
    else
        return DOTA_TEAM_BADGUYS
    end
end