MAX_CHARACTERS = 4
MAX_WEIGHT = 200

uses = {
	[0] = "holster",
	[1] = "drinks",
	[2] = "food",
	[3] = "usables",
	[4] = "meds",
	[5] = "melee",
	[6] = "handguns",
	[7] = "primary",
	[8] = "crafting",
}

items = {
	{n="Holster", id=0, use=0, weight=0, image="img/unarmed.png", model=nil, prop=nil, count=0},

	{n="Water", id=1, use=1, weight=1, image="img/items/water.png", model=nil, prop="prop_ld_flow_bottle", count=0},
	{n="Apple Juice", id=2, use=1, weight=1, image="img/items/applejuice.png", model=nil, prop="prop_food_cb_juice01", count=0},
	{n="Cola", id=3, use=1, weight=1, image="img/items/cola.png", model=nil, prop="ng_proc_sodacan_01a", count=0},
	{n="Red Bull", id=4, use=1, weight=1, image="img/items/redbull.png", model=nil, prop="ng_proc_sodacan_01b", count=0},
	{n="Coffee", id=5, use=1, weight=1, image="img/items/coffee.png", model=nil, prop="ng_proc_coffee_01a", count=0},

	{n="Burger", id=10, use=2, weight=1, image="img/items/burger.png", model=nil, prop="prop_cs_burger_01", count=0},
	{n="Hotdog", id=11, use=2, weight=1, image="img/items/hotdog.png", model=nil, prop="prop_food_bs_burger2", count=0},
	{n="Salad", id=12, use=2, weight=1, image="img/items/salad.png", model=nil, prop="ng_proc_food_bag02a", count=0},
	{n="Pineapple", id=13, use=2, weight=1, image="img/items/pineapple.png", model=nil, prop="prop_pineapple", count=0},
	{n="Banana", id=14, use=2, weight=1, image="img/items/banana.png", model=nil, prop="ng_proc_food_nana1a", count=0},

	{n="Joint", id=20, use=3, weight=1, image="img/items/joint.png", model=nil, prop="p_amb_joint_01", count=0},
	{n="Silencer", id=21, use=3, weight=1, image="img/items/suppressor.png", model=nil, prop="w_at_ar_supp", count=0},
	{n="Scope", id=22, use=3, weight=1, image="img/items/scope.png", model=nil, prop="w_at_scope_medium", count=0},

	{n="Medkit", id=30, use=4, weight=1, image="img/items/medkit.png", model=nil, prop="prop_med_bag_01b", count=0},

	{n="Knife", id=40, use=5, weight=1, image="img/knife.png", model="WEAPON_KNIFE", prop="w_me_knife_01", count=0},
	{n="Dagger", id=41, use=5, weight=1, image="img/dagger.png", model="WEAPON_DAGGER", prop="w_me_dagger", count=0},
	{n="Switchblade", id=42, use=5, weight=1, image="img/switchblade.png", model="WEAPON_SWITCHBLADE", prop=nil, count=0},
	{n="Bat", id=43, use=5, weight=1, image="img/bat.png", model="WEAPON_BAT", prop="w_me_bat", count=0},
	{n="Crowbar", id=44, use=5, weight=1, image="img/crowbar.png", model="WEAPON_CROWBAR", prop="w_me_crowbar", count=0},
	{n="Battle Axe", id=45, use=5, weight=1, image="img/battleaxe.png", model="WEAPON_BATTLEAXE", prop="prop_tool_fireaxe", count=0},
	{n="Machete", id=46, use=5, weight=1, image="img/machete.png", model="WEAPON_MACHETE", prop="prop_ld_w_me_machette", count=0},
	{n="P250", id=50, use=6, weight=1, image="img/pistolmk2.png", model="WEAPON_PISTOL_MK2", prop="w_pi_pistol", count=0},
	{n="P2000", id=51, use=6, weight=1, image="img/combatpistol.png", model="WEAPON_COMBATPISTOL", prop="w_pi_combatpistol", count=0},
	{n="SCAMP", id=52, use=6, weight=1, image="img/appistol.png", model="WEAPON_APPISTOL", prop="w_pi_appistol", count=0},
	{n="Stun Gun", id=53, use=6, weight=1, image="img/stungun.png", model="WEAPON_STUNGUN", prop="w_pi_stungun", count=0},
	{n="Desert Eagle", id=54, use=6, weight=1, image="img/pistol50.png", model="WEAPON_PISTOL50", prop="w_pi_pistol50", count=0},
	{n="AMT Backup", id=55, use=6, weight=1, image="img/snspistolmk2.png", model="WEAPON_SNSPISTOL_MK2", prop="w_pi_sns_pistol", count=0},
	{n="Model 1922", id=56, use=6, weight=1, image="img/vintage.png", model="WEAPON_VINTAGEPISTOL", prop="w_pi_vintage_pistol", count=0},
	{n="Revolver", id=57, use=6, weight=1, image="img/revolvermk2.png", model="WEAPON_REVOLVER_MK2", prop=nil, count=0},
	{n="MP5", id=60, use=7, weight=1, image="img/smg.png", model="WEAPON_SMG", prop="w_sb_smg", count=0},
	{n="MP5K", id=61, use=7, weight=1, image="img/smgmk2.png", model="WEAPON_SMG_MK2", prop="w_sb_smg", count=0},
	{n="P90", id=62, use=7, weight=1, image="img/assaultsmg.png", model="WEAPON_ASSAULTSMG", prop="w_sb_assaultsmg", count=0},
	{n="MPX", id=63, use=7, weight=1, image="img/combatpdw.png", model="WEAPON_COMBATPDW", prop=nil, count=0},
	{n="SMG-12", id=64, use=7, weight=1, image="img/machinepistol.png", model="WEAPON_MACHINEPISTOL", prop=nil, count=0},
	{n="MAC 10", id=65, use=7, weight=1, image="img/minismg.png", model="WEAPON_MINISMG", prop=nil, count=0},
	{n="Pump Shotgun", id=66, use=7, weight=1, image="img/pumpshotgun.png", model="WEAPON_PUMPSHOTGUN", prop="w_sg_pumpshotgun", count=0},
	{n="Sawed Off Shotgun", id=67, use=7, weight=1, image="img/sawedoff.png", model="WEAPON_SAWEDOFFSHOTGUN", prop="w_sg_sawnoff", count=0},
	{n="AK47", id=68, use=7, weight=1, image="img/assaultrifle.png", model="WEAPON_ASSAULTRIFLE", prop="w_ar_assaultrifle", count=0},
	{n="AKM", id=69, use=7, weight=1, image="img/assaultriflemk2.png", model="WEAPON_ASSAULTRIFLE_MK2", prop="w_ar_assaultrifle", count=0},
	{n="M4", id=70, use=7, weight=1, image="img/carbineriflemk2.png", model="WEAPON_CARBINERIFLE_MK2", prop="w_ar_carbinerifle", count=0},
	{n="Tar", id=71, use=7, weight=1, image="img/advancedrifle.png", model="WEAPON_ADVANCEDRIFLE", prop="w_ar_advancedrifle", count=0},
	{n="G36C", id=72, use=7, weight=1, image="img/specialcarbinemk2.png", model="WEAPON_SPECIALCARBINE_MK2", prop="w_ar_specialcarbine", count=0},
	{n="Famas", id=73, use=7, weight=1, image="img/bullpupriflemk2.png", model="WEAPON_BULLPUPRIFLE_MK2", prop="w_ar_bullpuprifle", count=0},
	{n="AK74-U", id=74, use=7, weight=1, image="img/compactrifle.png", model="WEAPON_COMPACTRIFLE", prop=nil, count=0},
	{n="PKM", id=75, use=7, weight=1, image="img/mg.png", model="WEAPON_MG", prop="w_mg_mg", count=0},
	{n="L96A1", id=76, use=7, weight=1, image="img/sniper.png", model="WEAPON_SNIPERRIFLE", prop="w_sr_sniperrifle", count=0},
	{n="Barrett 50Cal", id=77, use=7, weight=1, image="img/heavysniper.png", model="WEAPON_HEAVYSNIPER", prop="w_sr_heavysniper", count=0},
	{n="RPG", id=78, use=7, weight=1, image="img/rpg.png", model="WEAPON_RPG", prop="w_lr_rpg", count=0},
	{n="Grenade", id=79, use=7, weight=1, image="img/grenade.png", model="WEAPON_GRENADE", prop="w_ex_grenadefrag", count=0},
	{n="Gas", id=80, use=7, weight=1, image="img/bzgas.png", model="WEAPON_BZGAS", prop="prop_gas_grenade", count=0},

	{n="Scrap Metal", id=100, use=8, weight=1, image="img/items/scrap.png", model=nil, prop="hei_prop_cc_metalcover_01", count=0},
}

function CreateUser(source, data)
	local self = {}
	self.source = source
	self.identifiers = data["identifiers"]
	self.info = data["info"]
	self.selectedCharacter = data["selectedCharacter"]
	self.characters = data["characters"]
	self.lastCoords = {x=0.0, y=0.0, z=0.0, h=0.0}

	local user = {}

	user.GetSource = function()
		return self.source
	end

	user.GetIdentifiers = function()
		return self.identifiers
	end

	user.GetInfo = function()
		return self.info
	end
	user.IsUserNew = function()
		return self.info.newUser
	end
	user.HasPrevBeenBanned = function()
		return self.info.prevBanned
	end
	user.SetPrevBanned = function(prevBanned)
		self.info.prevBanned = prevBanned
		self.info.isChanged = true
		return true
	end
	user.GetGroup = function()
		return self.info.group
	end
	user.SetGroup = function(newGroup)
		local group = string.lower(newGroup)
		if (group == "user" or group == "mod" or group == "admin" or group == "owner" or group == "developer") then
			self.info.group = group
			self.info.isChanged = true
			return true
		else
			return false
		end
	end
	user.IsUserOnline = function()
		return self.info.isOnline
	end
	user.SetUserOffline = function()
		self.info.isOnline = false
		return true
	end
	user.HasUserChanged = function()
		return self.info.isChanged
	end
	user.SetUserChanged = function()
		self.info.isChanged = false
	end

	user.GetCharacterName = function()
		return self.characters[self.selectedCharacter]["info"].name
	end
	user.SetCharacterName = function(newName)
		if (name) then
			self.characters[self.selectedCharacter]["info"].name = newName
			return true
		else
			return false
		end
	end

	user.GetMoney = function()
		return self.characters[self.selectedCharacter]["money"]
	end
	user.SetMoney = function(amount)
		local money = math.floor(amount)
		if (money >= 0) then
			self.characters[self.selectedCharacter]["money"] = money
			self.info.isChanged = true
			return true
		else
			return false
		end
	end
	user.AddMoney = function(amount)
		local money = math.floor(amount)
		if (money >= 0) then
			self.characters[self.selectedCharacter]["money"] = self.characters[self.selectedCharacter]["money"] + money
			self.info.isChanged = true
			return true
		else
			return false
		end
	end
	user.RemoveMoney = function(amount)
		local money = self.characters[self.selectedCharacter]["money"] - math.floor(amount)
		if (money >= 0) then
			self.characters[self.selectedCharacter]["money"] = money
			self.info.isChanged = true
			return true
		else
			return false
		end
	end

	user.GetCoords = function()
		return self.characters[self.selectedCharacter]["coords"]
	end
	user.UpdateCoords = function(x, y, z, h)
		if (self.lastCoords.x == 0.00 and self.lastCoords.y == 0.00) then
			return false
		end
		
		self.characters[self.selectedCharacter]["coords"] = self.lastCoords
		self.info.isChanged = true
		return true
	end
	user.UpdateLastCoords = function(x, y, z, h)
		self.lastCoords = {x=x+0.0, y=y+0.0, z=z+0.0, h=h+0.0}
		self.info.isChanged = true
		return true
	end

	user.GetModel = function()
		return self.characters[self.selectedCharacter]["model"]
	end
	user.SetModel = function(model)
		self.characters[self.selectedCharacter]["model"] = model
		self.info.isChanged = true
		return true
	end

	user.GetSelectedCharacter = function()
		return self.selectedCharacter
	end
	user.GetCharacter = function()
		return self.characters[self.selectedCharacter]
	end
	user.ChangeCharacter = function(characterId)
		if (self.characters[characterId]) then
			self.selectedCharacter = characterId
			self.info.isChanged = true
			return true
		else
			return false
		end
	end
	user.GetCharacters = function()
		return self.characters
	end
	user.WipeData = function()
		for i,v in pairs(self.characters) do
			table.remove(self.characters, v)
		end
		if (#self.characters == 0) then
			self.info.isChanged = true
			return true
		else
			return false
		end
	end
	user.WipeCharacter = function(characterId)
		if (#self.characters >= characterId) then
			self.selectedCharacter = 1
			table.remove(self.characters, characterId)
			self.info.isChanged = true
			return true
		else
			return false
		end
	end
	user.AddCharacter = function(name, dob, gender)
		if (#self.characters < MAX_CHARACTERS) then
			if (name and dob and gender) then
				local newCharacter = DEFAULT_CHARACTER
				newCharacter["info"].name = name
				newCharacter["info"].dob = dob
				newCharacter["info"].gender = gender
				table.insert(self.characters, newCharacter)
				self.selectedCharacter = #self.characters
				self.info.isChanged = true
				return true
			else
				return false
			end
		else
			return false
		end
	end

	-- INVENTORY STUFF
	user.GetItemInventory = function()
		return self.characters[self.selectedCharacter]["inventory"].player
	end
	user.WipeInventory = function()
		self.characters[self.selectedCharacter]["inventory"].player = {}
		self.info.isChanged = true
		return true
	end
	user.GetItemsWeight = function()
		local inventoryWeight = 0
		for i,v in pairs(self.characters[self.selectedCharacter]["inventory"].player) do
			if (v.use == 5 or v.use == 6 or v.use == 7) then
				inventoryWeight = inventoryWeight + v.weight
			else
				inventoryWeight = inventoryWeight + (v.weight * v.count)
			end
		end

		return inventoryWeight
	end
	user.GiveItem = function(itemId, itemQty)
		local inventoryWeight = 0
		for i,v in pairs(self.characters[self.selectedCharacter]["inventory"].player) do
			if (v.use == 5 or v.use == 6 or v.use == 7) then
				inventoryWeight = inventoryWeight + v.weight
			else
				inventoryWeight = inventoryWeight + (v.weight * v.count)
			end
		end

		local item = GetItemFromId(itemId)
		if (item == nil) then
			return false
		end

		if (item.use == 5 or item.use == 6 or item.use == 7) then
			inventoryWeight = inventoryWeight + item.weight
		else
			inventoryWeight = inventoryWeight + (item.weight * itemQty)
		end

		if (inventoryWeight <= MAX_WEIGHT) then
			local found = false
			for i,v in pairs(self.characters[self.selectedCharacter]["inventory"].player) do
				if (v.id == itemId) then
					v.count = v.count + itemQty
					found = true
					self.info.isChanged = true
					return true
				end
			end
	
			if (found == false) then
				item.count = itemQty
				table.insert(self.characters[self.selectedCharacter]["inventory"].player, item)
				self.info.isChanged = true
				return true
			end
		else
			return false
		end
	end
	user.RemoveItem = function(itemId, itemQty)
		local amount = 0
		for i,v in pairs(self.characters[self.selectedCharacter]["inventory"].player) do
			if (v.id == itemId) then 
				amount = v.count
			end
		end

		if (amount >= itemQty) then
			for i,v in pairs(self.characters[self.selectedCharacter]["inventory"].player) do
				if (v.id == itemId) then 
					v.count = v.count - itemQty

					if (v.count <= 0) then
						table.remove(self.characters[self.selectedCharacter]["inventory"].player, i)
					end
					self.info.isChanged = true
					return true
				end
			end
			return false
		else
			return false
		end
	end
	user.HasItem = function(itemId)
		for i,v in pairs(self.characters[self.selectedCharacter]["inventory"].player) do
			if (v.id == itemId) then
				return v.count
			end
		end
		return 0
	end
	user.GetItem = function(itemId)
		for i,v in pairs(self.characters[self.selectedCharacter]["inventory"].player) do
			if (v.id == itemId) then
				return v
			end
		end
		return nil
	end

	-- CARS

	-- AIR

	-- REALESTATE

	return user
end

function GetItemFromId(id)
	for i,v in pairs(items) do
		if (v.id == id) then 
			return v 
		end
	end
	return nil
end

function GetItemFromName(name)
	for i,v in pairs(items) do
		if (v.name == name) then 
			return v 
		end
	end
	return nil
end