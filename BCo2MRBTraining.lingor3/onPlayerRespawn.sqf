if !(player getVariable ["playredIntro", false]) then {
	[] spawn {
		ace_hearing_disableVolumeUpdate = true;
		waitUntil {alive player};
		// sleep 6;
		player setPos [2719.993, 6867.530, 0];
		player setDir 260.598;
		[0, 0, false] spawn BIS_fnc_cinemaBorder;
		playMusic "LeadTrack01_F_EPA";
		0 fadeMusic 1;
		private _musicEH = addMusicEventHandler ["MusicStop", {
			removeMusicEventHandler ["MusicStop", player getVariable "musicEH"];
			ace_hearing_disableVolumeUpdate = false;
		}];
		player setVariable ["musicEH", _musicEH];
		endLoadingScreen;

		player switchMove "Acts_PercMwlkSlowWrflDf2";
		
		// ["<img image='images\insignia.paa'/>",-1,-1,999,2,0,789] spawn BIS_fnc_dynamicText;
		sleep 2;

		date params ["_year", "_month", "_day", "_hours", "_minutes"];
		_month = str _month;
		if (count _month < 2) then {
			_month = "0" + _month;
		};
		_day = str _day;
		if (count _day < 2) then {
			_day = "0" + _day;
		};
		_hours = str _hours;
		if (count _hours < 2) then {
			_hours = "0" + _hours;
		};
		_minutes = str _minutes;
		if (count _minutes < 2) then {
			_minutes = "0" + _minutes;
		};
		private _timeString = (str _year + "-" + _month + "-" + _day + " " + _hours + ":" + _minutes);

		[ 
			[
				[_timeString, "align = 'right' size='1.0'"],
				["", "<br/>"],
				["Airbase Requiem", "align = 'right' size='1.0'"],
				["", "<br/>"],
				["Lingor", "align = 'right' size='1.0'"]
			], 
			safeZoneX - 0.01, 
			safeZoneY + 0.875 * safeZoneH,
			true
		] spawn BIS_fnc_typeText2;

		waitUntil {player inArea t_walkInStop};
		// ["<img image='images\insignia.paa'/>",-1,-1,0,0,0,789] spawn BIS_fnc_dynamicText;
		[1, nil, false] spawn BIS_fnc_cinemaBorder;
		showHUD true; // turns off fake cinema borders
		player switchMove "AmovPercMstpSlowWrflDnon";
		player setVariable ["playredIntro", true];
		sleep 1;
		5 fadeMusic 0.25;
	};
} else {
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
};