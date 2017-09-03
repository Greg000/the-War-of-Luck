"use strict";

GameEvents.Subscribe( "luckywar_test_mode_enabled", MakeSidePanelVisible);

function eject( data ){
    var side_panel = $("#side_panel")
    var side_panel_button_image = $("#side_panel_button_panel")
    var button = $("#side_panel_button")
    if (button.BHasClass("class_switch_on"))
    {
        side_panel.style["position"] = "-570px 0 0"
        side_panel_button_image.style["transform"] = "rotateZ( 0deg )"
        button.RemoveClass("class_switch_on")
    }
    else
    {
        side_panel.style["position"] = "0px 0 0"
        side_panel_button_image.style["transform"] = "rotateZ( 180deg )"
        button.AddClass("class_switch_on")
    }
    Game.EmitSound("General.ButtonClick")

}

function hero( data ){
    var hero_index = data
    var pID = Game.GetLocalPlayerID()
    GameEvents.SendCustomGameEventToServer("testmode_hero_selected",{ "hero_index" : hero_index,"player_id" : pID});  
    Game.EmitSound("General.ButtonClick")
}

function creep_unfold( data ){
    var creep_container = $("#creep_container")
    var scroll_button = $("#creep_unfold_button")
    if (scroll_button.BHasClass("class_switch_on"))
    {
        creep_container.style["height"] = "40px"
        scroll_button.style["transform"] = "rotateZ( 0deg )"
        scroll_button.RemoveClass("class_switch_on")
    }
    else
    {
        creep_container.style["height"] = "240px"
        scroll_button.style["transform"] = "rotateZ( 180deg )"
        scroll_button.AddClass("class_switch_on")
    }
    Game.EmitSound("General.ButtonClick")
    
}

function creep( data ){
    var creep_index = data
    var pID = Game.GetLocalPlayerID()
    GameEvents.SendCustomGameEventToServer("testmode_creep_selected",{ "creep_index" : creep_index,"player_id" : pID});  
    Game.EmitSound("General.ButtonClick")
}

function page( data ){
    var page_button = $("#page_button")
    var hero_panel = $("#hero_icon_container")
    var creep_panel = $("#creep_container")
    if (page_button.BHasClass("class_to_right"))
    {
        hero_panel.style["position"] = "-50px 100px 0"
        hero_panel.style["opacity"] = "0"
        creep_panel.style["position"] = "180px 100px 0;"
        creep_panel.style["opacity"] = "1"
        page_button.style["transform"] = "rotateZ( 180deg )"
        page_button.RemoveClass("class_to_right")
        
    }
    else
    {
        hero_panel.style["position"] = "50px 100px 0"
        hero_panel.style["opacity"] = "1"
        creep_panel.style["position"] = "280px 100px 0;"
        creep_panel.style["opacity"] = "0"
        page_button.AddClass("class_to_right")
        page_button.style["transform"] = "rotateZ( 0deg )"
    }
    Game.EmitSound("General.ButtonClick")
}

function MakeSidePanelVisible(data){
     var side_panel = $("#side_panel")
     side_panel.style["visibility"] = "visible"
}