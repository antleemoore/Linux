Config { 
   font = "xft:DejaVu Sans:size=12:antialias=true:hinting=true",
   additionalFonts = [  "xft:Symbols Nerd Font:pixelsize=15:antialias=true:hinting=true", "xft:Noto Color Emoji:pixelsize=12"],
   bgColor = "#312F2E", fgColor = "#FCFCFA", position = TopW L 100, border = BottomB,
   borderColor = "black", sepChar = "%", alignSep = "}{",
-- Desktop template
   template = "%UnsafeStdinReader%  <fc=#ab9df2>%uptime%</fc>  %date%  <fc=#ffd866>%checkupdates%</fc>}{%dynnetwork%  %KMCO%  %chancerain%  <action=`alacritty -e newsboat`>%news%</action>  %multicpu%  %memory%  %gpu% %battery% %disku% %bright% %multivolume% %trayerpad%",
   lowerOnStart = True, hideOnStart = False, allDesktops = True,
   overrideRedirect = True, pickBroadest = False, persistent = True,

   commands = 
        [ Run DiskU [("/home", "<fn=2>\x1f4bd</fn><usedp>%")] 
                    ["-L", "20", "-H", "80", "-m", "1", "-p", "3"] 3000,
          -- Run Volume "default" "Master" [ "--template", "<action=`pavucontrol -t 3`><status> <volume>%</action>", "--", "--on", "<fn=1>\xf485</fn>", "--off", "<fn=1>\xf466</fn>", "--onc", "#F2E5BC", "--offc", "#FB4934" ] 5,
          Run Com "/home/anthonym/utils/multi-volume.sh" ["<fn=2>\x1f3a7</fn>", "<fn=2>🔊</fn>", "<fn=2>\x1f507</fn>"] "multivolume" 5,
          Run DynNetwork [ "--template" , "<fc=#78DCE8><fn=1>\xf0aa</fn></fc> <tx>KB/s <fc=#A9DC76><fn=1>\xf0ab</fn></fc> <rx>KB/s", "--Low", "1000", "--High", "5000", "--low", "#FCFCFA", "--normal", "#FCFCFA", "--high", "#FCFCFA" ] 60,
          Run MultiCpu [ "--template", "<fn=2>\x1f5a5</fn> <total>%" , "--Low", "50", "--High", "85", "--low", "#FCFCFA" , "--normal","#FCFCFA","--high", "#FCFCFA" ] 60,
          Run Memory [ "--template", "<action=`alacritty -e htop`><fn=2>💾</fn> <usedratio>%</action>", "--Low", "20", "--High", "90", "--low", "#FCFCFA", "--normal", "#FCFCFA", "--high", "#FCFCFA" ] 60,
          Run Brightness ["-t", "<fn=2>\x2600</fn>: <percent>%","--", "-D", "/sys/class/backlight/intel_backlight"] 60,
          Run Com "/home/anthonym/utils/trayer-padding-icon.sh" [] "trayerpad" 20,
          Run Com "/home/anthonym/utils/gpu-usage.sh" ["<fn=2>\x1f3ae</fn>"] "gpu" 60,
          Run Com "/home/anthonym/utils/chance-rain.sh" ["<fn=2>\x2602</fn>"] "chancerain" 36000,
          Run Com "/home/anthonym/utils/check-updates.sh" ["<fn=2>\x1F4E6</fn>"] "checkupdates" 3000,
          Run Com "/home/anthonym/utils/bitcoin-price.sh" ["<fn=2>\x1F4B0</fn>"] "bitcoin" 72000,
          Run Com "/home/anthonym/utils/shownews.sh" ["<fn=2>\x1F4F0</fn>"] "news" 1200,
          Run Date "<action=`microsoft-edge-stable https://calendar.google.com/calendar/u/0/r`><fc=#A9DC76><fn=2>\x1f4c5</fn> %a %b %d %Y</fc></action> <fc=#78DCE8><fn=2>\x1f551</fn> %I:%M:%S %p</fc>" "date" 10,
          Run Battery        [ "--template" , "<fn=2>\x1f50b</fn>: <acstatus>"
                             , "--Low"      , "10"        -- units: %
                             , "--High"     , "80"        -- units: %
                             , "--low"      , "darkred"
                             --, "--normal"   , "darkorange"
                             --, "--high"     , "green"

                             , "--" -- battery specific options
                                       -- discharging status
                                       , "-o"	, "<left>% (<timeleft>)"
                                       -- AC "on" status
                                       , "-O"	, "<fc=#dAA520><left>%</fc>"
                                       -- charged status
                                       , "-i"	, "<fc=#006000>Charged</fc>"
                             ] 50,
          Run UnsafeStdinReader,
          Run StdinReader,
          Run Locks,
          Run Uptime ["-t", "<fn=2>\x1F427</fn> <days>d <hours>h <minutes>m"] 600,
          Run WeatherX "KMCO" 
                            [ ("clear", "☀"), ("sunny", "☀"), ("mostly clear", "☀"), ("mostly sunny", "🌤 "), ("partly sunny", "⛅"), ("fair", "🌥"), ("cloudy","☁"), ("overcast","🌧"), ("partly cloudy", "🌤"), ("mostly cloudy", "⛅"), ("considerable cloudiness", "🌥") ]
                            [ "--template", "<fn=2><skyConditionS></fn><tempF>°F", "-L","68", "-H", "90", "--normal", "#FCFCFA", "--high", "#FF6188", "--low", "#ab9df2" ] 36000
        ]
}
-- Other Templates
-- , template = "%UnsafeStdinReader%}{ | %dynnetwork% | %multicpu% %multicoretemp%%cpufan% | %gpu% | %memory% | %disku% | %bright% | %default:Master% | %battery% | %KMCO% %chancerain% | %date% |%locks%%trayerpad%"
