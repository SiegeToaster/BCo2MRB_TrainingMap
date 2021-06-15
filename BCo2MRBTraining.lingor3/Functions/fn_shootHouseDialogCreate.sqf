/* Author: Siege
	Description: Creates the dialog to start shoot houses.

	Parameters: N/A.
	Returns: N/A.
*/

createDialog "shootHouse";

{

	if !((missionNamespace getVariable (_x select 1)) getVariable "inProgress") then {
		private _tempIndex = lbAdd [2100, _x select 0];
		lbSetData [2100, _tempIndex, _x select 1];
	};
} forEach [["Shoot House 1", "sh1Spawn"], ["Shoot House 2", "sh2Spawn"], ["Shoot House 3", "sh3Spawn"], ["The Pit", "pitSpawn"]];
lbSetCurSel [2100, 0];
{
	private _tempIndex = lbAdd [2101, _x];
	lbSetData [2101, _tempIndex, _x];
} forEach ["Easy", "Medium", "Hard"];
lbSetCurSel [2101, 1];

((findDisplay 1112) displayCtrl 2800) cbSetChecked true;