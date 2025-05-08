"use strict";
const canvas = document.createElement("canvas");
canvas.width = 8;
canvas.height = 8;
const ctx = canvas.getContext("2d");
if (!ctx) {
    throw new Error("Canvas context not found");
}
document.body.append(canvas);
let heldKeys = [];
// Character details
let is_jumping = false;
let jumpHeight = 0;
let jumpPerTick = 2;
let coilPower = 0;
let coilPowerMin = 5 * 7;
let coilPowerLevel1 = 10 * 7;
let coilPowerLevel2 = 20 * 7;
let coilPowerMax = 25 * 7;
let coilPerTick = 3;
let crouchIntensity = 0;
let crouchLevel1 = 3 * 10;
let crouchLevelMax = 20 * 10;
let crouchPerTick = 2;
let uncrouchPerTick = 3;
let spriteNameRenderOrder = [
    "blue-sky",
    "grass",
    "character-idle",
    "rock-1",
];
let c_blueSky = 0x7dc9ff;
let c_grass = 0xa8c857;
let c_skin = 0xffd69c;
let c_jumper = 0xcb6454;
let c_trousers = 0x62679f;
let c_rock = 0x89867b;
// Sprite definitions
let skyOrigin = [0, 0];
let sky = [[0, 0, 8, 8, c_blueSky]];
let grassOrigin = [0, 5];
let grass = [[0, 0, 8, 3, c_grass]];
let characterOrigin = [1, 5];
let character_stand = [
    [0, 0, 1, 1, c_trousers],
    [0, -1, 1, 1, c_jumper],
    [0, -2, 1, 1, c_skin],
];
let character_crouch_1 = [
    [0, 0, 1, 1, c_trousers],
    [0, -1, 1, 1, c_jumper],
    [1, -1, 1, 1, c_skin],
];
let character_crouch_2 = [
    [-1, 0, 1, 1, c_trousers],
    [0, 0, 1, 1, c_jumper],
    [1, 0, 1, 1, c_skin],
];
let character_coil_1 = [
    [0, 0, 1, 1, c_trousers],
    [-1, -1, 1, 1, c_jumper],
    [0, -2, 1, 1, c_skin],
];
let character_coil_2 = [
    [0, 0, 1, 1, c_trousers],
    [-1, -1, 1, 1, c_jumper],
    [0, -1, 1, 1, c_skin],
];
let character_jump_1 = [
    [0, -1, 1, 1, c_trousers],
    [1, -2, 1, 1, c_jumper],
    [0, -3, 1, 1, c_skin],
];
let character_jump_2 = [
    [0, -2, 1, 1, c_trousers],
    [-1, -3, 1, 1, c_jumper],
    [0, -4, 1, 1, c_skin],
];
let character_jump_3 = [
    [0, -3, 1, 1, c_trousers],
    [1, -4, 1, 1, c_jumper],
    [0, -5, 1, 1, c_skin],
];
let rockOrigin1 = [5, 5];
let rock = [[0, 0, 1, 1, c_rock]];
let rockX = 0;
const renderSprite = (spriteOrigin, spriteBlocks) => {
    for (let i = 0; i < spriteBlocks.length; i++) {
        const block = spriteBlocks[i];
        ctx.fillStyle = `#${block[4].toString(16)}`;
        ctx.fillRect(spriteOrigin[0] + block[0], spriteOrigin[1] + block[1], block[2], block[3]);
    }
};
const handleControls = () => {
    const primaryKey = heldKeys.at(-1);
    if (crouchIntensity === 0) {
        if (primaryKey === "Up" && !is_jumping) {
            if (!is_jumping) {
                if (coilPower === 0) {
                    coilPower = coilPowerMin;
                }
                else {
                    coilPower += coilPerTick;
                }
            }
        }
        else {
            if (coilPower > 0) {
                is_jumping = true;
                coilPower -= jumpPerTick;
                jumpHeight += jumpPerTick;
            }
            else if (is_jumping) {
                if (jumpHeight > 0) {
                    jumpHeight -= jumpPerTick;
                }
                else if (primaryKey !== "Up") {
                    is_jumping = false;
                }
            }
        }
    }
    if (coilPower < 0) {
        coilPower = 0;
    }
    else if (coilPower > coilPowerMax) {
        coilPower = coilPowerMax;
    }
    if (jumpHeight < 0) {
        jumpHeight = 0;
    }
    else if (jumpHeight > coilPowerMax) {
        jumpHeight = coilPowerMax;
    }
    if (!coilPower && !is_jumping) {
        if (primaryKey === "Down") {
            if (crouchIntensity < crouchLevelMax) {
                crouchIntensity += crouchPerTick;
            }
        }
        else {
            if (crouchIntensity > 0) {
                crouchIntensity -= uncrouchPerTick;
            }
        }
    }
    if (crouchIntensity < 0) {
        crouchIntensity = 0;
    }
    else if (crouchIntensity > crouchLevelMax) {
        crouchIntensity = crouchLevelMax;
    }
};
const setCharacterFrameName = (frameName) => {
    spriteNameRenderOrder[2] = frameName;
};
const updateCharacterFrame = () => {
    if (jumpHeight > coilPowerLevel2) {
        setCharacterFrameName("character-jump-3");
    }
    else if (jumpHeight > coilPowerLevel1) {
        setCharacterFrameName("character-jump-2");
    }
    else if (jumpHeight > 0) {
        setCharacterFrameName("character-jump-1");
    }
    else if (coilPower >= coilPowerLevel2) {
        setCharacterFrameName("character-coil-2");
    }
    else if (coilPower >= coilPowerLevel1) {
        setCharacterFrameName("character-coil-1");
    }
    else if (crouchIntensity >= crouchLevel1) {
        setCharacterFrameName("character-crouch-2");
    }
    else if (crouchIntensity > 0) {
        setCharacterFrameName("character-crouch-1");
    }
    else {
        setCharacterFrameName("character-idle");
    }
};
const updateEnemyFrames = () => {
    const speed = 20;
    if (rockX > 0) {
        rockX -= 1;
    }
    else if (Math.random() > 0.99) {
        rockX = 9 * speed;
    }
    rockOrigin1[0] = Math.floor(rockX / speed) - 1;
};
const renderSprites = () => {
    for (let i = 0; i < spriteNameRenderOrder.length; i++) {
        const spriteName = spriteNameRenderOrder[i];
        if (spriteName === "blue-sky") {
            renderSprite(skyOrigin, sky);
        }
        else if (spriteName === "grass") {
            renderSprite(grassOrigin, grass);
        }
        else if (spriteName === "character-idle") {
            renderSprite(characterOrigin, character_stand);
        }
        else if (spriteName === "character-crouch-1") {
            renderSprite(characterOrigin, character_crouch_1);
        }
        else if (spriteName === "character-crouch-2") {
            renderSprite(characterOrigin, character_crouch_2);
        }
        else if (spriteName === "character-coil-1") {
            renderSprite(characterOrigin, character_coil_1);
        }
        else if (spriteName === "character-coil-2") {
            renderSprite(characterOrigin, character_coil_2);
        }
        else if (spriteName === "character-jump-1") {
            renderSprite(characterOrigin, character_jump_1);
        }
        else if (spriteName === "character-jump-2") {
            renderSprite(characterOrigin, character_jump_2);
        }
        else if (spriteName === "character-jump-3") {
            renderSprite(characterOrigin, character_jump_3);
        }
        else if (spriteName === "rock-1") {
            renderSprite(rockOrigin1, rock);
        }
        else {
            console.log(`No definition for sprite ${spriteName}`);
        }
    }
};
const renderFrame = () => {
    updateCharacterFrame();
    updateEnemyFrames();
    renderSprites();
    requestAnimationFrame(renderFrame);
};
const handleKeyDown = (event) => {
    if (event.key === "ArrowUp") {
        if (!heldKeys.includes("Up")) {
            heldKeys.push("Up");
        }
    }
    else if (event.key === "ArrowDown") {
        if (!heldKeys.includes("Down")) {
            heldKeys.push("Down");
        }
    }
    else if (event.key === "ArrowLeft") {
        if (!heldKeys.includes("Left")) {
            heldKeys.push("Left");
        }
    }
    else if (event.key === "ArrowRight") {
        if (!heldKeys.includes("Right")) {
            heldKeys.push("Right");
        }
    }
    else if (event.key === " ") {
        if (!heldKeys.includes("Space")) {
            heldKeys.push("Space");
        }
    }
};
const handleKeyUp = (event) => {
    if (event.key === "ArrowUp") {
        heldKeys.splice(heldKeys.indexOf("Up"), 1);
    }
    else if (event.key === "ArrowDown") {
        heldKeys.splice(heldKeys.indexOf("Down"), 1);
    }
    else if (event.key === "ArrowLeft") {
        heldKeys.splice(heldKeys.indexOf("Left"), 1);
    }
    else if (event.key === "ArrowRight") {
        heldKeys.splice(heldKeys.indexOf("Right"), 1);
    }
    else if (event.key === " ") {
        heldKeys.splice(heldKeys.indexOf("Space"), 1);
    }
};
document.addEventListener("keydown", handleKeyDown);
document.addEventListener("keyup", handleKeyUp);
renderFrame();
handleControls();
setInterval(handleControls, 1000 / 120);
