local map = ...
local game = map:get_game()
local hero = map:get_hero()

---------------------------------------
-- Dungeon 5: Lakebed Lair (Floor 1) --
---------------------------------------

map:register_event("on_started", function(self, destination)
  to_basement:set_enabled(false)
  if not game:get_value("b1129") then chest_big_key:set_enabled(false) end
  if game:get_value("b1128") then
    map:open_doors("door_miniboss")
  else miniboss_aquadraco:set_enabled(false) end
  if game:get_value("b1140") then
    water_chest:set_enabled(false)
    sensor_room_flooded:set_enabled(false)
    obstacle:set_enabled(false)
  end
  if game:get_value("b1134") then
    water_room1_1:set_enabled(false)
    water_room1_2:set_enabled(false)
    to_outside:set_destination_name("from_lair_finished")
    grate:set_enabled(false)
    to_basement:set_enabled(true)
  else npc_zora:set_enabled(false) end
  if not game:get_value("b1126") then chest_compass:set_enabled(false) end
  if game:get_value("b1112") then
    grate:set_enabled(false)
    to_basement:set_enabled(true)
  end
end)

function sensor_miniboss:on_activated()
  if miniboss_aquadraco ~= nil then
    map:close_doors("door_miniboss")
    miniboss_aquadraco:set_enabled(true)
    sol.audio.play_music("boss")
  end
end

if miniboss_aquadraco ~= nil then
  function miniboss_aquadraco:on_dead()
    map:open_doors("door_miniboss")
    sol.audio.play_sound("boss_killed")
    sol.timer.start(1000, function()
      sol.audio.play_music("temple_lake")
    end)
  end
end

function sensor_room_flooded:on_activated()
  if hero:get_direction() == 3 then
    game:start_dialog("lakebed.room_flooded")
  end
end

function switch_puzzle_1:on_activated()
  spikes_puzzle:set_enabled(false)
end
function switch_puzzle_1:on_inactivated()
  spikes_puzzle:set_enabled(true)
end

function switch_puzzle_2:on_activated()
  map:move_camera(352, 400, 250, function()
    map:open_doors("door_puzzle")
  end, 500, 500)
end
function switch_puzzle_2:on_inactivated()
  map:move_camera(352, 400, 300, function()
    map:close_doors("door_puzzle")
  end, 400, 400)
end

for enemy in map:get_entities("aquadracini") do
  enemy.on_dead = function()
    if not map:has_entities("aquadracini") and not game:get_value("b1129") then
      chest_big_key:set_enabled(true)
      sol.audio.play_sound("chest_appears")
    end
  end
end

for enemy in map:get_entities("tektite") do
  enemy.on_dead = function()
    if not map:has_entities("tektite") then
      map:move_camera(1456, 624, 250, function()
        grate:set_enabled(false)
        to_basement:set_enabled(true)
        sol.audio.play_sound("secret")
        game:set_value("b1112", true)
      end, 500, 500)
    end
  end
end

for enemy in map:get_entities("chuchu") do
  enemy.on_dead = function()
    if not map:has_entities("chuchu_room13") then
      chest_compass:set_enabled(true)
      sol.audio.play_sound("chest_appears")
    end
  end
end

function set_intermediate_layer:on_activated()
  local x, y, l = hero:get_position()
  hero:set_position(x, y, 1)
end
function set_intermediate_layer_2:on_activated()
  local x, y, l = hero:get_position()
  hero:set_position(x, y, 1)
end

function npc_zora:on_interaction()
  if not game:get_value("b1124") then
    game:start_dialog("zora.1.lakebed", function(answer)
      if answer == 1 then
        hero:start_treasure("small_key")
        game:set_value("b1124", true)
      end
    end)
  else
    game:start_dialog("zora.0.lakebed")
  end
end

function sensor_reset_ground_1:on_activated()
  hero:save_solid_ground(hero:get_position())
end
function sensor_reset_ground_2:on_activated()
  hero:save_solid_ground(hero:get_position())
end
function sensor_reset_ground_3:on_activated()
  hero:save_solid_ground(hero:get_position())
end
function sensor_reset_ground_4:on_activated()
  hero:save_solid_ground(hero:get_position())
end
function sensor_reset_ground_5:on_activated()
  hero:save_solid_ground(hero:get_position())
end