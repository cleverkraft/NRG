-- NRG
-- Energy control system for Big Reactors / Mekanism
-- in 1.7.10 Pack
-- version 0.1
-- Alex Shaffer : alex@nosuch.org

local nrg = {}

function nrg.constInit()
  
  nrg.const = {}
  
  nrg.const.bigReactorMaxEnergyStorage = 10000000
  nrg.const.turbineRPMmode = { off = 0, half = 900 , full = 1800, free = -1 }
  
end

function nrg.configInit()
  
  nrg.config = {}
  nrg.status = {}
  
  nrg.config.enabled = true
  nrg.status.validGrid = false

end


-- Finds power equipment hooked up to the network
function nrg.gridInit()
  
  
  nrg.energyStorageMax = 0
  nrg.energyStorageCurrent = 0
  
  nrg.reactors = gridInitReactorFind()
  nrg.turbines = gridInitTurbineFind()
  nrg.storage = gridInitStorageFind(nrg.turbines)
  
  nrg.config.validGrid = (#nrg.reactors == 1) and (#nrg.turbines > 0)
  
  nrg.gridUpdate()

end


function gridInitReactorFind()
  
  local reactors = {}
  
  
  print("Reactors found: "..#reactors)
  
  return reactors
  
end

function gridInitTurbineFind()
  
  local turbines = {}
  
  
  print("Turbines found: "..#turbines)
  
  return turbines
  
end

function gridInitStorageFind()

  local storage = {}
  
  
  print("Additional storage found: "..#storage)
  
  return storage

end

-- Loads data about the current state of the power grid
function nrg.gridUpdate()
  
  -- nothing
  
end


-- Test code here

nrg.constInit()
nrg.configInit()
nrg.gridInit()

if nrg.gridValid then
  print("Valid grid.")
else
  print("Grid is not valid. Needs 1 reactors and at least 1 turbine.")
end


return nrg