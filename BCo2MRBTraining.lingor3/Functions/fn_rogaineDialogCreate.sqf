/* Author: Siege
	Description: Creates the dialog to start rogaining.

	Parameters: N/A.
	Returns: N/A.
*/

createDialog "rogaine";

{
	private _tempIndex = lbAdd [2100, _x];
	lbSetData [2100, _tempIndex, _x];
} forEach ["Easy", "Medium", "Hard"];
lbSetCurSel [2100, 1];