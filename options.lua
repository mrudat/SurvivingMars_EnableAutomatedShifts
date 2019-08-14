DefineClass("ModOptions_xE6pHpb", {
	__parents = {
		"ModOptionsObject",
	},
	properties = {
		{
			default = true,
			editor = "bool",
			id = "OnAutomationEnabled",
			name = T("Automated shifts when automation enabled"),
		},
		{
			default = false,
			editor = "bool",
			id = "OnConstructionComplete",
			name = T("Automated shifts for new buildings"),
		},
		{
			default = false,
			editor = "bool",
			id = "OnNewWorkshift",
			name = T("Automated shifts on shift change"),
		},
	},
})