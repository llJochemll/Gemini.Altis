/////////////////////////
//Script made by Jochem//
/////////////////////////
//Parameters *FREE TO EDIT*
//Classnames
infantryPool = ["O_Soldier_SL_F","O_soldier_AR_F","O_soldier_AR_F","O_soldier_exp_F","O_soldier_GL_F","O_soldier_GL_F","O_soldier_M_F","O_medic_F","O_soldier_AA_F","O_soldier_repair_F","O_Soldier_F","O_Soldier_F","O_soldier_LAT_F","O_soldier_LAT_F","O_soldier_lite_F","O_soldier_TL_F","O_soldier_TL_F"];    //infantry classnames
sfPool       = [];
carPool      = ["O_Heli_Attack_02_black_F","O_Heli_Attack_02_F"];        //car classnames
truckPool    = ["O_Truck_02_covered_F","O_Truck_02_transport_F"];        //truck classnames
apcPool      = ["O_APC_Wheeled_02_rcws_F"];       //apc classnames
ifvPool      = ["O_APC_Tracked_02_cannon_F"];       //ifv classnames
tankPool     = ["O_MBT_02_cannon_F"];       //tank classnames
supportPool  = ["O_Truck_02_ammo_F","O_Truck_02_fuel_F"];     //support classnames
airPool      = ["O_Heli_Light_02_F","O_Heli_Light_02_unarmed_F"];     //transport helicopter classnames
casPool      = ["O_Heli_Attack_02_black_F","O_Heli_Attack_02_F"];      //cas helicopters classnames
jetPool      = ["O_Plane_CAS_02_F"];       //jet classnames
//Markers
blackTowns = ["Sagonisi"];  //Blacklist towns
blackMarkers = ["mrk_safeZone"];
airfieldMarkers = ["mrk_airfield_0","mrk_airfield_1","mrk_airfield_2","mrk_airfield_3"];   //Markers for airfields

"mrk_area" setMarkerPos [worldSize/2,worldSize/2];
"mrk_area" setMarkerSize [worldSize/2,worldSize/2];
"mrk_area" setMarkerAlpha 0;

//Objects
leaderArray = [cmd1,cmd2,a0_1,b0_1,c0_1,h1,r1,anv1,s1,v1,rip1];
logisticsArray = ["l1","l2","l3","l4"];
logisticsVehArray = ["B_APC_Tracked_01_CRV_F"];
motorizedArray = ["rhsusf_m113_usarmy","RHS_M2A3_BUSKIII_wd","RHS_M6_wd"];
medicalVehArray = ["RHS_UH60M_MEV"];
jetArray = [];

//Init variables *DONT CHANGE*
//[towns,bases,airfields,grids]
opMarkers = [[],[],[],[]];
bluMarkers = [[],[],[],[]];

strategicArray = [];

activeTasks = [];
fobTrucks = [];
baseObjects = nearestObjects [(getMarkerPos "mrk_safeZone"), ["All"], 1200];
eastHQ = createCenter east;

//Script vars
CHVD_allowNoGrass = false; // Set 'false' if you want to disable "Low" option for terrain (default: true)
CHVD_maxView = 12000; // Set maximum view distance (default: 12000)
CHVD_maxObj = 12000; // Set maximimum object view distance (default: 12000)

//Public var for local scripts
publicVariable "logisticsArray";
publicVariable "baseObjects";
publicVariable "fobTrucks";
publicVariable "airfieldMarkers";

//Run init scripts
//spawn -needs a seperate thread to work
/*[]spawn JOC_fobManager;
[]spawn JOC_bftManager;
[]spawn JOC_aiManager;
[]spawn JOC_perfLoop;*/
