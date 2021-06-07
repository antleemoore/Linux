import XMonad
import XMonad.Config.Xfce
import qualified Data.Map as M
import qualified XMonad.StackSet as W
import XMonad.Actions.NoBorders

import XMonad.Util.Run
import XMonad.Util.SpawnOnce

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers

import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Layout.ResizableTile
import XMonad.Layout.LayoutHints

myTerminal = "terminator"
myWorkspaces = ["[1]","[2]","[3]","[4]","[5]","[6]","[7]","[8]","[9]"]

myFocusedBorderColor = "#FABD2F"
myBorderWidth = 3

mySpacing = spacingRaw True (Border 7 7 7 7) True (Border 7 7 7 7) True
myGaps = gaps [(U,10), (R,10), (L,10), (D,10)]
myVertSpacing = ResizableTall 1 (3/100) (3/5) []
myLayout = layoutHints (avoidStruts $ mySpacing $ myGaps $ myVertSpacing ||| layoutHook xfceConfig)
myStartupHook = do
            spawnOnce "setxkbmap -option caps:swapescape &"
            spawnOnce "xfce4-panel --restart"
            spawnOnce "picom --vsync &"

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

  [
  ((modm, xK_q), kill)
  , ((modm, xK_Return), spawn $ XMonad.terminal conf)
  , ((modm, xK_e), spawn "thunar")
  , ((modm, xK_w), spawn "firefox")
  , ((modm, xK_a), spawn "anki")
  , ((modm, xK_o), spawn "obs")
  , ((modm, xK_i), runInTerm "" "nvim")
  , ((modm .|. shiftMask, xK_i), spawn "code")
  , ((modm, xK_t), runInTerm "" "htop")
  , ((modm .|. shiftMask, xK_c), spawn "xmonad --recompile; xmonad --restart; xfce4-panel --restart")
  , ((modm, xK_y ), sendMessage NextLayout)
  , ((modm, xK_c ), spawn "guvcview")
  , ((modm .|. shiftMask, xK_y ), setLayout $ XMonad.layoutHook conf)
  , ((modm, xK_space), windows W.swapMaster)
  , ((modm, xK_b), withFocused toggleBorder)
  , ((modm, xK_g), sendMessage $ ToggleGaps)
  , ((modm, xK_u), sendMessage MirrorExpand)
  , ((modm, xK_d), sendMessage MirrorShrink)
  , ((modm, xK_p), spawn "xfce4-popup-whiskermenu")
  , ((modm, xK_f), sequence_ [ sendMessage $ ToggleStruts, sendMessage $ ToggleGaps, withFocused toggleBorder, windows W.focusDown])
  ]
  ++
  [((m .|. modm, k), windows $ f i)
    | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
    , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

main = xmonad $ ewmh xfceConfig{ terminal=myTerminal
                        , modMask=mod4Mask
                        , keys=myKeys <+> keys defaultConfig
                        , workspaces=myWorkspaces
                        , layoutHook=myLayout
                        , manageHook=myManageHooks <+> manageDocks <+> manageHook xfceConfig
                        , handleEventHook=handleEventHook xfceConfig <+> fullscreenEventHook
                        , focusedBorderColor=myFocusedBorderColor
                        , borderWidth=myBorderWidth
                        , startupHook=myStartupHook
                        }
myManageHooks = composeAll
        [ isFullscreen -->doFullFloat
        , appName =? "galculator" -->doCenterFloat
        ]
