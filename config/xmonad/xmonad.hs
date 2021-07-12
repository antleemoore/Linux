-- Dependencies: xmobar, trayer, caffeine, alacritty, styli.sh, lxsession, picom, dmenu, mpv, screenkey, galculator, gcolor2, keybind-programs

-- Base Imports
import XMonad
import XMonad.Config.Xfce
import qualified Data.Map as M
import qualified XMonad.StackSet as W
import Graphics.X11.ExtraTypes.XF86

-- Action Imports
import XMonad.Actions.NoBorders
import XMonad.Actions.CopyWindow
import XMonad.Actions.CycleWS
import XMonad.Actions.SpawnOn
import XMonad.Actions.OnScreen

-- Util Imports
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import XMonad.Util.Scratchpad

-- Hook Imports
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.InsertPosition

-- Layout Imports
import XMonad.Layout.Spacing
import XMonad.Layout.ResizableTile
import XMonad.Layout.LayoutHints
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Reflect
import XMonad.Layout.MultiToggle
import XMonad.Layout.Renamed
import XMonad.Layout.Grid
import XMonad.Layout.Spiral

spawnToWorkspace :: String -> String -> X ()
spawnToWorkspace workspace program = do
                                      spawn program
                                      windows $ W.greedyView workspace

-- Main XMonad Start
main = do
        h <- spawnPipe "xmobar ~/.xmonad/xmobar.hs"
        xmonad
            $ ewmh xfceConfig{ terminal=myTerminal, modMask=mod4Mask, keys=myKeyCombo, workspaces=myWorkspaces, layoutHook=myLayout, manageHook=myManageHookCombo, handleEventHook=myHandleEventHookCombo, focusedBorderColor=myFocusedBorderColor, borderWidth=myBorderWidth, startupHook=myStartupHook, logHook=dynamicLogWithPP
            $ xmobarPP{ ppOutput= hPutStrLn h, ppCurrent=currentWorkspaceStyle, ppTitle=windowTitleStyle, ppLayout=layoutIndicatorStyle, ppVisible=visibleWorkspaceStyle, ppSep=" ", ppOrder= \(ws:l:_:_) -> [ws,l] } }

-- Custom Hooks
myLayout = renamed [CutWordsLeft 1] $ toggleReflect $ layoutHints (avoidStruts(layoutsList))
myManageHooks = composeAll [ goFullScreen, floatCalculator, moveWebcamToSide, floatColorPicker ]
myStartupHook = do
            spawnOnce session_s
            spawnOnce swapCapsWithESC_s
            spawnOnce autowallpaper_s
            spawnOnce compositor_s
            spawnOnce trayer_s
            spawnOnce xmobar_s
            spawnOnce multimonitor_s
          
-- Default Variables
myTerminal = "alacritty"
myWorkspaces = ["1","2","3","4","5","6","7","8","9"]
myFocusedBorderColor = "#FB4934"
myBorderWidth = 3

-- Startup Variables
multimonitor_s="~/.screenlayout/threemonitorsetup.sh"
trayer_s="trayer --edge top --monitor primary --align right --widthtype request --SetDockType true --SetPartialStrut true --expand true --transparent true --alpha 0 --tint 0x32302f --height 19 &"
autowallpaper_s="/home/anthony/scripts/auto-wallpaper/styli.sh --directory /home/anthony/repos/Linux/wallpapers &"
session_s="lxsession &"
swapCapsWithESC_s="setxkbmap -option caps:escape &"
compositor_s="picom --vsync &"
xmobar_s="/home/anthony/utils/xmobar-delayed.sh &"
caffeine_s="caffeine &"

-- Spacing/Position Variables
mySpacing = spacingRaw False (Border 3 0 3 0) True (Border 0 3 0 3) True
myMoveToStackHook = insertPosition End Older 

-- Layout Variables
myVertSpacing = ResizableTall 1 (3/100) (3/5) []
myMirrorThreeCol = renamed [Replace "3 Col"] $ mySpacing $ reflectHoriz $ ThreeCol 2 (3/100) (1/2)
myMainStackLayout = renamed [Replace "Default"] $ mySpacing $ myVertSpacing
myxfceLayout = renamed [CutWordsLeft 1] $ mySpacing $ layoutHook xfceConfig
myGridLayout = renamed [Replace "Grid"] $ mySpacing $ Grid
mySpiralLayout = renamed[Replace "Spiral"] $ mySpacing $ spiral (6/7)

-- Layout List
layoutsList = myMainStackLayout ||| myGridLayout ||| mySpiralLayout ||| myMirrorThreeCol ||| myxfceLayout
toggleReflect= mkToggle (single REFLECTX)

-- Keybinding commands
dmenu_c="dmenu_run"
webcam_c="killall mpv || mpv --demuxer-lavf-o=video_size=1280x720,input_format=mjpeg av://v4l2:/dev/video0 --profile=low-latency --untimed"
restartXMonad_c="~/utils/reinstall-wm.sh"
screenkey_c="killall screenkey || screenkey &"
fullScreenToggle_c=[ sendMessage $ ToggleStruts, toggleScreenSpacingEnabled, toggleWindowSpacingEnabled, withFocused toggleBorder, windows W.focusDown]

-- Custom Hook Variables
goFullScreen=isFullscreen -->doFullFloat
floatCalculator=appName =? "galculator" -->doCenterFloat
moveWebcamToSide=className =? "mpv" -->myMoveToStackHook
floatColorPicker=appName =? "gcolor2" -->doCenterFloat
myManageHookCombo=myManageHooks <+> manageDocks <+> scratchpadManageHookDefault <+> manageHook xfceConfig
myHandleEventHookCombo=handleEventHook xfceConfig <+> docksEventHook <+> fullscreenEventHook
myKeyCombo=myKeys <+> keys defaultConfig

-- XMobar Styling
hiddenNoWindowWSStyle=xmobarColor "#F2E5BC" "" 
windowTitleStyle=xmobarColor "#B8BB26" ""
layoutIndicatorStyle=xmobarColor "#CC241D" ""
currentWorkspaceStyle=xmobarColor "#FABD2F" "" . wrap "[" "]"
hiddenWSStyle=xmobarColor "#FABD2F" ""
visibleWorkspaceStyle=xmobarColor "#e3869b" "" . wrap "(" ")"

-- Keybindings
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
  [ ((modm, xK_q), kill),-- ((modm .|. shiftMask, xK_q), spawn "lxlock"),
    ((modm, xK_grave), spawn "gcolor2"),
    ((modm, xK_w), spawn "firefox"),
    ((modm, xK_e), spawn "thunar"),
    ((modm, xK_r), sendMessage $ Toggle REFLECTX),
    ((controlMask .|. mod1Mask, xK_t), runInTerm "" "htop"),
    ((modm, xK_y), sendMessage NextLayout), ((modm .|. shiftMask, xK_y), setLayout $ XMonad.layoutHook conf),
    ((modm, xK_u), sendMessage MirrorExpand),
    ((modm, xK_i), spawn "code"),
    ((modm, xK_o), spawn "obs"),
    ((modm, xK_p), spawn dmenu_c),
    ((modm, xK_bracketright), nextWS), ((modm .|. shiftMask, xK_bracketright),  shiftToNext),
    ((modm, xK_bracketleft), prevWS), ((modm .|. shiftMask, xK_bracketleft),    shiftToPrev),
    ((modm, xK_a), spawn "anki"),
    ((modm, xK_s), spawnToWorkspace "9" "spotify"), ((modm .|. shiftMask, xK_s), spawn screenkey_c),
    ((modm, xK_d), sendMessage MirrorShrink), ((modm .|. shiftMask, xK_d), spawn "discord"),
    ((modm, xK_f), sequence_ fullScreenToggle_c),
    ((modm, xK_Return), spawn $ XMonad.terminal conf), ((mod1Mask, xK_Return), scratchpadSpawnActionCustom "alacritty --class scratchpad") ,
    ((modm, xK_c), spawn webcam_c), ((modm .|. shiftMask, xK_c), spawn restartXMonad_c),
    ((modm, xK_v), windows copyToAll), ((modm .|. shiftMask, xK_v),  killAllOtherCopies), ((controlMask .|. mod1Mask, xK_v), spawn "xfce4-popup-clipman"),
    ((modm, xK_b), withFocused toggleBorder),
    ((modm, xK_space), windows W.swapMaster),
    ((modm, xK_KP_Enter), spawn "galculator"),
    ((0,xF86XK_MonBrightnessDown), spawn "lux -m 1 -s 5%"),
    ((0,xF86XK_MonBrightnessUp), spawn "lux -M 936 -a 5%"),
    ((0,xF86XK_AudioMute), spawn "amixer set Master toggle"),
    ((0,xF86XK_AudioLowerVolume), spawn "amixer -q sset Master 2%-"),
    ((0,xF86XK_AudioRaiseVolume), spawn "amixer -q sset Master 2%+"),
    ((0,xF86XK_AudioPrev), spawn "playerctl previous"),
    ((0,xF86XK_AudioPlay), spawn "playerctl play-pause"),
    ((0,xF86XK_AudioNext), spawn "playerctl next"),
    ((modm, xK_0), runInTerm "" "xrandr --output HDMI-1-0 --auto"),
    ((modm, xK_F7), spawn "touchpad-indicator -c") ]
  ++
  [ ((m .|. 0, k), windows (f i))
      | (i, k) <- zip (workspaces conf) ([xK_1 .. xK_9])
      , (f, m) <- [ (viewOnScreen 0, modm), (viewOnScreen 1, mod1Mask), (viewOnScreen 2, controlMask .|. mod1Mask), (W.greedyView, mod1Mask .|. shiftMask) ]
    ]
