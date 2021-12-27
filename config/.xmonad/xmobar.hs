Config { 
   font = "xft:DejaVu Sans:size=12:antialias=true:hinting=true",
   additionalFonts = [  "xft:Symbols Nerd Font:pixelsize=15:antialias=true:hinting=true", "xft:Noto Color Emoji:pixelsize=12"],
   bgColor = "#403e41", fgColor = "#FCFCFA", position = TopW L 100, border = BottomB,
   borderColor = "black", sepChar = "%", alignSep = "}{",
-- Desktop template
   template = "%UnsafeStdinReader%  %uptime%  %date%  <fc=#FC9867>%bitcoin%</fc>}{%dynnetwork%  %KMCO%  %chancerain%  %checkupdates%  <action=`alacritty -e newsboat`>%news%</action>  %multicpu%  %memory%  %gpu%  %disku% %multivolume%  %trayerpad%",
   lowerOnStart = True, hideOnStart = False, allDesktops = True,
   overrideRedirect = True, pickBroadest = False, persistent = True,

   commands = 
        [ Run DiskU [("/home", "<fn=2>\x1f4bd</fn><usedp>%")] 
                    ["-L", "20", "-H", "80", "-m", "1", "-p", "3"] 3000,
          -- Run Volume "default" "Master" [ "--template", "<action=`pavucontrol -t 3`><status> <volume>%</action>", "--", "--on", "<fn=1>\xf485</fn>", "--off", "<fn=1>\xf466</fn>", "--onc", "#F2E5BC", "--offc", "#FB4934" ] 5,
          Run Com "/home/anthony/utils/multi-volume.sh" ["<fn=2>\x1f3a7</fn>", "<fn=2>🔊</fn>"] "multivolume" 5,
          Run DynNetwork [ "--template" , "<fc=#78DCE8><fn=1>\xf0aa</fn></fc> <tx>KB/s <fc=#A9DC76><fn=1>\xf0ab</fn></fc> <rx>KB/s", "--Low", "1000", "--High", "5000", "--low", "#FCFCFA", "--normal", "#FCFCFA", "--high", "#FCFCFA" ] 60,
          Run MultiCpu [ "--template", "<fn=2>\x1f5a5</fn> <total>%" , "--Low", "50", "--High", "85", "--low", "#FCFCFA" , "--normal","#FCFCFA","--high", "#FCFCFA" ] 60,
          Run Memory [ "--template", "<action=`alacritty -e htop`><fn=2>💾</fn> <usedratio>%</action>", "--Low", "20", "--High", "90", "--low", "#FCFCFA", "--normal", "#FCFCFA", "--high", "#FCFCFA" ] 60,
          Run Com "/home/anthony/utils/trayer-padding-icon.sh" [] "trayerpad" 20,
          Run Com "/home/anthony/utils/gpu-usage.sh" ["<fn=2>\x1f3ae</fn>"] "gpu" 60,
          Run Com "/home/anthony/utils/chance-rain.sh" ["<fn=2>\x2602</fn>"] "chancerain" 36000,
          Run Com "/home/anthony/utils/check-updates.sh" ["<fn=2>\x1F4E6</fn>"] "checkupdates" 36000,
          Run Com "/home/anthony/utils/bitcoin-price.sh" ["<fn=2>\x1F4B0</fn>"] "bitcoin" 72000,
          Run Com "/home/anthony/utils/shownews.sh" ["<fn=2>\x1F4F0</fn>"] "news" 1200,
          Run Date "<action=`alacritty -e calcurse`><fc=#A9DC76><fn=2>\x1f4c5</fn> %a %b %d %Y</fc></action> <fc=#78DCE8><fn=2>\x1f551</fn> %I:%M:%S %p</fc>" "date" 10,
          Run UnsafeStdinReader,
          Run StdinReader,
          Run Locks,
          Run Uptime ["-t", "<fn=2>\x1F427</fn> <days>d <hours>h <minutes>m"] 600,
          Run WeatherX "KMCO" 
                            [ ("clear", "☀"), ("sunny", "☀"), ("mostly clear", "☀"), ("mostly sunny", "🌤"), ("partly sunny", "⛅"), ("fair", "🌥"), ("cloudy","☁"), ("overcast","🌧"), ("partly cloudy", "🌤"), ("mostly cloudy", "⛅"), ("considerable cloudiness", "🌥") ]
                            [ "--template", "<fn=2><skyConditionS></fn><fc=#AB9DF2><tempF></fc>°F", "-L","65", "-H", "90", "--normal", "#FCFCFA", "--high", "#FF6188", "--low", "#78DCE8" ] 36000
        ]
}
-- Other Templates
-- , template = "%UnsafeStdinReader%}{ | %dynnetwork% | %multicpu% %multicoretemp%%cpufan% | %gpu% | %memory% | %disku% | %bright% | %default:Master% | %battery% | %KMCO% %chancerain% | %date% |%locks%%trayerpad%"
