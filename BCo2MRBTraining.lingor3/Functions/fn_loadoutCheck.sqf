/* Author: Siege
	Description: Checks loadout for earplugs and saves loadout if a custom one is not saved.

	Params:
		0: OBJECT - The player that is being checked.
	Returns: N/A.
*/

params [
	["_player", objNull, [objNull]]
];

if (({_x == "ACE_EarPlugs"} count items _player) < 1) then {
	systemChat "You don't have any earplugs in your inventory!";
};

if !(_player getVariable "customLoadout") then {
	_player setVariable ["loadout", getUnitLoadout _player];
	systemChat "Loadout Saved!";
};