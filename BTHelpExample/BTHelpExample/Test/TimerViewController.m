//
//  TimerViewController.m
//  BTHelpExample
//
//  Created by apple on 2020/6/15.
//  Copyright © 2020 stonemover. All rights reserved.
//

#import "TimerViewController.h"
#import "BTTimerHelp.h"
#import "BTUtils.h"

@interface TimerViewController ()

@property (nonatomic, strong) BTTimerHelp * timer;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;



@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Timer";
    __weak TimerViewController * weakSelf=self;
    self.timer = [[BTTimerHelp alloc] init];
    self.timer.changeTime = 1;
    self.timer.block = ^{
        weakSelf.timeLabel.text = [BTUtils convertSecToTime:(int)weakSelf.timer.totalTime];
    };
    
}


- (IBAction)startClick:(id)sender {
    [self.timer start];
}

- (IBAction)pauseClick:(id)sender {
    [self.timer pause];
}

- (IBAction)resetClick:(id)sender {
    self.timer.changeTime = 3;
    [self.timer start];
}

- (void)dealloc{
    [self.timer stop];
}

@end
