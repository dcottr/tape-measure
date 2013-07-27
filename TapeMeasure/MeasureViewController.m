//
//  MesureViewController.m
//  TapeMeasure
//
//  Created by David Cottrell on 7/27/13.
//  Copyright (c) 2013 David Cottrell. All rights reserved.
//

#import "MeasureViewController.h"
#import "MeasureHelper.h"
#import "MeasureHelperDelegate.h"


@interface MeasureViewController () <MeasureHelperDelegate>
@property (nonatomic, weak) IBOutlet UIButton *startBtn;
@property (nonatomic, weak) IBOutlet UILabel *distanceLabel;
@property (nonatomic, strong) MeasureHelper *measureHelper;
@property (nonatomic, assign) BOOL isMeasuring;

- (IBAction)startBtnAction:(id)sender;

@end

@implementation MeasureViewController

- (id)init
{
    self = [super initWithNibName:@"MeasureViewController" bundle:nil];
    if (self) {
        _measureHelper = [[MeasureHelper alloc] initWithDelegate:self];
        _isMeasuring = NO;
    }
    return self;
}

- (IBAction)startBtnAction:(id)sender
{
    _isMeasuring = !_isMeasuring;
    if (_isMeasuring) {
        [_measureHelper startMeasure];
    } else {
        [_measureHelper stopMeasure];
    }
    _startBtn.selected = _isMeasuring;
}

-(void)didUpdateDistance:(double)distance
{
    _distanceLabel.text = [NSString stringWithFormat:@"%f", distance];
}


@end
