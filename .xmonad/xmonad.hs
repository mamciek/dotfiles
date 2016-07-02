import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook
import System.Posix.Unistd(getSystemID, nodeName)
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig
import XMonad.Layout.NoBorders
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks

main =  do
    host <- getHost
    xmonad =<< dzen (withUrgencyHook NoUrgencyHook $ ewmh defaultConfig
        { modMask = mod4Mask
        , terminal = "st -e tmux"
        , manageHook = myManageHook
        , startupHook = setWMName "LG3D"
        , layoutHook = myLayoutHook
        , workspaces = myWorkspaces
        } `additionalKeysP` myKeys host)

myManageHook = composeAll
               [ className =? "Chromium" --> doShift "2:web"
               , className =? "mpv"      --> doFloat
               , className =? "clipster" --> doFloat
               , className =? "Clipster" --> doFloat
               , className =? "Volwheel" --> doFloat
               , className =? "MPlayer"  --> doFloat ]

myLayoutHook = avoidStruts $ smartBorders (tiled ||| Mirror tiled ||| Full)
  where
    -- default tiling algorithm partitions the screen into two panes
    tiled   = Tall nmaster delta ratio

    -- The default number of windows in the master pane
    nmaster = 1

    -- Default proportion of screen occupied by master pane
    ratio   = 1/2

    -- Percent of screen to increment by when resizing panes
    delta   = 3/100

myWorkspaces = ["1:term", "2:web", "3:code"] ++ map show [4..6] ++ ["7:win", "8:im", "9:media"]


myKeys _ = [ ("<XF86AudioMute>", spawn "amixer -q sset Master toggle")
           , ("<XF86AudioRaiseVolume>", spawn "amixer -q sset Master 5%+ unmute")
           , ("<XF86AudioLowerVolume>", spawn "amixer -q sset Master 5%- unmute")
           , ("<XF86MonBrightnessUp>", spawn "xbacklight -inc 10 -time 1 -steps 1")
           , ("<XF86MonBrightnessDown>", spawn "xbacklight -dec 10 -time 1 -steps 1")
           , ("M-<Insert>", spawn "/home/maciej/projects/clipster/clipster -sc")
           , ("C-M-l", spawn "slock")
           ] ++ workspaceKeys

workspaceKeys = [ (mask ++ "M-" ++ [key], screenWorkspace scr >>= flip whenJust (windows . action))
                | (key, scr)  <- zip "wer" [0,1,2] , (action, mask) <- [ (W.view, "") , (W.shift, "S-")]]


data Host = Work | Home deriving Eq

getHost = do
    host <-getSystemID
    case nodeName host of
        "ktr-mmazur" -> return Work
        _            -> return Home

