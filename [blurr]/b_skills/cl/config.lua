-- Base configuration
levelCount = 10				-- What is max level?
expPerLevel = 200			-- How much experience per level
expDiffPerLevel = 0.3		-- Multiplier per level for less uniform levelling
maxWeight = 200				-- Max weight in inventory (Needs to be updated if weight is changed in BCore)
weightBeforeAffected = 30	-- Weight of items before you start losing speed

-- Stat specific configs
firearmGain = 1.5			-- How much exp is gained per shot
firearmDrain = 0.05		-- How much exp is lost every 15 seconds
recoilMultipliers = {	-- How much recoil is multiplied per level (0 - 10)
	2.5, 
	2.25, 
	2.00, 
	1.75, 
	1.50, 
	1.0, 
	0.85, 
	0.60, 
	0.45, 
	0.45, 
	0.45
}

staminaGain = 25		-- How much exp is gained every 15 seconds if ran
staminaDrain = 0.05		-- How much exp is lost every 15 seconds
staminaMultipliers = {	-- How much stamina regen is multiplied per level (0 - 10)
	1.0, 
	1.1, 
	1.3, 
	1.5, 
	2.0, 
	2.5, 
	3.0, 
	3.5, 
	4.0, 
	5.0, 
	6.0
}