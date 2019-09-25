/* MultiBot2.ch */

#include <linkbot.h>
#include <stdarg.h>

class MultiBot2 {
    
/* CONFIGURATION:
Perspective from BEHIND: 
- rightbot should be the right wheel, back joint w/stabilizer facing away, JOINT3 attached to midbot
- leftbot should be the left wheel, back joint w/stabilizer facing away, JOINT1 attached to midbot
- midbot should be the center fulcrum, buttons facing away
- Cube is attached on the bottom of robot3, or the top of the module.
- gripper should be attached the the front of the cube. Buttons on right side (JOINT1 on top)
- Gripper must be wide open
- GRIPPER ALTERNATIVE: Buttons on right, JOINT1 on top
- GRIPPER NOTE: Joint 1 will always control the upper grip
*/
    
    private:
        
        double radius;
        double trackwidth;  // Trackwidth: Default = 10.60 inches
    
        CLinkbotI * rightbot;
        CLinkbotI * leftbot;
        CLinkbotI * midbot;
        CLinkbotL * gripper;
    
    public:
    
        MultiBot2(double radius, double trackwidth);
        void addRobots(CLinkbotI &rightbot, CLinkbotI &leftbot, CLinkbotI &midbot, CLinkbotI &gripper);
        
        // Movement
        void liftArm(...);
        void lowerArm(double angle);
        void driveDistance(double distance);
        void setJointSpeed(double speed);
        void turnRight(double angle);
        void turnLeft(double angle);
        void move(double angle1, double angle3);
        void resetGripper();
        void closeGripper(double angle);
        void openGripper(double angle);
        void applyPressureNB(double speed);
        void rotateGripper(double angle, double speed);
    
};

#include "MultiBot2Files.ch"
