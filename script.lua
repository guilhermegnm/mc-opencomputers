--Modified Pastebin from ...

-- Works for Enigmatica 2: Expert Unoficial (E2EU)
 
-- Basic imports
sides = require("sides")
component = require("component")
string = require("string")
os = require("os")
 
-- Change to the address of your adapter and redstone io
ae2 = component.proxy("db21a978-a004-4ba5-8e0e-52973e0bfbe7")
rs = component.proxy("716291d0-7945-4f2c-b2a8-da201f74daec")
 
 
-- List of items to watch. Enable advanced tooltips to get the itemnames (F3+H)
-- Add /X to end of item to get specific items based on metadata
-- Each item in this list needs to have a recipe in the system to craft it. 
 
watchitems = {
    -- Ingots
    ["minecraft:iron_ingot"]            =  5000,    -- Iron Ingot
    ["minecraft:gold_ingot"]            =  5000,    -- Gold Ingot
    ["mekanism:ingot/1"]                =  5000,    -- Osmium Ingot
    ["thermalfoundation:material/130"]  =  5000,    -- Silver Ingot
    ["thermalfoundation:material/128"]  =  5000,    -- Copper Ingot
    ["thermalfoundation:material/160"]  =  5000,    -- Steel Ingot
    ["thermalfoundation:material/161"]  =  1000,    -- Electrum Ingot
    ["thermalfoundation:material/162"]  =  1000,    -- Invar Ingot
    ["thermalfoundation:material/167"]  =  1000,    -- Enderium Ingot
    ["thermalfoundation:material/129"]  =  5000,    -- Tin Ingot
    ["thermalfoundation:material/131"]  =  2000,    -- Lead Ingot
    ["thermalfoundation:material/163"]  =  1000,    -- Bronze Ingot
 
    -- Gems & Dusts
    ["minecraft:redstone"]              = 20000,    -- Redstone
    ["minecraft:dye/4"]                 =  5000,    -- Lapis Lazuli
    ["minecraft:diamond"]               =  5000,    -- Diamond
    ["minecraft:quartz"]                = 10000,    -- Nether Quartz
    ["appliedenergistics2:material/0"]  = 10000,    -- Certus Quartz Crystal
    ["appliedenergistics2:material/7"]  = 10000,    -- Fluix Crystal
    ["appliedenergistics2:material/11"] = 10000,    -- Pure Nether Quartz Crystal
    ["appliedenergistics2:material/10"] = 10000,    -- Pure Certus Quartz Crystal
    ["appliedenergistics2:material/12"] = 10000,    -- Pure Fluix Quartz Crystal
    ["appliedenergistics2:material/3"]  =  5000,    -- Nether Quartz Dust
    ["appliedenergistics2:material/2"]  =  5000,    -- Certuz Quartz Dust
    ["appliedenergistics2:material/8"]  =  5000,    -- Fluix Dust

    -- EnderIO Conduits
    ["enderio:item_power_conduit/2"]    =  1000,    -- Ender Energy Conduit
    ["enderio:item_item_conduit/0"]     =  1000,    -- Item Conduit
    ["enderio:item_liquid_conduit/2"]   =  1000,    -- Ender Fluid Conduit
    ["enderio:item_gas_conduit/2"]      =   200,    -- Ender Gas Conduit
    ["enderio:item_me_conduit/0"]       =  1000,    -- ME Conduit

    -- AE2 Components
    ["appliedenergistics2:material/24"] =  5000,    -- Engineering Processor
    ["appliedenergistics2:material/23"] =  5000,    -- Calculation Processor
    ["appliedenergistics2:material/22"] =  5000,    -- Logic Processor
    ["appliedenergistics2:material/20"] = 15000,    -- Printed Silicon
    ["appliedenergistics2:material/18"] =  5000,    -- Printed Logic Circuit
    ["appliedenergistics2:material/17"] =  5000,    -- Printed Engineering Circuit
    ["appliedenergistics2:material/16"] =  5000,    -- Printed Calculation Circuit
    ["appliedenergistics2:interface"]   =  1000,    -- ME Interface
    ["appliedenergistics2:part/240"]    =  1000,    -- ME Import Bus
    ["appliedenergistics2:part/260"]    =  1000,    -- ME Export Bus
    ["appliedenergistics2:part/16"]     =  5000,    -- ME Glass Cable
    ["appliedenergistics2:material/58"] =  1000,    -- Pattern Expansion Card
    ["appliedenergistics2:material/30"] =  1000,    -- Acceleration Card

    -- Mekanism Components
    ["mekanism:compressedredstone"]     =  1000,    -- Compressed Redstone
    ["mekanism:compressedcarbon"]       =  1000,    -- Compressed Carbon
    ["mekanism:compresseddiamond"]      =  1000,    -- Compressed Diamond


    -- Metal Plates
    ["thermalfoundation:material/32"]   =  1000,    -- Iron Plate
    ["thermalfoundation:material/33"]   =  1000,    -- Gold Plate
    ["thermalfoundation:material/320"]  =  5000,    -- Copper Plate
    ["thermalfoundation:material/352"]  =  5000,    -- Steel Plate
    ["thermalfoundation:material/354"]  =  1000,    -- Invar Plate
    ["thermalfoundation:material/321"]  =  5000,    -- Tin Plate
    ["thermalfoundation:material/323"]  =  1000,    -- Lead Plate
    ["thermalfoundation:material/355"]  =  1000,    -- Bronze Plate

    -- Blocks
    ["minecraft:glass"]                 = 20000,    -- Glass

    -- Performance Upgrades
    ["mekanism:speedupgrade"]           =  1000,    -- Speed Upgrade (Mekanism)
    ["mekanism:energyupgrade"]          =  1000,    -- Energy Upgrade (Mekanism)
    ["nuclearcraft:upgrade/0"]          =  1000,    -- Speed Upgrade (Nuclear Craft)
    ["nuclearcraft:upgrade/1"]          =  1000,    -- Energy Upgrade (Nuclear Craft)
    ["enderio:item_extract_speed_upgrade"] =  1000,    -- Speed Upgrade (EnderIO)
}
 
 
-- Infinite loop, can use alt-ctrl-c to break
while true do
 
  -- Check to see if we're getting redstone input from the top.  
  rs_input = rs.getInput(sides.top)
 
  -- Check if any CPU's are currently being used.
  cpus = ae2.getCpus()

  --TEST
  busy = 0
  for i in ipairs(cpus) do
    if cpus[i].busy == true then
        busy = busy + 1
    end
  end

  -- OFF FOR NOW
  --busy = false
  --for i in ipairs(cpus) do busy = cpus[i].busy or busy end
 
  -- If no CPU's are being used, and we're not getting a redstone signal from manual kill lever
  -- then we will run a loop of itemchecking.

  -- OFF FOR NOW
  --if rs_input > 0 and busy == false then
  if rs_input > 0 and busy < 6 then
    
    -- Iterate through each item in watchitems table
    for itemname,keepsize in pairs(watchitems) do
 
      -- String parsing to get out the damage/metadata value from our string
      -- thermalfoundation:material/2048 becomes
      --   itemname = thermalfoundation:material
      --   damage = 2048
      -- Anything without a metadata specified is 0
      if string.find(itemname,"/") ~= nil then
        delim = string.find(itemname, "/")
        len = string.len(itemname)
        damage = string.sub(itemname, delim + 1, len )
        itemname = string.sub(itemname, 1 , delim - 1 )
      else
        damage = 0
      end
 
      -- Query AE2 to find items in network
      item_in_network = ae2.getItemsInNetwork({name = itemname, damage = tonumber(damage)})[1]
 
      -- If response is nil, the item doesn't exist in the network, so we have 0
      if item_in_network == nil then
        stocksize = 0
      else
        stocksize = item_in_network.size
      end
 
      -- If we have less than we want...
      if keepsize > stocksize then
        reqsize = keepsize - stocksize
 
        -- This checks the AE2 system to find the crafting recipe with that name/damage
        recipe = ae2.getCraftables({name = itemname, damage = tonumber(damage)})[1]
 
        -- Recipe not found, probably a typo or you need to set up the recipe
        if recipe == nil then
          print(string.format("No recipe found for %s / %s, recipe not found", itemname, damage))
        else
          
          -- Request that the AE2 system craft the recipe. Returns a monitor object 
          -- Note that if we don't have enough items in the system to actually craft the amount requested
          -- we have no way of finding that out, the API just tells us that the craft was done immediately.
          
          --TEST - if the item has not been requested yet, then craft it. Otherwise skip it.
          if recipe.requesting() == 0 and busy < 6 then
            print(string.format("%s/%s: Have %s, Need %s ", itemname, damage, stocksize, keepsize))
            monitor = recipe.request(reqsize)
          end
 
          -- Wait for the craft to complete

          --while monitor.isDone() == false and monitor.isCanceled() == false do
          --  os.sleep(5)
          --end
          --print(string.format("%s/%s: crafted %s", itemname,damage,reqsize))
        
        end
      end
 
      -- Wait a bit so as not to hammer to the system
      os.sleep(5)
    end
  end  
 
  -- Wait a bit so as not to hammer to the system
  os.sleep(30)
end