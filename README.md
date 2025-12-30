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

### **Dec 27, 2025 - Dec 28, 2025**

#### 🧩 Feature Summary
- For these days I worked on making the first enemy monkey sprite.
- I made the walking and idle animations for the monkey sprite.
- I attempted to make the camera of the game work, but it's still a work in progress for now.

---

#### ⚠️ Challenges
- I struggled to make the walking animation for the monkey sprite. I tweaked it dozens of times, even walking in my room slowly just to get the different key frames down, until I eventually ended up with a walk animation that I was pleased with.
- My biggest challenge right now is understanding the camera. I took inspiration from the camera of Super Mario where the main sprite moves about 50 percent to the right of the screen before making the camera drag to the right alongside it. I got it working, sort of? I was confused by how I set the drag margin to be 0.7 (meaning the character can move until 70% of the camera before panning) but in the game itself, it only took about 50% before the panning. I tried looking through sources to find out why that is and I was not able to find an answer for now. I'm thinking it might have to do with a mismatch of positions of the character and the camera. I plan to look more into it on my next work session by watching some guides on YouTube.

---

#### 🎞️ Visuals

**Enemy Monkey Sprite Animations:**

![Monkey walking animation](Devlog%20GIFs/monkey_walking_animation.gif)

![Monkey walking animation](Devlog%20GIFs/monkey_idle_animation.gif)

---

#### 🔗 Commits
- [View all commits for this devlog](https://github.com/ajogerio/monkey-game/compare/4c92f30...3ca0507) change this

### **Dec 29, 2025**

---

#### ⚠️ Challenges
- Still struggling with making the camera work. I've tried changing the logic by getting the left edge of the screen and checking if the player has moved past a constant distance. But then I realized that this distance will stay the same even if the player moves past it and it wont adjust based on where the player is currently positioned. Still need to work on this in the coming days.
- I got confused with viewports, resolutions, and scaling. Had to ask ChatGPT multiple times to explain it, and I am still kind of confused. I just know that resolution refers to the total amount of pixels on the screen, while scale is how large those pixels will be. So a "game pixel" isnt always one-to-one with the screen pixel in my laptop. A game pixel could be a square comprising multiple pixels from my laptop. And a good scale is a whole number.

### **Dec 30, 2025**

#### 🧩 Feature Summary
- Camera moves to the right when player is at 30% of the screen, and moves to the left when the player is at 10%.

---

#### ⚠️ Challenges
- I still struggled to make the camera do what I wanted it to. That is until I realized that you could change the "Anchor Mode" of the camera 2d such that its position is at the top left of the screen box rather than the center. This removed all my confusion and made calculating the barriers WAAAAY more easier.
- I also struggled with the "lerp" function at first because that was what I initially saw for ensuring smooth camera movements. I even had to draw super wonky sketches in MS Paint just to visualize how it was supposed to work. It worked perfectly for the right panning, but it started to jitter with left panning. And then I realized that I could just the increase or decrease the position of the camera relative to the velocity of the player instead of using lerp, and it worked! Now, my code looks much more simpler than it did the past few days. I'm proud of myself for finally making this work properly and consistently.

---

#### 🎞️ Visuals

**Goofy MS Paint sketch for understanding LERP (lol):**

![Goofy MS Paint sketch for understanding LERP](Devlog%20GIFs/camera_movement_sketch.png)

<br/>

**Working camera panning feature:**

![Working camera panning feature](Devlog%20GIFs/camera_panning_showcase.gif)

---

#### 🔗 Commits
- [View all commits for this devlog](https://github.com/ajogerio/monkey-game/compare/91f1aff...41c67e1)