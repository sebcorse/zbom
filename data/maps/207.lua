local map = ...
local game = map:get_game()

----------------------------------------
-- Dungeon 5: Lakebed Lair (Basement) --
----------------------------------------

map:register_event("on_started", function(self, destination)
  if not game:get_value("b1125") then chest_key_5:set_enabled(false) end
  map:set_doors_open("door_boss") -- shutter door
  map:set_doors_open("shutter_2")
  if not game:get_value("b1140") then map:set_entities_enabled("water_stream_chest", false) end
  if not game:get_value("b1131") then
    boss_plasmarine_blue:set_enabled(false)
    boss_plasmarine_red:set_enabled(false)
    to_outside:set_enabled(false)
  end
  if not game:get_value("b1791") then chest_crystal:set_enabled(false) end
  if not game:get_value("b1127") then chest_map:set_enabled(false) end
  if not game:get_value("b1134") then chest_book:set_enabled(false) end
  if not game:get_value("b1133") then boss_heart:set_enabled(false) end
  if game:get_value("b1141") then
    water_source_1:set_enabled(false)
    water_source_2:set_enabled(false)
    map:set_entities_enabled("water_stream", false)
    obstacle:set_enabled(false)
    obstacle_2:set_enabled(false)
  end
  pillar_1:set_enabled(false)
  pillar_2:set_enabled(false)
  hook_1:set_enabled(false)
end)

function door_bomb_1:on_opened()
  sol.audio.play_sound("water_drain")
  map:move_camera(1344, 736, 250, function()
    water_source_1:set_enabled(false)
    water_source_2:set_enabled(false)
    map:set_entities_enabled("water_stream", false)
    game:set_value("b1141", true)
    obstacle:set_enabled(false)
    obstacle_2:set_enabled(false)
  end, 250, 250)
end

function sensor_boss:on_activated()
  if boss_plasmarine_blue ~= nil and boss_plasmarine_red ~= nil then
    map:close_doors("door_boss")
    boss_plasmarine_blue:set_enabled(true)
    boss_plasmarine_red:set_enabled(true)
    sol.audio.play_music("boss")
  end
end

if boss_plasmarine_blue ~= nil and boss_plasmarine_red ~= nil then
  function boss_plasmarine_blue:on_dead()
    if boss_plasmarine_red == nil then -- both Plasmarines have to be dead to win
      game:set_value("b1131", true)
      map:open_doors("door_boss")
      sol.audio.play_sound("boss_killed")
      if boss_heart ~= nil then boss_heart:set_enabled(true) end
      chest_book:set_enabled(true); chest_blocker:set_enabled(true)
      sol.audio.play_sound("chest_appears")
      sol.audio.play_music("temple_lake")
      to_outside:set_enabled(true)
      map:open_doors("shutter_waterfall")
      sensor_close_shutter_waterfall:set_enabled(false)
    end
  end
  function boss_plasmarine_red:on_dead()
    if boss_plasmarine_blue == nil then -- both Plasmarines have to be dead to win
      game:set_value("b1131", true)
      map:open_doors("door_boss")
      sol.audio.play_sound("boss_killed")
      if boss_heart ~= nil then boss_heart:set_enabled(true) end
      chest_book:set_enabled(true)
      sol.audio.play_sound("chest_appears")
      sol.audio.play_music("temple_lake")
      to_outside:set_enabled(true)
      map:open_doors("shutter_waterfall")
      sensor_close_shutter_waterfall:set_enabled(false)
    end
  end
end

function sensor_open_shutter_1:on_activated()
  map:open_doors("shutter_1")
end
function sensor_close_shutter_1:on_activated()
  map:close_doors("shutter_1")
end

function sensor_close_shutter_2:on_activated()
  map:close_doors("shutter_2")
end

function sensor_open_shutter_3:on_activated()
  map:open_doors("shutter_3")
end
function sensor_close_shutter_3:on_activated()
  map:close_doors("shutter_3")
end

function sensor_open_shutter_waterfall:on_activated()
  if game:get_value("b1141") then
    map:open_doors("shutter_waterfall")
    obstacle:set_enabled(false)
    obstacle_2:set_enabled(false)
  else
    game:start_dialog("lakebed.waterfall")
  end
end
function sensor_close_shutter_waterfall:on_activated()
  map:close_doors("shutter_waterfall")
end

function switch_water_chest:on_activated()
  game:set_value("b1140", true)
  map:set_entities_enabled("water_stream_chest", true)
  sol.audio.play_sound("secret")
end

function switch_stone:on_activated()
  pillar_1:set_enabled(true)
  pillar_2:set_enabled(true)
  hook_1:set_enabled(true)
end
function switch_stone:on_inactivated()
  pillar_1:set_enabled(false)
  pillar_2:set_enabled(false)
  hook_1:set_enabled(false)
end

function switch_arrow_map:on_activated()
  chest_map:set_enabled(true)
  sol.audio.play_sound("chest_appears")
end

for enemy in map:get_entities("aquadracini") do
  enemy.on_dead = function()
    if not map:has_entities("aquadracini") then
      chest_key_5:set_enabled(true)
      sol.audio.play_sound("chest_appears")
    end
  end
end

for enemy in map:get_entities("chuchu") do
  enemy.on_dead = function()
    if not map:has_entities("chuchu") then
      map:open_doors("shutter_2")
    end
  end
end

for enemy in map:get_entities("leever") do
  enemy.on_dead = function()
    if not map:has_entities("leever_room12") then
      chest_crystal:set_enabled(true)
      sol.audio.play_sound("chest_appears")
    end
  end
end

function sensor_reset_ground_1:on_activated()
  hero:reset_solid_ground()
end
function sensor_reset_ground_2:on_activated()
  hero:reset_solid_ground()
end
function sensor_reset_ground_3:on_activated()
  hero:reset_solid_ground()
end
function sensor_reset_ground_4:on_activated()
  hero:reset_solid_ground()
end

function chest_book:on_opened(item, variant, savegame_variable)
  -- Dynamically determine book variant to give, since dungeons can be done in any order.
  local book_variant = game:get_item("book_mudora"):get_variant() + 1
  map:get_hero():start_treasure("book_mudora", book_variant)
  game:set_dungeon_finished(5)
  game:set_value("b1134", true) -- This value varies depending on the dungeon (chest save value)
end