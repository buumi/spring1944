local GERJagdPanzerIV = MediumTank:New(TankDestroyer):New{
	name				= "SdKfz 162 JagdPanzer IV/70(V)",
	description			= "Turretless Tank Destroyer",
	buildCostMetal		= 4500,
	maxDamage			= 2580,
	trackOffset			= 5,
	trackWidth			= 20,

	weapons = {
		[1] = {
			name				= "kwk75mml71AP",
			maxAngleDif			= 25,
		},
		[2] = {
			name				= ".50calproof",
		},
	},
	customParams = {
		armor_front			= 80,
		armor_rear			= 22,
		armor_side			= 40,
		armor_top			= 20,
		slope_front			= 50,
		slope_rear			= -5,
		slope_side			= 29,
		maxammo				= 15,
		soundcategory		= "GER/Tank/JgPz",
		maxvelocitykmh		= 35,

	},
}

return lowerkeys({
	["GERJagdPanzerIV"] = GERJagdPanzerIV,
})
