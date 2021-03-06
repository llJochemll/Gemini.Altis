/////////////////////////
//Script made by Jochem//
/////////////////////////
params["_crate"];

if (_crate inArea "mrk_safeZone") exitWith {hint "Can't build in base area";};

_orgCurator = getAssignedCuratorLogic player;
//if (!isNull _orgCurator) exitWith {hint "Logout as admin/zeus";};

[[_crate,player],{
    params["_crate","_player"];

    //Remove current curator
    unassignCurator (getAssignedCuratorLogic _player);

    //Create curator
    _curatorGroup = creategroup sideLogic;
    _curator = _curatorGroup createUnit ["ModuleCurator_F",[0,90,90],[],0.5,"NONE"];
    _curator addCuratorEditingArea [0,getPos _crate,100];
    _curator setCuratorEditingAreaType true;
    _curator addCuratorCameraArea [0,getPos _crate,100];
    removeAllCuratorAddons _curator;
    _curator addCuratorAddons ["A3_Structures_F_Mil_BagBunker","A3_Structures_F_Mil_BagFence","A3_Structures_F_Mil_Bunker","A3_Structures_F_Mil_Cargo","A3_Structures_F_Mil_Fortification","A3_Structures_F_Mil_Helipads","A3_Structures_F_Mil_Shelters","rhsusf_c_statics"];
    _player assignCurator _curator;

    {
        _x hideObject true;
    } forEach (allUnits select {side _x == east});
    {
        _x hideObject true;
    } forEach (vehicles select {side _x == east});
}] remoteExecCall ["BIS_fnc_call",2];

waitUntil{sleep 1; !isNull(getAssignedCuratorLogic player)};

(getAssignedCuratorLogic player) addEventHandler ["CuratorObjectPlaced",{
    [[(_this select 1)],{
    	params["_object"];
    	if (count buildObjects <= 1000) then {
    	    buildObjects pushBack _object;
    	} else {
    	    deleteVehicle _object;
        };
    }] remoteExecCall ["BIS_fnc_call",2];
}];

openCuratorInterface;
waitUntil{sleep 1; isNull curatorCamera || player distance2D _crate > 7};

[[(getAssignedCuratorLogic player),_orgCurator],{
    params["_curator","_orgCurator"];
    unassignCurator _curator;
    objNull assignCurator _curator;
    deleteVehicle _curator;
    player assignCurator _orgCurator;

    {
        _x hideObject false;
    } forEach allUnits;
    {
        _x hideObject false;
    } forEach vehicles;
}] remoteExecCall ["BIS_fnc_call",2];
