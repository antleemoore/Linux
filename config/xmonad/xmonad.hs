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

-- Util Imports
import XMonad.Util.Run
import XMonad.Util.SpawnOnce

-- Hook Imports
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.InsertPosition

-- Layout Imports
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Layout.ResizableTile
import XMonad.Layout.LayoutHints
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Reflect
import XMonad.Layout.MultiToggle
import XMonad.Layout.Renamed

-- Main XMonad Start
main = do
        h <- spawnPipe "xmobar ~/.xmonad/xmobar.hs"
        xmonad $ ewmh xfceConfig{ 
                terminal=myTerminal, modMask=mod4Mask, keys=myKeyCombo
                , workspaces=myWorkspaces, layoutHook=myLayout, manageHook=myManageHookCombo
                , handleEventHook=myHandleEventHookCombo, focusedBorderColor=myFocusedBorderColor 
                , borderWidth=myBorderWidth, startupHook=myStartupHook
                , logHook=dynamicLogWithPP $ xmobarPP{ ppOutput= hPutStrLn h
                                                    , ppCurrent=xmobarColor "#FABD2F" "" . wrap "[" "]"
                                                    , ppTitle=xmobarColor "#B8BB26" ""
                                                    , ppLayout=xmobarColor "#CC241D" ""
                                                    , ppSep=" | "
                                                    }
                }

-- Keybindings
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

  [
    ((modm, xK_q), kill)
  , ((modm, xK_e), spawn "thunar")
  , ((modm, xK_w), spawn "firefox")
  , ((modm, xK_a), spawn "anki")
  , ((modm, xK_o), spawn "obs")
  , ((modm, xK_v), windows copyToAll)
  , ((modm, xK_i), runInTerm "" "nvim")
  , ((modm, xK_grave), spawn "gcolor2")
  , ((modm, xK_p), spawn dmenu_c)
  , ((modm, xK_c), spawn webcam_c) 
  , ((modm, xK_y), sendMessage NextLayout)
  , ((modm, xK_space), windows W.swapMaster)
  , ((modm, xK_b), withFocused toggleBorder)
  , ((modm, xK_g), sendMessage $ ToggleGaps)
  , ((modm, xK_u), sendMessage MirrorExpand)
  , ((modm, xK_d), sendMessage MirrorShrink)
  , ((modm, xK_f), sequence_ fullScreenToggle_c)
  , ((modm, xK_r), sendMessage $ Toggle REFLECTX)
  , ((modm, xK_F7), spawn "touchpad-indicator -c")
  , ((modm, xK_v), spawn "xfce4-popup-clipman")
  , ((modm, xK_Return), spawn $ XMonad.terminal conf)
  , ((modm, xK_KP_Enter), spawn "galculator")
  , ((0,xF86XK_MonBrightnessDown), spawn "lux -s 10%")
  , ((0,xF86XK_MonBrightnessUp), spawn "lux -a 10%")
  , ((0,xF86XK_AudioMute), spawn "amixer set Master toggle")
  , ((0,xF86XK_AudioLowerVolume), spawn "amixer -q sset Master 2%-")
  , ((0,xF86XK_AudioRaiseVolume), spawn "amixer -q sset Master 2%+")
  , ((modm .|. shiftMask, xK_i), spawn "code")
  , ((modm .|. shiftMask, xK_d), spawn "discord")
  , ((modm .|. shiftMask, xK_s), spawn screenkey_c)
  , ((modm .|. shiftMask, xK_v),  killAllOtherCopies)
  , ((modm .|. shiftMask, xK_t), runInTerm "" "htop")
  , ((modm .|. shiftMask, xK_c), spawn restartXMonad_c)
  , ((modm .|. shiftMask, xK_y), setLayout $ XMonad.layoutHook conf)
  , ((modm,               xK_bracketright),  nextWS)
  , ((modm,               xK_bracketleft),    prevWS)
  , ((modm .|. shiftMask, xK_bracketright),  shiftToNext)
  , ((modm .|. shiftMask, xK_bracketleft),    shiftToPrev)
  ]
  -- Workspace Binds
  ++
  [((m .|. modm, k), windows $ f i)
    | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
    , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

-- Custom Hooks
myLayout = renamed [CutWordsLeft 1] $ toggleReflect $ layoutHints (avoidStruts(layoutsList))
myManageHooks = composeAll
        [ goFullScreen, floatCalculator, moveWebcamToSide, floatColorPicker ]
myStartupHook = do
            spawnOnce "lxsession &"
            spawnOnce "setxkbmap -option caps:escape &"
            spawnOnce "trayer --edge top --align right --widthtype request --SetDockType true --SetPartialStrut true --expand true --transparent true --alpha 0 --tint 0x32302f --height 19 &"
            spawnOnce "xmobar ~/.xmonad/xmobar.hs &"
            spawnOnce "picom --vsync &"
            spawnOnce "/home/anthony/scripts/auto-wallpaper/styli.sh --directory /home/anthony/repos/wallpapers &"

-- Default Variables
myTerminal = "xfce4-terminal"
myWorkspaces = ["1","2","3","4","5","6","7","8","9"]
myFocusedBorderColor = "#FABD2F"
myBorderWidth = 3

-- Spacing/Position Variables
mySpacing = spacingRaw True (Border 10 10 10 10) True (Border 10 10 10 10) True
myGaps = gaps [(U,10), (R,10), (L,10), (D,10)]
myMoveToStackHook = insertPosition End Older 

-- Layout Variables
myVertSpacing = ResizableTall 1 (3/100) (3/5) []
myMirrorThreeCol = renamed [Replace "3 Col"] $ mySpacing $ myGaps $ reflectHoriz $ ThreeCol 2 (3/100) (1/2)
myMainStackLayout = renamed [Replace "Default"] $ mySpacing $ myGaps $ myVertSpacing
myxfceLayout = renamed [CutWordsLeft 1] $ mySpacing $ myGaps $ layoutHook xfceConfig
-- Layout List
layoutsList = myMainStackLayout ||| myxfceLayout ||| myMirrorThreeCol
toggleReflect= mkToggle (single REFLECTX)

-- Keybinding commands
dmenu_c="dmenu_run -i -sb '#FABD2F' -sf '#000' -fn 'Cascadia Mono Roman'"
webcam_c="killall mpv || mpv --demuxer-lavf-o=video_size=1280x720,input_format=mjpeg av://v4l2:/dev/video0 --profile=low-latency --untimed"
restartXMonad_c="~/utils/reinstall-wm"
screenkey_c="killall screenkey || screenkey &"
fullScreenToggle_c=[ sendMessage $ ToggleStruts, sendMessage $ ToggleGaps, withFocused toggleBorder, windows W.focusDown]

-- Custom Hook Variables
goFullScreen=isFullscreen -->doFullFloat
floatCalculator=appName =? "galculator" -->doCenterFloat
moveWebcamToSide=className =? "mpv" -->myMoveToStackHook
floatColorPicker=appName =? "gcolor2" -->doCenterFloat
myManageHookCombo=myManageHooks <+> manageDocks <+> manageHook xfceConfig
myHandleEventHookCombo=handleEventHook xfceConfig <+> docksEventHook <+> fullscreenEventHook
myKeyCombo=myKeys <+> keys defaultConfig
