/* 	Author: Siege

	Description: Finds availabe spot for a vehicle to be spawned at.

	Parameters: NONE

	Returns:
	OBJECT - The first trigger that is empty.
*/
if (lbCurSel 2100 == 0) exitWith {};

private _type = param [0, "", ["rhsusf_m1025_d_s"]];
private _spawners = player getVariable "vehPoolTemp";

// systemChat format ["Spawners %1", _spawners];
private _veh = nil;

for [{private _i = 0}, {_i < (count _spawners)}, {_i = _i + 1}] do {
	if (triggerActivated (_spawners select _i)) exitWith {
		private _tempSpawner = (_spawners select _i);
		_veh = createVehicle [_type, _tempSpawner];
		_veh setPosASL getPosASL _tempSpawner;
		_veh setDir ((triggerArea _tempSpawner) select 2);
	};
};
if (isNil "_veh") then {systemChat "All spawnpoints are blocked!"};