--[=[
    @class Loader
    Simple module loader by @NeoIsSad
    Inspired by Knit by @sleitnick
]=]

type Load = {
	[any]: any,
}

local Loader = {}
Loader.Loaded = {}

--[=[
    Loads a table of modules
    @param modules {ModuleScript} -- Array of module scripts to load
]=]
function Loader.Load(modules: { ModuleScript })
	assert(
		type(modules) == "table" and #modules > 0 and modules[1].ClassName == "ModuleScript",
		"Loader.Load must be provided an array of ModuleScripts to load"
	)

	for _, module in ipairs(modules) do
		local load = require(module)
		Loader.Loaded[module.Name] = load
		if type(load.Init) == "function" then
			load:Init()
		end
	end

	for _, load in pairs(Loader.Loaded) do
		if type(load.Start) == "function" then
			load:Start()
		end
	end
end

--[=[
	Requires a table of modules
    @param modules {ModuleScript} -- Array of module scripts to require
	@return {table} -- Table of returned tables
]=]
function Loader.Require(modules: { ModuleScript })
	local tables = {}
	for index, module in ipairs(modules) do
		tables[index] = require(module)
	end
	return tables
end

--[=[
    Returns a loaded load
    @param loadName string -- Name of the load
    @return Load -- The loaded load of name loadName
]=]
function Loader.GetLoad(loadName): Load
	return Loader.Loaded[loadName]
end

return Loader
