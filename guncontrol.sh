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
export BOLD && export RED && export GREEN && export BLUE && export YELLOW && export WHITE && export RESET && export TOPLINE && export BOTTOMLINE && export EMPTYLINE
BOLD=$(tput bold)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
YELLOW=$(tput setaf 3)
WHITE=$(tput setaf 7)
RESET=$(tput sgr0)
TOPLINE=""
BOTTOMLINE="\n ───────────────────────────────────────────────────────────── ─"
EMPTYLINE="│                                                              │"

export CMD && export BOTFOLDER && export FILES && export NAME
CMD=$1
BOTFOLDER="${PWD}"
FILES="*-config.js"

clear
echo -e "${BLUE}""\n┌───────────────────────────────────────────────────────┐\n${BLUE}│${RESET}  ${GREEN}GUNBOT LAUNCHER v0.0.2${RESET}             ${BLUE}$(date +%d.%m.%Y\ %H:%M)${RESET}  ${BLUE}│\n└───────────────────────────────────────────────────────┘\n""${RESET}"

##  OPTIONS
##  -----------------------------------------------
if [[ -n "$CMD" ]]; then

  ##  START
  ##  -----------------------------------------------
  if [[ "$CMD" == "start" ]]; then
    echo -e "${WHITE}""   STARTING GUNBOT...\n ─────────────────────────────────────────────────────── " "${RESET}"
    for f in $FILES
    do
      NAME1="${f%-*}"
      NAME=${NAME1#"poloniex-"}

      echo -e "${WHITE}"" • Checking ${YELLOW}$NAME${WHITE}...  ${RESET}\c"
      if ! screen -list | grep -wo "$NAME"; then
        echo -e "${BLUE}""\t\t\tSTOPPED!\n   Starting \c""${RESET}"
        screen -dmS "$NAME" "${BOTFOLDER}"/gunthy-linuxx64 "$NAME" poloniex && sleep 1
        echo -n "${BLUE}...1 ${RESET}" && sleep 1
        echo -n "${BLUE}...2 ${RESET}" && sleep 1
        echo -n "${BLUE}...3 ${RESET}" && sleep 1
        echo -n "${BLUE}...4 ${RESET}" && sleep 1
        echo -e "${BLUE}...5!  ${RESET}${GREEN}            DONE!${RESET}"
      else
        echo -e "${BLUE}""\t\t\tRUNNING!\n   Skipping...                                     ${GREEN}DONE!""${RESET}" && sleep 0.2
      fi
    done
    echo -e "${WHITE}"" ─────────────────────────────────────────────────────── \n   ALL PAIRS ARE RUNNING!" "${RESET}"
    exit 0
  fi

  ##  STOP
  ##  -----------------------------------------------
  if [[ "$CMD" == "stop" ]]; then
    echo -e "${WHITE}""   STOPPING GUNBOT...\n ─────────────────────────────────────────────────────── \n" "${RESET}"
    for f in $FILES
    do
      NAME1="${f%-*}"
      NAME=${NAME1#"poloniex-"}
      echo -e "${WHITE} • Checking ${YELLOW}$NAME ${WHITE}... \t\t\t${RESET}\c"
      if ! screen -list | grep -q "$NAME"; then
        echo -e "${BLUE}""STOPPED!\n   Skipping...                                     ${GREEN}DONE!""${RESET}" && sleep 0.2
      else
        echo -e "${BLUE}""RUNNING!\n   Stopping...                                     ${GREEN}DONE!""${RESET}" && sleep 0.2
        screen -S "$NAME" -X quit && sleep 0.2
      fi
    done
    echo -e "${WHITE}"" ─────────────────────────────────────────────────────── \n   ALL PAIRS ARE STOPPED!" "${RESET}"
    exit 0
  fi

  ##  LIST
  ##  -----------------------------------------------
  if [[ "$CMD" == "list" ]]; then
    export LOOKUP && export HEADER && export DIVIDER
    LOOKUP="ps aux"
    HEADER="%-12b\t%-12s\t%-12b\n"
    DIVIDER=${BLUE}"   ------------"${RESET}
    echo -e "${WHITE}""   RUNNING PAIRS:\n ─────────────────────────────────────────────────────── \n" "${RESET}"
    # echo -e "${BLUE}""   STRATEGY\t" "  PAIR\t" "  EXCHANGE\t""${RESET}"
    # echo -e "${DIVIDER}" "${DIVIDER}" "${DIVIDER}"
    # $LOOKUP | grep -v grep | grep "SCREEN" | awk '{printf "   %-12s\t   %-12s\t   %-12s   \n", $09, $13, $16}'
    $LOOKUP | grep -v grep | grep "SCREEN" | awk '{printf " • %-09s\n", $13}'
    echo -e "${WHITE}""\n ─────────────────────────────────────────────────────── " "${RESET}"
    exit 0
  fi
else
  echo -e "${RED}""  ${RED}COMMAND MISSING\n ─────────────────────────────────────────────────────── \n""${RESET}"
  echo -e "  ${BLUE}Usage: ${WHITE}bash guncontrol.sh [${GREEN}${BOLD} start ${RESET}| ${RED}${BOLD}stop ${RESET}| ${YELLOW}${BOLD}list${RESET} ]${RESET}"
    echo -e "${RED}""\n ─────────────────────────────────────────────────────── " "${RESET}"
  exit 0
fi
