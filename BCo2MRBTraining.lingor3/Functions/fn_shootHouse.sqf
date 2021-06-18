/* Author: Siege
	Description: Fills a pre-made shoothouse with AI at pre-designated locations.

	Params:
		0: OBJECT - the object corresponding to the shoothouse.  Must have a trigger set as its varable name "triggerName".  Must have an array of objects set as its variable name "spawnPoints".  Can have an array of objects set as its variable name "turretSpawnPoints".
		1: STRING - difficulty level.
		2: BOOLEAN - true if AI should shoot back, false if not.
	Returns: N/A
*/

params [
	["_location", sh1Spawn, [sh1Spawn]],
	["_difficulty", "medium", ["medium"]],
	["_responsive", true, [true]]
];
private _trigger = _location getVariable "triggerName";
private _spawnPoints = _location getVariable "spawnPoints";
_spawnPoints = _spawnPoints call BIS_fnc_arrayShuffle;
private _turretSpawnPoints = _location getVariable "turretSpawnPoints";
_location setVariable ["inProgress", true, true];
if (_responsive) then {
	_responsive = "this disableAI 'PATH';";
} else {
	_responsive = "this disableAI 'all';";
};

private _difficultyMultiplier = 1;
switch (toLower _difficulty) do {
	case "easy": {_difficultyMultiplier = 0.8};
	case "medium": {_difficultyMultiplier = 1};
	case "hard": {_difficultyMultiplier = 1.25};
	case "test": {_difficultyMultiplier = 4}; // this will cause all enemy positions to be used.
	default {_difficultyMultiplier = 1};
};

(str _location + " starting on " + toLower _difficulty + " difficulty.") remoteExec ["systemChat", 0];
private _players = nearestObjects [startArea, ["Man"], 4];
_location setVariable ["players", _players, true];
private _enemy = selectRandom ["rhsgref_ins_g_rifleman_akm", "rhsgref_ins_g_rifleman_aks74", "rhsgref_ins_g_rifleman_aksu", "rhssaf_army_m10_digital_rifleman_m21", "rhssaf_army_m10_digital_rifleman_m70"];

switch (str _location) do {
	case "sh1Spawn": {
		_spawnPoints resize (round (((count _spawnPoints) / 4) * _difficultyMultiplier));
		if (count _players > 4) then {
			_players resize 4;
		};		
	};
	case "sh2Spawn": {
		_spawnPoints resize (round (((count _spawnPoints) / 4) * _difficultyMultiplier));
		if (count _players > 6) then {
			_players resize 6;
		};
	};
	case "sh3Spawn": {
		switch (_difficultyMultiplier) do {
			case 0.8: {_difficultyMultiplier = 0.7};
			case 1.25: {_difficultyMultiplier = 1.5};
			case 4: {_difficultyMultiplier = 8};
		};

		_spawnPoints resize (round (((count _spawnPoints) / 8) * _difficultyMultiplier));
	};
	case "pitSpawn";
	case "consulateSpawn": {
		_spawnPoints resize ((count _spawnPoints) / 5);
		if (count _players > 9) then {
			_players resize 9;
		};
	};
	case "cargoShip": {
		_spawnPoints resize (round (((count _spawnPoints) / 12) * _difficultyMultiplier));
	};
};

private _tgts = [];
for [{private _i = 0}, {_i < (count _spawnPoints)}, {_i = _i + 1}] do {_enemy createUnit [(_spawnPoints select _i), enemyGroup, _responsive + "_tgts pushBack this; this setPosASL (getPosASL (_spawnPoints select _i));", 0.4]};
if !(isNil "_turretSpawnPoints") then {
	for [{private _i = 0}, {_i < (count _turretSpawnPoints)}, {_i = _i + 1}] do {"rhsgref_ins_g_DSHKM" createUnit [(_turretSpawnPoints select _i), enemyGroup, _responsive + "_tgts pushBack this; this setPosASL (getPosASL (_spawnPoints select _i));", 0.4]};
};
if !(str _location == "cargoShip") then {
	{_x setPosATL getPosATL (_location)} forEach _players;
};
private _startTime = time;

waitUntil {({alive _x} count _tgts == (count _tgts)) && (if (typeName _trigger == "ARRAY") then {{(getPosATL _x) inPolygon _trigger} count _players == (count _players)} else {{_x inArea _trigger} count _players == (count _players)})};
[_players, _location, _trigger, _tgts] spawn {
	params ["_players", "_location", "_trigger", "_tgts"];

	while {true} do {
		waitUntil {!(if (typeName _trigger == "ARRAY") then {{(getPosATL _x) inPolygon _trigger} count _players == (count _players)} else {{_x inArea _trigger} count _players == (count _players)}) || ({alive _x} count _tgts == 0 || (if (typeName _trigger == "ARRAY") then {{(getPosATL _x) inPolygon _trigger} count _players == 0} else {{_x inArea _trigger} count _players == 0}) || {alive _x} count _players == 0)};
		if ({alive _x} count _tgts == 0 || (if (typeName _trigger == "ARRAY") then {{(getPosATL _x) inPolygon _trigger} count _players == 0} else {{_x inArea _trigger} count _players == 0}) || {alive _x} count _players == 0) exitWith {};
		
		{
			if (!(if (typeName _trigger == "ARRAY") then {{(getPosATL _x) inPolygon _trigger} count _players == (count _players)} else {{_x inArea _trigger} count _players == (count _players)}) && (alive _x)) then {
				_x setPosATL getPosATL (_location);
			};
		} forEach _players;
	};
};

waitUntil {{alive _x} count _tgts == 0 || (if (typeName _trigger == "ARRAY") then {{(getPosATL _x) inPolygon _trigger} count _players == 0} else {{_x inArea _trigger} count _players == 0}) || {alive _x} count _players == 0};
{
	private _bool = if (typeName _trigger == "ARRAY") then {(getPosATL _x) inPolygon _trigger} else {_x inArea _trigger};
	if (_bool && alive _x) then {
		_x setPosATL (getPosATL startArea);
		[objNull, _x] call ace_medical_treatment_fnc_fullHeal;
	} else {
		deleteVehicle _x;
	};
} forEach _players;
{deleteVehicle _x} forEach _tgts;

if ({alive _x} count _tgts == 0) then {
	(str _location + " finished in " + ([time - _startTime] call Co2T_fnc_timeConvert) + " on " + toLower _difficulty + " difficulty.") remoteExec ["systemChat", 0];
} else {
	if ({alive _x} count _players == 0) then {
		(str _location + " failed in " + ([time - _startTime] call Co2T_fnc_timeConvert) + " on " + toLower _difficulty + " difficulty.") remoteExec ["systemChat", 0];
	} else {
		(str _location + " canceled.") remoteExec ["systemChat", 0];
	};
};
_location setVariable ["inProgress", false, true];