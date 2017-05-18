#!/bin/bash

##  GUNCONTROL • GUNBOT 3.2 CUSTOM LAUNCHER
##  version v0.0.2 / May 2017.
##
##
##  Denis Smirnov / densmirnov@me.com / densmirnov.com
##  Also credits goes to gionni@gunthy.org for his GunBot Start/Stop Bash Script
##
##  BTC: 1denG4FjcXDeGSYeiv65R6Eyi3HWo7R8j
##  ETH: 0xa4C7fACEFC08e684Cd9043c3e31C86Dfb88DF75a
##  LSK: 10061645427951005252L
##  -----------------------------------------------

##  STARTUP ITEMS
##  -----------------------------------------------
    export RESET && export BOLD && export RED && export GREEN && export BLUE && export YELLOW && export WHITE && export BOTTOM
    RESET=$(tput sgr0) && BOLD=$(tput bold) && RED=$(tput setaf 1) && GREEN=$(tput setaf 2) && BLUE=$(tput setaf 4) && YELLOW=$(tput setaf 3) && WHITE=$(tput setaf 7) && BOTTOM="\n ─────────────────────────────────────────────────────── \n"

    export CMD && export ARCH && export BOTFOLDER && export FILES && export NAME && export NAME1 && export GUNTHY
    CMD=$1 && ARCH=$(uname -m) && BOTFOLDER="$(pwd)" && FILES="*-config.js" && NAME1="${f%-*}" && NAME=${NAME1#"poloniex-"} && GUNTHY=""

##  OS DETECTION
##  -----------------------------------------------
    if [[ "$OSTYPE" == "linux-gnu" && "$ARCH" == "x86_64" ]]; then
      GUNTHY="gunthy-linuxx64"
    elif [[ "$OSTYPE" == "linux-gnu" && "$ARCH" == "i686" ]]; then
      GUNTHY="gunthy-linuxx86"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
      GUNTHY="gunthy-macos"
    else
      GUNTHY="Unknown OS"
    fi


##  MAIN SCRIPT
##  -----------------------------------------------
    # clear
    echo -e "${BLUE}""\n┌───────────────────────────────────────────────────────┐\n${BLUE}│${RESET}  ${GREEN}GUNBOT LAUNCHER v0.0.2${RESET}             ${BLUE}$(date +%d.%m.%Y\ %H:%M)${RESET}  ${BLUE}│\n└───────────────────────────────────────────────────────┘""${RESET}"

    if [[ -n "$CMD" ]]; then
      ##
      ##  START
      ##  -----------------------------------------------
      if [[ "$CMD" == "start" ]]; then
        echo -e "${WHITE}""   STARTING GUNBOT...$BOTTOM" "${RESET}"
        for f in $FILES
        do
          echo -e "${WHITE}"" • Checking ${YELLOW}$NAME${WHITE}...  ${RESET}\c"
          if ! screen -list | grep -wo "$NAME"; then
            echo -e "${BLUE}""\t\t\tSTOPPED!\n   Starting \c""${RESET}"
            screen -dmS "$NAME" "${BOTFOLDER}"/"$GUNTHY" "$NAME" poloniex && sleep 1
            echo -n "${BLUE}...1 ${RESET}" && sleep 1
            echo -n "${BLUE}...2 ${RESET}" && sleep 1
            echo -n "${BLUE}...3 ${RESET}" && sleep 1
            echo -n "${BLUE}...4 ${RESET}" && sleep 1
            echo -e "${BLUE}...5!  ${RESET}${GREEN}            DONE!${RESET}"
          else
            echo -e "${BLUE}""\t\t\tRUNNING!\n   Skipping...                                     ${GREEN}DONE!""${RESET}" && sleep 0.2
          fi
        done
        echo -e "${WHITE}""\n ─────────────────────────────────────────────────────── \n   ALL PAIRS ARE RUNNING!" "${RESET}"
        exit 0
      fi

      ##  STOP
      ##  -----------------------------------------------
      if [[ "$CMD" == "stop" ]]; then
        echo -e "${WHITE}""   STOPPING GUNBOT...$BOTTOM" "${RESET}"
        for f in $FILES
        do
          echo -e "${WHITE} • Checking ${YELLOW}$NAME ${WHITE}... \t\t\t${RESET}\c"
          if ! screen -list | grep -q "$NAME"; then
            echo -e "${BLUE}""STOPPED!\n   Skipping...                                     ${GREEN}DONE!""${RESET}" && sleep 0.2
          else
            echo -e "${BLUE}""RUNNING!\n   Stopping...                                     ${GREEN}DONE!""${RESET}" && sleep 0.2
            screen -S "$NAME" -X quit && sleep 0.2
          fi
        done
        echo -e "${WHITE}""$BOTTOM   ALL PAIRS ARE STOPPED!" "${RESET}"
        exit 0
      fi

      ##  LIST
      ##  -----------------------------------------------
      if [[ "$CMD" == "list" ]]; then
        export LOOKUP && export HEADER && export DIVIDER
        LOOKUP="ps aux"
        HEADER="%-12b\t%-12s\t%-12b\n"
        DIVIDER=${BLUE}"   ------------"${RESET}
        echo -e "${WHITE}""   RUNNING PAIRS:$BOTTOM" "${RESET}"
        $LOOKUP | grep -v grep | grep "SCREEN" | awk '{printf " • %-09s\n", $13}'
        echo -e "${WHITE}""$BOTTOM" "${RESET}"
        exit 0
      fi
    else
      echo -e "${RED}""  ${RED}COMMAND MISSING$BOTTOM""${RESET}"
      echo -e "  ${BLUE}Usage: ${WHITE}bash guncontrol.sh [${GREEN}${BOLD} start ${RESET}| ${RED}${BOLD}stop ${RESET}| ${YELLOW}${BOLD}list${RESET} ]${RESET}"
        echo -e "${RED}""$BOTTOM" "${RESET}"
      exit 0
    fi
