//
//  MeasureHelperDelegate.h
//  TapeMeasure
//
//  Created by David Cottrell on 7/27/13.
//  Copyright (c) 2013 David Cottrell. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MeasureHelperDelegate <NSObject>

-(void)didUpdateDistance:(double)distance;

@end
