/****************************************************************
ARMA Mission Development Framework
ADF version: 1.41 / JULY 2015

Script: Mission initialization countdown timer
Author: Whiztler
Script version: 1.47

Game type: n/a
File: ADF_init_post.sqf
****************************************************************
DO NOT EDIT THIS FILE

Configure the mission timer in ADF_init_config.sqf
****************************************************************/

diag_log "ADF RPT: Init - executing ADF_init_post.sqf"; // Reporting. Do NOT edit/remove

if (ADF_debug) then {
	{
		_diagMsg = "DIAG - Script executed: " + str _x;
		[_diagMsg,false] call ADF_fnc_log;
	} forEach diag_activeSQFScripts;
};

// Init
private ["_ADF_unit","_cnt","_TimerInput","_mVersion","_timer"];
_ADF_unit 		= player;
_cnt 			= 0;
_TimerInput 		= _this select 0;
ADF_tVersion 	= str (_this select 1);
_mVersion 		= str (_this select 2);
ADF_devBuild 	= _this select 3;
ADF_devBuildNr 	= _this select 4;
ADF_devBuildRun 	= false;
_timer = _TimerInput / 100;
ADF_mapMrkText = "[ADF] ARMA Mission Development Framework v";


if (isServer) then {
	private ["_bVersion","_m"];
	If ((ADF_devBuild == "Alpha") || (ADF_devBuild == "Beta")) then {
		_bVersion =  format [" (Build: %1 %2)", ADF_devBuild,ADF_devBuildNr];
		ADF_mapMrkText = ADF_mapMrkText + ADF_tVersion + _bVersion;	
	} else {
		ADF_mapMrkText = ADF_mapMrkText + ADF_tVersion;
	};

	_m = createMarker ["mADF_version",[1000,1000,0]];
	_m setMarkerSize [0,0];
	_m setMarkerShape "ICON";
	_m setMarkerType "mil_box";
	_m setMarkerColor "ColorWhite";
	_m setMarkerDir 0;
	_m setMarkerText ADF_mapMrkText;
	
	if ({side _x == EAST} count allUnits == 0) then {createCenter EAST;};
	if ({side _x == west} count allUnits == 0) then {createCenter WEST;};
	if ({side _x == RESISTANCE} count allUnits == 0) then {createCenter RESISTANCE;};
	if ({side _x == CIVILIAN} count allUnits == 0) then {createCenter CIVILIAN;};
};

if (time > 300) exitWith {ADF_missionInit = true;};
If (isDedicated || ADF_isHC) exitWith {ADF_missionInit = true;};
if (ADF_debug) exitWith {ADF_missionInit = true; publicVariable "ADF_missionInit";["INIT - debug mode detected, skipping mission init timer",false] call ADF_fnc_log;};
if (isMultiplayer) then {_ADF_unit enableSimulation false;};

If ((ADF_devBuild == "Alpha") || (ADF_devBuild == "Beta")) then {
	_ADF_debugLog_msg = format ["This is a development build of ADF (%1 - %2 %3). Do not use for live missions!",ADF_tVersion,ADF_devBuild,ADF_devBuildNr];
	[_ADF_debugLog_msg,"systemChat"] call BIS_fnc_MP; // v.39 B6
};
		
while {(_cnt != 100)} do {
	_cnt = _cnt + 1;
	
	ADF_initMsg = format ["
		<br/>
		<t align='left' size='1.1' color='#A1A4AD'>Mission Initializing: </t>
		<t size='1.1' align='left' color='#F7D358' font='PuristaBold'>%1&#0037;</t><t size='1.1' align='left' color='#A1A4AD'> done</t><br/><br/>
		<t align='left' color='#A1A4AD'>- Refrain from moving!</t><br/>
		<t align='left' color='#A1A4AD'>- Do not use your radio!</t><br/>
		<t align='left' color='#A1A4AD'>- Follow TL orders</t><br/>
		<t align='left' color='#A1A4AD'>- Init takes approx %2 secs</t><br/><br/>
		<t align='left' color='#A1A4AD'>Tpl: <t color='#FFFFFF' align='left'>%3</t>  |  Mission: </t><t color='#FFFFFF' align='left'>%4</t><br/>
	", _cnt,_TimerInput,ADF_tVersion,_mVersion];

	If ((ADF_devBuild == "Alpha") || (ADF_devBuild == "Beta")) then {
		ADF_initMsg = ADF_initMsg + format ["
			<t align='left' color='#A1A4AD'>Build: <t color='#FFFFFF' align='left'>%1</t>  |  Build version: </t><t color='#FFFFFF' align='left'>%2</t><br/>
		", ADF_devBuild,ADF_devBuildNr];
	};	
	sleep _timer;
	hintSilent parseText ADF_initMsg; 
};

if (isMultiplayer) then {_ADF_unit enableSimulation true;};

ADF_postInitMsg = format ["
	<br/>
	<t size='1.1' color='#FFFFFF' align='left'>Mission initializing complete</t>
	<t size='1' align='left' color='#A1A4AD'><br/><br/>
	- Refrain from moving!<br/>
	- Do not use your radio!<br/>
	- Follow TL orders<br/>
	- Init takes approx %1 secs<br/><br/>
	Tpl: %2  |  Mission: %3</t><br/><br/>
",_TimerInput,ADF_tVersion,_mVersion];

If ((ADF_devBuild == "Alpha") || (ADF_devBuild == "Beta")) then {
	ADF_postInitMsg = ADF_postInitMsg + format ["
		<t align='left' color='#A1A4AD'>Build: %1 | Build version: %2</t><br/>
	", ADF_devBuild,ADF_devBuildNr];
};

hintSilent parseText ADF_postInitMsg;
finishMissionInit;
sleep 3; hintSilent "";
ADF_missionInit = true; //publicVariable "ADF_missionInit"; // > 140B06
if (ADF_debug) then {["INIT - MissionInit Timer done",false] call ADF_fnc_log};
ADF_postInitMsg = nil; ADF_initMsg = nil; ADF_mapMrkText = nil;
