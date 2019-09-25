/* MultiBotClass.ch */

#include <linkbot.h>
#include <stdarg.h>

class MultiBot {
    
/* CONFIGURATION:
Perspective from BEHIND: 
- rightbot should be the right wheel, back joint w/stabilizer facing away, JOINT3 attached to midbot
- leftbot should be the left wheel, back joint w/stabilizer facing away, JOINT1 attached to midbot
- midbot should be the center fulcrum, buttons facing away, bottoms up
- Cube is attached on the bottom of robot3, or the top of the module. Open hole facing towards you
- gripper should be attached the the front of the cube. Buttons on top.
- GRIPPER ALTERNATIVE: Buttons on left, JOINT3 on top
- GRIPPER NOTE: Joint 3 will always control the lower grip
*/
    
    private:
        
        double radius;
        double trackwidth;  // Trackwidth: Default = 10.60 inches
    
        CLinkbotI * rightbot;
        CLinkbotI * leftbot;
        CLinkbotI * midbot;
        CLinkbotI * gripper;
    
    public:
    
        MultiBot(double radius, double trackwidth);
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
    
};

#include "MultiBotFiles.ch"

/* RESERVED FOR EXPLORER */


/*
class Explorer {
// CONFIGURATION: 
    
    private:
        
        double radius;
        double trackwidth;  // Trackwidth: Default = 10.60 inches
    
        CLinkbotI * rightbot;
        CLinkbotI * leftbot;
        CLinkbotI * lowerbot;
        CLinkbotI * upperbot;
        CLinkbotI * gripper;
    
    public:
    
        Explorer(double radius, double trackwidth);
        void addRobots(CLinkbotI &rightbot, CLinkbotI &leftbot, CLinkbotI &lowerbot, CLinkbotI &upperbot, CLinkbotL &gripper);
        
        // Movement
        void liftArm(...);
        void lowerArm(double angle);
        void readyArm();
        void setReadyArm(double angle, double angle2);
        void driveDistance(double distance);
        void setJointSpeed(double speed);
        void turnRight(double angle);
        void turnLeft(double angle);
        void move(double angle1, double angle3);
        void resetGripper();
        void closeGripper(double angle);
        void openGripper(double angle);
    
};

#include "ExplorerFiles.ch"
*/
