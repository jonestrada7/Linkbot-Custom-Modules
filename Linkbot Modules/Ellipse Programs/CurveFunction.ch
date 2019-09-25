/* File: CurveFunction.ch */

#include <linkbot.h>
CLinkbotI robot;

int driveCircle(CLinkbotI &robot, double r, double speed1); // Function prototype: Required for this case

double r;
double speed;

printf("Enter the radius that you would like the robot to drive:\n");
scanf("%lf", &r);
printf("Enter the speed of the inner wheel:\n");
scanf("%lf", &speed);

driveCircle(robot, r, speed);
   
   
// Creates function driveCircle
int driveCircle(CLinkbotI &robot, double r, double speed1) {
    double radius = 1.75;
    double trackwidth = 3.69;
    double C1, C2;            // Of circle the robot will be driving in
    double degreesI, degreesO;
    double speed2;
    double degreeConversion = 0.0305;

// Objective: Find ratio of wheel speeds based on circumference

    C1 = (2*M_PI) * r;                  // Circumference of inner wheel in inches
    C2 = (2*M_PI) * (r + trackwidth);   // Circumference of outer wheel in inches
    degreesI = C1/degreeConversion;     // Convert to degrees
    degreesO = C2/degreeConversion;

    speed2 = (degreesO * speed1) / degreesI;
    
    while (speed2 > 240) {
        printf("At %lf, the speed of joint3 is %lf, beyond the limit of 240 degrees/sec.\n", speed1, speed2);
        printf("Please enter a lower number:\n");
        scanf("%lf", &speed1);
        speed2 = (degreesO * speed1) / degreesI;        // Equation: degreesI/speed1 = degreesO/speed2
    }
    
    robot.setJointSpeeds(speed1, NaN, speed2);
    robot.move(degreesI, NaN, -degreesO);       // Use ratio to find degrees so that both will stop at the same time
    return 0;
}
