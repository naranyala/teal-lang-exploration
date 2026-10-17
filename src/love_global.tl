local record LoveWindow
   setTitle: function(string): nil
end

local record LoveKeyboard
   isDown: function(string, string): boolean
end

local record LoveEvent
   quit: function(): nil
end

local record LoveGraphics
   setBackgroundColor: function(number, number, number): nil
   setColor: function(number, number, number): nil
   rectangle: function(string, number, number, number, number): nil
   print: function(string, number, number): nil
end

local record Love
   window: LoveWindow
   keyboard: LoveKeyboard
   event: LoveEvent
   graphics: LoveGraphics
   load: function(): nil
   update: function(number): nil
   keypressed: function(string): nil
   draw: function(): nil
end

global love: Love
