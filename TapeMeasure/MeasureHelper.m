//
//  MeasureHelper.m
//  TapeMeasure
//
//  Created by David Cottrell on 7/27/13.
//  Copyright (c) 2013 David Cottrell. All rights reserved.
//

#import "MeasureHelper.h"
#import <CoreMotion/CoreMotion.h>

@interface MeasureHelper ()

@property (nonatomic, weak) id <MeasureHelperDelegate> delegate;
@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, strong) NSOperationQueue *queue;

@property (nonatomic, assign) NSTimeInterval previousTimeStamp;

@property (nonatomic, assign) double px;
@property (nonatomic, assign) double py;
@property (nonatomic, assign) double pz;

@property (nonatomic, assign) double vx;
@property (nonatomic, assign) double vy;
@property (nonatomic, assign) double vz;


@property (nonatomic, assign) NSTimeInterval timeSinceMeaningfulAccelerationX;
@property (nonatomic, assign) NSTimeInterval timeSinceMeaningfulAccelerationY;
@property (nonatomic, assign) NSTimeInterval timeSinceMeaningfulAccelerationZ;

@end

@implementation MeasureHelper

- (id)initWithDelegate:(id <MeasureHelperDelegate>)delegate
{
    self = [super init];
    if (self) {
        _delegate = delegate;
        _motionManager = [[CMMotionManager alloc] init];
        _queue = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 1;
    }
    return self;
}

- (void)initializeValues
{
    _previousTimeStamp = -1.0;
    
    _px = _py = _pz = 0.0;
    _vx = _vy = _vz = 0.0;
}


- (double)distanceWithX:(double)x y:(double)y z:(double)z
{
    return sqrt(x*x + y*y + z*z);
}

- (void)computeUpdatedDistance:(CMDeviceMotion *)motion
{
    if (_previousTimeStamp != -1.0) {
        
        NSTimeInterval deltaT = motion.timestamp-_previousTimeStamp;
        
        double ax = motion.userAcceleration.x;
        double ay = motion.userAcceleration.y;
        double az = motion.userAcceleration.z;
        
        if (fabs(ax) < 0.01) {
            _timeSinceMeaningfulAccelerationX += deltaT;
        } else {
            _timeSinceMeaningfulAccelerationX = 0.0;
        }
        
        if (fabs(ay) < 0.01) {
            _timeSinceMeaningfulAccelerationY += deltaT;
        } else {
            _timeSinceMeaningfulAccelerationY = 0.0;
        }
        if (fabs(az) < 0.04) {
            _timeSinceMeaningfulAccelerationZ += deltaT;
        } else {
            _timeSinceMeaningfulAccelerationZ = 0.0;
        }
        
        if (_timeSinceMeaningfulAccelerationX > 0.1) {
            _vx *= 0.75;
        } else {
            _vx += ax * deltaT;
        }
        if (_timeSinceMeaningfulAccelerationY > 0.1) {
            _vy *= 0.75;
        } else {
            _vy += ax * deltaT;
        }
        
        if (_timeSinceMeaningfulAccelerationZ > 0.1) {
            _vz *= 0.5;
            DLog(@"dampen");
        } else {
            _vz += ax * deltaT;
        }
        
        _px += _vx * deltaT;
        _py += _vy * deltaT;
        _pz += _vz * deltaT;

//        DLog(@"v:%f", _vz);
//        DLog(@"accel:%f", motion.userAcceleration.z);
//        DLog(@"x:%f", _px*980.6);
//        DLog(@"y:%f", _py*980.6);
//        DLog(@"z:%f", _pz*980.6);

        
//        DLog(@"y:%f", _py);
//        DLog(@"z:%f", _pz);

        
        DLog(@"Total Distance: %f", [self distanceWithX:_px y:_py z:_pz] * 980.6);
    }
    
    _previousTimeStamp = motion.timestamp;
    
}

- (void)startMeasure
{
    [self initializeValues];
    _motionManager.deviceMotionUpdateInterval = 0.01;
    
    [_motionManager startDeviceMotionUpdatesToQueue:_queue withHandler:^(CMDeviceMotion *motion, NSError *error) {
        if (error) {
            DLog(@"ERROR: %@", error);
        } else {
            [self computeUpdatedDistance:motion];
        }
    }];
}

- (void)stopMeasure
{
    [_motionManager stopDeviceMotionUpdates];
}

@end
