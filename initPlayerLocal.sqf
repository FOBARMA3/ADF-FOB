/****************************************************************
ARMA Mission Development Framework
ADF version: 1.43 / NOVEMBER 2015

Script: Local Player init
Author: Whiztler
Script version: 1.31

Game type: n/a
File: initPlayerLocal.sqf
*****************************************************************
Executed locally when player joins mission (includes both mission
start and JIP).

[player:Object, didJIP:Boolean]
****************************************************************/

diag_log "ADF RPT: Init - executing initPlayerLocal.sqf"; // Reporting. Do NOT edit/remove

// init
ADF_didJIP = false;
ADF_fnc_respawn = player addEventHandler ["killed", {_this execVM "ADF_onPlayerRespawn.sqf"}]; // Respawn client
ADF_didJIP = _this select 1;

enableEnvironment false; // Perf saver - remove rabbits, snakes, etc


