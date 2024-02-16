jobs = {
	["ems"] = {
		["displayName"] = "Médecin",
		["skin"] = "s_m_m_paramedic_01",
		["customJoinMessage"] = "Pour soigner un joueur tape: ^2^*/heal ID",
		["weapons"] = {},
		["salary"] = 1050
	},
	["fireman"] = {
		["displayName"] = "Fireman",
		["weapons"] = {},
		["salary"] = 1050
	},
	["trucker"] = {
		["displayName"] = "Trucker",
		["customJoinMessage"] = "N'oublie pas d'acheter un camion avant de partir faire des livraisons",
		["weapons"] = {},
		["salary"] = 900
	},
	["serviceman"] = {
	["displayName"] = "Dépanneur",
	["customJoinMessage"] = "N'oublie pas d'acheter une dépanneuse avant de partir bosser!",
	["weapons"] = {},
	["salary"] = 950
	},
}

-- Groups
groups = {}
groups.ems = {["ems"] = true, --[[Add more if wanted]]}
groups.fire = {["fireman"] = true, --[[Add more if wanted]]}
groups.serviceman = {["serviceman"] = true, --[[Add more if wanted]]}

-- Police data
police = {}
police.arrest_points = {
	{['x'] = 1690.28, ['y'] = 2593.77, ['z'] = 45.45},
	{['x'] = 639.6, ['y'] = 1.3, ['z'] = 82.7},
	{['x'] = -1113.9, ['y'] = -852.5, ['z'] = 13.5},
	{['x'] = -886.0, ['y'] = -2365.6, ['z'] = 13.9},
	{['x'] = 371.1, ['y'] = -1609.0, ['z'] = 29.2},
	{['x'] = 872.2, ['y'] = -1288.8, ['z'] = 28.2},
	{['x'] = 462.1, ['y'] = -989.5, ['z'] = 24.91},
	{['x'] = -446.5, ['y'] = 6013.8, ['z'] = 31.7},
	{['x'] = 1852.9, ['y'] = 3688.1, ['z'] = 34.2}
}