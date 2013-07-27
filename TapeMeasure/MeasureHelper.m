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
        _previousTimeStamp = -1.0;
    }
    return self;
}

- (double)distanceWithAccelerationX:(double)x accelerationY:(double)y accelerationZ:(double)z time:(NSTimeInterval)deltaT
{
#pragma message("TODO: implement")
    return 0.0;
}

- (void)computeUpdatedDistance:(CMDeviceMotion *)motion
{
    DLog(@"motion: %@", motion);
    if (_previousTimeStamp != -1.0) {
        
        double addedDistance = [self distanceWithAccelerationX:motion.userAcceleration.x accelerationY:motion.userAcceleration.y accelerationZ:motion.userAcceleration.z time:(motion.timestamp-_previousTimeStamp)];
        
#pragma message("TODO: add to current tally")
        
        
    }
    
    _previousTimeStamp = motion.timestamp;
    
}

- (void)startMeasure
{
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
