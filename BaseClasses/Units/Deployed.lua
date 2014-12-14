-- Vehicles ----
local Deployed = Unit:New{
	activateWhenBuilt			= true,
	airSightDistance			= 2000,
	buildingGroundDecalSizeX	= 5,
	buildingGroundDecalSizeY	= 5,
	buildingGroundDecalType		= "Dirt2.dds",
	category					= "DEPLOYED",
	flankingBonusMax			= 1.25,
	flankingBonusMin			= 0.75,
	flankingBonusMode			= 1,
	footprintX					= 3,
	footprintZ					= 3,
	maxDamage					= 2500,
	maxSlope					= 15,
	maxWaterDepth				= 0,
	radardistance				= 650,
	sightDistance				= 650,
	stealth						= true,
	useBuildingGroundDecal		= true,
	
	customParams = {
		feartarget		= 1,
		soundcategory	= "<SIDE>/Gun",
	},
}

local DeployedGun = Deployed:New{
	customParams = { -- SandbagMG doesn't use ammo, and can't overwrite with nil (and false doesn't seem to work either)
		maxammo			= 4,
	},
}

local TankShelter = Deployed:New{
	description					= "Tank fortification",
	buildCostMetal				= 450,
	cloakCost					= 0,
	cloakCostMoving				= 0,
	isFirePlatform				= true,
	maxDamage					= 2500,
	minCloakDistance			= 500,
	objectName					= "GEN/<NAME>.s3o",
	cloakTimeout				= 160,
	releaseHeld					= true,
	script						= "tankshelter.lua",
	transportCapacity			= 1,
	transportSize				= 9, -- mass is used to control size of loadable unit
}

-- Sandbag MG --
local SandbagMG = Deployed:New{
	description					= "Dug-in Heavy Infantry Fire Support",
	buildCostMetal				= 800, -- only for power calcs
	buildingGroundDecalSizeX	= 4,
	buildingGroundDecalSizeY	= 4,
	buildPic					= "<SIDE>SandbagMG.png",
	corpse						= "SandbagMG_Destroyed",
	footprintX					= 2,
	footprintZ					= 2,
	iconType					= "lightmg",
	maxDamage					= 1600,
	noChaseCategory				= "OPENVEH AIR FLAG SOFTVEH MINE",
	objectName					= "<SIDE>/<SIDE>SandbagMG.S3O",

	sfxtypes = {
		explosionGenerators = {
			[1] = "custom:SMOKEPUFF_GPL_FX",
			[7] = "custom:MG_SHELLCASINGS",
			[8] = "custom:MG_MUZZLEFLASH",
		},
	},

    weapons = {
		[1] = { -- MG
			maxAngleDif					= 120, -- overwritten by MG42 & M1919A4
			onlyTargetCategory			= "INFANTRY SOFTVEH DEPLOYED",
		},
		[2] = { -- Tracer, same for all except those using green
			name = "Small_Tracer",
		},
	},
}

-- Guns --
local AAGun = DeployedGun:New{
	description			= "Deployed Anti-Aircraft Gun",
	buildCostMetal		= 1400,
	iconType			= "aaartillery",
	maxDamage			= 1250,
	customParams = {
		weaponswithammo		= 2,
		maxammo				= 16,
	},
	weapons = {
		[1] = { -- AA
			onlyTargetCategory	= "AIR",
		},
		[2] = { -- HE
			onlyTargetCategory	= "BUILDING INFANTRY SOFTVEH OPENVEH HARDVEH SHIP LARGESHIP DEPLOYED",
		},
	},	
}

local ATGun = DeployedGun:New{
	description			= "Deployed Anti-Tank Gun",
	buildCostMetal		= 840,
	iconType			= "atartillery",
	customParams = {
		weaponswithammo		= 1,
	},
	weapons = {
		[1] = { -- AP
			badTargetCategory	= "SOFTVEH",
			onlyTargetCategory	= "SOFTVEH OPENVEH HARDVEH SHIP LARGESHIP",
			maxAngleDif			= 70,
		},
	},
}

local LightATGun = ATGun:New{
	buildCostMetal		= 400,
	initCloaked			= true,
	cloakCost			= 0,
	cloakTimeout		= 160,
	minCloakDistance	= 300,
}

local FGGun = DeployedGun:New{
	description			= "Deployed Field Gun",
	buildCostMetal		= 1300,
	iconType			= "artillery",
	customParams = {
		weaponswithammo		= 2,
	},
	weapons = {
		[1] = { -- HE
			onlyTargetCategory	= "BUILDING INFANTRY SOFTVEH OPENVEH HARDVEH SHIP LARGESHIP DEPLOYED",
			maxAngleDif			= 60,
		},
		[2] = { -- AP
			onlyTargetCategory	= "OPENVEH HARDVEH",
			maxAngleDif			= 60,
		},
	},	
}

local HGun = DeployedGun:New{
	description			= "Deployed Howitzer",
	buildCostMetal		= 1800,
	iconType			= "artillery",
	customParams = {
	    canAreaAttack		= true,
		canfiresmoke		= true,
		weaponswithammo		= 2,
	},
	weapons = {
		[1] = { -- HE
			onlyTargetCategory	= "BUILDING INFANTRY SOFTVEH OPENVEH HARDVEH SHIP LARGESHIP DEPLOYED",
			maxAngleDif			= 35,
		},
		[2] = { -- Smoke
			onlyTargetCategory	= "NOTHING",
			maxAngleDif			= 35,
		},
	},
}

local RGun = DeployedGun:New{
	description			= "Deployed Rocket Launcher",
	buildCostMetal		= 3600,
	iconType			= "artillery",
	customParams = {
		weaponswithammo		= 1,
	},
	weapons = {
		[1] = {
			onlyTargetCategory	= "BUILDING INFANTRY SOFTVEH OPENVEH HARDVEH SHIP LARGESHIP DEPLOYED",
			maxAngleDif			= 35,
		},
	},
}

return {
	Deployed = Deployed,
	DeployedGun = DeployedGun,
	TankShelter = TankShelter,
	SandbagMG = SandbagMG,
	-- Trucks
	AAGun = AAGun,
	ATGun = ATGun,
	LightATGun = LightATGun,
	FGGun = FGGun,
	HGun = HGun,
	RGun = RGun,
}