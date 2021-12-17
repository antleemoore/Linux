-- Dependencies: xmobar, trayer, caffeine, alacritty, styli.sh, lxsession, picom, dmenu, mpv, screenkey, galculator, gcolor2, keybind-programs

-- Base Imports

import qualified Data.Map as M
import Graphics.X11.ExtraTypes.XF86
import XMonad
-- Action Imports

import XMonad.Actions.CopyWindow
import XMonad.Actions.CycleWS
import XMonad.Actions.FindEmptyWorkspace
import XMonad.Actions.NoBorders
import XMonad.Actions.OnScreen
import XMonad.Actions.SpawnOn
import XMonad.Config.Xfce
-- Util Imports

-- Hook Imports
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
-- Layout Imports

import XMonad.Layout.Grid
import XMonad.Layout.LayoutHints
import XMonad.Layout.MultiToggle
import XMonad.Layout.Reflect
import XMonad.Layout.Renamed
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing
import XMonad.Layout.Spiral
import XMonad.Layout.ThreeColumns
import XMonad.ManageHook
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Util.Scratchpad
import XMonad.Util.SpawnOnce

spawnToWorkspace :: String -> String -> X ()
spawnToWorkspace workspace program = do
  spawn program
  windows $ W.greedyView workspace

-- Main XMonad Start
main = do
  h <- spawnPipe "xmobar $HOME/.xmonad/xmobar.hs"
  xmonad $
    ewmh
      xfceConfig
        { terminal = myTerminal,
          modMask = mod4Mask,
          keys = myKeyCombo,
          workspaces = myClickableWorkspaces,
          layoutHook = myLayout,
          manageHook = myManageHookCombo,
          handleEventHook = myHandleEventHookCombo,
          focusedBorderColor = myFocusedBorderColor,
          borderWidth = myBorderWidth,
          startupHook = myStartupHook,
          logHook =
            dynamicLogWithPP $
              xmobarPP {ppOutput = hPutStrLn h, ppCurrent = currentWorkspaceStyle, ppTitle = windowTitleStyle, ppLayout = layoutIndicatorStyle, ppVisible = visibleWorkspaceStyle, ppSep = " ", ppOrder = \(ws : l : t : _) -> [ws,l,t]}
        }

-- Custom Hooks
myLayout = renamed [CutWordsLeft 1] $ toggleReflect $ layoutHints (avoidStruts layoutsList)
myManageHooks = composeAll [goFullScreen, floatCalculator, floatPavu, moveWebcamToSide, floatColorPicker, teamsMonitor, chromeMonitor, floatSu, floatPiP]

myStartupHook = do
  spawnOnce session_s
  spawnOnce swapCapsWithESC_s
  spawnOnce autowallpaper_s
  spawnOnce compositor_s
  spawnOnce trayer_s
  spawnOnce xmobar_s
  spawnOnce screenlayout_s
  spawnOnce clipboard_s

-- Default Variables
myTerminal = "alacritty"
myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
xmobarEscape = concatMap doubleLts
  where
    doubleLts '<' = "<<"
    doubleLts x = [x]

myClickableWorkspaces :: [String]
myClickableWorkspaces = clickable . map xmobarEscape $ myWorkspaces
  where
    clickable l =
      [ "<action=xdotool key super+" ++ show n ++ ">" ++ ws ++ "</action>"
        | (i, ws) <- zip [1 .. 9] l,
          let n = i
      ]

myFocusedBorderColor = "#FB4934"
myBorderWidth = 3

-- Startup Variables
multimonitor_s = "$HOME/bin/threemon"
screenlayout_s = "$HOME/.screenlayout/layout.sh"
trayer_s = "trayer --edge top --monitor primary --align right --widthtype request --SetDockType true --SetPartialStrut true --expand true --transparent true --alpha 0 --tint 0x32302f --height 19 &"
autowallpaper_s = "nitrogen --restore &"
session_s = "lxsession &"
swapCapsWithESC_s = "setxkbmap -option caps:escape &"
compositor_s = "picom &"
xmobar_s = "/home/anthony/utils/xmobar-delayed.sh &"
caffeine_s = "caffeine &"
clipboard_s = "xfce4-clipman &"

-- Spacing/Position Variables
mySpacing = spacingRaw False (Border 3 0 3 0) True (Border 0 3 0 3) True
myMoveToStackHook = insertPosition End Older

-- Layout Variables
myVertSpacing = ResizableTall 1 (3 / 100) (3 / 5) []
myMirrorThreeCol = renamed [Replace "3 Col"] $ mySpacing $ reflectHoriz $ ThreeCol 2 (3 / 100) (1 / 2)
myMainStackLayout = renamed [Replace "Default"] $ mySpacing $ myVertSpacing
myxfceLayout = renamed [CutWordsLeft 1] $ mySpacing $ layoutHook xfceConfig
myGridLayout = renamed [Replace "Grid"] $ mySpacing $ Grid
mySpiralLayout = renamed [Replace "Spiral"] $ mySpacing $ spiral (6 / 7)

-- Layout List
layoutsList = myMainStackLayout ||| myGridLayout ||| mySpiralLayout ||| myMirrorThreeCol ||| myxfceLayout
toggleReflect = mkToggle (single REFLECTX)

-- Keybinding commands
dmenu_c = "dmenu_run -p 'Applications'"
webcam_c = "mpv --demuxer-lavf-o=video_size=1920x1080,input_format=mjpeg av://v4l2:/dev/video0 --profile=low-latency --untimed"
restartXMonad_c = "$HOME/utils/reinstall-wm.sh"
screenkey_c = "killall screenkey || screenkey &"
fullScreenToggle_c = [sendMessage $ ToggleStruts, toggleScreenSpacingEnabled, toggleWindowSpacingEnabled, withFocused toggleBorder, windows W.focusDown]

-- Custom Hook Variables
goFullScreen = isFullscreen --> doFullFloat
floatPiP = className =? "Toolkit"--> doCenterFloat
floatCalculator = appName =? "galculator" --> doCenterFloat
floatPavu = appName =? "pavucontrol" --> doCenterFloat
floatSu = appName =? "zenity" --> doCenterFloat
moveWebcamToSide = className =? "mpv" --> myMoveToStackHook
floatColorPicker = appName =? "gcolor2" --> doCenterFloat
myManageHookCombo = myManageHooks <+> manageSpawn <+> manageDocks <+> scratchpadManageHookDefault <+> manageHook xfceConfig
myHandleEventHookCombo = handleEventHook xfceConfig <+> docksEventHook <+> fullscreenEventHook
myKeyCombo = myKeys <+> keys defaultConfig
teamsMonitor = appName =? "Microsoft Teams - Preview" --> openSilent "3"
chromeMonitor = appName =? "google-chrome" --> openSilent "2"

-- XMobar Styling
hiddenNoWindowWSStyle = xmobarColor "#F2E5BC" ""
windowTitleStyle = xmobarColor "#B8BB26" ""
layoutIndicatorStyle = xmobarColor "#CC241D" ""
currentWorkspaceStyle = xmobarColor "#FABD2F" "" . wrap "[" "]"
hiddenWSStyle = xmobarColor "#FABD2F" ""
visibleWorkspaceStyle = xmobarColor "#e3869b" "" . wrap "(" ")"

openSilent :: WorkspaceId -> ManageHook
openSilent tows = do
  fromws <- liftX $ return . W.currentTag . windowset =<< get -- get the current ws tag
  wid <- ask -- get opened windowId
  doF $ W.view fromws . W.insertUp wid . W.view tows

--       |               |                |- move focus to "to" workspace
--       |               |- insert window
--       |- move focus back to "from" workspace
-- Keybindings
myKeys conf@(XConfig {XMonad.modMask = modm}) =
  M.fromList $
    [ ((modm, xK_q), kill),
      ((modm .|. shiftMask, xK_q), spawn "xfce4-session-logout"),
      ((modm, xK_grave), spawn "gcolor2"),
      ((modm, xK_w), spawn "firefox"),
      ((mod1Mask, xK_w), spawn "$HOME/scripts/bookmarksdmenu.sh"),
      ((modm, xK_e), spawn "thunar"),
      ((mod1Mask, xK_e), spawn "$HOME/scripts/confdmenu.sh"),
      ((modm, xK_r), sendMessage $ Toggle REFLECTX),
      ((mod1Mask, xK_t), runInTerm "" "htop"),
      ((modm, xK_y), sendMessage NextLayout),
      ((mod1Mask, xK_y), setLayout $ XMonad.layoutHook conf),
      ((modm, xK_u), sendMessage MirrorExpand),
      ((modm, xK_p), spawn dmenu_c),
      ((modm, xK_bracketright), nextWS),
      ((mod1Mask, xK_bracketright), shiftToNext),
      ((modm, xK_bracketleft), prevWS),
      ((mod1Mask, xK_bracketleft), shiftToPrev),
      ((modm, xK_a), spawn "pavucontrol"),
      ((modm, xK_s), spawn "xfce4-screenshooter -r"), ((mod1Mask, xK_s), spawn screenkey_c),
      ((modm, xK_d), sendMessage MirrorShrink),
      ((modm, xK_f), sequence_ fullScreenToggle_c),
      ((modm, xK_Return), spawn $ XMonad.terminal conf),
      ((mod1Mask, xK_Return), scratchpadSpawnActionCustom "alacritty --class scratchpad"),
      ((modm .|. shiftMask, xK_x), spawn "xkill"),
      ((modm, xK_c), spawn webcam_c),
      ((modm .|. shiftMask, xK_c), spawn "killall mpv"),
      ((modm, xK_v), windows copyToAll),
      ((modm .|. shiftMask, xK_v), killAllOtherCopies),
      ((mod1Mask, xK_v), spawn "xfce4-popup-clipman"),
      ((modm, xK_b), withFocused toggleBorder),
      ((modm, xK_m), sendToEmptyWorkspace),
      ((mod1Mask, xK_m), tagToEmptyWorkspace),
      ((modm, xK_n), viewEmptyWorkspace),
      ((modm, xK_space), windows W.swapMaster),
      ((modm, xK_KP_Enter), spawn "galculator"),
      ((0, xF86XK_MonBrightnessDown), spawn "lux -m 1 -s 5%"),
      ((0, xF86XK_MonBrightnessUp), spawn "lux -M 936 -a 5%"),
      ((0, xF86XK_AudioMute), spawn "$HOME/utils/volume.sh mute"),
      ((0, xF86XK_AudioLowerVolume), spawn "$HOME/utils/volume.sh down"),
      ((0, xF86XK_AudioRaiseVolume), spawn "$HOME/utils/volume.sh up"),
      ((0, xF86XK_AudioPrev), spawn "playerctl previous"),
      ((0, xF86XK_AudioPlay), spawn "playerctl play-pause"),
      ((0, xF86XK_AudioNext), spawn "playerctl next"),
      ((0, xK_Menu), spawn "xdotool click 3"),
      ((0, xK_Pause), spawn "xfce4-session-logout -s"),
      ((modm, xK_0), runInTerm "" "xrandr --output HDMI-1-0 --auto"),
      ((modm, xK_F7), spawn "touchpad-indicator -c")
    ]
      ++ [ ((m .|. 0, k), windows (f i))
           | (i, k) <- zip (workspaces conf) [xK_1 .. xK_9],
             (f, m) <- [(viewOnScreen 0, modm), (viewOnScreen 1, mod1Mask), (viewOnScreen 2, controlMask .|. mod1Mask), (W.greedyView, mod1Mask .|. shiftMask)]
         ]

myMouseBindings XConfig {XMonad.modMask = modMask} =
  M.fromList
    [ ((modMask, button1), \w -> focus w >> mouseMoveWindow w),
      ((modMask, button3), \w -> focus w >> windows W.swapMaster),
      ((modMask, button2), \w -> focus w >> mouseResizeWindow w),
      ((modMask, button4), \w -> focus w >> windows W.focusUp),
      ((modMask, button5), \w -> focus w >> windows W.focusDown),
      ((mod1Mask, button4), \w -> focus w >> windows W.swapUp),
      ((mod1Mask, button5), \w -> focus w >> windows W.swapDown)
    ]
