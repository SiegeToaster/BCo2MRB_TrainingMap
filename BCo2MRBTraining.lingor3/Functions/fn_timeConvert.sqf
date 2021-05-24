/* Author: Siege
	Description: Converts seconds minutes and seconds.

	Parameters:
		0: number.  The seconds.

	Return:
		Minutes and seconds.
*/

params [["_seconds", 0, [1.1]]];
private _decimals = floor ((_seconds % 1) * 100);
private _minutes = floor (_seconds / 60);
_seconds = (round _seconds) % 60;

([_minutes, " minutes and ", _seconds, ".", _decimals, " seconds"] joinString "");