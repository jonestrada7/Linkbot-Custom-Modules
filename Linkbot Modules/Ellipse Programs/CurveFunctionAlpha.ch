/* File: CurveFunctionAlpha.ch 
   Created by: Jonathan Estrada*/

#include <linkbot.h>
CLinkbotI robot1;
/* IMPORTANT: File below MUST be placed after the linkbot.h file is included and after class robot is introduced 
   else function will fail to execute. The file must ALSO be placed in the same directory as this file */
#include <CurveFile.chf>

double gap = 0.8; // Gap in between Linkbots (Only if t wo Linkbots are present)
                  // Variable "gap" can be negated in this program since it isn't being demonstrated.
double r, innerSpeed;

/* driveCircle function takes three arguments:
    1) Desired robot
    2) Radius of circle robot will be driving in
    3) Speed (Degrees/second)
*/

printf("Radius of inner circle (midpoint to inner wheel)?\n");
scanf("%lf", &r);
printf("Speed of inner wheel?\n");
scanf ("%lf", &innerSpeed);


degreeCircleRight(robot1, 8, 90, 100);
//driveCircle(robot1, r, innerSpeed);     // Linkbot "robot1" should drive in a full circle with a radius "r" and 
                                        // an inner wheel speed of "innerSpeed"
