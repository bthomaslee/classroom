#!/bin/zsh

# This script will trigger the next event in a puzzle room sequence (puzzle room 001) and wait for the next trigger.

# Set paths.

## Directories
pr_dir="/Users/Brian/Dropbox/Classes/BTL/Generic Resources/Puzzle Rooms/001"
sounds_dir="/Users/Brian/Dropbox/Sounds/Samples/Collected/Limited"
video_dir="/Users/Brian/Dropbox/Images/Cinematic/Studio/2023.09.21 - Puzzle Room 001/Scenes/Video"

## Videos
welcome_video="$video_dir/1_Welcome.mp4"
launch_video="$video_dir/2_Launch.mp4"
puzzling_video="$video_dir/3_Puzzling.mp4"
landing_video="$video_dir/4_Landing.mp4"
video_playlist="$video_dir/PuzzleRoom001_VideoPlaylist.m3u"

## Apps
terminal_app="/System/Applications/Utilities/Terminal.app"
video_app="/Applications/VLC.app"

## Sounds
digital_typing="$sounds_dir/UIClick_Digital-Typing-Resonant-Low-Mid-Pitch-(5m)-01_Unknown_Unknown.mp3"
wrong_answer="$sounds_dir/ALRMBuzr_Wrong-Answer-Game-Show-Two-Beeps-01_Unknown_Unknown.mp3"
system_start="$sounds_dir/UIBeep_HUD-11_Unknown_YouTube.wav"
success01="$sounds_dir/UIBeep_HUD-12_Unknown_YouTube.wav"
success02="$sounds_dir/ALRMMisc-UI_Simple-Subtle-Beep-Alarm-01_Unknown_Unknown.mp3"

# Load zsh modules.
zmodload zsh/datetime

# Set initial functions.
idle_between_periods(){
while true; do
    sleep 10
    get_current_time
    if [[ $current_time -ge 900 && $current_time -lt 1010 ]]
        then
        if [[ $current_time -ge 957 ]]
            then break
            else continue
        fi
    elif [[ $current_time -ge 1010 && $current_time -lt 1110 ]]
        then
        if [[ $current_time -ge 1057 ]]
            then break
            else continue
        fi
    elif [[ $current_time -ge 1110 && $current_time -lt 1240 ]]
        then
        if [[ $current_time -ge 1227 ]]
            then break
            else continue
        fi
    elif [[ $current_time -ge 1240 && $current_time -lt 1340 ]]
        then
        if [[ $current_time -ge 1327 ]]
            then break
            else continue
        fi
    elif [[ $current_time -ge 1340 || $current_time -lt 900 ]]
        then break
    fi
done
}
gate(){
    unset gate_code
    while true; do
        read -s -k 1 gate_code
        if [[ $gate_code = n ]]; then afplay "$wrong_answer"; fi
        if [[ $gate_code = y ]]; then break; fi
    done
}
display_reboot_stringA(){
    string=$(cat "$pr_dir/reboot_stringsA.txt")
    input="$string"
    c="${#input[@]}"
    p=0
    until [[ $p -gt $c ]]; do
        printf "${input[$p]}"
        let p++
    done
    printf "\n\n\n"
}
display_reboot_stringB(){
    string=$(cat "$pr_dir/reboot_stringsB.txt")
    input="$string"
    c="${#input[@]}"
    p=0
    until [[ $p -gt $c ]]; do
        printf "${input[$p]}"
        sleep 0.000001
        let p++
    done
    printf "\n\n\n"
}
display_reboot_stringC(){
    string=$(cat "$pr_dir/reboot_stringsC.txt")
    input="$string"
    c="${#input[@]}"
    p=0
    until [[ $p -gt $c ]]; do
        printf "${input[$p]}"
        sleep 0.01
        let p++
    done
    printf "\n"
}
get_current_time(){
    current_time=$(date +"%H%M")
}
clear_terminal(){
    open "$terminal_app"
    sleep 1
    cliclick kd:cmd t:k ku:cmd
}
idle_before_firstperiod(){
    while true; do
        sleep 10
        get_current_time
        if [[ $current_time -lt 857 ]]
            then continue
            else break
        fi
    done
}

# Idle before first period.
clear_terminal
idle_before_firstperiod
osascript -e 'set volume output volume 100'

# Start main loop.
while true; do

# Welcome sequence.
afplay "$system_start" &
printf "All systems ready for launch.\nAwaiting command from flight deck.\n"
open $video_playlist
open $terminal_app
cliclick c:.
sleep 370

# Launch sequence.
printf "Countdown hold for final launch checkouts.\n"
sleep 13
printf "Logging final launch checkouts from all stations.\n"
sleep 15
printf "Countdown initiated.\n"
sleep 10
printf "Primary booster engaged.\n"
sleep 25
printf "\n${red}ERROR:${reset} Escape velocity anomaly."
sleep 2
printf "\n${red}ERROR:${reset} Orbital decay anticipated."
sleep 2
printf "\n${red}ERROR:${reset} Navigation misalignment."
sleep 1
printf "\n${flash}${red}NAVIGATION FAILURE${reset}"
sleep 1
printf "\33[2K\r${flash}${red}NA&IGA]ION FAI\$URE${reset}"
sleep 2
printf "\33[2K\r${flash}${red}N      ION FAI\$U E${reset}"
sleep 1
clear_terminal
printf "\33[2K\r${flash}${bold}${red}NAVIGATION FAILURE${reset}"
sleep 20

# Puzzling sequence.

## Recalibrate navigation panels.
printf "\33[2K\r${red}${bold}Safe-mode reboot of navigation system required. See emergency handbook.${reset}"
gate
printf "\n${green}Success.${reset} 1 of 3 navigation panels calibrated for reboot."
afplay "$success01" & 
gate
printf "\n${green}Success.${reset} 2 of 3 navigation panels calibrated for reboot."
afplay "$success01" &  
gate
printf "\n${green}Success.${reset} 3 of 3 navigation panels calibrated for reboot."
afplay "$success01" & 
sleep 2

## Show reboot of navigation system.
printf "\n\n${bold}Rebooting navigation system in emergency safe-mode...${reset}"
sleep 3
afplay "$digital_typing" &
display_reboot_stringA
display_reboot_stringB
display_reboot_stringC
killall afplay

## Use emergency keypad to initiate landing sequence.
printf "\n\nUse ${bold}${underline}emergency keypad${reset} to enter ${bold}${underline}9-digit passcode${reset} to initiate landing sequence.\n\n\n"
get_current_time
if [[ $current_time -ge 900 && $current_time -lt 1010 ]]
    then correct_passcode="184917385"
elif [[ $current_time -ge 1010 && $current_time -lt 1110 ]]
    then correct_passcode="173851849"
elif [[ $current_time -ge 1110 && $current_time -lt 1210 ]]
    then correct_passcode="851849173"
elif [[ $current_time -ge 1230 && $current_time -lt 1340 ]]
    then correct_passcode="184917385"
elif [[ $current_time -ge 1340 || $current_time -lt 900 ]]
    then correct_passcode="173851849"
    else correct_passcode="173851849"
fi

attempt_num=1
passcode=null; echo; until [[ $passcode = $correct_passcode || $passcode = "y" ]]; do
printf "(Attempt $attempt_num) Enter passcode: \n\n\n"; read passcode
if ! [[ $passcode = $correct_passcode || $passcode = "y" ]]
    then
    afplay "$wrong_answer" &
    let attempt_num++
done

# Landing sequence.
printf "\n${green}Passcode accepted.${reset}\n\n\n"
afplay "$success02" &
sleep 2
printf "\nProcessing...\n\n\n"
osascript -e 'set volume output volume 90'
sleep 0.5
osascript -e 'set volume output volume 75'
sleep 0.5
osascript -e 'set volume output volume 50'
sleep 0.5
osascript -e 'set volume output volume 30'
sleep 0.5
osascript -e 'set volume output volume 10'
sleep 0.5
osascript -e 'set volume output volume 0'
open "$video_app"
cliclick kd:cmd kp:arrow-right ku:cmd
sleep 0.5
osascript -e 'set volume output volume 100'
open $terminal_app
cliclick c:.
printf "\nEmergency landing sequence initiated.\n\n\n"
sleep 105
printf "\n${flash}${green}Landing sequence complete.${reset}\n\n\n"
sleep 5
printf "\nConducting system-wide diagnostic scan.\n\n\n"
sleep 15
clear_terminal

# Idle until three minutes before the next period.
idle_between_periods
if [[ $current_time -ge 1330 ]]
    then break
fi

# End main loop.
done