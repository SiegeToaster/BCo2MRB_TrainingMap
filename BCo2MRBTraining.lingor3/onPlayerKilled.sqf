//Saves loadout
if !(player getVariable "customLoadout") then {
	player setVariable ["loadout", getUnitLoadout player];
};