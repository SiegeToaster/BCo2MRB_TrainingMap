/* Shoothouse script by Siege 

Fills a pre-made shoothouse with AI at pre-designated locations.

Params:
		0: object, the object corresponding to the shoothouse.  Must have a trigger set as it's varable name "triggerName".
*/

params [["_location", sh1Spawn, [sh1Spawn]]];
private _trigger = _location getVariable "triggerName";
_location setVariable ["inProgress", true, true];
private _startTime = time;
private _shootHouseMode = shootHouseMode;

(str _location + " starting.") remoteExec ["systemChat", 0];
private _spawnPoints = (nearestObjects [_location, ["Logic"], 100]) call BIS_fnc_arrayShuffle;
private _players = nearestObjects [startArea, ["Man"], 4];
private _enemy = selectRandom ["rhsgref_ins_g_rifleman_akm", "rhsgref_ins_g_rifleman_aks74", "rhsgref_ins_g_rifleman_aksu", "rhssaf_army_m10_digital_rifleman_m21", "rhssaf_army_m10_digital_rifleman_m70"];

switch (str _location) do {
	case "sh1Spawn": {
		_spawnPoints resize ((count _spawnPoints) / 4);
		_players resize 4;
	};
	case "sh2Spawn": {
		_spawnPoints resize ((count _spawnPoints) / 4);
		_players resize 6;
	};
	case "sh3Spawn": {};
	case "pitSpawn";
	case "consulateSpawn": {
		_spawnPoints resize ((count _spawnPoints) / 5);
		_players resize 9;
	};
};

private _tgts = [];
for [{private _i = 0}, {_i < (count _spawnPoints)}, {_i = _i + 1}] do {_enemy createUnit [(_spawnPoints select _i), enemyGroup, _shootHouseMode + "_tgts pushBack this;", 0.4]};
{_x setPosATL getPosATL (_location)} forEach _players;

waitUntil {{alive _x} count _tgts == 0 || {_x inArea _trigger} count _players == 0 || {alive _x} count _players == 0};
{if (_x inArea t_SH1 || _x inArea t_Pit) then {
_x setPosATL (getPosATL startArea);
if (alive _x) then {
	[objNull, _x] call ace_medical_treatment_fnc_fullHeal;
} else {
	deleteVehicle _x;
};
}} forEach _players;
{deleteVehicle _x} forEach nearestObjects [(getPosATL (_location)), [_enemy], 100];

(str _location + " finished in " + ([time - _startTime] call Co2T_fnc_timeConvert) +".") remoteExec ["systemChat", 0];
_location setVariable ["inProgress", false, true];