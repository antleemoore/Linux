import XMonad
import XMonad.Config.Xfce
import qualified Data.Map as M
import qualified XMonad.StackSet as W
import XMonad.Hooks.DynamicLog

myTerminal = "xfce4-terminal"
myWorkspaces = ["[1]","[2]","[3]","[4]","[5]","[6]","[7]","[8]","[9]"]

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

  [
  ((modm, xK_q), kill)
  , ((modm, xK_Return), spawn $ XMonad.terminal conf)
  , ((modm .|. shiftMask, xK_c     ), spawn "xmonad --recompile; xmonad --restart")
  ]
  ++
  [((m .|. modm, k), windows $ f i)
    | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
    , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

main = xmonad xfceConfig{ terminal=myTerminal
                        , modMask=mod4Mask
                        , keys=myKeys <+> keys defaultConfig
                        , workspaces=myWorkspaces
            }
