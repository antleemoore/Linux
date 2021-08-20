-- Dependencies: Symbols Nerd Font
Config { 
   font = "xft:DejaVu Sans:size=10:antialias=true:hinting=true",
   additionalFonts = [  "xft:Symbols Nerd Font:pixelsize=18:antialias=true:hinting=true", "xft:Noto Color Emoji:pixelsize=15"],
   bgColor = "#32302F", fgColor = "#F2E5BC", position = TopW L 100, border = BottomB,
   borderColor = "black", sepChar = "%", alignSep = "}{",
-- Desktop template
   template = "%UnsafeStdinReader%  %date%  %KMCO% %chancerain%}{ %dynnetwork%  %multicpu% %multicoretemp%  %gpu%  %memory%  %disku%  %default:Master% %trayerpad%",
   lowerOnStart = True, hideOnStart = False, allDesktops = True,
   overrideRedirect = True, pickBroadest = False, persistent = True,

   commands = 
        [ Run DiskU [("/", "<fn=1>\xf7c9</fn><usedp>%")] 
                    ["-L", "20", "-H", "80", "-m", "1", "-p", "3"] 3000,
          Run Volume "default" "Master" [ "--template", "<action=`pavucontrol`><status> <volume>%</action>", "--", "--on", "<fn=1>\xf485</fn>", "--off", "<fn=1>\xf466</fn>", "--onc", "#F2E5BC", "--offc", "#FB4934" ] 5,
          Run DynNetwork [ "--template" , "<fc=#83A598><fn=1>\xf0aa</fn></fc> <tx>KB/s <fc=#B8BB26><fn=1>\xf0ab</fn></fc> <rx>KB/s", "--Low", "1000", "--High", "5000", "--low", "#F2E5BC", "--normal", "#F2E5BC", "--high", "#F2E5BC" ] 60,
          Run MultiCpu [ "--template", "<fn=1>\xf85a</fn> <total>%" , "--Low", "50", "--High", "85", "--low", "#F2E5BC" , "--normal","#F2E5BC","--high", "#F2E5BC" ] 60,
          Run MultiCoreTemp [ "-t", "<max>°C ", "-L", "60", "-H", "80", "-l", "#F2E5BC", "-n", "#F2E5BC", "-h", "#F2E5BC", "--", "--mintemp", "20", "--maxtemp", "100" ] 60,
          Run Memory [ "--template", "<action=`alacritty -e htop`><fn=1>\xf0c7</fn> <usedratio>%</action>", "--Low", "20", "--High", "90", "--low", "#F2E5BC", "--normal", "#F2E5BC", "--high", "#F2E5BC" ] 60,
          Run Com "/home/anthony/utils/trayer-padding-icon.sh" [] "trayerpad" 20,
          Run Com "/home/anthony/utils/gpu-usage.sh" ["<fn=1>\xf878</fn>"] "gpu" 60,
          Run Com "/home/anthony/utils/chance-rain.sh" ["<fn=2>☔</fn>"] "chancerain" 36000,
          Run Date "<action=`calcurse-caldav && alacritty -e calcurse && calcurse-caldav`><fc=#83c07c><fn=2>📆</fn> %a %b %d %Y</fc></action> <fc=#83A598><fn=2>🕒</fn> %I:%M:%S %p</fc>" "date" 10,
          Run UnsafeStdinReader,
          Run Locks,
          Run WeatherX "KMCO" 
                            [ ("clear", "☀"), ("sunny", "☀"), ("mostly clear", "🌤"), ("mostly sunny", "🌤"), ("partly sunny", "⛅"), ("fair", "🌥"), ("cloudy","☁"), ("overcast","🌧"), ("partly cloudy", "🌤"), ("mostly cloudy", "⛅"), ("considerable cloudiness", "🌥") ]
                            [ "--template", "<fn=2><skyConditionS></fn><fc=#4682B4><tempF></fc>°F", "-L","65", "-H", "90", "--normal", "#F2E5BC", "--high", "#FB4934", "--low", "#83A598" ] 36000
        ]
}
-- Other Templates
-- , template = "%UnsafeStdinReader%}{ | %dynnetwork% | %multicpu% %multicoretemp%%cpufan% | %gpu% | %memory% | %disku% | %bright% | %default:Master% | %battery% | %KMCO% %chancerain% | %date% |%locks%%trayerpad%"
