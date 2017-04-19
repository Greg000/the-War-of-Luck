"use strict";

GameEvents.Subscribe( "luckywar_initiate_rounds_number", SetInitialRoundsNumber);
GameEvents.Subscribe( "luckywar_update_rounds", UpdateRoundsNumber);



function SetInitialRoundsNumber( data ){
    var TotalRound = data.TotalRound
    var RoundsLabel = $("#RoundsLabel")
    var RoundsCount = "0 / "
    RoundsCount = RoundsCount + TotalRound
    RoundsLabel.text = RoundsCount
}

function UpdateRoundsNumber( data){
    var rounds_number = data.rounds_number
    rounds_number += " / "
    rounds_number +=  TotalRound.toString()
    RoundsLabel.text = rounds_number
} 