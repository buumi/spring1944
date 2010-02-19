--[[
TODO: 
add the settle radius stuff (check if target is more than settleRadius away from previous spotID for that unit...which means adding a new table layer for units)
make sure the logic of aiming at a spot, settling for acuisitionTime, and then firing with improved accuracy really works.
fix any bugs


]]--

function gadget:GetInfo()
    return {
        name      = "Indirect Fire Accuracy Manager",
        desc      = "Changes the accuracy of weapons fire based on the LoS status of the target",
        author    = "Ben Tyler (Nemo)",
        date      = "Feb 10th, 2009",
        license   = "LGPL v2.1 or later",
        layer     = 0,
        enabled   = true  --  loaded by default?
    }
end

if (not gadgetHandler:IsSyncedCode()) then
  return false
end

--CMDS
local CMD_ATTACK			= CMD.ATTACK
local CMD_AREA_ATTACK		= CMD.AREA_ATTACK
--synced read
local IsPosInLos 			= Spring.IsPosInLos
local IsValidUnitID			= Spring.ValidUnitID
local GetUnitPosition		= Spring.GetUnitPosition
local GetUnitAllyTeam		= Spring.GetUnitAllyTeam
local GetGameSeconds		= Spring.GetGameSeconds
--synced control
local SetUnitWeaponState	= Spring.SetUnitWeaponState

--constants
local losMult 				= 0.25 --how much more accurate the weapon gets
local accuracyDelay			= 20 --# of seconds before the accuracy improvement kicks in
--vars
local visibleAreas			= {}


local function updateUnit(allyTeam, unitID)
	--Spring.Echo("update function called")
	local unitDefID = Spring.GetUnitDefID(unitID)
	local weapons = UnitDefs[unitDefID].weapons
	local newAccuracy
	if visibleAreas[allyTeam][unitID] ~= nil then
		if (visibleAreas[allyTeam][unitID].zeroed == true) then
			newAccuracy = WeaponDefs[weapons[1].weaponDef].accuracy * losMult
			Spring.Echo("zero'd in on target! you've attacked the same place long enough")
		else
			Spring.Echo("Not yet zeroed in on target - not in LoS or not zeroed")
			newAccuracy = WeaponDefs[weapons[1].weaponDef].accuracy
		end
	end
	
	for i=0, #weapons do
		Spring.Echo("old accuracy:", WeaponDefs[weapons[1].weaponDef].accuracy, "new accuracy", newAccuracy)
		SetUnitWeaponState(unitID, i, {accuracy = newAccuracy})
		Spring.Echo("change the weapon accuracy for weapon", i)
	end
end

function gadget:AllowCommand(unitID, unitDefID, unitTeam, cmdID, cmdParams)
	local ud = UnitDefs[unitDefID]
		if ud.customParams.canfiresmoke == "1" and ud.customParams.feartarget=="1" then
			if cmdID == CMD_ATTACK or cmdID == CMD_AREA_ATTACK then
				local allyTeam = GetUnitAllyTeam(unitID)
				local targetX, targetY, targetZ
				
				if IsValidUnitID(cmdParams[1]) == true then
					targetX, targetY, targetZ = GetUnitPosition(cmdParams[1])
					Spring.Echo("shooting at a unit!, ID", cmdParams[1])
				else
					targetX, targetY, targetZ = cmdParams[1], cmdParams[2], cmdParams[3]
					Spring.Echo("shooting at the ground!, coords:", cmdParams[1], cmdParams[2], cmdParams[3])
				end
				
				if visibleAreas[allyTeam] == nil then
					visibleAreas[allyTeam] = {}
				end
				if visibleAreas[allyTeam][unitID] == nil then
					visibleAreas[allyTeam][unitID] = {}
				end
				
				visibleAreas[allyTeam][unitID] = {
							targetTime = nil, --just until the next update calls
							zeroed = false,
							x = targetX,
							y = targetY,
							z = targetZ,
						}
				
				if IsPosInLos(targetX, targetY, targetZ) == true then
					visibleAreas[allyTeam][unitID].targetTime = GetGameSeconds()
				end
			end
		end
	return true	
end

function gadget:GameFrame(n)
	if (n % (2*30)) < 0.1 then
		for allyID, someThing in pairs(visibleAreas) do
			for unitID, someThing in pairs(visibleAreas[allyID]) do
				local unitArea = visibleAreas[allyID][unitID]
					if IsPosInLos(unitArea.x, unitArea.y, unitArea.z) == true then
						if unitArea.targetTime == nil then 
							unitArea.targetTime = GetGameSeconds()
						end
						if ((n/30) - unitArea.targetTime) > accuracyDelay then
							unitArea.zeroed = true
						end
					else
						unitArea.targetTime = GetGameSeconds()
						unitArea.zeroed = false
					end
				updateUnit(allyID, unitID)
			end
		end
	end
end