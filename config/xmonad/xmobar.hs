Config { 
   font =         "xft:Cascadia Code PL:size=10:antialias=true:hinting=true"
   , additionalFonts = [  "xft:Symbols Nerd Font:pixelsize=13:antialias=true:hinting=true" ]
   , bgColor =      "#32302F"
   , fgColor =      "#F2E5BC"
   , position =     Top
   , border =       BottomB
   , borderColor =  "black"

   , sepChar =  "%"   -- delineator between plugin names and straight text
   , alignSep = "}{"  -- separator between left-right alignment
   , template = "%UnsafeStdinReader%}{ | %dynnetwork% | %multicpu% %multicoretemp% | %gpu% | %memory% | %disku% | %bright% | %default:Master% | %battery% | %KMCO% | %date% |%trayerpad%"

   , lowerOnStart =     True    -- send to bottom of window stack on start
   , hideOnStart =      False   -- start with window unmapped (hidden)
   , allDesktops =      True    -- show on all desktops
   , overrideRedirect = True    -- set the Override Redirect flag (Xlib)
   , pickBroadest =     False   -- choose widest display (multi-monitor)
   , persistent =       True    -- enable/disable hiding (True = disabled)

   , commands = 
        -- weather monitor
        [ Run WeatherX "KMCO" 
                            [ ("clear", "\xfa98")
                            , ("sunny", "\xfa98")
                            , ("mostly clear", "\xe30c")
                            , ("mostly sunny", "\xe30c")
                            , ("partly sunny", "\xe30c")
                            , ("fair", "\xe3bc")
                            , ("cloudy","\xe312")
                            , ("overcast","\xe312")
                            , ("partly cloudy", "\xe302")
                            , ("mostly cloudy", "\xe309")
                            , ("considerable cloudiness", "\xe305")] 
                            [ "--template", "<fn=1><skyConditionS></fn> <fc=#4682B4><tempF></fc>°F" 
                            , "-L","65", "-H", "90", "--normal", "#F2E5BC"
                            , "--high", "#FB4934", "--low", "#83A598"
                            ] 36000

        , Run DiskU [("/", "<fn=1>\xf7c9</fn> <used> / <size>")]
                    ["-L", "20", "-H", "80", "-m", "1", "-p", "3"]
                    18000
        , Run Brightness [ "-t", "<fn=1>\xf5dd</fn> <percent>%", "--", "-D", "intel_backlight" ] 10

        , Run Volume "default" "Master" [ "--template", "<status> <volume>%"
                                        , "--", "--on", "<fn=1>\xfa7d</fn>", "--off", "<fn=1>\xfa80</fn>"
                                        , "--onc", "#F2E5BC", "--offc", "#FB4934"
                                        ] 10
        -- network activity monitor (dynamic interface resolution)
         , Run DynNetwork     [  "--template" , "<fn=1>\xf1eb</fn> <fc=#83A598><fn=1>\xf0aa</fn></fc> <tx>KB/s <fc=#B8BB26><fn=1>\xf0ab</fn></fc> <rx>KB/s"
                              , "--Low"      , "1000"       -- units: B/s
                              , "--High"     , "5000"       -- units: B/s
                              , "--low"      , "#F2E5BC"
                              , "--normal"   , "#F2E5BC"
                              , "--high"     , "#F2E5BC"
                              ] 50

        , Run Wireless "" [ "--template", "<ssid>"] 600
        -- cpu activity monitor
        , Run MultiCpu       [ "--template" , "CPU: <total>%"
                                    , "--Low"      , "50"         -- units: %
                                    , "--High"     , "85"         -- units: %
                                    , "--low"      , "#F2E5BC"
                                , "--normal"   , "#F2E5BC"
                                , "--high"     , "#F2E5BC"
                            ] 50

        , Run MultiCoreTemp ["-t", "<max>°C ",
                        "-L", "60", "-H", "80",
                        "-l", "#F2E5BC", "-n", "#F2E5BC", "-h", "#F2E5BC",
                        "--", "--mintemp", "20", "--maxtemp", "100"] 50

                          
        , Run Memory         [ "--template" ,"RAM: <usedratio>%"
                             , "--Low"      , "20"        -- units: %
                             , "--High"     , "90"        -- units: %
                             , "--low"      , "#F2E5BC"
                             , "--normal"   , "#F2E5BC"
                             , "--high"     , "#F2E5BC"
                             ] 50
        , Run Battery        [ "--template" , "<acstatus>"
                             , "--Low"      , "10"        -- units: %
                             , "--High"     , "80"        -- units: %
                             , "--low"      , "#FB4934"
                             , "--normal"   , "#F2E5BC"
                             , "--high"     , "green"

                             , "--" -- battery specific options
                                       -- discharging status
                                       , "-o"   , "<fc=#F2E5BC><fn=1>\xf578</fn></fc> <left><fc=#F2E5BC>% (<timeleft>)</fc>"
                                       -- AC "on" status
                                       , "-O"   , "<fc=lightgreen><fn=1>\xf583</fn></fc> <left>%"
                                       -- charged status
                                       , "-i"   , "<fc=green><fn=1>\xf583</fn></fc> <left>%"
                             ] 50

        -- , Run Com "check-updates" ["<fn=1>\xf487</fn>"] "" 36000
        , Run Com "/home/anthony/utils/trayer-padding-icon.sh" [] "trayerpad" 20
        , Run Com "/home/anthony/utils/gpu-usage" [] "gpu" 50
        -- time and date indicator 
        , Run Date           "<fn=1>\xf133</fn> %a %b %d %Y %I:%M %p" "date" 50
        , Run UnsafeStdinReader
        ]
}
