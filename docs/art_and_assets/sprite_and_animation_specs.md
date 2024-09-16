# Sprite and Animation Specifications

## Characters
- **Base resolution**: 32x32 pixels per character.
- **Frames per action**: 
  - Idle: 4 frames.
  - Walking: 6 frames.
  - Attacking: 5 frames.
  - Dying: 6 frames.

- **Animations**:
  - **Idle**: Slight movement for breathing effect.
  - **Walk**: Smooth, looping animation.
  - **Attack**: Quick action frames with clear feedback for the player.
  - **Death**: More dramatic, with fading or shrinking effect.

## Projectiles
- **Resolution**: 16x16 pixels.
- **Animation**: 4 frames for movement animation, looping as needed.
  
## Environment Assets
- **Tiles**: 32x32 pixels for each tile.
- **Objects (trees, rocks, etc.)**: Size varies but follows a grid of 32x32 or 64x64 pixels.

## Scaling
- Characters and objects will scale by 3x for full-screen resolution (e.g., 96x96 pixels for characters).
- **Frame rate**: 12-15 frames per second for a smooth animation without requiring too many frames.

## File Format
- **Format**: All sprites will be exported as PNG files with transparency.
- **Sprite Sheets**: Group multiple frames of animation for each character into a single sprite sheet (e.g., `character_idle.png`, `character_walk.png`).
