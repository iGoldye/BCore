Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    DisableControlAction(1, 81, true)
    DisableControlAction(1, 82, true)
    DisableControlAction(1, 83, true)
    DisableControlAction(1, 84, true)
    DisableControlAction(1, 85, true)
    DisableControlAction(1, 332, true)
    DisableControlAction(1, 333, true)
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    local vehicles = EnumerateVehicles()
    for vehicle in vehicles do
      if (vehicle ~= nil) then
        SetVehicleRadioEnabled(vehicle, false)
      end
    end
  end
end)

entityEnumerator = {
  __gc = function(enum)
    if enum.destructor and enum.handle then
      enum.destructor(enum.handle)
    end
    enum.destructor = nil
    enum.handle = nil
  end
}

function EnumerateEntities(initFunc, moveFunc, disposeFunc)
  return coroutine.wrap(function()
    local iter, id = initFunc()
    if not id or id == 0 then
      disposeFunc(iter)
      return
    end
    
    local enum = {handle = iter, destructor = disposeFunc}
    setmetatable(enum, entityEnumerator)
    
    local next = true
    repeat
      coroutine.yield(id)
      next, id = moveFunc(iter)
    until not next
    
    enum.destructor, enum.handle = nil, nil
    disposeFunc(iter)
  end)
end

function EnumerateObjects()
  return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
  return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
  return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePickups()
  return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end