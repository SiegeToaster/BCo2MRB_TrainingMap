/* Author: Siege
	Description: Determines if a point is visible from another point.

	Parameters:
		0: Player - OBJECT.  The player.
		1: Target - OBJECT.  The object that is being tested.

	Returns:
*/

params [
	["_player", objNull, [objNull]],
	["_target", objNull, [objNull]]
];

(count (lineIntersectsSurfaces [
	(AGLtoASL (_player modelToWorldVisual (_player selectionPosition "pilot"))),
	getPosASL _target,
	_target,
	_player,
	true,
	1,
	"GEOM",
	"NONE"
]) > 0)