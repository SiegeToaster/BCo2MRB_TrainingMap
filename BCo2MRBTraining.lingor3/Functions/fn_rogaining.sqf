/* Author: Siege
	Description: Creates rogaining minigame in a pre-defined area.  Amount of markers vary based on amount variable.  Directions vary based on difficulty level.

	Parameters: 
		0: STRING - difficulty level.
		1: NUMBER/SCALAR - amount of checkpoints.
	Returns: N/A.
*/

params [
	["_diff", "Medium", ["Medium"]],
	["_amount", 10, [10]]
];

private _players = nearestObjects [rogaineArea, ["Man"], 4];
if (_amount < 1) exitWith {"Number of checkpoints must be a number greater than 0." remoteExec ["systemChat", _players];};
srt_rogain setVariable ["inProgress", true, true];
private _positions = [];

("Land nav course starting with " + str _amount + " checkpoints on " + toLower _diff + " difficulty.") remoteExec ["systemChat"];

for [{private _i = 0}, {_i < (_amount + 1)}, {_i = _i + 1}] do {
	_positions pushBack ([srt_rogain, 0, 1250, 0, 0, 0.3] call BIS_fnc_findSafePos);
	while {if (_i == 0) exitWith {false}; (_positions select _i) distance (_positions select (_i - 1)) > 1000} do {
		_positions set [_i, ([srt_rogain, 0, 1250, 0, 0, 0.3] call BIS_fnc_findSafePos)];
	};
};
pos = createVehicle ["FlagSmall_F", (_positions select 0)];
{_x setPosATL getPosATL pos} forEach _players;

{
	[_x] remoteExec ["Co2T_fnc_loadoutCheck", _x];

	removeAllItems _x;
	removeAllAssignedItems _x;

	for "_i" from 1 to 4 do {_x addItem "ACE_tourniquet";};
	for "_i" from 1 to 4 do {_x addItem "ACE_splint";};
	for "_i" from 1 to 3 do {_x addItem "ACE_morphine";};
	_x addItem "ACE_MapTools";
	_x addItem "ACE_Flashlight_XL50";
	for "_i" from 1 to 2 do {_x addItem "ACE_epinephrine";};
	_x addItem "ACE_EarPlugs";
	for "_i" from 1 to 2 do {_x addItem "ACE_CableTie";};
	for "_i" from 1 to 8 do {_x addItem "ACE_elasticBandage";};
	for "_i" from 1 to 3 do {_x addItem "rhsusf_mag_15Rnd_9x19_JHP";};
	_x addItem "ACE_EntrenchingTool";
	_x addItem "ItemcTabHCam";

	_x linkItem "ItemMap";
	_x linkItem "ItemCompass";
	_x linkItem "ACE_Altimeter";
	_x linkItem "TFAR_anprc152";
} forEach _players;
"Good Luck!" remoteExec ["hintSilent", _players];

{	
	{
		if (_x in assignedItems player) then {
			player unassignItem _x;
			player removeItem _x;
		};
	} forEach ["ItemAndroid", "ItemGPS", "ItemMicroDAGR", "FIR_PDU", "ItemcTab", "I_UavTerminal", "C_UavTerminal", "O_UavTerminal", "I_E_UavTerminal", "B_UavTerminal"];
	if ("ACE_microDAGR" in items player) then {
		player removeItem "ACE_microDAGR";
	}
} remoteExec ["call", _players];

sleep 1;
"" remoteExec ["hintSilent", _players]; 

createMarker ["_posMarker", _positions select 0, 0];
"_posMarker" setMarkerType "hd_flag";
"_posMarker" setMarkerColor "colorIndependent";
"_posMarker" setMarkerText "Position 0";
waitUntil {{_x inArea t_trainingIsland} count _players == (count _players)};
private _startTime = time;

[_players] spawn {
	params ["_players"];

	while {true} do {
		waitUntil {!(srt_rogain getVariable "inProgress") || ({!(_x inArea t_trainingIsland)} forEach _players)};
		if (!(srt_rogain getVariable "inProgress")) exitWith {};

		{
			if ({!(_x inArea t_trainingIsland)} forEach _players) then {
				_players = _players - [_x];
			};
		} forEach _players;
	};
};

for [{private _i = 1}, {_i < (_amount + 1)}, {_i = _i + 1}] do {
	waitUntil {({(_x distance pos) < 4} count _players) > 0 || {_x inArea t_trainingIsland} count _players == 0};
	if ({_x inArea t_trainingIsland} count _players == 0) exitWith {};
	["markerReached", []] remoteExecCall ["BIS_fnc_showNotification", _players];
	deleteVehicle pos;
	deleteMarker "_posMarker";
	pos = createVehicle ["FlagSmall_F", (_positions select _i)];
	publicVariable "pos";
	str _diff remoteExec ["systemChat"];
	if ((_i % 2) == 1) then {
		createMarker ["_posMarker", _positions select _i, 0];
		"_posMarker" setMarkerType "hd_flag";
		"_posMarker" setMarkerColor "colorIndependent";
		"_posMarker" setMarkerText "Position " + str _i;
		switch (_diff) do {
			case "Medium": {{systemChat ("Target marked on map " + str (player distance2D pos) + " meters away.")} remoteExec ["call", _players]};
			case "Hard": {("Target marked on map.") remoteExec ["systemChat", _players]};
		};
	} else {
		if (_diff == "Hard") then {
			{systemChat ("Target at " + str (player getDir pos) + " degrees.")} remoteExec ["call", _players];
		} else {
			if (_diff == "Medium") then {
				{systemChat ("Target at " + str (player getDir pos) + " degrees for " + str (player distance2D pos) + " meters.")} remoteExec ["call", _players];
			};
		};
	};
	if (_diff == "Easy") then {
		{systemChat ("Target at " + str (player getDir pos) + " degrees for " + str (player distance2D pos) + " meters.")} remoteExec ["call", _players];
	};
};

waitUntil {{(_x distance pos) < 4} forEach _players || {_x inArea t_trainingIsland} count _players == 0};
deleteVehicle pos;
deleteMarker "_posMarker";
if ({_x inArea t_trainingIsland} count _players == 0) then {
	("Land nav course stopped.") remoteExec ["systemChat", _players];
} else {
	{_x setPosATL getPosATL (rogaineInterface)} forEach _players;
	("Land nav course finished in " + ([time - _startTime] call Co2T_fnc_timeConvert) + " on " + toLower _diff + " difficulty.") remoteExec ["systemChat"];
};

srt_rogain setVariable ["inProgress", false, true];

{
	private _loadout = _x getVariable ["loadout", getUnitLoadout _x];
	removeAllWeapons _x;
	removeGoggles _x;
	removeHeadgear _x;
	removeVest _x;
	removeUniform _x;
	removeAllAssignedItems _x;
	clearAllItemsFromBackpack _x;
	removeBackpack _x;
	_x setUnitLoadout _loadout;
} forEach _players;

if ((_diff == "Easy") || (_amount < 8) || ({_x inArea t_trainingIsland} count _players == 0)) exitWith {};
{
	private _playerData = rogainingScoreboard getOrDefault [getPlayerUID _x, [0, 0, 0]];
	
	_playerData set [2, ((_playerData select 2) + 1)];
	if ((_playerData select 1) == 0) then {
		_playerData set [1, time - _startTime];
	} else {
		_playerData set [1, ((((_playerData select 2) * (_playerData select 1)) + (time - _startTime)) / ((_playerData select 2) + 1))]; // slightly adapted combined mean formula
	};
	if (((time - _startTime) < (_playerData select 1)) || ((_playerData select 1) == 0)) then {
		_playerData set [0, (time - _startTime)];
	};

	rogainingScoreboard set [getPlayerUID _x, _playerData];
	publicVariable "rogainingScoreboard";
	"Rogaining score saved successfully." remoteExec ["systemChat", _x];
	{profileNamespace setVariable ["rogainingStatus", (rogainingScoreboard get getPlayerUID player)]} remoteExec ["call", _x];
} forEach _players;