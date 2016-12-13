 "use strict";

 
 function LevelUp()
 {
     var pID = Game.GetLocalPlayerInfo().player_id;
    GameEvents.SendCustomGameEventToServer("LevelUp",pID);
}