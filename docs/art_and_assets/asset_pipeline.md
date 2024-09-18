# Asset Pipeline

## Workflow Overview
The asset pipeline ensures that art and sound assets are created, reviewed, and integrated smoothly into the game. The process involves:
1. **Creation**: Assets are created in external software.
2. **Review**: Art and sound assets are reviewed by the team.
3. **Export and Integration**: Final assets are exported and integrated into Godot.

## Tools
- **Pixel Art**: Aseprite for creating pixel art and animations.
- **Sound Design**: Bfxr for sound effects, Audacity for additional editing.
- **Version Control**: GitHub will be used to manage and track changes in the assets.

## Pixel Art Pipeline
1. **Concept sketches** (optional) created on paper or digitally.
2. **Pixel art creation** in Aseprite.
3. **Animation**: Frame-by-frame animation in Aseprite.
4. **Export**: Sprites and sprite sheets exported as PNG files.
5. **Integration**: Assets added to the Godot project in the `assets/` folder.

## Sound Asset Pipeline
1. **SFX Creation**: Effects created using Bfxr.
2. **Music Composition**: Composed with a tracker software or similar tools for chiptune music.
3. **Editing**: Use Audacity to fine-tune effects.
4. **Export**: Export in `.wav` format.
5. **Integration**: Files added to the `audio/` folder in Godot.

## Asset Naming Conventions
- **Sprites**: `character_<name>_<action>.png` (e.g., `character_mage_walk.png`).
- **Sounds**: `sfx_<event>.wav` (e.g., `sfx_fireball_cast.wav`).

## Backup and Versioning
- Assets will be backed up weekly, with older versions stored on a dedicated backup branch in GitHub.
