# CSCI 5619 Final Project Fall 2023 | Wizarding World VR
 
Wizarding World VR, a virtual reality experience built in Godot 4.2 mono for CSCI 5619 Final Project Fall 2023. In this environemnt immerse yourself as a wizard, cast spells, manipulate objects, and create magic tomes. This project showcases various Virtual Reality techniques, including locomotion, interaction, selection and manipulation, and a unique speech-to-text implementation for spellcasting.

## Features
### Speech-to-Text Spellcasting
In the virtual environment, you can gain the authority to cast spells through a speech-to-text implementation. Access the VR menu using the left menu button, and navigate to the voice tab. Record and stop recording your voice to cast spells matching the interpreted speech. Particle effects surrounding your hand represent the spell you are about to cast.

### Spells
1. Fire Spell: Emit fire from your hands while holding the trigger button.
2. Ice Spell: Shoot an ice ball with collision physics towards the aimed location upon releasing the trigger button.
3. Teleport Spell: Instantiate up to three spawn points with the left controller trigger release. Teleport to any point by holding the trigger button on the right controller and moving your hand towards the visualized spawn points.
4. Vision Spell: Shoot small eye balls with the left controller trigger release. Command a giant eye to look at the player, displaying the real-time scene on a spell orb in the "All Seeing Eye" tab.
5. Grab Function: Pick up and manipulate objects with the right hand's extruding pointer. Rotate and scale objects using the left controller's functionality.
### Arcane Tab
Experiment with the experimental "Arcane" tab, allowing users to draw objects with controller trigger clicks and instantiate them into the world.

## Media Showcase
- Utilization of the Grab Spell
<img width="600" alt="grab" src="https://github.com/ocollison/CSCI-5619-Final-Project-Fall2023/assets/61022366/c1a9d5d9-30c1-427f-9761-6a75e707308d">

- Utilization of the VR Menu
<img width="600" alt="menu" src="https://github.com/ocollison/CSCI-5619-Final-Project-Fall2023/assets/61022366/1309fe05-545b-4d87-87ef-73049be43e75">


- Utilization of the Vision Spell
<img width="600" alt="eye" src="https://github.com/ocollison/CSCI-5619-Final-Project-Fall2023/assets/61022366/cb08b5f8-1add-43d2-a538-61e80a96b858">


- Casting the Fire Spell
<img width="600" alt="fire" src="https://github.com/ocollison/CSCI-5619-Final-Project-Fall2023/assets/61022366/82da73b3-11ae-4183-bdf9-192a081b5013">

   
## Add-ons, Resources & Acknlowledgements
- [Ed's CSG to MeshInstance](https://github.com/StrayEddy/GodotPlugin-CSGToMeshInstance): Used for 3D mesh sculpting.
- [Godot Speech Recognition](https://github.com/unusualprojects/GodotSpeechRecognition): Implemented for the speech recognition functionality.
- Polygon Adventure Pack: Utilized for building the 3D environment.
- [Godot XRtools](https://github.com/GodotVR/godot-xr-tools): Used for hand models and VR menu implementation.
- [Godot 2D GD Paint Demo](https://github.com/godotengine/godot-demo-projects/tree/3.5-9e68af3/2d/gd_paint): demo used for scene for drawing in the Arcane tab.
- [Fire spell texture creation](https://www.youtube.com/watch?v=8ngg6ueC_ks)
## Improvements and Future Work
### Improvements
- Fine-tune the Grab spell for smoother interactions and include support for more objects.
- Refine the drawing functionality in the Arcane tab, addressing both functionality and resulting image proportions.
- Clean up unnecessary material, images, scenes, and code in the project.
### Future Work
- Enhance the Arcane tab's drawing functionality to align with a wizarding world VR experience.
- Implement the ability for the Grab spell to save grabbed objects for later instantiation.
- Add additional functionality to complement the collision physics of the Ice spell.




