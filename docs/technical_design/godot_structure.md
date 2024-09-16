# Godot Structure

## Project Structure
The project is organized into several main folders and files to manage different aspects of the game.

### Folder Layout
- **`assets/`**: Contains all art, sound, and other media assets.
  - **`images/`**: Pixel art and textures.
  - **`audio/`**: Sound effects and music.
- **`scripts/`**: Contains GDScript files for game logic.
  - **`characters/`**: Scripts for character behaviors and abilities.
  - **`items/`**: Scripts for item behaviors and upgrades.
- **`scenes/`**: Contains scene files for different game levels and menus.
  - **`levels/`**: Scene files for gameplay levels.
  - **`ui/`**: Scene files for user interface elements.
- **`data/`**: Stores configuration files and save data.
  - **`config/`**: Configuration files for game settings.
  - **`savegames/`**: Player save data.

## File Naming Conventions
- **Scripts**: `character_name.gd` (e.g., `pyromancer.gd`)
- **Scenes**: `scene_name.tscn` (e.g., `main_menu.tscn`)
- **Assets**: `asset_name.png` (e.g., `fireball.png`)

## Important Scenes
- **`MainMenu.tscn`**: The starting menu scene.
- **`GameScene.tscn`**: The main gameplay scene.
- **`HUD.tscn`**: The scene for in-game user interface elements.

## Scripts Overview
- **`Character.gd`**: Base class for all character scripts.
- **`SpellSystem.gd`**: Manages spell casting and effects.
- **`Inventory.gd`**: Handles item and upgrade management.

