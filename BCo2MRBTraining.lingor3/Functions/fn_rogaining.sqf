/* Rogaining script by Siege

Creates rogaining minigame in a pre-defined area.  10 markers total that are no more than 1 km away from the previous one.  Directions vary based on difficulty level.
*/

private _diff = diff;
private _amount = amount;
srt_rogain setVariable ["inProgress", true, true];
private _startTime = time;
private _positions = [];

("Land nav course starting with " + str _amount + " checkpoints on " + toLower _diff + " difficulty.") remoteExec ["systemChat", 0];
_players = nearestObjects [rogaineArea, ["Man"], 4];

for [{private _i = 0}, {_i < (amount + 1)}, {_i = _i + 1}] do {
	_positions pushBack ([srt_rogain, 0, 1250, 0, 0, 0.3] call BIS_fnc_findSafePos);
	while {if (_i == 0) exitWith {false}; (_positions select _i) distance (_positions select (_i - 1)) > 1000} do {
		_positions set [_i, ([srt_rogain, 0, 1250, 0, 0, 0.3] call BIS_fnc_findSafePos)];
	};
};
private _pos = createVehicle ["FlagSmall_F", (_positions select 0)];
{_x setPosATL getPosATL _pos; hintSilent "Good Luck!";} forEach _players;

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
hintSilent "";

createMarker ["_posMarker", _positions select 0, 0];
"_posMarker" setMarkerType "hd_flag";
"_posMarker" setMarkerColor "colorIndependent";
"_posMarker" setMarkerText "Position 0";

for [{private _i = 1}, {_i < (amount + 1)}, {_i = _i + 1}] do {
	waitUntil {{(_x distance _pos) < 4} forEach _players || {_x inArea t_trainingIsland} count _players == 0};
	if ({_x inArea t_trainingIsland} count _players == 0) exitWith {};
	{["markerReached", []] call BIS_fnc_showNotification} forEach _players;
	deleteVehicle _pos;
	deleteMarker "_posMarker";
	_pos = createVehicle ["FlagSmall_F", (_positions select _i)];
	if ((_i % 2) == 1) then {
		createMarker ["_posMarker", _positions select _i, 0];
		"_posMarker" setMarkerType "hd_flag";
		"_posMarker" setMarkerColor "colorIndependent";
		"_posMarker" setMarkerText "Position " + str _i;
		switch (_diff) do {
			case "Normal": {{systemChat ("Target marked on map " + str (player distance2D _pos) + " meters away.")} forEach _players;};
			case "Hard": {{systemChat "Target marked on map."} forEach _players;};
			default {};
		};
	} else {
		if (_diff == "Hard") then {
			{systemChat ("Target at " + str (player getDir _pos) + " degrees.")} forEach _players;
		} else {
			{systemChat ("Target at "+ str (player getDir _pos) + " degrees for " + str (player distance2D _pos) + " meters.")} forEach _players;
		};
	};
	if (_diff == "Easy") then {
		{systemChat ("Target at " + str (player getDir _pos) + " degrees for " + str (player distance2D _pos) + " meters.")} forEach _players;
	};
};

waitUntil {{(_x distance _pos) < 4} forEach _players || {_x inArea t_trainingIsland} count _players == 0};
deleteVehicle _pos;
deleteMarker "_posMarker";
if ({_x inArea t_trainingIsland} count _players == 0) then {
	("Land nav course stopped.") remoteExec ["systemChat", 0];
} else {
	{_x setPosATL getPosATL (rogaineInterface)} forEach _players;
	("Land nav course finished in " + ([time - _startTime] call Co2T_fnc_timeConvert) + " on " + toLower _diff + " difficulty.") remoteExec ["systemChat", 0];
};

srt_rogain setVariable ["inProgress", false, true];