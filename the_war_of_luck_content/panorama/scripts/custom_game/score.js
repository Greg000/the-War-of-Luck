"use strict";

GameEvents.Subscribe( "luckywar_update_score", UpdateScore);

function UpdateScore( data ){
    var RadiantScore = data.radiant_score
    var DireScore = data.dire_score
    var RadiantScoreLabel = $("#RadiantScoreLabel")
    var DireScoreLabel = $("#DireScoreLabel")

    RadiantScoreLabel.text = RadiantScore
    DireScoreLabel.text = DireScore

}