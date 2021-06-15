/* Author: Siege
	Description: manages the shooting range.

	Parameters:
		0: NUMBER or STRING.  The number/string of the layer.
		1: OBJECT.  The logic correlating to the layer.
		2: NUMBER.  The target distance.
	Return: N/A
*/

params ["_layer", "_logic", "_distance"];
private _moveDistance = _distance - (_logic getVariable "distancePosition");

{
	private _pos = getPosATL _x;
	_pos set [0, (_pos select 0) + _moveDistance];
	_x setPosATL _pos;
} forEach ((getMissionLayerEntities _layer) select 0);

_logic setVariable ["distancePosition", _distance, true];