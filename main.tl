local launcher = require("launcher")
local pong = require("demos.pong")
local snake = require("demos.snake")
local breakout = require("demos.breakout")

local screen: string = "launcher"

function love.load(): nil
   love.window.setTitle("Teal + LÖVE launcher")
end

function love.update(dt: number): nil
   if screen == "pong" then
      pong.update(dt)
   elseif screen == "snake" then
      snake.update(dt)
   elseif screen == "breakout" then
      breakout.update(dt)
   end
end

function love.keypressed(key: string): nil
   if screen == "launcher" then
      local action: string = launcher.keypressed(key)
      if action == "quit" then
         love.event.quit()
      elseif action == "pong" then
         screen = "pong"
         pong.reset()
         love.window.setTitle(pong.title)
      elseif action == "snake" then
         screen = "snake"
         snake.reset()
         love.window.setTitle(snake.title)
      elseif action == "breakout" then
         screen = "breakout"
         breakout.reset()
         love.window.setTitle(breakout.title)
      end
   elseif screen == "pong" then
      if key == "escape" then
         screen = "launcher"
         love.window.setTitle("Teal + LÖVE launcher")
      end
   elseif screen == "snake" then
      if key == "escape" then
         screen = "launcher"
         love.window.setTitle("Teal + LÖVE launcher")
      else
         snake.keypressed(key)
      end
   elseif screen == "breakout" then
      if key == "escape" then
         screen = "launcher"
         love.window.setTitle("Teal + LÖVE launcher")
      else
         breakout.keypressed(key)
      end
   end
end

function love.draw(): nil
   if screen == "launcher" then
      launcher.draw()
   elseif screen == "pong" then
      pong.draw()
   elseif screen == "breakout" then
      breakout.draw()
   else
      snake.draw()
   end
end
