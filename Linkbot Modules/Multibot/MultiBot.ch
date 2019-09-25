/* File: MultiBot.ch */

/* CONFIGURATION:
Perspective from BEHIND: 
- rightbot should be the right wheel, front facing away, JOINT1 attached to midbot
- leftbot should be the left wheel, front facing away, JOINT3 attached to midbot
- midbot should be the center fulcrum, buttons facing away
- Cube is attached on the bottom of robot3, or the top of the module.
- gripper should be attached the the front of the cube. Buttons on top.
- GRIPPER ALTERNATIVE: Buttons on left, JOINT3 on top
- GRIPPER NOTE: Joint 3 will always control the lower grip
*/

#include "MultiBot2.ch"
CLinkbotI rightbot, leftbot, midbot;
CLinkbotL gripper;

double radius = 1.75;          // Recommendation: 4-inch wheels
double trackwidth = 10.6;     // Default trackwidth is 10.6 inches

// Initializing MultiBot: Format: MultiBot NAME = MultiBot(radius, trackwidth);
MultiBot2 Simon = MultiBot2(radius, trackwidth); 

Simon.addRobots(rightbot, leftbot, midbot, gripper);   // Adding robots to MultiBot in SPECIFIC order

    // Starting from open-most position

Simon.liftArm(50);
/*Simon.openGripper(50);
Simon.driveDistance(-2);
Simon.turnLeft(10);
Simon.driveDistance(3);
Simon.lowerArm(5);
Simon.closeGripper(70);*/
