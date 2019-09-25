/* ConcentricCirclesAlpha.ch */

/* cocentriccircles */

#include <linkbot.h>
CLinkbotI robot1, robot2;

double radius = 1.75;   // Of wheel
double trackwidth = 3.69;
double OLIW = 4.00;     // In reference of the inner wheel of inner linkbot (Outer Linkbot Inner Wheel)
double r, C1, C2, C3, C4;          // Of circle the robot will be driving in
double degreesI, degreesI2, degreesO, degreesO2;
double speed1, speed2, speed3, speed4;
double degreeConversion = 0.0305;       // Constant used to convert degrees into inches or vice versa
double gap = 0.5;   // The gap taken into account between the two linkbots
double maxSpeed;    // Max speed that innermost wheel can have in reference to outermost wheel

// Objective: Find ratio of wheel speeds based on circumference
printf("Radius of inner circle (midpoint to inner wheel)?\n");
scanf("%lf", &r);
printf("Speed of inner wheel?\n");
scanf("%lf", &speed1);

C1 = (2*M_PI) * r;                  // Circumference of inner wheel in inches
C2 = (2*M_PI) * (r + trackwidth);   // Circumference of outer wheel in inches
C3 = (2*M_PI) * (r + trackwidth + gap);          // Inner wheel Outer Linkbot
C4 = (2*M_PI) * (r + 2*trackwidth + gap);       // Circumference of outermost wheel of outer linkbot

degreesI = C1/degreeConversion;                 // Convert to degrees
degreesO = C2/degreeConversion;
degreesI2 = C3/degreeConversion;
degreesO2 = C4/degreeConversion;

// Equations below utilize multiple speed ratios (3 Curve Theorems in play)
speed2 = (degreesO * speed1) / degreesI;        // speed1/speed2 = degreesI/degreesO 
speed3 = (degreesI2 * speed2) / degreesO;       // speed2/speed3 = degreesO/degreesI2
speed4 = (degreesO2 * speed3) / degreesI2;      // speed3/speed4 = degreesI2/degreesO2
maxSpeed = 240 * (speed1/speed4);               // Calculate max possible speed for innermost wheel

/* When inputting speed1, the above calculation may set speed2 to above 240, which is not permitted. 
Therefore, a while loop forces the user to enter a lower number. */
while (speed4 > 240) {
    printf("WARNING: At %lf degrees/sec, the speed of joint3 is %lf degrees/sec, above the limit of 240 degrees/sec.\n", speed1, speed4);
    printf("Please enter a speed lower than %lf degrees/sec:\n", maxSpeed);
    scanf("%lf", &speed1);
    speed2 = (degreesO * speed1) / degreesI;    // Equation: degreesI/speed1 = degreesO/speed2
    speed3 = (degreesI2 * speed2) / degreesO;
    speed4 = (degreesO2 * speed3) / degreesI2;
    maxSpeed = 240 * (speed1/speed4);           
        /* Above statement is derived from the ratio of speed 1 to speed 4 equaling that of
           the max of the innermost wheel to 240. speed1/speed4 = maxSpeed/240 */
}

printf("\nSpeed1: %lf\n", speed1);  // For human reference
printf("Speed2: %lf\n", speed2);
printf("Speed3: %lf\n", speed3);
printf("Speed4: %lf\n", speed4);

robot1.setJointSpeeds(speed1, NaN, speed2);
robot2.setJointSpeeds(speed3, NaN, speed4);
robot1.moveNB(degreesI, NaN, -degreesO);       // Use ratio to find degrees so that both will stop at the same time
robot2.move(degreesI2, NaN, -degreesO2);


