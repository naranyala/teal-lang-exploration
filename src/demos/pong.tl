local M = {
   title = "Pong",
}

local field_width: number = 640
local field_top: number = 70
local field_bottom: number = 450
local paddle_width: number = 12
local paddle_height: number = 80
local paddle_speed: number = 320
local ball_size: number = 14

local left_y: number = 260
local right_y: number = 260
local ball_x: number = 320
local ball_y: number = 260
local ball_vx: number = 240
local ball_vy: number = 120
local player_score: number = 0
local computer_score: number = 0

local function reset_ball(direction: number): nil
   ball_x = 320
   ball_y = 260
   ball_vx = 240 * direction
   ball_vy = 120
end

function M.reset(): nil
   left_y = 260
   right_y = 260
   player_score = 0
   computer_score = 0
   reset_ball(1)
end

function M.update(dt: number): nil
   if love.keyboard.isDown("up", "w") then left_y = left_y - paddle_speed * dt end
   if love.keyboard.isDown("down", "s") then left_y = left_y + paddle_speed * dt end
   if left_y < field_top then left_y = field_top end
   if left_y > field_bottom - paddle_height then left_y = field_bottom - paddle_height end

   local target_y: number = ball_y - paddle_height / 2
   if right_y < target_y then right_y = right_y + paddle_speed * 0.72 * dt end
   if right_y > target_y then right_y = right_y - paddle_speed * 0.72 * dt end
   if right_y < field_top then right_y = field_top end
   if right_y > field_bottom - paddle_height then right_y = field_bottom - paddle_height end

   ball_x = ball_x + ball_vx * dt
   ball_y = ball_y + ball_vy * dt

   if ball_y <= field_top or ball_y + ball_size >= field_bottom then
      ball_vy = -ball_vy
   end

   local left_hit: boolean = ball_x <= 36 and ball_x + ball_size >= 24 and ball_y + ball_size >= left_y and ball_y <= left_y + paddle_height
   local right_hit: boolean = ball_x + ball_size >= 604 and ball_x <= 616 and ball_y + ball_size >= right_y and ball_y <= right_y + paddle_height
   if left_hit and ball_vx < 0 then
      ball_vx = -ball_vx
      ball_vy = (ball_y - left_y - paddle_height / 2) * 4
   elseif right_hit and ball_vx > 0 then
      ball_vx = -ball_vx
      ball_vy = (ball_y - right_y - paddle_height / 2) * 4
   end

   if ball_x < -ball_size then
      computer_score = computer_score + 1
      reset_ball(1)
   elseif ball_x > field_width then
      player_score = player_score + 1
      reset_ball(-1)
   end
end

function M.keypressed(key: string): nil
   if key == "r" then M.reset() end
end

function M.draw(): nil
   love.graphics.setBackgroundColor(0.035, 0.045, 0.075)
   love.graphics.setColor(0.25, 0.75, 0.95)
   love.graphics.print("PONG", 24, 20)
   love.graphics.setColor(1, 1, 1)
   love.graphics.print(tostring(player_score) .. "  -  " .. tostring(computer_score), 300, 20)
   love.graphics.setColor(0.68, 0.72, 0.80)
   love.graphics.print("W/S or ↑/↓ move    R restart    Esc launcher", 180, 468)

   love.graphics.setColor(0.09, 0.11, 0.17)
   love.graphics.rectangle("fill", 0, field_top, field_width, field_bottom - field_top)
   love.graphics.setColor(0.25, 0.75, 0.95)
   love.graphics.rectangle("fill", 24, left_y, paddle_width, paddle_height)
   love.graphics.setColor(0.35, 0.85, 0.65)
   love.graphics.rectangle("fill", 604, right_y, paddle_width, paddle_height)
   love.graphics.setColor(1, 0.8, 0.35)
   love.graphics.rectangle("fill", ball_x, ball_y, ball_size, ball_size)
end

M.reset()
return M
