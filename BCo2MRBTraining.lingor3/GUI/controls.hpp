class vehPool
{
	idd = 1111;

	class controls
	{
		class vehPoolBackground: RscPicture
		{
			idc = 1200;
			text = "#(argb,8,8,3)color(0,0,0,0.5)";
			x = 0.365937 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 0.268125 * safezoneW;
			h = 0.242 * safezoneH;
		};
		class vehPoolTitle: RscPicture
		{
			idc = 1201;
			text = "#(argb,8,8,3)color(0.77,0.51,0.08,0.5)";
			x = 0.365937 * safezoneW + safezoneX;
			y = 0.368 * safezoneH + safezoneY;
			w = 0.268125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class vehPoolTitleText: RscText
		{
			idc = 1000;
			text = "Vehicle Pool"; //--- ToDo: Localize;
			x = 0.365937 * safezoneW + safezoneX;
			y = 0.368 * safezoneH + safezoneY;
			w = 0.257813 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class vehPoolSelectionText: RscText
		{
			idc = 1001;
			text = "Vehicle Selector"; //--- ToDo: Localize;
			x = 0.381406 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.237187 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class vehPoolSelection: RscCombo
		{
			idc = 2100;
			// _ctrl = (findDisplay 1111) displayCtrl 2100;
			x = 0.381406 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.237187 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class vehPoolCustomText: RscText
		{
			idc = 1002;
			text = "Custom Input (class name)"; //--- ToDo: Localize;
			x = 0.381406 * safezoneW + safezoneX;
			y = 0.522 * safezoneH + safezoneY;
			w = 0.237187 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class vehPoolCustom: RscEdit
		{
			idc = 1400;
			// _ctrl = (findDisplay 1111) displayCtrl 1400;
			x = 0.381406 * safezoneW + safezoneX;
			y = 0.555 * safezoneH + safezoneY;
			w = 0.237187 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class vehPoolPresetSelect: RscButton
		{
			idc = 1600;
			action = "[lbData [2100, lbCurSel 2100]] call Co2T_fnc_vehSpawn;";
			x = 0.561875 * safezoneW + safezoneX;
			y = 0.489 * safezoneH + safezoneY;
			w = 0.0567187 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class vehPoolCustomSelect: RscButton
		{
			idc = 1601;
			action = "[ctrlText 1003] call Co2T_fnc_vehSpawn;";
			x = 0.561875 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.0567187 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class vehPoolCustomSelectText: RscText
		{
			idc = 1003;
			text = "SPAWN"; //--- ToDo: Localize;
			x = 0.561875 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class vehPoolPresetSelectText: RscText
		{
			idc = 1004;
			text = "SPAWN"; //--- ToDo: Localize;
			x = 0.561875 * safezoneW + safezoneX;
			y = 0.489 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class vehPoolCancel: RscButtonMenu
		{
			idc = 2400;
			text = "CANCEL"; //--- ToDo: Localize;
			action = "closeDialog 2";
			x = 0.365937 * safezoneW + safezoneX;
			y = 0.654 * safezoneH + safezoneY;
			w = 0.0670312 * safezoneW;
			h = 0.022 * safezoneH;
		};
	};
};

class shootHouse
{
	idd = 1112;
	
	class controls
	{
		class shootHouseBackground: RscPicture
		{
			idc = 1200;

			text = "#(argb,8,8,3)color(0,0,0,0.5)";
			x = 0.386562 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 0.226875 * safezoneW;
			h = 0.22 * safezoneH;
		};
		class shootHouseTitle: RscPicture
		{
			idc = 1201;

			text = "#(argb,8,8,3)color(0.77,0.51,0.08,0.5)";
			x = 0.386562 * safezoneW + safezoneX;
			y = 0.368 * safezoneH + safezoneY;
			w = 0.226875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class shootHouseTitleText: RscText
		{
			idc = 1000;

			text = "Shoot House Start"; //--- ToDo: Localize;
			x = 0.386562 * safezoneW + safezoneX;
			y = 0.368 * safezoneH + safezoneY;
			w = 0.221719 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class shootHouseSelectorText: RscText
		{
			idc = 1001;

			text = "Shoot House"; //--- ToDo: Localize;
			x = 0.396875 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.20625 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class shootHouseSelector: RscCombo
		{
			idc = 2100;

			x = 0.396875 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.20625 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class shootHouseDifficultyText: RscText
		{
			idc = 1002;

			text = "Difficulty"; //--- ToDo: Localize;
			x = 0.396875 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.20625 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class shootHouseDifficulty: RscCombo
		{
			idc = 2101;

			x = 0.396875 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.20625 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class shootHouseResponsiveEnemiesText: RscText
		{
			idc = 1003;

			text = "Responsive Enemies"; //--- ToDo: Localize;
			x = 0.396875 * safezoneW + safezoneX;
			y = 0.577 * safezoneH + safezoneY;
			w = 0.20625 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class shootHouseResponsiveEnemies: RscCheckbox
		{
			idc = 2800;
			// _ctrl = (findDisplay 1112) displayCtrl 2800;
			x = 0.587656 * safezoneW + safezoneX;
			y = 0.577 * safezoneH + safezoneY;
			w = 0.0154688 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class shootHouseCancel: RscButtonMenu
		{
			idc = 2400;
			action = "closeDialog 2";
			text = "CANCEL"; //--- ToDo: Localize;
			x = 0.386562 * safezoneW + safezoneX;
			y = 0.632 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class shootHouseStartButton: RscButton
		{
			idc = 1600;
			action = "[(missionNamespace getVariable (lbData [2100, lbCurSel 2100])), lbData [2101, lbCurSel 2101], cbChecked ((findDisplay 1112) displayCtrl 2800)] remoteExec ['Co2T_fnc_shootHouse', 2]; closeDialog 2;";
			x = 0.551562 * safezoneW + safezoneX;
			y = 0.632 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class shootHouseStartButtonText: RscText
		{
			idc = 1004;
			text = "START"; //--- ToDo: Localize;
			x = 0.551562 * safezoneW + safezoneX;
			y = 0.632 * safezoneH + safezoneY;
			w = 0.0567187 * safezoneW;
			h = 0.022 * safezoneH;
		};
	};
};

class rogaine
{
	idd = 1113;

	class controls
	{
		class rogaineBackground: RscPicture
		{
			idc = 1200;
			text = "#(argb,8,8,3)color(0,0,0,0.5)";
			x = 0.386562 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 0.226875 * safezoneW;
			h = 0.209 * safezoneH;
		};
		class rogaineTitle: RscPicture
		{
			idc = 1201;
			text = "#(argb,8,8,3)color(0.77,0.51,0.08,0.5)";
			x = 0.386562 * safezoneW + safezoneX;
			y = 0.368 * safezoneH + safezoneY;
			w = 0.226875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class rogaineTitleText: RscText
		{
			idc = 1000;
			text = "Start Rogaining"; //--- ToDo: Localize;
			x = 0.386562 * safezoneW + safezoneX;
			y = 0.368 * safezoneH + safezoneY;
			w = 0.221719 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class rogaineDifficultyText: RscText
		{
			idc = 1001;
			text = "Difficulty"; //--- ToDo: Localize;
			x = 0.396875 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.20625 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class rogaineAmountText: RscText
		{
			idc = 1002;
			text = "Number of Checkpoints"; //--- ToDo: Localize;
			x = 0.396875 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.20625 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class rogaineDifficulty: RscCombo
		{
			idc = 2100;
			x = 0.396875 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.20625 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class rogaineAmount: RscEdit
		{
			idc = 1400;
			// _ctrl = (findDisplay 1113) displayCtrl 1400;
			x = 0.402031 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.201094 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class rogaineWarnMessage: RscStructuredText
		{
			idc = 1100;
			x = 0.402031 * safezoneW + safezoneX;
			y = 0.577 * safezoneH + safezoneY;
			w = 0.201094 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {-1,-1,-1,0};
			colorActive[] = {-1,-1,-1,0};
		};
		class rogaineCancel: RscButtonMenu
		{
			idc = 2400;
			action = "closeDialog 2";
			text = "CANCEL"; //--- ToDo: Localize;
			x = 0.386562 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class rogaineStart: RscButton
		{
			idc = 1600;
			action = "[lbData [2100, lbCurSel 2100], parseNumber (ctrlText ((findDisplay 1113) displayCtrl 1400))] remoteExec ['Co2T_fnc_rogaining', 2]; closeDialog 2";
			x = 0.551562 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class rogaineStartText: RscText
		{
			idc = 1003;
			text = "START"; //--- ToDo: Localize;
			x = 0.551562 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.0567187 * safezoneW;
			h = 0.022 * safezoneH;
		};
	};
};