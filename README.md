# MP3 for CS 415

A simple platformer following the following criteria:

| Name | Criteria |
|------|----------|
| Movement | Player is able to move, jump, double-jump, and wall jump. Movement is mostly tight. |
| Levels | Levels have platforms, walls, and hazards. Multiple levels (at least 3). Player respawns at the beginning of level after dying. |
| Hazards | Hazards kill the player. Some spawn randomly and in "unfair" manners. Others are static. Can take the shape of spikes, projectiles, or random sprites. |
| Power-ups | Power-ups exist throughout the levels and can add additional functionality (such as flight, a weapon, etc.). |
| Mini-boss | Mini-boss exists as a sprite. Randomly spawns in some levels, and makes presence known when spawning in. Attacks player. Has attack patterns and health. Game ends upon death. |

# Running on Localhost

To run, `cd export` and run `python http_server.py`. Then, just open `http://localhost:8000/CS415Final.html` in a browser and enjoy :)
Note: 8000 is the default port, you can supply an argument to change it.
