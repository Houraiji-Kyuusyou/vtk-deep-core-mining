function get_filtered_amount(amount)
    -- spawn deep core ore chunks depending on the ore patch removed amount
    -- 10 000 = 3%
    -- 300% = 1 000 000
    -- Set to 10% of amount by removing ore patch and max 1 000 chunks (stacks to 100, so 10 stacks to be transportable)
    -- eg : Yields 100 per refine, so total = 1 000 000
    local amountospawn = 0.1 * amount
    -- prevent too much spawning if amount is over the top (ie creative mod / cheating, etc).
    if amountospawn > 1000 then
        amountospawn = 1000
    elseif amountospawn < 10 then
        amountospawn = 10
    end
    
    return amountospawn
end

function get_patchable_ores()
  local patchableOres =  {
    ["iron-ore"] = "iron-ore",
    ["copper-ore"] = "copper-ore", 
    ["coal"] = "coal", 
    ["stone"] = "stone", 
    ["uranium-ore"] = "uranium-ore", 
  }

  -- SimpleSilicon's ore support
  if game.active_mods["SimpleSilicon"] then
    patchableOres = table.merge(patchableOres, {["SiSi-quartz-ore"] = "SiSi-quartz"})
  end

  -- Angel's ore support
  if game.active_mods["angelsrefining"] then
    local angelsores = {
      ["angels-ore1"] = "angels-ore1", 
      ["angels-ore2"] = "angels-ore2", 
      ["angels-ore3"] = "angels-ore3", 
      ["angels-ore4"] = "angels-ore4", 
      ["angels-ore5"] = "angels-ore5", 
      ["angels-ore6"] = "angels-ore6", 
    }
    patchableOres = table.merge(patchableOres, angelsores)
  end
  
  -- Clowns Extended Minerals ore support
  if game.active_mods["Clowns-Extended-Minerals"] then
    local clownssores = {
      ["clowns-ore1"] = "clowns-ore1", 
      ["clowns-ore2"] = "clowns-ore2", 
      ["clowns-ore3"] = "clowns-ore3", 
      ["clowns-ore4"] = "clowns-ore4", 
      ["clowns-ore5"] = "clowns-ore5", 
      ["clowns-ore6"] = "clowns-ore6", 
      ["clowns-ore7"] = "clowns-ore7", 
    }
    patchableOres = table.merge(patchableOres, clownssores)
  end

  -- Bob's ore support
  if game.active_mods["bobores"] and not game.active_mods["angelsrefining"] then
    local bobores = {
      ["tin-ore"] = "tin-ore", 
      ["lead-ore"] = "lead-ore",
      ["quartz"] = "quartz", 
      ["silver-ore"] = "silver-ore", 
      ["zinc-ore"] = "zinc-ore", 
      ["gold-ore"] = "gold-ore", 
      ["bauxite-ore"] = "bauxite-ore", 
      ["rutile-ore"] = "rutile-ore", 
      ["tungsten-ore"] = "tungsten-ore", 
      ["thorium-ore"] = "thorium-ore", 
      ["nickel-ore"] = "nickel-ore", 
      ["cobalt-ore"] = "cobalt-ore", 
      ["sulfur"] = "sulfur", 
      ["gem-ore"] = "gem-ore", 
    }
    patchableOres = table.merge(patchableOres, bobores)
  end
  
  -- Krastorio2's ore support
  if game.active_mods["Krastorio2"] then
    patchableOres = table.merge(patchableOres, {["rare-metals"] = "raw-rare-metals"})
  end
  
  -- Leighzer's Morphite support
  if game.active_mods["leighzermorphite"] then
    local leighzermorphite = {
      ["morphite-ore"] = "morphite-ore",
    }
    patchableOres = table.merge(patchableOres, leighzermorphite)
  end

  -- Pyanodons Raw Ores support
  if game.active_mods["pyrawores"] then
    local pyrawores = {
      ["ore-tin"] = "ore-tin",
      ["ore-quartz"] = "ore-quartz",
      ["ore-aluminium"] = "ore-aluminium",
      ["ore-chromium"] = "ore-chromium",
      ["ore-lead"] = "ore-lead",
      ["ore-nickel"] = "ore-nickel",
      ["raw-coal"] = "raw-coal",
      ["ore-titanium"] = "ore-titanium",
      ["ore-zinc"] = "ore-zinc",
    }
    patchableOres = table.merge(patchableOres, pyrawores)
  end

  -- Pyanodons Coal Processing support
  if game.active_mods["pycoalprocessing"] then
    local pycoalprocessing = {
      ["borax"] = "raw-borax",
      ["niobium"] = "niobium-ore",
    }
    patchableOres = table.merge(patchableOres, pycoalprocessing)
  end

  -- Brevvens's Titanium support
  if game.active_mods["bztitanium"] then
    local bztitanium = {
      ["titanium-ore"] = "titanium-ore",
    }
    patchableOres = table.merge(patchableOres, bztitanium)
  end

  -- Brevvens's Lead support
  if game.active_mods["bzlead"] and not game.active_mods["bobores"] and not game.active_mods["angelsrefining"] then
    local bzlead = {
      ["lead-ore"] = "lead-ore",
    }
    patchableOres = table.merge(patchableOres, bzlead)
  end

  -- Brevvens's Tungsten support
  if game.active_mods["bztungsten"] and not game.active_mods["bobores"] then
    local bztungsten = {
      ["tungsten-ore"] = "tungsten-ore",
    }
    patchableOres = table.merge(patchableOres, bztungsten)
  end

  -- Brevvens's Zirconium support
  if game.active_mods["bzzirconium"] then
    local bzzirconium = {
      ["zircon"] = "zircon",
    }
    patchableOres = table.merge(patchableOres, bzzirconium)
  end

  -- Space Exploration Ores support
  if game.active_mods["space-exploration"] then
    local seore = {
      ["se-beryllium-ore"] = "se-beryllium-ore",
      ["se-cryonite"] = "se-cryonite",
      ["se-holmium-ore"] = "se-holmium-ore",
      ["se-iridium-ore"] = "se-iridium-ore",
      ["se-naquium-ore"] = "se-naquium-ore",
      ["se-vulcanite"] = "se-vulcanite",
      ["se-vitamelange"] = "se-vitamelange",
    }
    patchableOres = table.merge(patchableOres, seore)
  end
  
  return patchableOres
end

function get_all_patches()
  local patches = {}
  for _,ore in pairs(get_patchable_ores()) do
      table.insert(patches, ore.."-patch")
      table.insert(patches, ore.."-patch-ore")
      table.insert(patches, ore.."-patch-chunk")
  end
  return patches
end

function spawn_ore_patch_on_depleted_ore(event)
    local ore = event.entity
    local surface = ore.surface
    local areaToScan = Position.expand_to_area(ore.position, settings.global["vtk-deep-core-mining-patch-spawn-distance"].value)
    local minspawnrange = settings.global["vtk-deep-core-mining-spawn-radius-from-start"].value
    local minrichness = settings.global["vtk-deep-core-mining-patch-min-richness"].value
    local maxrichness = settings.global["vtk-deep-core-mining-patch-max-richness"].value
    local patchableOres = get_patchable_ores()
    
    -- since it is a user setting, it is possible to break things up, making sure this won't
    if minrichness > maxrichness then
        minrichness = maxrichness
    end

    -- Add support for Dirty Mining of supported ore patches
    if game.active_mods["DirtyMining"] then
        local dirtyores = {}
        for orename, oreresult in pairs(patchableOres) do
          local dirtyorename = 'dirty-ore-'..orename
          if game.entity_prototypes[dirtyorename] then
            dirtyores = table.merge(dirtyores, {[dirtyorename] = oreresult})
          end
        end
        patchableOres = table.merge(patchableOres, dirtyores)
    end
    
    -- When Prospector is installed, only generate patches after the last deposit is exhausted
    -- Prospector is currently not really compatible to DirtyMining, so only enable this feature when DirtyMining is absent
    if game.active_mods["Prospector"] and not game.active_mods["DirtyMining"] then
      local patchableOresNew = {}
      for key, name in pairs(patchableOres) do
          local key_seam = key.."-seam"
          if game.entity_prototypes[key_seam] ~= nil then
              patchableOresNew = table.merge(patchableOresNew, {[key_seam] = name})
          else
              patchableOresNew = table.merge(patchableOresNew, {[key] = name})
          end
      end
      patchableOres = patchableOresNew
  end

    -- logic : 
    -- - if depleted ore has an equivalent patch entity
    -- - configuration(default 10) % chance to spawn an ore patch on depletion
    -- - check if there isn't a nearby ore patch already
    -- - then spawn it on the location the ore was depleted
    
    -- debug
    -- local player = game.players[1]
    -- player.print("VTK-DEEP-CORE-MINING_DEBUG")
    -- player.print("mined ore : "..serpent.block(ore.name))
    -- player.print(serpent.block(player))
    
    local validOre = false
    local orePatchToSpawn = nil
    for patchableOre, oreresult in pairs(patchableOres) do
        -- need to pass true for "plain" search as 4th param because some ore have a "-" and it is a special character for lua string.find() apparently ...
        -- if string.find(patchableOre, ore.name, 1, true) then 
        if patchableOre == ore.name then
            if settings.global["vtk-deep-core-mining-spawn-"..oreresult.."-patch"]
            and settings.global["vtk-deep-core-mining-spawn-"..oreresult.."-patch"].value then
                validOre = true
                orePatchToSpawn = oreresult.."-patch"
                break
            end
        end
    end
    
    if validOre and not Area.inside(Position.expand_to_area({0,0}, minspawnrange), ore.position) then
        local number = math.random(1, settings.global["vtk-deep-core-mining-patch-spawn-chance"].value)
        
        local patches = get_all_patches()
        entitiesCount = surface.count_entities_filtered{area = areaToScan, name = patches}
        
        if number == 1 and entitiesCount == 0 then
            oreamount = math.random(minrichness, maxrichness)
            local newOreEntity = surface.create_entity({name = orePatchToSpawn, amount = oreamount, position = ore.position, force = game.forces.neutral, raise_built = true})
        end
    end
  
end


function place_deep_core_cracks(area, surface)
    if not settings.global["vtk-deep-core-mining-spawn-cracks"].value then
        return
    end
    
    local minspawnrange = settings.global["vtk-deep-core-mining-spawn-radius-from-start"].value
    
  -- debug
  -- local player = game.players[1]
  -- player.print("VTK-DEEP-CORE-MINING_DEBUG")

    -- only spawn deep core mining cracks in nauvis
    -- supports New Game Plus mod's "Nauvis plus" worlds
    if surface.name ~= "nauvis" and not string.contains(surface.name, "Nauvis plus") then
        return
    end
    
    -- lucky day ? (1 / 500)
    local luck = math.random(1, settings.global["vtk-deep-core-mining-crack-spawn-chance"].value)
  -- debug player.print(serpent.block(luck))
    if luck ~= 250 then
        return
    end

    -- check if there's already an entity present here (shouldn't but just in case)
    entitiesCount = surface.count_entities_filtered{area = area, name = "vtk-deepcore-mining-crack"}
  -- debug player.print(serpent.block(entitiesCount))

    if entitiesCount ~= 0 then
        return
    end
    
  -- minimum distance from spawn where deepcore mining cracks appear (default 1)
  -- debug
  -- player.print("setting value "..minspawnrange)
  -- player.print("position x "..x1.." y "..y1)

  if Area.inside(Position.expand_to_area({0,0}, minspawnrange), {area.left_top.x, area.left_top.y}) then
    return
  end
  
  create_crack(surface, area, 1)
end

function create_crack(surface, area, cracks)

  local stop = math.random(settings.global["vtk-deep-core-mining-spawn-min-group"].value, settings.global["vtk-deep-core-mining-spawn-max-group"].value)
  if cracks > stop then
    return
  end

  local x1 = area.left_top.x
  local y1 = area.left_top.y
  local x2 = area.right_bottom.x
  local y2 = area.right_bottom.y
  
  local crackrichness = settings.global["vtk-deep-core-mining-crack-richness"].value
  local attempts = 0
  -- try 10 times to find a valid position to spawn a crack otherwise abandon
  while attempts < 10 do
      local x = math.random(x1, x2)
      local y = math.random(y1, y2)
      
      local tile = surface.get_tile(x, y)
  -- debug player.print(serpent.block(tile.name))
    
      if tile.valid and surface.can_place_entity{name = "vtk-deepcore-mining-crack", position = tile.position} then
          local oreamount = crackrichness
          local createdentity = surface.create_entity({name = "vtk-deepcore-mining-crack", amount = oreamount, position = tile.position, force = game.forces.neutral})
          
          -- cleanup decoratives around the newly spawned crack
          local cleanupzone = Area.construct(createdentity.position.x, createdentity.position.y, createdentity.position.x, createdentity.position.y)
          surface.destroy_decoratives({area=Area.expand(cleanupzone, 0.6)})
    -- debug
    -- player.print("vtk-deepcore-mining-crack placed successfully")
    -- player.print(serpent.block(tile.position))
    -- player.print(serpent.block(cleanupzone))

          -- a crack was spawned succesfully, let's continue to try to spawn a group up to a maxium recurcively
          cracks = cracks + 1
          create_crack(surface, Area.expand(cleanupzone, 20), cracks)
          return
      end
      attempts = attempts + 1
  end
end


function remove_ore_patch(player, surface, area, entities)
    local patchescount = 0
    local sulfuricpatchescount = 0
    local chlorinepatchescount = 0
    local dronescount = player.get_item_count("vtk-deepcore-mining-drone")
    local patches = {}
    local sulfuricpatches = {}
    local todo = true
    local sulfuricacidbarrel = "sulfuric-acid-barrel"
    if game.active_mods["angelspetrochem"] then
        sulfuricacidbarrel = "liquid-sulfuric-acid-barrel"
    end
    local sulfuricacidbarrelcount = player.get_item_count(sulfuricacidbarrel)
    local chlorinebarrelcount = 0
    
    if game.active_mods["Krastorio2"] then
      local chlorinebarrelcount = player.get_item_count("chlorine-barrel")
    end

    -- debug
    -- player.print("inventory : "..serpent.line(player.get_inventory(defines.inventory.player_main).get_contents()))
    for _,entity in pairs(entities) do
      -- player.print("entity : "..serpent.line(entity))
      -- player.print("entity : "..serpent.block(entity))
      -- player.print("name : "..entity.name)
      -- player.print("type : "..entity.type)
      -- player.print("entity proto : "..serpent.block(entity.prototype))
      -- player.print("proto : "..serpent.line(game.entity_prototypes[entity.name].name))
      -- player.print("cat : "..game.entity_prototypes[entity.name].resource_category)
      -- player.print("entity proto name : "..serpent.block(entity.prototype.name))
      -- player.print("entity proto cat : "..serpent.block(entity.prototype.resource_category))

        if entity.type == "resource"
            and (entity.prototype.resource_category == "vtk-deepcore-mining-ore-patch" 
            or entity.prototype.resource_category == "vtk-deepcore-mining-crack")
        then
            table.insert(patches, entity)
            patchescount = patchescount + 1
            if entity.name == "uranium-ore-patch" or entity.name == "vtk-deepcore-mining-crack" then
                sulfuricpatchescount = sulfuricpatchescount + 1
            end
            if entity.name == "rare-metals" then
                chlorinepatchescount = chlorinepatchescount + 1
            end
        end
    end
    
    -- nothing todo ?
    if patchescount <= 0 then
        todo = false
    end
    -- display all requirements if not enough in inventory
    if dronescount < patchescount then
        player.print("Not enough Deep Core mining drones. "..patchescount.." needed only "..dronescount.." in inventory.")
        todo = false
    end
    if sulfuricacidbarrelcount < sulfuricpatchescount then
        player.print("Not enough sulfuric acid barrel. "..sulfuricpatchescount.." needed only "..sulfuricacidbarrelcount.." in inventory.")
        todo = false
    end
    if chlorinepatchescount < chlorinebarrelcount then
        player.print("Not enough chlorine acid barrel. "..chlorinepatchescount.." needed only "..chlorinebarrelcount.." in inventory.")
        todo = false
    end
    if not todo then
        return
    end
    
    -- removing !
    for _,entity in pairs(patches) do
        local amountospawn = get_filtered_amount(entity.amount)
        -- debug
        -- player.print("VTK-DEEP-CORE-MINING_DEBUG")
        -- player.print("Found "..patchescount.." patches to remove and "..sulfuricpatchescount.." sulfuric patches to remove")
        -- player.print(serpent.block(entity.name))
        -- player.print(serpent.block(entity.amount))
        -- player.print(serpent.block(amountospawn))

        if entity.name == "vtk-deepcore-mining-crack" then
          surface.spill_item_stack(entity.position, {name="vtk-deepcore-mining-ore-chunk", count = amountospawn}, true)
        
        elseif (entity.prototype.resource_category == "vtk-deepcore-mining-ore-patch") then
          local chunk = string.sub(entity.name, 1, -7) -- "iron-ore-patch"
          surface.spill_item_stack(entity.position, {name="vtk-deepcore-mining-"..chunk.."-chunk", count = amountospawn}, true)

        end
        entity.destroy({raise_destroy = true})
    end
    
    player.remove_item{name="vtk-deepcore-mining-drone", count = patchescount}
    if sulfuricpatchescount > 0 then
        player.remove_item{name=sulfuricacidbarrel, count = sulfuricpatchescount}
    end
	
    if chlorinepatchescount > 0 then
      player.remove_item{name="chlorine-barrel", count = chlorinepatchescount}
  end
end