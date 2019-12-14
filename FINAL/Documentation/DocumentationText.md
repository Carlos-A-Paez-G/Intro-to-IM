## **CONCEPT**

*Micro Wars* is a turn-based strategy game that preserves the depth and pacing of larger-scale strategic games, while trying to make it more accessible. The game is controlled through a physical board that takes player inputs and a screen that uses supporting images to instruct the players on what to do.

This accessibility is represented through a focus on competition, symmetry between players, and openness to simpler forms of creativity. The mechanics of *Micro Wars* are based on games such as *Fire Emblem*, *Disgaea*, and *Into the Breach*, all of which are games that feature gameplay on a chess-like grid and different characters with specific abilities (which I have implemented as well), but with a focus on single-player gameplay, enhancing elements such as character growth and customization, story elements, or highly challenging situations in which the player must play at a disadvantage compared to the enemy. The appeal of these games is two-fold, between the joy of meeting many different unique characters and then seeing how they can interact in-game, and gameplay that requires measured calculation. *Micro Wars* preserves these elements, by keeping fidelity to these game's mechanics and featuring a diverse cast of colorful characters. However, *Micro Wars* also allows for a competitive environment that is similar to what makes fighting games engaging. A full round of *Micro Wars* is much shorter, compared to even an average game of chess. This would, hopefully, make it easier for players to learn the game through repeated playing and come up with new strategies faster. 

The physical interface is meant to make the game more accessible in the context of an exhibition. Players would not only be drawn to the complexity of the game, but also to the physical and tactile nature of the physical interface.

[[How?]]

## **BEHAVIOR**

Here is a [link](https://docs.google.com/document/d/1gmuQoXyX3fguGp9TEuZXX2jHlozByviMlpZIkkNpt-E/edit?usp=sharing) to the manual for the game. It briefly explains the rules of the game and how to carry out different actions, as well as what are the keyboard shortcuts to play the game in case the board malfunctions. 

The game uses a chess-like grid and a turn-based system. Characters can move around the grid during their turn (done by pressing the MOVE button), limited by their “move”, which is an integer that defines how far they can move. This movement is measured through adjacent blocks, meaning that diagonal movement is only possible if a character moves twice (once horizontally and once vertically). To move, players must use the physical interface. The physical board is a 4x4 grid, with Light Dependent Resistors placed on each cell. The LDRs are meant to detect if there is a block on that cell, by letting the Arduino send a message to processing whenever the value of the LDR changes past a certain threshold. This reads which cell the block was moved to, and carries out the movement accordingly.

The physical board also has six buttons, three for each player to both choose their characters and for them to do their actions during the game. 

During their turn, characters can either move, pass their turn, or move and then either use their Attack, Special, or Extra. Attacking (done by pressing the ATTACK button) is simply dealing damage to enemies that are within their “range” (all characters have a range of 1, except for the stick robot (L1uv14), who has a range of 2). Special moves and Extra moves have a variety of effects, from dealing damage with an additional effect, to strengthening allies with either more defense or attack. An Extra move is done by pressing the SPECIAL button after having pressed the MOVE button but before moving the character on the board. This is deliberately a complicated process, because an Extra move can only be used once per game and is meant to push players to be thoughtful about when to use the move. This also adds another layer of complexity to the game, as it means that Extra moves can only be used after having also moved. 

Whenever players choose an action, a message in red appears on the screen telling them what to do, such as to move the character on the board, or to lift the character they want to attack. 

Each character has a certain amount of Hit Points (HP) and these are reduced whenever they are attacked by other characters (characters can also damage themselves). How much damage a character’s attacks deal depends on their attack stat, which also varies depending on the character. 

Below is a description of every character. I’ve put a screenshot of how their attacks and stats are described in the game, as well as an explanation of what each character is trying to achieve in the greater context of the game.

# DEFENDER (Ricardo)

![DefenderPhoto](/Images/Defender.png) ![GitHub Logo](/images/logo.png)

