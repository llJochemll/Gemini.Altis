/////////////////////////
//Script made by Jochem//
/////////////////////////
//Attack


//Command
JOC_cmdCmdLoop = compileFinal preprocessFileLineNumbers "Functions\Commander\Command\loop.sqf";
JOC_cmdCmdreqSupport = compileFinal preprocessFileLineNumbers "Functions\Commander\Command\reqSupport.sqf";
JOC_cmdCmdRequest = compileFinal preprocessFileLineNumbers "Functions\Commander\Command\request.sqf";

//Defend
JOC_cmdDefConvoy = compileFinal preprocessFileLineNumbers "Functions\Commander\Defend\convoy.sqf";
JOC_cmdDefHeli = compileFinal preprocessFileLineNumbers "Functions\Commander\Defend\heli.sqf";
JOC_cmdDefNear = compileFinal preprocessFileLineNumbers "Functions\Commander\Defend\near.sqf";
JOC_cmdDefRetreat = compileFinal preprocessFileLineNumbers "Functions\Commander\Defend\retreat.sqf";

//Init
JOC_cmdInitAA = compileFinal preprocessFileLineNumbers "Functions\Commander\Init\aa.sqf";
JOC_cmdInitAirfield = compileFinal preprocessFileLineNumbers "Functions\Commander\Init\airfield.sqf";
JOC_cmdInitArty = compileFinal preprocessFileLineNumbers "Functions\Commander\Init\arty.sqf";
JOC_cmdInitBase = compileFinal preprocessFileLineNumbers "Functions\Commander\Init\base.sqf";
JOC_cmdInitCamp = compileFinal preprocessFileLineNumbers "Functions\Commander\Init\camp.sqf";
JOC_cmdInitFactory = compileFinal preprocessFileLineNumbers "Functions\Commander\Init\factory.sqf";
JOC_cmdInitMine = compileFinal preprocessFileLineNumbers "Functions\Commander\Init\mine.sqf";
JOC_cmdInitRadio = compileFinal preprocessFileLineNumbers "Functions\Commander\Init\radio.sqf";
JOC_cmdInitRoadblock = compileFinal preprocessFileLineNumbers "Functions\Commander\Init\roadblock.sqf";
JOC_cmdInitStatic = compileFinal preprocessFileLineNumbers "Functions\Commander\Init\static.sqf";
JOC_cmdInitTown = compileFinal preprocessFileLineNumbers "Functions\Commander\Init\town.sqf";

//Logistics
JOC_cmdLogAmmo = compileFinal preprocessFileLineNumbers "Functions\Commander\Logistics\ammo.sqf";
JOC_cmdLogHeli = compileFinal preprocessFileLineNumbers "Functions\Commander\Logistics\heli.sqf";
JOC_cmdLogSupply = compileFinal preprocessFileLineNumbers "Functions\Commander\Logistics\supply.sqf";
JOC_cmdLogTruck = compileFinal preprocessFileLineNumbers "Functions\Commander\Logistics\truck.sqf";

//Misc
JOC_cmdMiscGetNearestStrategic = compileFinal preprocessFileLineNumbers "Functions\Commander\Misc\getNearestStrategic.sqf";
JOC_cmdMiscMonitorStrategic = compileFinal preprocessFileLineNumbers "Functions\Commander\Misc\monitorStrategic.sqf";
JOC_cmdMiscRadar = compileFinal preprocessFileLineNumbers "Functions\Commander\Misc\radar.sqf";

//Patrol
JOC_cmdPatrolArea= compileFinal preprocessFileLineNumbers "Functions\Commander\Patrol\Area.sqf";
JOC_cmdPatrolStrategic = compileFinal preprocessFileLineNumbers "Functions\Commander\Patrol\Strategic.sqf";

//Support
JOC_cmdDefArmor = compileFinal preprocessFileLineNumbers "Functions\Commander\Support\armor.sqf";
JOC_cmdSupportArty = compileFinal preprocessFileLineNumbers "Functions\Commander\Support\arty.sqf";
JOC_cmdDefCas = compileFinal preprocessFileLineNumbers "Functions\Commander\Support\cas.sqf";
JOC_cmdSupportIntercept = compileFinal preprocessFileLineNumbers "Functions\Commander\Support\intercept.sqf";
