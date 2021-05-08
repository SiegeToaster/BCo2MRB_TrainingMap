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