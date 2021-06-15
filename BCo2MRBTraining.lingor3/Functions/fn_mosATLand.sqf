/* Author: Siege
	Description: Spawns a random vehicle at a random point on the AT range.  Smoke will be spawned if designated, maximum range is also able to be designated.

	Parameters: N/A.
	Returns: N/A.
*/

private _position = [0, 0, 0];
private _target = selectRandom ["rhsgref_ins_uaz", "rhs_tigr_msv", "rhs_btr80a_msv", "rhs_bmd1k", "rhs_bmp2d_msv", "rhs_bmp2k_vdv", "rhs_t72bc_tv"];
private _players = nearestObjects [MOS_ATRangeInteract, ["Man"], 25];
private _vehicle = objNull;
private _smoke = objNull;
private _distance = ATLandDistance;

while {([nearestObject [MOS_ATRangeInteract, "Man"], _vehicle] call Co2T_fnc_isVisible) || ((nearestObject [MOS_ATRangeInteract, "Man"] distance _vehicle) > _distance)} do {
	deleteVehicle _vehicle;
	private _pos = selectRandom [[logic_AT1, 0, 350, 0, 0, 0.3], [logic_AT2, 0, 300, 0, 0, 0.3]];
	_position = (_pos call BIS_fnc_findSafePos);
	_vehicle = "Land_Wreck_Car_F" createVehicle _position;
};
deleteVehicle _vehicle;

_vehicle = _target createVehicle _position;
waitUntil {alive _vehicle};

if (MOS_ATRangeInteract getVariable "enableSmoke") then {
	_smoke = "SmokeShellPurple" createVehicle _position;
	format ["Target at %1 degrees.  Marked with purple smoke.", round (MOS_ATRangeInteract getDir _position)] remoteExec ["systemChat", _players];
} else {
	format ["Target at %1 degrees.", round (MOS_ATRangeInteract getDir _position)] remoteExec ["systemChat", _players];
};

waitUntil {!alive _vehicle};
["Target hit!"] remoteExec ["systemChat", _players];
sleep 1;
{deleteVehicle _x;} forEach [_vehicle, _smoke];