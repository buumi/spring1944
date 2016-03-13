local HUNInf = {
	maxDamageMul		= 1.0,
}

local HUN_HQEngineer = EngineerInf:New(HUNInf):New{
	name				= "Engineer",
}

local HUN_Rifle = RifleInf:New(HUNInf):New{
	name				= "FÉG 35M",
	weapons = {
		[1] = { -- Rifle
			name				= "feg35m",
		},
		[2] = { -- Grenade
			name				= "Model24",
		},
	},
}

local HUN_SMG43M = SMGInf:New(HUNInf):New{
	name				= "Danuvia 43M Submachinegun",
	weapons = {
		[1] = { -- SMG
			name				= "danuvia43m",
		},
		[2] = { -- Grenade
			name				= "Model24",
		},
	},
}

local HUN_LMG31M = LMGInf:New(HUNInf):New{
	name				= "Solothurn 31M light machinegun",
	weapons = {
		[1] = { -- LMG
			name				= "mg30",
		},
	},
}

local HUN_HMG = HMGInf:New(HUNInf):New{
	name				= "Schwarzlose 07/31M heavy machinegun",
}

local HUN_HMG_Sandbag = SandbagMG:New{
	name				= "Deployed Schwarzlose 07/31M heavy machinegun",
	weapons = {
		[1] = { -- HMG
			name				= "mg7_deployed",
		},
	},
}

local HUN_Sniper = SniperInf:New(HUNInf):New{
	name				= "FÉG 35M Sniper",
	weapons = {
		[1] = { -- Sniper Rifle
			name				= "feg35m_sniper",
		},
	},
}

local HUN_PanzerFaust = ATLauncherInf:New(HUNInf):New{
	name				= "Panzerfaust 60",
	weapons = {
		[1] = { -- AT Launcher
			name				= "Panzerfaust",
		},
	},
}

local HUN_PanzerSchrek = ATLauncherInf:New(HUNInf):New{
	name				= "Panzerschrek RPzB 54",
	description			= "Heavy Anti-Tank Infantry",
	weapons = {
		[1] = { -- AT Launcher
			name				= "Panzerschrek",
		},
	},
}

local HUN_GrW34 = MedMortarInf:New(HUNInf):New{
	name				= "8cm GrW 34 Mortar",
	weapons = {
		[1] = { -- HE
			name				= "GrW34_8cmMortar",
		},
		[2] = { -- Smoke
			name				= "GrW34_8cmMortarSmoke",
		},
	},
}

local HUN_Observ = ObservInf:New(HUNInf):New{
	weapons = {
		[2] = { -- Pistol
			name				= "feg37m",
		},
	},
}


return lowerkeys({
	-- Regular Inf
	["HUNEngineer"] = HUN_HQEngineer,
	["HUNHQAIEngineer"] = HUN_HQEngineer:Clone("HUNEngineer"),
	["HUNRifle"] = HUN_Rifle,
	["HUNSMG"] = HUN_SMG43M,
	["HUNLMG"] = HUN_LMG31M,
	["HUNHMG"] = HUN_HMG,
	["HUNSandbagMG"] = HUN_HMG_Sandbag,
	["HUNSniper"] = HUN_Sniper,
	["HUNPanzerfaust"] = HUN_PanzerFaust,
	["HUNPanzerschrek"] = HUN_PanzerSchrek,
	["HUNGrW34"] = HUN_GrW34,
	["HUNObserv"] = HUN_Observ,
})
