player setPosASL getPosASL respawn_obj;

zeusMod addCuratorEditableObjects [[player],false];
/*player addEventHandler ["fired", {
if((_this select 0) distance respawn_obj < 500)then{
	hint "Don't fire in base!";
	deleteVehicle (_this select 6);
};
}]; //Base protection*/
//[]spawn JOC_loadoutMaster;
[]spawn JOC_playerLoop;
[]spawn JOC_playerClick;
["KeyDown", "_this call JOC_playerButton"] call CBA_fnc_addDisplayHandler;
cduEnabled = false;