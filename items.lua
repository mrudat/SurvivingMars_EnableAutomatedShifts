return {
PlaceObj('ModItemCode', {
	'name', "EnableAutomatedShifts",
	'FileName', "Code/EnableAutomatedShifts.lua",
}),
PlaceObj('ModItemOptionToggle', {
	'name', "OnAutomationEnabled",
	'DisplayName', "Automated shifts when automation enabled",
	'DefaultValue', true,
}),
PlaceObj('ModItemOptionToggle', {
	'name', "OnConstructionComplete",
	'DisplayName', "Automated shifts for new buildings",
}),
PlaceObj('ModItemOptionToggle', {
	'name', "OnNewWorkshift",
	'DisplayName', "Automated shifts on shift change",
}),
}
