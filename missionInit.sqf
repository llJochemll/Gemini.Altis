/////////////////////////
//Script made by Jochem//
/////////////////////////

//Note to user:
//This is the only file in the mission meant to be edited, also the only one containing good commenting on user variables.
//Do not edit below 'do not edit' mark or an other file in this mission without knowledge of ArmA SQF scripting.

//Parameters *FREE TO EDIT*
//Classnames
infantryPool = ["rhs_vdv_rifleman","rhs_vdv_efreitor","rhs_vdv_engineer","rhs_vdv_grenadier","rhs_vdv_at","rhs_vdv_aa","rhs_vdv_strelok_rpg_assist","rhs_vdv_junior_sergeant","rhs_vdv_machinegunner","rhs_vdv_machinegunner_assistant","rhs_vdv_marksman","rhs_vdv_medic","rhs_vdv_LAT","rhs_vdv_RShG2","rhs_vdv_sergeant"];    //infantry classnames
sfPool       = []; //currently not in use, do to RHS not having any Russian SF
carPool      = ["rhs_tigr_m_vdv","rhs_tigr_sts_vdv","rhs_tigr_vdv"];        //car classnames
truckPool    = ["RHS_Ural_VDV_01","RHS_Ural_Open_VDV_01"];        //truck classnames
apcPool      = ["rhs_btr80a_vdv","rhs_btr80_vdv"];       //apc classnames
ifvPool      = ["rhs_bmd4ma_vdv","rhs_bmd4_vdv","rhs_bmp2k_vdv"];       //ifv classnames
tankPool     = ["rhs_t90a_tv","rhs_t80ue1"];       //tank classnames
supportPool  = ["RHS_Ural_Fuel_VDV_01","rhs_gaz66_ammo_vdv"];     //support classnames
airPool      = ["RHS_Mi8AMT_vdv","RHS_Mi8mt_Cargo_vdv","RHS_Mi8MTV3_vdv"];     //transport helicopter classnames
casPool      = ["RHS_Mi24V_vdv","RHS_Ka52_vvs"];      //cas helicopters classnames
jetPoolAG    = ["RHS_Su25SM_KH29_vvs"];       //jet classnames (anti-ground)
jetPoolAA    = ["RHS_T50_vvs_blueonblue"];       //jet classnames (anti-air)
crewClass    = "rhs_vdv_combatcrew";    //Crewman classname
pilotClass   = "rhs_pilot";   //Pilot classname
artyClass    = "rhs_2s3_tv";    //Arty classname
aaClass      = "rhs_zsu234_aa"; //AA classname
fobClass     = "rhsusf_M1083A1P2_B_M2_d_MHQ_fmtv_usarmy"; //Fob classname
emptyClass   = "Land_Airport_center_F";  //Large object, don't change or delete

//Markers
blackTowns = ["Sagonisi"];  //Blacklist towns to not get any strategic value
blackMarkers = ["mrk_safeZone"];    //Markers enemies will not spawn in nor patrol
airfieldMarkers = ["mrk_airfield_0","mrk_airfield_1","mrk_airfield_2","mrk_airfield_3"];   //Markers for airfields

//Objects
leaderArray = ["cmd1","cmd2","a0_1","b0_1","c0_1","h1","r1","anv1","s1","v1","rip1"]; //All leading elements, this is also used for chain of command
arsenalBoxes = [arsenal1,arsenal2];    //All pre-placed boxes that need to be a virtual arsenal
logisticsArray = ["l1","l2","l3","l4"]; //All units that will be able to use the building crate
logisticsVehArray = ["B_APC_Tracked_01_CRV_F"]; //All vehicles that can tow (might be broken atm, do not expect this to work properly)
motorizedArray = [];    //All vehicles that are classed as motorized, mainly for proper display on BFT (will otherwised be displayed as tanks)
medicalVehArray = [];   //All medical vehicles, mainly for proper display on BFT (will otherwise be displayed as their vehicle type, i.e. car)

//Variables
bftEnable = false;  //Enable blue force tracking (is currently being reworked, recommend disable, might still work)
bftRefresh = 0.3;  //Refresh rate for blue force tracking (in seconds)
fobLimit = 5;   //Max number of FOB trucks active
radarRange = 6000;  //Max range of radars, after this distance radars won't chack for targets (currently ignored, might be added back)
CHVD_allowNoGrass = false; // Set 'false' if you want to disable "Low" option for terrain (default: true)
CHVD_maxView = 12000; // Set maximum view distance (default: 12000)
CHVD_maxObj = 12000; // Set maximimum object view distance (default: 12000)

//////DO NOT EDIT//////

//Create marker used by position generation
"mrk_area" setMarkerPos [worldSize/2,worldSize/2];
"mrk_area" setMarkerSize [worldSize/2,worldSize/2];
"mrk_area" setMarkerAlpha 0;

//Vars needed by scripts
jetTargets = [];
heliTargets = [];
activeTasks = [];   //Not being used
fobTrucks = [];
vehArray = [];
radars = [];
jetActive = false;
saveCount = 0;

//Public var for local scripts
publicVariable "logisticsArray";
publicVariable "logisticsVehArray";
publicVariable "editorObjects";
publicVariable "airfieldMarkers";
publicVariable "arsenalBoxes";
publicVariable "CHVD_allowNoGrass";
publicVariable "CHVD_maxView";
publicVariable "CHVD_maxObj";

//Init caching vars
JOC_pauseCache = false;
cacheGroup = createGroup east;
cacheGroupLeader = cacheGroup createUnit ["O_soldier_F", [0,0,0], [], 0, "NONE"];
cacheGroupLeader allowDamage false;
cacheGroupLeader enableSimulation false;
cacheGroupLeader hideObjectGlobal true;
placeHolderGroupWest = createGroup west;
placeHolderGroupWestLeader = cacheGroup createUnit ["B_soldier_F", [0,0,0], [], 0, "NONE"];
placeHolderGroupWestLeader allowDamage false;
placeHolderGroupWestLeader enableSimulation false;
placeHolderGroupWestLeader hideObjectGlobal true;
cachedArray = [];

//Get a list of all objects placed in editor
objectsStart = nearestObjects [[worldSize/2,worldSize/2], ["all"], (worldSize*2^0.5)];

//Read database
_inidbi = 0;
_dbSaved = false;
if(typeName (["read", ["header", "saved",false]] call inidbiDB1))then{
    _inidbi = inidbiDB1;
    _dbSaved = true;
};
if(typeName (["read", ["header", "saved",false]] call inidbiDB2))then{
    _inidbi = inidbiDB2;
    _dbSaved = true;
};

if(_dbSaved)then{
    _index = 0;

    //Get strategic array
    //Get virtualized array
    while{typeName (["read", ["main", format["virtualizedArray_%1",_index],0]] call _inidbi) != typeName 0}do{
        strategicArray = strategicArray + [(["read", ["main", format["strategicArray_%1",_index]]] call _inidbi)];
        _index = _index + 1;
    };

    {
        _name = (_x select 0);
        _marker = createMarker [_nameM, (_x select 1)];
        _name setMarkerShape (_x select 2);
        _name setMarkerSize (_x select 3);
        _nameM setMarkerBrush (_x select 4);
        _name setMarkerColor (_x select 5);
        _x set [_x,_name];
    } forEach strategicArray;

    //Get virtualized array
    while{typeName (["read", ["main", format["virtualizedArray_%1",_index],0]] call _inidbi) != typeName 0}do{
        virtualizedArray pushBack [(["read", ["main", format["virtualizedArray_%1",_index]]] call _inidbi)];
        _index = _index + 1;
    };

    //Object damage
    _damageValues = [];
    while{typeName (["read", ["main", format["damageValues_%1",_index],0]] call _inidbi) != typeName 0}do{
        _damageValues pushBack [(["read", ["main", format["damageValues_%1",_index]]] call _inidbi)];
        _index = _index + 1;
    };
    {
        _x setDamage (_damageValues select _forEachIndex);
    } forEach objectsStart;

    //Objects spawned on mission load
    _objectsAdded = [];
    while{typeName (["read", ["main", format["objectsAdded_%1",_index],0]] call _inidbi) != typeName 0}do{
        _objectsAdded pushBack [(["read", ["main", format["objectsAdded_%1",_index]]] call _inidbi)];
        _index = _index + 1;
    };
    {
        _object = (_x select 0) createVehicle (_x select 1);
        _object setPosWorld (_x select 1);
        _object setDir (_x select 2);
    } forEach _objectsAdded;

    //get fobs and deploy them if applicable
    _fobArray = ["read", ["main", "fobArray"]] call _inidbi;
    {
        _truck = fobClass createVehicle (_x select 0);
        _truck setPosWorld (_x select 0);
        _truck setDir (_x select 1);
        [_truck]call JOC_fobInit;
        fobTrucks pushBack _truck;

        if(_x select 2)then{
            [_truck]call JOC_fobDeploy;
        };
    } forEach _fobArray;
}else{
    strategicArray = [];
    virtualizedArray = [];

    []call JOC_cmdCreateLocations;

    [[],{
        progressLoadingScreen 0.3;
    }] remoteExec ["BIS_fnc_spawn", 0, true];

    []call JOC_cmdCreateEnemy;

    {
        ["write", ["main", format["objectsAdded_%1",_forEachIndex], [typeOf _x, getPosWorld _x, getDir _x]]] call _inidbi;
    } forEach ((nearestObjects [[worldSize/2,worldSize/2], ["all"], (worldSize*2^0.5)]) - objectsStart);

};

//End loading screen
[[],{
    endLoadingScreen;
    JOC_serverLoaded = true;
    if(!isServer)then{
        waitUntil{!isNil{JOC_playerInit}};
        []spawn JOC_playerInit;
    };
}] remoteExec ["BIS_fnc_spawn", 0, true];;

[]call JOC_initPlayerBase;
[]call JOC_initDepot;


//EXP, should give better performance
[JOC_aiManager, 3, []] call CBA_fnc_addPerFrameHandler;
[JOC_perfLoop, 30, []] call CBA_fnc_addPerFrameHandler;
[JOC_vehRespawn, 60, []] call CBA_fnc_addPerFrameHandler;
[JOC_saveMission, 600, []] call CBA_fnc_addPerFrameHandler;
//[JOC_bftManager, bftRefresh, []] call CBA_fnc_addPerFrameHandler;
