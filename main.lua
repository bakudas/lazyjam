-- Import the library
debugGraph = require 'libs/debugGraph'
player = require 'player'
baton = require 'libs/baton'

-- Inputs
local input = baton.new {
  controls = {
    left = {'key:left', 'key:a', 'axis:leftx-', 'button:dpleft'},
    right = {'key:right', 'key:d', 'axis:leftx+', 'button:dpright'},
    up = {'key:up', 'key:w', 'axis:lefty-', 'button:dpup'},
    down = {'key:down', 'key:s', 'axis:lefty+', 'button:dpdown'},
    action = {'key:x', 'button:a'},
  },
  pairs = {
    move = {'left', 'right', 'up', 'down'}
  },
  joystick = love.joystick.getJoysticks()[1],
}

-- https://love2d.org/wiki/General_math
-- Returns 'n' rounded to the nearest 'deci'th (defaulting whole numbers).
function math.round(n, deci)
  deci = 10^(deci or 0)
  return math.floor(n*deci+.5)/deci
end

function love.load()
  --debug graph
  fpsGraph = debugGraph:new('fps', 0, 0)
  memGraph = debugGraph:new('mem', 0, 30)
  dtGraph = debugGraph:new('custom', 0, 60)

  jogador = player:new('line', 100, 200, 30, 10)

end

function love.draw()
  -- Draw graphs
  fpsGraph:draw()
  memGraph:draw()
  dtGraph:draw()

  -- desenha o player
  jogador:draw()

end

function love.update(dt)

  -- Update player
  jogador:debug() -- texto de debug player

  -- Update the inputs
  input:update()

  local x, y = input:get 'move'
  jogador.x, jogador.y = jogador.x + x*10, jogador.y + y*10 

  -- Update the graphs
  fpsGraph:update(dt)
  memGraph:update(dt)

  -- Update our custom graph
  dtGraph:update(dt, math.floor(dt * 1000))
  dtGraph.label = 'DT: ' ..  math.round(dt, 4)

end


function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  end
end