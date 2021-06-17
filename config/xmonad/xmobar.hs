-- Dependencies: Symbols Nerd Font
Config { 
   font = "xft:Cascadia Code PL:size=10:antialias=true:hinting=true",
   additionalFonts = [  "xft:Symbols Nerd Font:pixelsize=12:antialias=true:hinting=true" ],
   bgColor = "#32302F", fgColor = "#F2E5BC", position = Top, border = BottomB,
   borderColor = "black", sepChar = "%", alignSep = "}{",
   template = "%UnsafeStdinReader%}{ %bright% %default:Master% %battery% %KMCO% %chancerain% %date% %locks%%trayerpad%",
   lowerOnStart = True, hideOnStart = False, allDesktops = True,
   overrideRedirect = True, pickBroadest = False, persistent = True,

   commands = 
        [ Run DiskU [("/", "<fn=1>\xf7c9</fn><usedp>%")] 
                    ["-L", "20", "-H", "80", "-m", "1", "-p", "3"] 3000,
          Run Brightness [ "-t", "<fn=1>\xf0eb</fn> <percent>%", "--", "-D", "intel_backlight" ] 5,
          Run Volume "default" "Master" [ "--template", "<status> <volume>%", "--", "--on", "<fn=1>\xf485</fn>", "--off", "<fn=1>\xf466</fn>", "--onc", "#F2E5BC", "--offc", "#FB4934" ] 5,
          Run DynNetwork [ "--template" , "<fn=1>\xf1eb</fn> <fc=#83A598><fn=1>\xf0aa</fn></fc> <tx>KB/s <fc=#B8BB26><fn=1>\xf0ab</fn></fc> <rx>KB/s", "--Low", "1000", "--High", "5000", "--low", "#F2E5BC", "--normal", "#F2E5BC", "--high", "#F2E5BC" ] 50,
          Run MultiCpu [ "--template", "CPU: <total>%" , "--Low", "50", "--High", "85", "--low", "#F2E5BC" , "--normal","#F2E5BC","--high", "#F2E5BC" ] 50,
          Run MultiCoreTemp [ "-t", "<max>°C ", "-L", "60", "-H", "80", "-l", "#F2E5BC", "-n", "#F2E5BC", "-h", "#F2E5BC", "--", "--mintemp", "20", "--maxtemp", "100" ] 50,
          Run Memory [ "--template", "RAM: <usedratio>%", "--Low", "20", "--High", "90", "--low", "#F2E5BC", "--normal", "#F2E5BC", "--high", "#F2E5BC" ] 50,
          Run Battery [ "--template", "<acstatus>", "--Low", "10", "--High", "80", "--low", "#FB4934", "--normal", "#F2E5BC", "--high", "#F2E5BC", "--", "-o", "<fc=#F2E5BC><fn=1>\xf578</fn></fc> <left><fc=#F2E5BC>%</fc>", "-O", "<fc=#458588><fn=1>\xf583</fn></fc> <left>%", "-i", "<fc=#98971A><fn=1>\xf583</fn></fc> <left>%" ] 20,
          Run Com "/home/anthony/utils/trayer-padding-icon.sh" [] "trayerpad" 20,
          Run Com "/home/anthony/utils/gpu-usage" [] "gpu" 50,
          Run Com "/home/anthony/utils/fan-speed" [] "cpufan" 50,
          Run Com "/home/anthony/utils/chance-rain" ["<fn=1>\xe37c</fn>"] "chancerain" 36000,
          Run Date "<fn=1>\xf133</fn> %a %b %d %Y %I:%M%p" "date" 50,
          Run UnsafeStdinReader,
          Run Locks,
          Run WeatherX "KMCO" 
                            [ ("clear", "\xfa98"), ("sunny", "\xfa98"), ("mostly clear", "\xe30c"), ("mostly sunny", "\xe30c"), ("partly sunny", "\xe30c"), ("fair", "\xe3bc"), ("cloudy","\xe312"), ("overcast","\xe312"), ("partly cloudy", "\xe302"), ("mostly cloudy", "\xe309"), ("considerable cloudiness", "\xe305") ]
                            [ "--template", "<fn=1><skyConditionS></fn> <fc=#4682B4><tempF></fc>°F", "-L","65", "-H", "90", "--normal", "#F2E5BC", "--high", "#FB4934", "--low", "#83A598" ] 36000
        ]
}
-- Other Templates
-- , template = "%UnsafeStdinReader%}{ | %dynnetwork% | %multicpu% %multicoretemp%%cpufan% | %gpu% | %memory% | %disku% | %bright% | %default:Master% | %battery% | %KMCO% %chancerain% | %date% |%locks%%trayerpad%"
