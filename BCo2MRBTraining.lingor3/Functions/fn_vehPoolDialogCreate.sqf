params [
	["_spawnPoints", [], [[t_infBaseSpawn1], landVehicles]],
	["_dropdownChoices", [], [landVehicles]]
];
player setVariable ["vehPoolTemp", _spawnPoints, true];

createDialog "vehPool";
lbAdd [2100, "SELECT VEHICLE"];
{
	_tempIndex = lbAdd [2100, _x select 0];
	lbSetData [2100, _tempIndex, _x select 1];
} forEach _dropdownChoices;
lbSetCurSel [2100, 0];