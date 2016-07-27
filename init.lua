-- Flags mod for Minetest

if not minetest.get_modpath("flags") then
	error("\nWrong mod directory name! Please change it to 'flags'.\n" ..
			"See also: http://dev.minetest.net/Installing_Mods")
end

local DEFAULT_HUES = {
	-- Item name, Description
	{"cyan", "Cyan"},
	{"blue", "Blue"},
	{"green", "Green"},
	{"magenta", "Magenta"},
	{"orange", "Orange"},
	{"red", "Red"},
	{"violet", "Violet"},
	{"yellow", "Yellow"}
}

local UNIFIED_HUES = {
	{"aqua", "Aqua"},
	{"lime", "Lime"},
	{"redviolet", "Red-violet"},
	{"skyblue", "Sky-blue"}
}

-- Nodes and crafts
minetest.register_craft({
	output = "flags:white 16",
	recipe = {
		{"wool:white", "wool:white", "wool:white"},
		{"wool:white", "wool:white", "wool:white"}
	}
})

-- Register flag function
register_flag = function(hue, hue2)
	if type(hue) == "table" then
		hue2 = hue[2]
		hue = hue[1]
	end

	minetest.register_craft({
		type = "shapeless",
		output = "flags:" .. hue,
		recipe = {
			"group:flag",
			"dye:" .. hue
		}
	})

	local animation = {
		name = "flags_"..hue..".png",
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 1.0
		}
	}
	minetest.register_node("flags:"..hue, {
		description = hue2 .. " Flag",
		drawtype = "torchlike",
		inventory_image = "flags_item_"..hue..".png",
		wield_image = "flags_item_"..hue..".png",
		tiles = {
			table.copy(animation),
			table.copy(animation),
			table.copy(animation)
		},
		paramtype = "light",
		paramtype2 = "wallmounted",
		sunlight_propagates = true,
		walkable = false,
		selection_box = {
			type = "wallmounted",
			wall_top = {-0.1, 0.5-0.6, -0.1, 0.1, 0.5, 0.1},
			wall_bottom = {0, -0.5, -0.1, 0.1, -0.5+0.6, 0.1},
			wall_side = {-0.5, -0.3, -0.1, 0.5, 0.3, 0.1},
		},
		groups = {dig_immediate=3, attached=1, flag=1},
		legacy_wallmounted = true,
		sounds = default.node_sound_defaults()
	})
end

-- Register Flags
register_flag("black", "Black")
register_flag("white", "White")

for i = 1, #DEFAULT_HUES do
	register_flag(DEFAULT_HUES[i])
end

if minetest.get_modpath("unifieddyes") then
	for i = 1, #UNIFIED_HUES do
		register_flag(UNIFIED_HUES[i])
	end
end

print("[Flags] Loaded!")
