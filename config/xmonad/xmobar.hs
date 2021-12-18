Config { 
   font = "xft:DejaVu Sans:size=12:antialias=true:hinting=true",
   additionalFonts = [  "xft:Symbols Nerd Font:pixelsize=15:antialias=true:hinting=true", "xft:Noto Color Emoji:pixelsize=12"],
   bgColor = "#32302F", fgColor = "#F2E5BC", position = TopW L 100, border = BottomB,
   borderColor = "black", sepChar = "%", alignSep = "}{",
-- Desktop template
   template = "%uptime%  %checkupdates%  %date%  %KMCO%  %chancerain%  <action=`alacritty -e newsboat`>%news%</action>  %UnsafeStdinReader%}{  %dynnetwork%  %multicpu%  %memory%  %gpu%  %disku%  %multivolume%  %trayerpad%",
   lowerOnStart = True, hideOnStart = False, allDesktops = True,
   overrideRedirect = True, pickBroadest = False, persistent = True,

   commands = 
        [ Run DiskU [("/", "<fn=2>\x1f5c4</fn><freep>%")] 
                    ["-L", "20", "-H", "80", "-m", "1", "-p", "3"] 3000,
          -- Run Volume "default" "Master" [ "--template", "<action=`pavucontrol -t 3`><status> <volume>%</action>", "--", "--on", "<fn=1>\xf485</fn>", "--off", "<fn=1>\xf466</fn>", "--onc", "#F2E5BC", "--offc", "#FB4934" ] 5,
          Run Com "/home/anthony/utils/multi-volume.sh" ["<fn=2>\x1f3a7</fn>", "<fn=2>🔊</fn>"] "multivolume" 5,
          Run DynNetwork [ "--template" , "<fc=#83A598><fn=1>\xf0aa</fn></fc> <tx>KB/s <fc=#B8BB26><fn=1>\xf0ab</fn></fc> <rx>KB/s", "--Low", "1000", "--High", "5000", "--low", "#F2E5BC", "--normal", "#F2E5BC", "--high", "#F2E5BC" ] 60,
          Run MultiCpu [ "--template", "<fn=2>\x1f5a5</fn> <total>%" , "--Low", "50", "--High", "85", "--low", "#F2E5BC" , "--normal","#F2E5BC","--high", "#F2E5BC" ] 60,
          Run Memory [ "--template", "<action=`alacritty -e htop`><fn=2>💾</fn> <usedratio>%</action>", "--Low", "20", "--High", "90", "--low", "#F2E5BC", "--normal", "#F2E5BC", "--high", "#F2E5BC" ] 60,
          Run Com "/home/anthony/utils/trayer-padding-icon.sh" [] "trayerpad" 20,
          Run Com "/home/anthony/utils/gpu-usage.sh" ["<fn=2>\x1f3ae</fn>"] "gpu" 60,
          Run Com "/home/anthony/utils/chance-rain.sh" ["<fn=2>\x2602</fn>"] "chancerain" 36000,
          Run Com "/home/anthony/utils/check-updates.sh" ["<fn=2>\x1F4E6</fn>"] "checkupdates" 36000,
          Run Com "/home/anthony/utils/shownews.sh" ["<fn=2>\x1F4F0</fn>"] "news" 1200,
          Run Date "<action=`alacritty -e calcurse`><fc=#83c07c><fn=2>\x1f4c5</fn> %a %b %d %Y</fc></action> <fc=#83A598><fn=2>\x1f551</fn> %I:%M:%S %p</fc>" "date" 10,
          Run UnsafeStdinReader,
          Run StdinReader,
          Run Locks,
          Run Uptime ["-t", "<fn=2>\x1F427</fn> <fc=#FFF1C6><days>d <hours>h <minutes>m</fc>"] 600,
          Run WeatherX "KMCO" 
                            [ ("clear", "☀"), ("sunny", "☀"), ("mostly clear", "☀"), ("mostly sunny", "🌤"), ("partly sunny", "⛅"), ("fair", "🌥"), ("cloudy","☁"), ("overcast","🌧"), ("partly cloudy", "🌤"), ("mostly cloudy", "⛅"), ("considerable cloudiness", "🌥") ]
                            [ "--template", "<fn=2><skyConditionS></fn><fc=#4682B4><tempF></fc>°F", "-L","65", "-H", "90", "--normal", "#F2E5BC", "--high", "#FB4934", "--low", "#83A598" ] 36000
        ]
}
-- Other Templates
-- , template = "%UnsafeStdinReader%}{ | %dynnetwork% | %multicpu% %multicoretemp%%cpufan% | %gpu% | %memory% | %disku% | %bright% | %default:Master% | %battery% | %KMCO% %chancerain% | %date% |%locks%%trayerpad%"
