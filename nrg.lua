-- NRG
-- Energy control system for Big Reactors / Mekanism
-- in 1.7.10 Pack
-- version 0.1
-- Alex Shaffer : alex@nosuch.org

local nrg = {}

function nrg.constInit()
  
  nrg.const = {}
  
  nrg.const.BRmaxEnergyStorage = 10000000
  nrg.const.turbineRPMmode = { off = 0, half = 900 , full = 1800, free = -1 }
  nrg.const.BRreactor = "BigReactors-Reactor"
  nrg.const.BRturbine = "BigReactors-Turbine"
  nrg.const.MKcube = "mekanism-machine"
  
end

function nrg.configInit()
  
  nrg.config = {}
  nrg.status = {}
  
  nrg.config.enabled = true
  nrg.config.CC = (_CC_VERSION ~= nil)
  nrg.status.gridValid = false

end

function nrg.bridgingInit()
  
  nrg.fn = {}
  
  if nrg.config.CC then
    
    nrg.fn.findReactors = function() return {peripheral.find(nrg.const.BRreactor)} end
    nrg.fn.findTurbines = function() return {peripheral.find(nrg.const.BRturbine)} end
    nrg.fn.findStorage = function() return {peripheral.find(nrg.const.MKcube)} end
    
  else
    
    nrg.fn.findReactors = function() return {} end
    nrg.fn.findTurbines = function() return {} end
    nrg.fn.findStorage = function() return {} end
    
  end
  
end


-- Finds power equipment hooked up to the network
function nrg.gridInit()
  
  nrg.energyStorageMax = 0
  nrg.energyStorageCurrent = 0
  
  nrg.reactors = gridInitReactorsFind()
  nrg.turbines = gridInitTurbinesFind()
  nrg.storage = gridInitStorageFind(nrg.turbines)
  
  nrg.config.gridValid = ((#nrg.reactors == 1) and (#nrg.turbines > 0))
  
  print("Grid summary:")
  print("Reactors: "..#nrg.reactors)
  print("Turbines: "..#nrg.turbines)
  print("Storage: "..#nrg.storage)
  print("Valid: "..tostring(nrg.config.gridValid))
  
  
  nrg.gridUpdate()

end


function gridInitReactorsFind()
  
  local reactors = nrg.fn.findReactors()
    
    
  print("Reactors found: "..#reactors)
  
  return reactors
  
end

function gridInitTurbinesFind()
  
  local turbines = nrg.fn.findTurbines()
  
  
  print("Turbines found: "..#turbines)
  
  return turbines
  
end

function gridInitStorageFind(turbines)

  local storage = nrg.fn.findStorage()
  
  
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
nrg.bridgingInit()
nrg.gridInit()

if nrg.config.gridValid then
  print("Valid grid.")
else
  print("Grid is not valid. Needs 1 reactor and at least 1 turbine.")
end


return nrg