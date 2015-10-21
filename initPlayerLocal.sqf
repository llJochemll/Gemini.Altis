/////////////////////////
//Script made by Jochem//
/////////////////////////
//intro text
_date = date;
_year = _date select 0;
_month = _date select 1;
_day = _date select 2;
_hour = _date select 3;
_minute = _date select 4;

_rank = rank player;
_name = name player;

_textDate = format["%3/%2/%1 - %4:%5",_year,_month,_day,_hour,_minute];
_textName = format["%1 %2",_rank,_name];
waitUntil {!isNull player};
waitUntil {player == player};

[
	[
		["Gemini","<t align = 'center' shadow = '1' size = '0.6'>%1</t><br/>"],
		[_textDate,"<t align = 'center' shadow = '1' size = '0.6'>%1</t><br/>"],
		[_textName,"<t align = 'center' shadow = '1' size = '0.6'>%1</t><br/>"],
        ["Molos airfield, NATO HQ","<t align = 'center' shadow = '1' size = '0.6'>%1</t><br/>"],
        [worldName,"<t align = 'center' shadow = '1' size = '0.6'>%1</t>",30]
	],
    1,
    1,
    "<t align = 'center' shadow = '1' size = '1.0'>%1</t>"
] spawn BIS_fnc_typeText;

[]spawn JOC_playerClick;
[]call JOC_garage;
["KeyDown", "_this call JOC_playerButton"] call CBA_fnc_addDisplayHandler;

//Ace interaction
viewDistanceI = ["ViewDistance","View distance","",{[]spawn CHVD_fnc_openDialog},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], viewDistanceI] call ace_interact_menu_fnc_addActionToObject;

gridMarkersI = ["gridMarkers","Show/hide grid markers","",{},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], gridMarkersI] call ace_interact_menu_fnc_addActionToObject;
