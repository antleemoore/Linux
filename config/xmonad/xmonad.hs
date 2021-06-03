import XMonad
import XMonad.Config.Xfce
import qualified Data.Map as M
import qualified XMonad.StackSet as W
import XMonad.Hooks.DynamicLog
import XMonad.Layout.Spacing
import XMonad.Hooks.ManageDocks

myTerminal = "xfce4-terminal"
myWorkspaces = ["[1]","[2]","[3]","[4]","[5]","[6]","[7]","[8]","[9]"]

myLayout = avoidStruts $ spacingRaw True (Border 5 5 5 5) True (Border 5 5 5 5) True $
            layoutHook xfceConfig

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

  [
  ((modm, xK_q), kill)
  , ((modm, xK_Return), spawn $ XMonad.terminal conf)
  , ((modm, xK_e), spawn "thunar")
  , ((modm .|. shiftMask, xK_Return), spawn "firefox")
  , ((modm .|. shiftMask, xK_c     ), spawn "xmonad --recompile; xmonad --restart")
  , ((modm,               xK_y ), sendMessage NextLayout)
  , ((modm .|. shiftMask, xK_y ), setLayout $ XMonad.layoutHook conf)
  , ((modm,               xK_space), windows W.swapMaster)
  ]
  ++
  [((m .|. modm, k), windows $ f i)
    | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
    , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

main = xmonad xfceConfig{ terminal=myTerminal
                        , modMask=mod4Mask
                        , keys=myKeys <+> keys defaultConfig
                        , workspaces=myWorkspaces
                        , layoutHook=myLayout
            }
