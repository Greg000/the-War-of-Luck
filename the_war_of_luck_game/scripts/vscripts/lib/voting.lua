if Voting == nil then
	Voting = class({})
end
local Table_Button_To_Rounds = {
    [1] = 9,
    [2] = 19,
    [3] = 29,
    [4] = 39,
    [5] = 49
}
Voting.VoteCount = {}

function Voting:NewVote(ButtonIndex)
    if Voting.VoteCount[ButtonIndex] == nil then
        Voting.VoteCount[ButtonIndex] = 1
        print(Voting.VoteCount[ButtonIndex])
    else 
        Voting.VoteCount[ButtonIndex] = Voting.VoteCount[ButtonIndex] + 1
        print(Voting.VoteCount[ButtonIndex])
    end

    Voting:UpdateVoteCountToClient(ButtonIndex)

end

function Voting:UpdateVoteCountToClient(ButtonIndex)
    local VoteCount =  Voting.VoteCount[ButtonIndex]
    CustomGameEventManager:Send_ServerToAllClients( "luckywar_update_vote", {ButtonIndex = ButtonIndex, VoteCount = VoteCount } )
end


function Voting:ReturnVoteResult()
    local FinalLevel = 0
    local FinalID = nil
    for i = 1,5 do 
        if Voting.VoteCount[i] ~= nil then
            if Voting.VoteCount[i] > FinalLevel then
                FinalLevel = Voting.VoteCount[i]
                FinalID = i
            end
        end
    end
    CustomGameEventManager:Send_ServerToAllClients( "luckywar_final_result", {ButtonIndex = FinalID } )
    Voting.RoundNumber = Table_Button_To_Rounds[FinalID]
end

function Voting:GetTotalRoundsNumber()
    return Voting.RoundNumber
end