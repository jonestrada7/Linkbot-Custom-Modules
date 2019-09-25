/* File: MultiBotFiles.ch */

/* TEST LOG 1:
   After multiple attempts at manipulating pointers and references, I believe
   I've found my solution! */
   
/* CONFIG:
   rightbot wheel = JOINT1
   leftbot wheel = JOINT3 */
   
/* Programmer's Notes:
   Why use implicit pointer 'this->'?
   A: 'this->' is required for disambiguation. Also allows member functions to access its own address.
   In simpler terms, take an example class named object. When using a function,
   'this->function' resolves to 'object.function' */

MultiBot::MultiBot(double r, double tr) {
    this->radius = r;
    this->trackwidth = tr;
}

void MultiBot::addRobots(CLinkbotI &right, CLinkbotI &left, CLinkbotI &mid, CLinkbotI &gripperfnc) {
    this->rightbot = &right;
    this->leftbot = &left;
    this->midbot = &mid;
    this->gripper = &gripperfnc;
    printf("Radius: %.2lf\nTrackwidth: %.2lf\n", this->radius, this->trackwidth);
    /* (*this->rightbot).holdJoint(JOINT1);
    (*this->leftbot).holdJoint(JOINT3); */
} 

void MultiBot::liftArm(...) {
    va_list args;
    va_start(args, 1);
    int vacount = va_count(args);
    
    if (vacount == 1) {
        double angle = va_arg(args, double);
        (*this->rightbot).holdJoint(JOINT3);
        (*this->leftbot).holdJoint(JOINT1);
        (*this->midbot).move(angle, NaN, -angle);
    }
    
    else {
        (*this->rightbot).holdJoint(JOINT3);
        (*this->leftbot).holdJoint(JOINT1);
        (*this->midbot).move(55, NaN, -55);
        (*this->midbot).holdJoints();
    }
    va_end(args);
}

void MultiBot::lowerArm(double angle) {
    (*this->rightbot).holdJoint(JOINT3);
    (*this->leftbot).holdJoint(JOINT1);
    (*this->midbot).move(-angle, NaN, angle);
}

void MultiBot::driveDistance(double distance) {
    double angle = (360*distance)/(2*(this->radius)*M_PI);  // Converts inches to degrees using ratio and given radius
    (*this->rightbot).moveJointNB(JOINT1, -angle);
    (*this->leftbot).moveJoint(JOINT3, angle);
}

void MultiBot::setJointSpeed(double speed) {
    (*this->rightbot).setJointSpeed(JOINT1, speed);
    (*this->leftbot).setJointSpeed(JOINT3, speed);
}

void MultiBot::turnRight(double givenAngle) {
    // Under maintenance
      double arc = ((givenAngle/360)*(this->trackwidth)*M_PI);
    double angle = (360*arc)/(2*(this->radius)*M_PI);   // Converts inches to degrees
    (*this->rightbot).moveJointNB(JOINT1, angle);
    (*this->leftbot).moveJoint(JOINT3, angle);
}

void MultiBot::turnLeft(double givenAngle) {
    // Under maintenance
    double arc = ((givenAngle/360)*(this->trackwidth)*M_PI);
    double angle = (360*arc)/(2*(this->radius)*M_PI);   // Converts inches to degrees
    (*this->rightbot).moveJointNB(JOINT1, -angle);
    (*this->leftbot).moveJoint(JOINT3, -angle);
}

void MultiBot::move(double angle1, double angle2) {
    (*this->rightbot).moveJointNB(JOINT1, angle1);
    (*this->leftbot).moveJoint(JOINT3, -angle2);
}

void MultiBot::resetGripper() {
    // NOTE: Still in maintenance. If in use, beware of malfunctioning gripper
    double angle1, angle3;
    (*this->gripper).getJointAngles(angle1, NaN, angle3);
    if (angle3 >= 0 && angle3 <= 90) {
        (*this->gripper).moveJointTo(JOINT3, 0);
    }
    else if (angle3 > 90 && angle3 <= 180) {
        (*this->gripper).moveJointTo(JOINT3, 90);
    }
    else if (angle3 > 180 && angle3 <= 270) {
        (*this->gripper).moveJointTo(JOINT3, 180);
    }
    else if (angle3 > 270 && angle3 < 359) {
        (*this->gripper).moveJointTo(JOINT3, 270);
    }
    
    if (angle1 >= 0 && angle1 <= 90) {
        (*this->gripper).moveJointTo(JOINT3, 0);
    }
    else if (angle1 > 90 && angle1 <= 180) {
        (*this->gripper).moveJointTo(JOINT3, 90);
    }
    else if (angle1 > 180 && angle1 <= 270) {
        (*this->gripper).moveJointTo(JOINT3, 180);
    }
    else if (angle1 > 270 && angle1 < 359) {
        (*this->gripper).moveJointTo(JOINT3, 270);
    }
}

void MultiBot::closeGripper(double angle) {
    // From openmost position, the degrees to full closure is 75
    (*this->gripper).moveJointNB(JOINT3, angle);
    (*this->gripper).moveJoint(JOINT1, angle);
    (*this->gripper).holdJoint(JOINT1);
    (*this->gripper).holdJoint(JOINT3);
}

void MultiBot::openGripper(double angle) {
    (*this->gripper).moveJointNB(JOINT3, -angle);
    (*this->gripper).moveJoint(JOINT1, -angle);
}

void MultiBot::applyPressureNB(double speed) {
    (*this->gripper).setJointSpeed(JOINT1, speed);
    (*this->gripper).moveJointNB(JOINT1, 10);
}
