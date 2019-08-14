return PlaceObj('ModDef', {
	'title', "Enable Automated Shifts",
	'description', "For automated buildings, finds disabled workshifts and changes them to enabled with no crew.\n\nThere are three options for when to enable automated shifts:\n* Automated shifts when automation enabled - enable automated shifts when automation research completes, and also for newly constructed buildings. This is enabled by default.\n* Automated shifts for new buildings - enable automated shifts for newly constructed buildings only.\n* Automated shifts on shift change - enable automated shifts on each shift change.\n\nPermission is granted to update this mod to support the latest version of the game if I'm not around to do it myself.",
	'last_changes', "reduced log spam",
	'id', "xE6pHpb",
	'steam_id', "1801139016",
	'pops_desktop_uuid', "494cbceb-857d-4b42-9343-7e5d5d1449f3",
	'pops_any_uuid', "7798d9f2-4326-4c48-a437-ba5d8b6d74f4",
	'author', "mrudat",
	'version', 16,
	'lua_revision', 233360,
	'saved_with_revision', 245618,
	'code', {
		"Code/EnableAutomatedShifts.lua",
	},
	'has_options', true,
	'saved', 1565003442,
	'TagGameplay', true,
})