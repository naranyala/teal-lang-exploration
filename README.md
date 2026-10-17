# Teal + LÖVE starter

A tiny [Teal](https://teal-language.org/) game starter for [LÖVE](https://love2d.org/).

## Requirements

- Teal (`tl`)
- LÖVE 12.0

## Commands

```sh
make check  # type-check main.tl
make build  # generate main.lua for LÖVE
make run    # build and launch the game
```

The generated `main.lua` is ignored by Git. Run `make build` before launching
the project with LÖVE directly.

The Teal code is split into `main.tl`, `src/launcher.tl`, and the individual
demo modules under `src/demos/`. `src/love_global.tl` contains the shared LÖVE
API typing used during type checking.

The launcher includes Pong, Snake, and Breakout. Press Escape to return to the
launcher or quit from the launcher.
