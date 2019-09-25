/* File: CurveTests.ch */

#include <linkbot.h>
CLinkbotI robot, robot2;

double radius = 1.75;   // Of wheel
double trackwidth = 3.69;
double r, C1, C2;            // Of circle the robot will be driving in
double degreesI, degreesO;
double speed1, speed2;
double degreeConversion = 0.0305;   // Number of inches in a degree for a Linkbot wheel whose radius = 1.75


printf("Input the radius of the circle you want the robot to create:\n");
printf("*** Radius is in reference to the inner wheel of the Linkbot ***\n");
scanf("%lf", &r);
printf("Speed of Joint1?\n");
scanf("%lf", &speed1);

// Objective: Find ratio of wheel speeds based on circumference

C1 = (2*M_PI) * r;                  // Circumference of inner wheel in inches
C2 = (2*M_PI) * (r + trackwidth);   // Circumference of outer wheel in inches
degreesI = C1/degreeConversion;               // Convert to degrees
degreesO = C2/degreeConversion;

speed2 = (degreesO * speed1) / degreesI;

/* When inputting speed1, the above calculation may set speed2 to above 240, which is not permitted. 
Therefore, a while loop forces the user to enter a lower number. */
while (speed2 > 240) {
    printf("At %lf, the speed of joint3 is %lf, beyond the limit of 240 degrees/sec.\n", speed1, speed2);
    printf("Please enter a lower number:\n");
    scanf("%lf", &speed1);
    speed2 = (degreesO * speed1) / degreesI;    // Equation is a direct proportion: degreesI/speed1 = degreesO/speed2
}

robot.setJointSpeeds(speed1, NaN, speed2);  // Apply the values generated from the above formulas
robot.move(degreesI, NaN, -degreesO);       // Use ratio to find degrees so that both will stop at the same time



