import XMonad
import XMonad.Config.Xfce
import qualified Data.Map as M
import qualified XMonad.StackSet as W
import XMonad.Hooks.DynamicLog
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Actions.NoBorders
import XMonad.Hooks.ManageHelpers

myTerminal = "terminator"
myWorkspaces = ["[1]","[2]","[3]","[4]","[5]","[6]","[7]","[8]","[9]"]

myFocusedBorderColor = "#FABD2F"
myBorderWidth = 3

mySpacing = spacingRaw True (Border 10 10 10 10 ) True (Border 10 10 10 10 ) True
myGaps = gaps [(U,10), (R,10), (L,10), (D,10)]

myLayout = avoidStruts $ mySpacing $ myGaps $ layoutHook xfceConfig 

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

  [
  ((modm, xK_q), kill)
  , ((modm, xK_Return), spawn $ XMonad.terminal conf)
  , ((modm, xK_e), spawn "thunar")
  , ((modm .|. shiftMask, xK_Return), spawn "firefox")
  , ((modm .|. shiftMask, xK_c), spawn "xmonad --recompile; xmonad --restart")
  , ((modm,               xK_y ), sendMessage NextLayout)
  , ((modm .|. shiftMask, xK_y ), setLayout $ XMonad.layoutHook conf)
  , ((modm, xK_space), windows W.swapMaster)
  , ((modm, xK_b), withFocused toggleBorder)
  , ((modm, xK_g), sendMessage $ ToggleGaps)
  , ((modm, xK_f), sequence_ [ sendMessage $ ToggleStruts, sendMessage $ ToggleGaps, withFocused toggleBorder, windows W.focusDown])
  ]
  ++
  [((m .|. modm, k), windows $ f i)
    | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
    , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

main = xmonad $ docks $ ewmh xfceConfig{ terminal=myTerminal
                        , modMask=mod4Mask
                        , keys=myKeys <+> keys defaultConfig
                        , workspaces=myWorkspaces
                        , layoutHook=myLayout
                        , manageHook = manageDocks <+> manageHook xfceConfig
                        , handleEventHook=handleEventHook xfceConfig <+> fullscreenEventHook
                        , focusedBorderColor=myFocusedBorderColor
                        , borderWidth=myBorderWidth
            }
myManageHooks = composeAll
        [ isFullscreen -->doFullFloat
        ]
