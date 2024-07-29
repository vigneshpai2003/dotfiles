#!/bin/sh
hyprctl dispatch fullscreen 1
isFullScreen=`hyprctl activeworkspace | grep hasfullscreen | awk '{print $2}'`  
currentWorkspace=`hyprctl activeworkspace | head -n 1 | awk '{print $3}'`

if [ $isFullScreen -eq 1 ]; then
    hyprctl keyword workspace $currentWorkspace,gapsout:-3,gapsin:0,border:false,rounding:false,decorate:false
    exit 0
else
    hyprctl keyword workspace $currentWorkspace,gapsout:10,gapsin:5,border:true,rounding:true,decorate:true
    exit 0
fi
