extends Node

# Freeze
const FREEZE_TIME_SCALE: float = 0.05
const FREEZE_DURATION: float = 0.1

# Health components
const MAX_HEALTH: int = 100
const DEFAULT_HEALTH: int = 100

# Velocity component
const MAX_SPEED: float = 100.0
const ACCELERATION_COEFFICIENT: float = 10.0
const SPEED_MULTIPLIER: float = 1.0
const ACCELERATION_COEFFICIENT_MULTIPLIER: float = 1.0
const DRAW_LINE_MOD: float = 8.0

const GROUP_ENEMY: String = "enemy"
const ATTACK_DAMAGE: float = 10.0
const KNOBACK_FORCE: float = 1.0
const STUN_TIME: float = 0.0
const ADVANCE_TIMER: int = 1
const DEBUG_DRAW: bool = true
const DEBUG_RADIUS: float = 3.0
const DEBUG_LINE_WIDTH: float = 1.0
const DEBUG_COLOR: Color = Color.ORANGE

# Player
const PLAYER_SPEED: float = 100
const PLAYER_INVENCIBILITY_FRAMES: int = 5

# OBjects
const BULLET_SPEED: float = 200
