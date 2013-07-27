//
//  MeasureHelper.h
//  TapeMeasure
//
//  Created by David Cottrell on 7/27/13.
//  Copyright (c) 2013 David Cottrell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MeasureHelperDelegate.h"

@interface MeasureHelper : NSObject

- (void)startMeasure;
- (void)stopMeasure;

- (id)initWithDelegate:(id <MeasureHelperDelegate>)delegate;

@end
