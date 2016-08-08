/////////////////////////
//Script made by Jochem//
/////////////////////////
JOC_missionInit = compileFinal preprocessFileLineNumbers "missionInit.sqf";

//AI
JOC_aiManager = compileFinal preprocessFileLineNumbers "Functions\AI\aiManager.sqf";
JOC_cleanUp = compileFinal preprocessFileLineNumbers "Functions\AI\cleanUp.sqf";
JOC_virtualize = compileFinal preprocessFileLineNumbers "Functions\AI\virtualize.sqf";
JOC_unVirtualize = compileFinal preprocessFileLineNumbers "Functions\AI\unVirtualize.sqf";

//Bluforce tracking
JOC_bftManager = compileFinal preprocessFileLineNumbers "Functions\BFT\manager.sqf";

//Commander
#include "Commander\fn_commander_compile.sqf";
JOC_cmdCreateLocations = compileFinal preprocessFileLineNumbers "Functions\Commander\createLocations.sqf";
JOC_cmdCreateEnemy = compileFinal preprocessFileLineNumbers "Functions\Commander\createEnemy.sqf";

//Diary
JOC_createDiary = compileFinal preprocessFileLineNumbers "Functions\Diary\createDiary.sqf";

//Init
JOC_initDepot = compileFinal preprocessFileLineNumbers "Functions\Init\initDepot.sqf";
JOC_initPlayerBase = compileFinal preprocessFileLineNumbers "Functions\Init\initPlayerBase.sqf";

//Loadouts
JOC_arsenal = compileFinal preprocessFileLineNumbers "Functions\Loadouts\arsenal.sqf";
JOC_loadoutMaster = compileFinal preprocessFileLineNumbers "Functions\Loadouts\master.sqf";

//Logistics
#include "Logistics\fn_logistics_compile.sqf";
JOC_spawnComposition = compileFinal preprocessFileLineNumbers "Functions\Logistics\spawnComposition.sqf";

//Misc
JOC_drawLine = compileFinal preprocessFileLineNumbers "Functions\Misc\drawLine.sqf";
JOC_findCenter = compileFinal preprocessFileLineNumbers "Functions\Misc\findCenter.sqf";
JOC_getGroup = compileFinal preprocessFileLineNumbers "Functions\Misc\getGroup.sqf";
JOC_nearestPlayers = compileFinal preprocessFileLineNumbers "Functions\Misc\nearestPlayers.sqf";
JOC_playersNear = compileFinal preprocessFileLineNumbers "Functions\Misc\playersNear.sqf";
JOC_setGroupID = compileFinal preprocessFileLineNumbers "Functions\Misc\setGroupID.sqf";

//Performance
JOC_perfLoop = compileFinal preprocessFileLineNumbers "Functions\Performance\loop.sqf";
JOC_objectRemove = compileFinal preprocessFileLineNumbers "Functions\Performance\objectRemove.sqf";
JOC_itemRemove = compileFinal preprocessFileLineNumbers "Functions\Performance\itemRemove.sqf";

//Player
JOC_playerButton = compileFinal preprocessFileLineNumbers "Functions\Player\button.sqf";
JOC_playerClick = compileFinal preprocessFileLineNumbers "Functions\Player\click.sqf";
JOC_playerInit = compileFinal preprocessFileLineNumbers "Functions\Player\init.sqf";
JOC_playerLoop = compileFinal preprocessFileLineNumbers "Functions\Player\loop.sqf";
JOC_playerSmkGren = compileFinal preprocessFileLineNumbers "Functions\Player\smkGren.sqf";

//Save
JOC_saveMission = compileFinal preprocessFileLineNumbers "Functions\Save\save.sqf";
JOC_saveVirtualize = compileFinal preprocessFileLineNumbers "Functions\Save\virtualize.sqf";

//Vehicle
JOC_vehInit = compileFinal preprocessFileLineNumbers "Functions\Vehicle\init.sqf";
JOC_service = compileFinal preprocessFileLineNumbers "Functions\Vehicle\service.sqf";
JOC_vehCDU = compileFinal preprocessFileLineNumbers "Functions\Vehicle\cdu.sqf";
JOC_vehRespawn = compileFinal preprocessFileLineNumbers "Functions\Vehicle\respawn.sqf";
JOC_vehScrap = compileFinal preprocessFileLineNumbers "Functions\Vehicle\scrap.sqf";
