/* Author: Siege
	Description: Creates the dialog for the vehicle pool.

	Parameters:
		0: ARRAY of OBJECTS, OBJECT - The spawnpoints for the vehicles.
		1: VARIABLE - Should be a variable for an array with format: [["Display Name", "className"], ["DisplayName2", "className2"]].
	Returns: N/A.
*/

params [
	["_spawnPoints", [], [[t_infBaseSpawn1], landVehicles]],
	["_dropdownChoices", [], [landVehicles]]
];
player setVariable ["vehPoolTemp", _spawnPoints, true];

createDialog "vehPool";
lbAdd [2100, "SELECT VEHICLE"];
{
	private _tempIndex = lbAdd [2100, _x select 0];
	lbSetData [2100, _tempIndex, _x select 1];
} forEach _dropdownChoices;
lbSetCurSel [2100, 0];