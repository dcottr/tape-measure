//
//  MeasureHelper.m
//  TapeMeasure
//
//  Created by David Cottrell on 7/27/13.
//  Copyright (c) 2013 David Cottrell. All rights reserved.
//

#import "MeasureHelper.h"

@interface MeasureHelper ()

@property (nonatomic, weak) id <MeasureHelperDelegate> delegate;

@end

@implementation MeasureHelper

- (id)initWithDelegate:(id <MeasureHelperDelegate>)delegate
{
    self = [super init];
    if (self) {
        _delegate = delegate;
    }
    return self;
}

- (void)startMeasure
{
#pragma message("TODO: Implement")
}

- (void)stopMeasure
{
#pragma message("TODO: Implement")
}

@end
