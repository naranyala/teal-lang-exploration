# Teal Lab

A small collection of playable [LÖVE](https://love2d.org/) demos written in
[Teal](https://teal-language.org/). Teal provides type checking while LÖVE
handles the window, input, drawing, and game loop.

## Demos

The launcher currently includes:

| Demo | Controls | Description |
| --- | --- | --- |
| Pong | `W`/`S` or `↑`/`↓` | Play against a simple computer opponent. |
| Snake | `W`/`A`/`S`/`D` or arrow keys | Eat fruit, grow, and avoid collisions. |
| Breakout | `A`/`D` or `←`/`→` | Clear the brick wall with the ball. |

In the launcher, use `↑`/`↓` to select a demo and `Enter` or `Space` to open
it. Press `Esc` inside a demo to return to the launcher. Each game can be
restarted with `R`.

## Requirements

- [Teal](https://github.com/teal-language/tl) with the `tl` command available
  on `PATH`
- [LÖVE 12.0](https://love2d.org/)
- GNU Make (for the provided workflow)

Check the installed tools with:

```sh
tl --version
love --version
```

## Run

The simplest option is:

```sh
./run.sh
```

`run.sh` verifies that Teal and LÖVE are installed, compiles the project, and
launches the game.

You can also use Make directly:

```sh
make check  # type-check all Teal sources
make build  # generate Lua modules for LÖVE
make run    # build and launch the game
make clean  # remove generated Lua files
```

Generated Lua files are ignored by Git. LÖVE runs the generated `main.lua`
entry point and loads the generated modules from `launcher.lua` and `demos/`.

## Project structure

```text
.
├── main.tl                 # LÖVE callbacks and screen routing
├── conf.lua                # window configuration
├── run.sh                  # check, build, and launch helper
├── Makefile                # type-check and build commands
└── src/
    ├── launcher.tl         # demo selection screen
    ├── love_global.tl      # shared LÖVE API types
    └── demos/
        ├── pong.tl
        ├── snake.tl
        └── breakout.tl
```

## Adding a demo

1. Add a module under `src/demos/` exposing `title`, `reset`, `update`,
   `keypressed`, and `draw`.
2. Add the demo to the list in `src/launcher.tl`.
3. Add routing for its action in `main.tl`.
4. Add a generation target for its runtime module in the `Makefile`.
5. Run `make check && make build` before committing.
