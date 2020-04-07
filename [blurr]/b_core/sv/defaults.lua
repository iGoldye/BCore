DEFAULT_USER = {
	["identifiers"] = {}, 
	["info"] = {
		newUser = true, 
		prevBanned = false, 
		group = "user", -- user, mod, admin, owner, developer
		online = true,
		isChanged = false,
	}, 
	["selectedCharacter"] = 1,
	["characters"] = {},
}

DEFAULT_CHARACTER = {
	["info"] = {
		name = "New User",
		dob = {d=20, m=3, y=1998},
		gender = "male",
	},
	["money"] = 250, 
	["inventory"] = {
		player = {}, 
		cars = {}, 
		air = {},
		realestate = {},
	}, 
	["coords"] = {
		x = 1455.667,
		y = 6344.834,
		z = 24.168,
		h = 25.907,
	},
	["model"] = {
		skin = "a_m_y_soucent_01",
        new = true,
        clothing = {drawables = {0,0,0,0,0,0,0,0,0,0,0,0},textures = {2,0,1,1,0,0,0,0,0,0,0,0},palette = {0,0,0,0,0,0,0,0,0,0,0,0}},
        props = {drawables = {-1,-1,-1,-1,-1,-1,-1,-1}, textures = {-1,-1,-1,-1,-1,-1,-1,-1}},
        overlays = {drawables = {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1}, opacity = {1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0}, colours = {{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0}}},
	},
}