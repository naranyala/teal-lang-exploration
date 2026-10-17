local M = {
   title = "Snake",
}

local record Segment
   x: number
   y: number
end

local record FoodPosition
   x: number
   y: number
end

local grid_size: number = 20
local cell_size: number = 20
local step_time: number = 0.12
local elapsed: number = 0
local direction_x: number = 1
local direction_y: number = 0
local next_direction_x: number = 1
local next_direction_y: number = 0
local food_x: number = 20
local food_y: number = 10
local food_index: integer = 1
local game_over: boolean = false
local snake: {Segment} = {}

local food_positions: {FoodPosition} = {
   { x = 15, y = 10 },
   { x = 6, y = 5 },
   { x = 16, y = 18 },
   { x = 12, y = 4 },
   { x = 3, y = 15 },
}

function M.reset(): nil
   snake = {
      { x = 8, y = 12 },
      { x = 7, y = 12 },
      { x = 6, y = 12 },
   }
   direction_x = 1
   direction_y = 0
   next_direction_x = 1
   next_direction_y = 0
   food_index = 1
   food_x = food_positions[food_index].x
   food_y = food_positions[food_index].y
   elapsed = 0
   game_over = false
end

local function occupies(x: number, y: number): boolean
   for _, segment in ipairs(snake) do
      if segment.x == x and segment.y == y then return true end
   end
   return false
end

local function advance_food(): nil
   food_index = food_index + 1
   if food_index > #food_positions then food_index = 1 end
   food_x = food_positions[food_index].x
   food_y = food_positions[food_index].y
end

local function step(): nil
   direction_x = next_direction_x
   direction_y = next_direction_y
   local head: Segment = snake[1]
   local next_x: number = head.x + direction_x
   local next_y: number = head.y + direction_y

   if next_x < 0 or next_x >= grid_size or next_y < 0 or next_y >= grid_size or occupies(next_x, next_y) then
      game_over = true
      return
   end

   table.insert(snake, 1, { x = next_x, y = next_y })
   if next_x == food_x and next_y == food_y then
      advance_food()
   else
      table.remove(snake)
   end
end

function M.update(dt: number): nil
   if game_over then return end
   elapsed = elapsed + dt
   if elapsed >= step_time then
      elapsed = elapsed - step_time
      step()
   end
end

function M.keypressed(key: string): nil
   if key == "r" and game_over then
      M.reset()
   elseif (key == "up" or key == "w") and direction_y ~= 1 then
      next_direction_x = 0
      next_direction_y = -1
   elseif (key == "down" or key == "s") and direction_y ~= -1 then
      next_direction_x = 0
      next_direction_y = 1
   elseif (key == "left" or key == "a") and direction_x ~= 1 then
      next_direction_x = -1
      next_direction_y = 0
   elseif (key == "right" or key == "d") and direction_x ~= -1 then
      next_direction_x = 1
      next_direction_y = 0
   end
end

function M.draw(): nil
   love.graphics.setBackgroundColor(0.035, 0.045, 0.075)
   love.graphics.setColor(0.25, 0.75, 0.95)
   love.graphics.print("SNAKE", 20, 14)
   love.graphics.setColor(0.68, 0.72, 0.80)
   love.graphics.print("WASD / arrows move    R restart    Esc launcher", 120, 14)

   love.graphics.setColor(0.09, 0.11, 0.17)
   love.graphics.rectangle("fill", 0, 40, grid_size * cell_size, grid_size * cell_size)

   love.graphics.setColor(0.95, 0.35, 0.35)
   love.graphics.rectangle("fill", food_x * cell_size, 40 + food_y * cell_size, cell_size, cell_size)

   for index, segment in ipairs(snake) do
      if index == 1 then
         love.graphics.setColor(0.25, 0.85, 0.65)
      else
         love.graphics.setColor(0.18, 0.62, 0.48)
      end
      love.graphics.rectangle("fill", segment.x * cell_size, 40 + segment.y * cell_size, cell_size - 1, cell_size - 1)
   end

   if game_over then
      love.graphics.setColor(1, 0.8, 0.35)
      love.graphics.print("GAME OVER - press R to restart", 190, 460)
   end
end

M.reset()
return M
