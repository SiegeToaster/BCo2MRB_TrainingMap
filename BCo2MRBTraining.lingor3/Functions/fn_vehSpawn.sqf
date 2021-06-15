/* 	Author: Siege

	Description: Finds availabe spot for a vehicle to be spawned at.

	Parameters: N/A.
	Returns: OBJECT - The first trigger that is empty.
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
		if (_type == "rhsusf_m1165a1_gmv_m134d_m240_socom_d" || _type == "rhsusf_m1165a1_gmv_m2_m240_socom_d" || _type == "rhsusf_m1165a1_gmv_mk19_m240_socom_d") then {
			[_veh, ["rhs_sofwoodland", 1]] call BIS_fnc_initVehicle;
		} else {
			if (_type == "rhsusf_mrzr4_d" || _type == "I_C_Offroad_02_unarmed_F" || _type == "I_C_Offroad_02_LMG_F" || _type == "I_C_Offroad_02_AT_F") then {
				[_veh, ["Olive",1]] call BIS_fnc_initVehicle;
			};
		};
		_veh setPosASL getPosASL _tempSpawner;
		_veh setDir ((triggerArea _tempSpawner) select 2);		
	};
};
if (isNil "_veh") then {systemChat "All spawnpoints are blocked!"};