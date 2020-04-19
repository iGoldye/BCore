-- Base configuration
levelCount = 10			-- What is max level?
expPerLevel = 200		-- How much experience per level
expDiffPerLevel = 0.3	-- Multiplier per level for less uniform levelling

-- Stat specific configs
firearmGain = 1			-- How much exp is gained per shot
firearmDrain = 0.1		-- How much exp is lost every 15 seconds
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