local orig_print = print
if Mods.mrudat_TestingMods then
  print = orig_print
else
  print = empty_func
end

local CurrentModId = rawget(_G, 'CurrentModId') or rawget(_G, 'CurrentModId_X')
local CurrentModDef = rawget(_G, 'CurrentModDef') or rawget(_G, 'CurrentModDef_X')
if not CurrentModId then

  -- copied shamelessly from Expanded Cheat Menu
  local Mods, rawset = Mods, rawset
  for id, mod in pairs(Mods) do
    rawset(mod.env, "CurrentModId_X", id)
    rawset(mod.env, "CurrentModDef_X", mod)
  end

  CurrentModId = CurrentModId_X
  CurrentModDef = CurrentModDef_X
end

orig_print("loading", CurrentModId, "-", CurrentModDef.title)

local function enableDisabledShift(workplace, shift)
  print("enableDisabledShift", workplace, shift)
  print(workplace:IsClosedShift(shift))
  if workplace:IsClosedShift(shift) then
    -- enable disabled shifts, but restrict workers to 0
    workplace:OpenShift(shift)
    workplace:ClosePositions(shift, 0)
  end
end

local function ActualEnableDisabledShifts(workplace)
  print("enableDisabledShifts")
  if workplace.automation <= 0 then return end
  for shift = 1, workplace.max_shifts do
    enableDisabledShift(workplace, shift)
  end
end

local EnableDisabledShifts = (function()
  local delayed_update_thread
  local workplaces = {}
  return function(workplace)
    workplaces[workplace] = true
    delayed_update_thread = delayed_update_thread or CreateRealTimeThread(function()
      WaitMsg("OnRender")
      for workplace in pairs(workplaces) do
        ActualEnableDisabledShifts(workplace)
      end
      workplaces = {}
      delayed_update_thread = false
    end)
  end
end)()

function OnMsg.NewWorkshift(shift)
  print("Msg.NewWorkshift", shift)
  if CurrentModOptions.OnNewWorkshift == false then return end
  local container = UICity.labels.Workplace
  if container == nil then return end
  for i = 1, #container do
    local workplace = container[i]
    if workplace.automation > 0 then
      enableDisabledShift(workplace, shift)
    end
  end
end

function OnMsg.ConstructionComplete(building)
  print("Msg.ConstructionComplete", building.name or "?")
  if CurrentModOptions.OnConstructionComplete == false then return end
  if building:IsKindOf('Workplace') then
    EnableDisabledShifts(building)
  end
end

local function find_method(class_name, method_name)
  local class = _G[class_name]
  local method = class[method_name]
  if method then return method end
  for _, parent_class_name in ipairs(class.__parents) do
    method = find_method(parent_class_name, method_name)
    if method then return method end
  end
  return false
end

local function wrap_method(class_name, method_name, wrapper)
  local orig_method = find_method(class_name, method_name)
  _G[class_name][method_name] = function(self, ...)
    return wrapper(self, orig_method, ...)
  end
end

wrap_method('Workplace', 'OnModifiableValueChanged', function(self, orig_method, prop, old_value, new_value)
  orig_method(self, prop, old_value, new_value)
  if CurrentModOptions.OnAutomationEnabled == false then return end
  if prop == "automation" then
    if new_value > 0 then
      EnableDisabledShifts(self)
    end
  end
end)

orig_print("loaded", CurrentModId, "-", CurrentModDef.title)
