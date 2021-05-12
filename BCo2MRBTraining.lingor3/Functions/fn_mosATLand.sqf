private _position = selectRandom [([logic_AT1, 0, 180, 0, 0, 0.3] call BIS_fnc_findSafePos), ([logic_AT2, 0, 150, 0, 0, 0.3] call BIS_fnc_findSafePos)];
private _target = selectRandom ["rhsgref_ins_uaz", "rhs_tigr_msv", "rhs_btr80a_msv", "rhs_bmd1k", "rhs_bmp2d_msv", "rhs_bmp2k_vdv", "rhs_t72bc_tv"];
private _players = nearestObjects [ATRange, ["Man"], 25];

private _vehicle = _target createVehicle _position;
private _smoke = "SmokeShellPurple" createVehicle _position;

format ["Target at %1 degrees.  Marked with purple smoke.", round (ATRange getDir _position)] remoteExec ["systemChat", _players];

waitUntil {!alive _vehicle};

["Target hit!"] remoteExec ["systemChat", _players];
sleep 1;
{deleteVehicle _x;} forEach [_vehicle, _smoke];