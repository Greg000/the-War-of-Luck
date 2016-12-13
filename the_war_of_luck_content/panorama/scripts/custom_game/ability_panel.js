 "use strict";

 
 function LevelUp()
 {
    var pID = Game.GetLocalPlayerID()
    GameEvents.SendCustomGameEventToServer("LevelUp",{ "key1":pID, "key2":"value2" });    //Client JavaScript向Server Lua发送事件和数据
}