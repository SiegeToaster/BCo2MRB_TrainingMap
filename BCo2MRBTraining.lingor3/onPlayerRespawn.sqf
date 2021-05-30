//Save loadout on death
private _loadout = player getVariable ["loadout", nil];
if (!isNil "_loadout") then {
	removeAllWeapons player;
	removeGoggles player;
	removeHeadgear player;
	removeVest player;
	removeUniform player;
	removeAllAssignedItems player;
	clearAllItemsFromBackpack player;
	removeBackpack player;
	player setUnitLoadout (player getVariable "loadout");
};