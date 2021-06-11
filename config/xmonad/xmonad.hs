-- Base Imports
import XMonad
import XMonad.Config.Xfce
import qualified Data.Map as M
import qualified XMonad.StackSet as W

-- Action Imports
import XMonad.Actions.NoBorders
import XMonad.Actions.CopyWindow

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

-- Default Variables
myTerminal = "xfce4-terminal"
myWorkspaces = ["[1]","[2]","[3]","[4]","[5]","[6]","[7]","[8]","[9]"]
myFocusedBorderColor = "#FABD2F"
myBorderWidth = 3

-- Spacing/Position Variables
mySpacing = spacingRaw True (Border 7 7 7 7) True (Border 7 7 7 7) True
myGaps = gaps [(U,10), (R,10), (L,10), (D,10)]
myMoveToStackHook = insertPosition End Older 

-- Layout Variables
myVertSpacing = ResizableTall 1 (3/100) (3/5) []
myMirrorThreeCol = mySpacing $ myGaps $ reflectHoriz $ ThreeCol 2 (3/100) (1/2)
myMainStackLayout = mySpacing $ myGaps $ myVertSpacing
myxfceLayout = mySpacing $ myGaps $ layoutHook xfceConfig
-- Layout List
layoutsList = myMainStackLayout ||| myxfceLayout ||| myMirrorThreeCol

-- Keybinding commands
dmenu_c="dmenu_run -i -sb '#FABD2F' -sf '#000' -fn 'Cascadia Mono Roman'"
webcam_c="killall mpv || mpv --demuxer-lavf-o=video_size=1280x720,input_format=mjpeg av://v4l2:/dev/video0 --profile=low-latency --untimed"
restartXMonad_c="xmonad --recompile; xmonad --restart;"
screenkey_c="killall screenkey || screenkey &"
fullScreenToggle_c=[ sendMessage $ ToggleStruts, sendMessage $ ToggleGaps, withFocused toggleBorder, windows W.focusDown]

-- Custom Layout Hook
myLayout = mkToggle (single REFLECTX) $
           mkToggle (single REFLECTY) $
           layoutHints (avoidStruts(layoutsList))

-- Custom Manage Hooks
myManageHooks = composeAll
        [ isFullscreen -->doFullFloat
        , appName =? "galculator" -->doCenterFloat
        , className =? "mpv" -->myMoveToStackHook
        , appName =? "gcolor2" -->doCenterFloat
        ]

-- XMonad Startup
myStartupHook = do
            spawnOnce "setxkbmap -option caps:escape"
            spawnOnce "xfce4-panel --restart || xfce4-panel &"
            spawnOnce "picom --vsync &"

-- Main XMonad Start
main = xmonad $ ewmh xfceConfig{ 
                        terminal=myTerminal
                        , modMask=mod4Mask
                        , keys=myKeys <+> keys defaultConfig
                        , workspaces=myWorkspaces
                        , layoutHook=myLayout
                        , manageHook=myManageHooks <+> manageDocks <+> manageHook xfceConfig
                        , handleEventHook=handleEventHook xfceConfig <+> docksEventHook <+> fullscreenEventHook
                        , focusedBorderColor=myFocusedBorderColor
                        , borderWidth=myBorderWidth
                        , startupHook=myStartupHook
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
  , ((modm, xK_r), sendMessage $ Toggle REFLECTY)
  , ((modm, xK_F7), spawn "touchpad-indicator -c")
  , ((modm, xK_v), spawn "xfce4-popup-clipman")
  , ((modm, xK_Return), spawn $ XMonad.terminal conf)
  , ((modm, xK_KP_Enter), spawn "galculator")
  , ((modm .|. shiftMask, xK_i), spawn "code")
  , ((modm .|. shiftMask, xK_d), spawn "discord")
  , ((modm .|. shiftMask, xK_s), spawn screenkey_c)
  , ((modm .|. shiftMask, xK_v),  killAllOtherCopies)
  , ((modm .|. shiftMask, xK_t), runInTerm "" "htop")
  , ((modm .|. shiftMask, xK_q), spawn "xfce4-session-logout")
  , ((modm .|. shiftMask, xK_c), spawn restartXMonad_c)
  , ((modm .|. shiftMask, xK_r), sendMessage $ Toggle REFLECTX)
  , ((modm .|. shiftMask, xK_y), setLayout $ XMonad.layoutHook conf)
  ]
  -- Workspace Binds
  ++
  [((m .|. modm, k), windows $ f i)
    | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
    , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
