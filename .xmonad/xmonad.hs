import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig
import XMonad.Layout.NoBorders
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Actions.CycleWS
import qualified XMonad.Hooks.WorkspaceHistory as WH

main :: IO()
main =  do
    xmonad =<< dzen (withUrgencyHook NoUrgencyHook $ myEwmh def
        { modMask = mod4Mask
        , terminal = "st -e bash -i -c tmux"
        , manageHook = myManageHook
        , startupHook = myStartupHook
        , layoutHook = myLayoutHook
        , workspaces = myWorkspaces
        } `additionalKeysP` myKeys)

myEwmh :: XConfig a -> XConfig a
myEwmh c = c { startupHook     = startupHook c +++ ewmhDesktopsStartup
             , handleEventHook = handleEventHook c +++ ewmhDesktopsEventHook
             , logHook         = logHook c +++ myEwmhDesktopsLogHook }
  where x +++ y = mappend y x

myEwmhDesktopsLogHook :: X ()
myEwmhDesktopsLogHook = ewmhDesktopsLogHookCustom sortByHistory

sortByHistory :: [WindowSpace] -> [WindowSpace]
sortByHistory ws = reverse ws

myStartupHook :: X ()
myStartupHook = do
  setWMName "LG3D"
--  spawn "systemctl --user start alttab"

myManageHook :: ManageHook
myManageHook = composeAll
               [ className =? "Chromium" --> doShift "2:web"
               , className =? "mpv"      --> doFloat
               , className =? "clipster" --> doFloat
               , className =? "Clipster" --> doFloat
               , className =? "Volwheel" --> doFloat
               , className =? "MPlayer"  --> doFloat]

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

myWorkspaces :: [WorkspaceId]
myWorkspaces = ["1:term", "2:web", "3:code"] ++ map show [4..6] ++ ["7:win", "8:im", "9:media"]

myKeys :: [(String, X ())]
myKeys = [ ("<XF86AudioMute>", spawn "amixer -q sset Master toggle")
         , ("<XF86AudioRaiseVolume>", spawn "amixer -q sset Master 5%+ unmute")
         , ("<XF86AudioLowerVolume>", spawn "amixer -q sset Master 5%- unmute")
         , ("<XF86MonBrightnessUp>", spawn "xbacklight -inc 10 -time 1 -steps 1")
         , ("<XF86MonBrightnessDown>", spawn "xbacklight -dec 10 -time 1 -steps 1")
         , ("M-<Insert>", spawn "/home/maciej/projects/clipster/clipster -sc")
         , ("C-M-l", spawn "slock")
         , ("M-<Tab>", toggleWS)
         , ("M1-<Tab>", spawn "rofi -show window -window-format '{c}' -kb-cancel 'Alt+Escape,Escape' -kb-accept-entry '!Alt-Tab,Return,Control+j' -kb-row-down 'Alt-Tab,Down,Control+n' -kb-row-up 'Alt+ISO_Left_Tab,Control+p'")
         ] ++ workspaceKeys

workspaceKeys :: [(String, X ())]
workspaceKeys = [ (mask ++ "M-" ++ [key], screenWorkspace scr >>= flip whenJust (windows . action))
                | (key, scr)  <- zip "wer" [0,1,2] , (action, mask) <- [ (W.view, "") , (W.shift, "S-")]]
