"use strict";

var votingUI = $( "#testPanel" );

GameEvents.Subscribe( "luckywar_toggle_vote", LuckyWar_Toggle_Vote );
GameEvents.Subscribe( "luckywar_update_vote", CreateYellowSquare );
GameEvents.Subscribe( "luckywar_start_timer", Timer);
GameEvents.Subscribe( "luckywar_final_result", FinalResult);



function SetLevel(buttonID){
    GameEvents.SendCustomGameEventToServer("SetLevel",{ "key1" : buttonID});  
    $("#mainContainer").style.opacity = 1;
    
    for (var i=1;i<6;i++)
    {
        $("#level"+ i.toString()).enabled = false;
    }
    $("#level" + buttonID.toString()).style.brightness = 2;
    
}    

function LuckyWar_Toggle_Vote( data ){
    var main_container = $("#mainContainer")
    if (data.visible == false)
    {
         main_container.style.opacity = 0;
    }
    else
    {
         main_container.style.opacity = 1;
    }
}

function CreateYellowSquare (data){
    /** get the number (i.e. position) of the new panel from the server first  */ 
    var ButtonID = data.ButtonIndex
    var VoteCount = data.VoteCount;
    var fatherPanel = "#vote_box_"
    fatherPanel += ButtonID.toString();
    var panel = $(fatherPanel);

    for (var i=0;i<VoteCount;i++)
    {

    var newPanel  = $.CreatePanel('Panel', panel, '');
    var xPosition = i * 20 + 10
    newPanel.style.width = "12px";
    newPanel.style.height = "12px";
    newPanel.style["background-color"] = "#ece900ff"
    newPanel.style["position"] = xPosition.toString() + "px 65px" + " 0px"
    newPanel.style["box-shadow"] = "inset #000000ff 1px 1px 5px 2px"
    }
    

}

function Timer(data)
{
    var timerPanel = $("#timerlabel")
    timerPanel.text = data.time + ""

}

function FinalResult( data ){
    var ButtonID = data.ButtonIndex
    var Button = $("#level"+ ButtonID.toString())
    Button.style.brightness = 2;
    Button.style["box-shadow"] = "#ffffff8f 0px 0px 3px 1px"

}
     

