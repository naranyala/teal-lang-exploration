local M = {}
local selected: number = 1
local demos = {
   {
      title = "Pong",
      description = "Play against a simple computer opponent.",
      status = "READY",
   },
   {
      title = "Snake",
      description = "Eat the fruit and grow without hitting yourself.",
      status = "READY",
   },
   {
      title = "Breakout",
      description = "Bounce the ball and clear every brick.",
      status = "READY",
   },
}

function M.keypressed(key: string): string
   if key == "escape" then return "quit" end
   if key == "up" or key == "w" then
      selected = selected - 1
      if selected < 1 then selected = #demos end
   elseif key == "down" or key == "s" then
      selected = selected + 1
      if selected > #demos then selected = 1 end
   elseif key == "return" or key == "space" then
      if selected == 1 then return "pong" elseif selected == 2 then return "snake" else return "breakout" end
   end
   return "launcher"
end

function M.draw(): nil
   love.graphics.setBackgroundColor(0.035, 0.045, 0.075)
   love.graphics.setColor(0.25, 0.75, 0.95)
   love.graphics.print("TEAL LAB", 48, 40)
   love.graphics.setColor(0.72, 0.76, 0.86)
   love.graphics.print("A small collection of interactive experiments", 48, 68)

   local y: number = 126
   for index, demo in ipairs(demos) do
      local is_selected: boolean = index == selected
      if is_selected then love.graphics.setColor(0.12, 0.25, 0.34) else love.graphics.setColor(0.09, 0.11, 0.17) end
      love.graphics.rectangle("fill", 48, y, 544, 86)
      if is_selected then
         love.graphics.setColor(0.25, 0.75, 0.95)
         love.graphics.rectangle("fill", 48, y, 5, 86)
      end
      love.graphics.setColor(1, 1, 1)
      love.graphics.print(demo.title, 72, y + 18)
      love.graphics.setColor(0.68, 0.72, 0.80)
      love.graphics.print(demo.description, 72, y + 44)
      love.graphics.setColor(0.35, 0.85, 0.65)
      love.graphics.print(demo.status, 510, y + 18)
      y = y + 102
   end

   love.graphics.setColor(0.55, 0.58, 0.67)
   love.graphics.print("↑↓ select    Enter / Space open    Esc quit", 48, 420)
end

return M
