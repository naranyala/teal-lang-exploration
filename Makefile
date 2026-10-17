.PHONY: check build run clean

SOURCES := src/love_global.tl main.tl $(wildcard src/launcher.tl src/demos/*.tl)

GENERATED := main.lua launcher.lua demos/pong.lua demos/snake.lua demos/breakout.lua

main.lua: $(SOURCES)
	tl -I src gen -c src/love_global.tl main.tl
	rm -f love_global.lua

launcher.lua: src/launcher.tl src/love_global.tl
	tl -I src gen -c src/love_global.tl src/launcher.tl
	rm -f love_global.lua

demos/pong.lua: src/demos/pong.tl src/love_global.tl
	mkdir -p demos
	tl -I src gen -c src/love_global.tl src/demos/pong.tl
	mv pong.lua demos/pong.lua
	rm -f love_global.lua

demos/snake.lua: src/demos/snake.tl src/love_global.tl
	mkdir -p demos
	tl -I src gen -c src/love_global.tl src/demos/snake.tl
	mv snake.lua demos/snake.lua
	rm -f love_global.lua

demos/breakout.lua: src/demos/breakout.tl src/love_global.tl
	mkdir -p demos
	tl -I src gen -c src/love_global.tl src/demos/breakout.tl
	mv breakout.lua demos/breakout.lua
	rm -f love_global.lua

check:
	tl -I src check $(SOURCES)

build: $(GENERATED)

run: build
	love .

clean:
	rm -f main.lua launcher.lua demos/pong.lua demos/snake.lua demos/breakout.lua demos/movement.lua demos/calculator.lua
