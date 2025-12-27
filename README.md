# 🐒 Monkey Platformer

Some description here.

---

## ✨ Features
- Feature 1  
- Feature 2  
- Feature 3  
- ...

---

## 📓 Devlog

### **Dec 24, 2025**

#### 🧩 Feature Summary
- Today I started creating my first game (ever!). I initialized the Godot project and set up this GitHub repository to log all my progress in making this game.
- I set up the first character.
- Added left-to-right movement, jumping, and gravity.
- Created a simple idle animation for the character.

---

#### ⚠️ Challenges
- Perhaps the most challenging tasks today were making the character and its corresponding idle animation.
- I am not much of an artistic guy, but I am willing to improve.
- I went on Pinterest and found some good references to use for making the character, specifically this one by xxx.
- Overall, I am happy with how the animation and character turned out, even if it took me several hours to complete.

---

#### 🎞️ Visuals

**First sprite with idle animation:**

![First sprite idle animation](Devlog%20GIFs/Idle%20Animation%20CB.gif)

<br/>

**Initial movement mechanics:**

![Character movement](Devlog%20GIFs/movement_showcase.gif)

---

#### 🔗 Commits
- [View all commits for this devlog](https://github.com/ajogerio/monkey-game/compare/91f1aff...41c67e1)

### **Dec 25, 2025**

#### 🧩 Feature Summary
- Today I worked on the shooting mechanic of the game.
- I wanted the character to shoot cookies, so I called these bullets "cookie bullets."
- I mapped the left mouse-click to trigger shots and bullets will shoot in the direction of the mouse cursor.

---

#### ⚠️ Challenges
- I had no idea how to even make shooting bullets in the first place so I consulted trusty ChatGPT to provide the links to the Godot docs that taught that specific mechanic.
- I also had problems with the bullets spawning in the center of the game screen rather than on the designated marker I positioned in front of the character.
- Turns out I was putting all my nodes in a single scene, which caused the global position of the bullets to be mismatched.
- I fixed the issue by creating a scene for each element of the game (i.e. game scene, player scene, cookie bullet scene, etc.) and then adding scenes in the main game scene. Kind of like making functions and calling them in the main function.

---

#### 🎞️ Visuals

**Shooting mechanic demo:**

![Shooting mechanic](Devlog%20GIFs/shooting_mechanic.gif)

---

#### 🔗 Commits
- [View all commits for this devlog](https://github.com/ajogerio/monkey-game/compare/4c92f30...3ca0507)
