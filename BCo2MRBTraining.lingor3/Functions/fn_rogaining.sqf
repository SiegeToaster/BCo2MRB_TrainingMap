/* Author: Siege
	Description: Creates rogaining minigame in a pre-defined area.  Amount of markers vary based on amount variable.  Directions vary based on difficulty level.

	Parameters: 
		0: STRING - difficulty level.
		1: NUMBER/SCALAR - amount of checkpoints.
	Returns: N/A.
*/

params [
	["_diff", "Normal", ["Normal"]],
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
private _pos = createVehicle ["FlagSmall_F", (_positions select 0)];
{_x setPosATL getPosATL _pos} forEach _players;
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

for [{private _i = 1}, {_i < (_amount + 1)}, {_i = _i + 1}] do {
	// str (({(_x distance _pos) < 4} count _players) > 0) remoteExec ["systemChat", 0];
	waitUntil {({(_x distance _pos) < 4} count _players) > 0 || {_x inArea t_trainingIsland} count _players == 0};
	// "waitUntil marker" remoteExec ["systemChat", 0];
	if ({_x inArea t_trainingIsland} count _players == 0) exitWith {};
	["markerReached", []] remoteExecCall ["BIS_fnc_showNotification", _players];
	deleteVehicle _pos;
	deleteMarker "_posMarker";
	private _pos = createVehicle ["FlagSmall_F", (_positions select _i)];
	if ((_i % 2) == 1) then {
		createMarker ["_posMarker", _positions select _i, 0];
		"_posMarker" setMarkerType "hd_flag";
		"_posMarker" setMarkerColor "colorIndependent";
		"_posMarker" setMarkerText "Position " + str _i;
		switch (_diff) do {
			case "Normal": {("Target marked on map " + str (player distance2D _pos) + " meters away.") remoteExec ["systemChat", _players]};
			case "Hard": {"Target marked on map." remoteExec ["systemChat", _players]};
			default {};
		};
	} else {
		if (_diff == "Hard") then {
			"Target at " + str (player getDir _pos) + " degrees." remoteExec ["systemChat", _players];
		} else {
			("Target at "+ str (player getDir _pos) + " degrees for " + str (player distance2D _pos) + " meters.") remoteExec ["systemChat", _players];
		};
	};
	if (_diff == "Easy") then {
		("Target at " + str (player getDir _pos) + " degrees for " + str (player distance2D _pos) + " meters.") remoteExec ["systemChat", _players];
	};
}; // something wrong with {str (player distance2D _pos)} - returns 1e+010 (either player or _pos is objNull)

waitUntil {{(_x distance _pos) < 4} forEach _players || {_x inArea t_trainingIsland} count _players == 0};
deleteVehicle _pos;
deleteMarker "_posMarker";
if ({_x inArea t_trainingIsland} count _players == 0) then {
	("Land nav course stopped.") remoteExec ["systemChat", _players];
} else {
	{_x setPosATL getPosATL (rogaineInterface)} forEach _players;
	("Land nav course finished in " + ([time - _startTime] call Co2T_fnc_timeConvert) + " on " + toLower _diff + " difficulty.") remoteExec ["systemChat"];
};

srt_rogain setVariable ["inProgress", false, true];