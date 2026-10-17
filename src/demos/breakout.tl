local M = {
   title = "Breakout",
}

local record Brick
   x: number
   y: number
   alive: boolean
   color: number
end

local field_width: number = 640
local field_top: number = 70
local field_bottom: number = 450
local paddle_x: number = 270
local paddle_y: number = 420
local paddle_width: number = 100
local paddle_height: number = 14
local paddle_speed: number = 360
local ball_x: number = 320
local ball_y: number = 390
local ball_size: number = 12
local ball_vx: number = 190
local ball_vy: number = -220
local score: number = 0
local bricks_left: integer = 0
local game_over: boolean = false
local won: boolean = false
local bricks: {Brick} = {}

local function reset_ball(): nil
   ball_x = 320
   ball_y = 390
   ball_vx = 190
   ball_vy = -220
end

function M.reset(): nil
   paddle_x = 270
   score = 0
   bricks_left = 0
   game_over = false
   won = false
   bricks = {}
   for row = 0, 4 do
      for column = 0, 7 do
         table.insert(bricks, {
            x = 48 + column * 68,
            y = 90 + row * 28,
            alive = true,
            color = row,
         })
         bricks_left = bricks_left + 1
      end
   end
   reset_ball()
end

function M.update(dt: number): nil
   if game_over or won then return end
   if love.keyboard.isDown("left", "a") then paddle_x = paddle_x - paddle_speed * dt end
   if love.keyboard.isDown("right", "d") then paddle_x = paddle_x + paddle_speed * dt end
   if paddle_x < 0 then paddle_x = 0 end
   if paddle_x > field_width - paddle_width then paddle_x = field_width - paddle_width end

   ball_x = ball_x + ball_vx * dt
   ball_y = ball_y + ball_vy * dt

   if ball_x <= 0 or ball_x + ball_size >= field_width then ball_vx = -ball_vx end
   if ball_y <= field_top then ball_vy = -ball_vy end

   local paddle_hit: boolean = ball_x + ball_size >= paddle_x and ball_x <= paddle_x + paddle_width and ball_y + ball_size >= paddle_y and ball_y <= paddle_y + paddle_height
   if paddle_hit and ball_vy > 0 then
      ball_vy = -ball_vy
      ball_vx = (ball_x + ball_size / 2 - paddle_x - paddle_width / 2) * 4
   end

   for _, brick in ipairs(bricks) do
      local hit: boolean = brick.alive and ball_x + ball_size >= brick.x and ball_x <= brick.x + 60 and ball_y + ball_size >= brick.y and ball_y <= brick.y + 20
      if hit then
         brick.alive = false
         bricks_left = bricks_left - 1
         score = score + 10
         ball_vy = -ball_vy
         if bricks_left == 0 then won = true end
         break
      end
   end

   if ball_y > field_bottom then
      game_over = true
   end
end

function M.keypressed(key: string): nil
   if key == "r" then M.reset() end
end

function M.draw(): nil
   love.graphics.setBackgroundColor(0.035, 0.045, 0.075)
   love.graphics.setColor(0.25, 0.75, 0.95)
   love.graphics.print("BREAKOUT", 20, 20)
   love.graphics.setColor(1, 1, 1)
   love.graphics.print("Score: " .. tostring(score), 500, 20)
   love.graphics.setColor(0.68, 0.72, 0.80)
   love.graphics.print("A/D or ←/→ move    R restart    Esc launcher", 180, 468)

   love.graphics.setColor(0.09, 0.11, 0.17)
   love.graphics.rectangle("fill", 0, field_top, field_width, field_bottom - field_top)

   for _, brick in ipairs(bricks) do
      if brick.alive then
         love.graphics.setColor(0.25 + brick.color * 0.12, 0.45 + brick.color * 0.06, 0.85 - brick.color * 0.08)
         love.graphics.rectangle("fill", brick.x, brick.y, 60, 20)
      end
   end

   love.graphics.setColor(0.25, 0.75, 0.95)
   love.graphics.rectangle("fill", paddle_x, paddle_y, paddle_width, paddle_height)
   love.graphics.setColor(1, 0.8, 0.35)
   love.graphics.rectangle("fill", ball_x, ball_y, ball_size, ball_size)

   if game_over then
      love.graphics.setColor(1, 0.45, 0.45)
      love.graphics.print("GAME OVER - press R to restart", 210, 250)
   elseif won then
      love.graphics.setColor(0.35, 0.9, 0.65)
      love.graphics.print("YOU WIN - press R to play again", 210, 250)
   end
end

M.reset()
return M
