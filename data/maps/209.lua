local map = ...
local game = map:get_game()

-------------------------------------------
-- Dungeon 5: Snowpeak Caverns (Floor 2) --
-------------------------------------------

map:register_event("on_started", function(self, destination)
  local _, _, layer = hero:get_position()
  hero:save_solid_ground(176, 992, layer) -- If falling from above, can end up in an infinate loop of death!
  if not game:get_value("b1147") then
    boss_stalfos:set_enabled(false)
  else map:open_doors("door_boss") end
  if not game:get_value("b1149") then boss_heart:set_enabled(false) end
  if not game:get_value("b1153") then chest_key_2:set_enabled(false) end
  if not game:get_value("b1155") then chest_key_3:set_enabled(false) end
end)

function switch_star_1:on_activated()
  switch_star_2:set_activated(false)
  local positions_1 = {
    {x = 152, y = 1368},
    {x = 376, y = 1336},
    {x = 464, y = 1520},
    {x = 608, y = 1352},
    {x = 376, y = 1536},
    {x = 496, y = 1336},
    {x = 640, y = 1560}
  }
  local positions_2 = {
    {x = 280, y = 1368},
    {x = 432, y = 1576},
    {x = 464, y = 1464},
    {x = 560, y = 1512},
    {x = 448, y = 1416},
    {x = 496, y = 1368},
    {x = 544, y = 1416}
  }
  local c = map:get_entities_count("hole_puzzle")
  for i=1,c do
    local ex, ey, el = map:get_entity("hole_puzzle_"..c):get_position()
    if (ex == positions_2[c].x) and (ey == positions_2[c].y) then
      map:get_entity("hole_puzzle_"..i):set_position(positions_1[i].x, positions_1[i].y)
    else
      map:get_entity("hole_puzzle_"..i):set_position(positions_2[i].x, positions_2[i].y)
    end
  end
end
function switch_star_2:on_activated()
  switch_star_1:set_activated(false)
  local positions_1 = {
    {x = 152, y = 1368},
    {x = 376, y = 1336},
    {x = 464, y = 1520},
    {x = 608, y = 1352},
    {x = 376, y = 1536},
    {x = 496, y = 1336},
    {x = 640, y = 1560}
  }
  local positions_2 = {
    {x = 280, y = 1368},
    {x = 432, y = 1576},
    {x = 464, y = 1464},
    {x = 560, y = 1512},
    {x = 448, y = 1416},
    {x = 496, y = 1368},
    {x = 544, y = 1416}
  }
  local c = map:get_entities_count("hole_puzzle")
  for i=1,c do
    local ex, ey, el = map:get_entity("hole_puzzle_"..c):get_position()
    if (ex == positions_2[c].x) and (ey == positions_2[c].y) then
      map:get_entity("hole_puzzle_"..i):set_position(positions_1[i].x, positions_1[i].y)
    else
      map:get_entity("hole_puzzle_"..i):set_position(positions_2[i].x, positions_2[i].y)
    end
  end
end

function switch_star_boss:on_activated()
  switch_star_boss_2:set_activated(false)
  local positions_1 = {
    {x = 480, y = 264},
    {x = 584, y = 344},
    {x = 696, y = 280},
    {x = 880, y = 240},
    {x = 800, y = 104},
    {x = 768, y = 864}
  }
  local positions_2 = {
    {x = 512, y = 288},
    {x = 704, y = 256},
    {x = 768, y = 168},
    {x = 912, y = 64},
    {x = 816, y = 368},
    {x = 880, y = 864}
  }
  local c = map:get_entities_count("hole_boss")
  for i=1,c do
    local ex, ey, el = map:get_entity("hole_boss_"..c):get_position()
    if (ex == positions_2[c].x) and (ey == positions_2[c].y) then
      map:get_entity("hole_boss_"..i):set_position(positions_1[i].x, positions_1[i].y)
    else
      map:get_entity("hole_boss_"..i):set_position(positions_2[i].x, positions_2[i].y)
    end
  end
end

function switch_star_boss_2:on_activated()
  hero:save_solid_ground(848, 405, 1)
  switch_star_boss:set_activated(false)
  local positions_1 = {
    {x = 480, y = 264},
    {x = 584, y = 344},
    {x = 696, y = 280},
    {x = 880, y = 240},
    {x = 800, y = 104},
    {x = 768, y = 864}
  }
  local positions_2 = {
    {x = 512, y = 288},
    {x = 704, y = 256},
    {x = 768, y = 168},
    {x = 912, y = 64},
    {x = 816, y = 368},
    {x = 880, y = 864}
  }
  local c = map:get_entities_count("hole_boss")
  for i=1,c do
    local ex, ey, el = map:get_entity("hole_boss_"..c):get_position()
    if (ex == positions_2[c].x) and (ey == positions_2[c].y) then
      map:get_entity("hole_boss_"..i):set_position(positions_1[i].x, positions_1[i].y)
    else
      map:get_entity("hole_boss_"..i):set_position(positions_2[i].x, positions_2[i].y)
    end
  end
end

function switch_bridge1:on_activated()
  bridge1:set_enabled(true)
end
function switch_bridge1:on_inactivated()
  bridge1:set_enabled(false)
end

function switch_bridge2:on_activated()
  bridge2:set_enabled(true)
end
function switch_bridge2:on_inactivated()
  bridge2:set_enabled(false)
end

function switch_bridge3:on_activated()
  bridge3_1:set_enabled(true)
  bridge3_2:set_enabled(true)
end
function switch_bridge3:on_inactivated()
  bridge3_1:set_enabled(false)
  bridge3_2:set_enabled(false)
end

function switch_bridge4:on_activated()
  bridge4:set_enabled(true)
end
function switch_bridge4:on_inactivated()
  bridge4:set_enabled(false)
end

function switch_bridge5:on_activated()
  bridge5:set_enabled(true)
  bridge6_1:set_enabled(false)
  bridge6_2:set_enabled(false)
end
function switch_bridge5:on_inactivated()
  bridge5:set_enabled(false)
  bridge6_1:set_enabled(true)
  bridge6_2:set_enabled(true)
end

function sensor_save_ground:on_activated()
  hero:reset_solid_ground()
  hero:save_solid_ground()
end
function sensor_reset_ground:on_activated()
  hero:reset_solid_ground()
end

for enemy in map:get_entities("room7_hardhat") do
  enemy.on_dead = function()
    if not map:has_entities("room7_hardhat") and not game:get_value("b1153") then
      chest_key_2:set_enabled(true)
      sol.audio.play_sound("chest_appears")
    end
  end
end

for enemy in map:get_entities("room5_hardhat") do
  enemy.on_dead = function()
    if not map:has_entities("room5_hardhat") and not game:get_value("b1155") then
      chest_key_3:set_enabled(true)
      sol.audio.play_sound("chest_appears")
    end
  end
end

function sensor_boss:on_activated()
  if boss_stalfos ~= nil then
    map:close_doors("door_boss")
    boss_stalfos:set_enabled(true)
    sol.audio.play_music("boss")
  end
end

if boss_stalfos ~= nil then
  function boss_stalfos:on_dead()
    map:open_doors("door_boss")
    sol.audio.play_sound("boss_killed")
    boss_heart:set_enabled(true)
    sol.timer.start(1000, function()
      sol.audio.play_music("temple_snow")
    end)
    pit_boss_1_7:set_filled()
    pit_boss_1_8:set_filled()
    pit_boss_1_9:set_filled()
    pit_boss_2_7:set_filled()
    pit_boss_2_8:set_filled()
  end
end

function chest_book:on_opened(item, variant, savegame_variable)
  -- Dynamically determine book variant to give, since dungeons can be done in any order.
  local book_variant = game:get_item("book_mudora"):get_variant() + 1
  map:get_hero():start_treasure("book_mudora", book_variant)
  game:set_dungeon_finished(6)
  game:set_value("b1150", true) -- This value varies depending on the dungeon (chest save value)
end