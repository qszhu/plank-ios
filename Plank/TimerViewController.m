//
// Created by Qinsi ZHU on 8/15/13.
// Copyright (c) 2013 Qinsi ZHU. All rights reserved.
//


#import "TimerViewController.h"

@interface TimerViewController ()
@property(nonatomic) NSUInteger elapsedMilliSeconds;
@property(nonatomic) BOOL isTimerRunning;
@property(strong, nonatomic) NSTimer *timer;
@end

@implementation TimerViewController {
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.elapsedMilliSeconds = 0;
    self.isTimerRunning = NO;
}

- (NSString *)timerText {
    NSInteger minutes = self.elapsedMilliSeconds % 3600000 / 60000;
    NSInteger seconds = self.elapsedMilliSeconds % 60000 / 1000;
    NSUInteger milliseconds = self.elapsedMilliSeconds % 1000;
    return [NSString stringWithFormat:@"%02d:%02d:%02d", minutes, seconds, milliseconds/10];
}

- (void)onTimerTick {
    self.elapsedMilliSeconds += 10;
    self.timerLabel.text = [self timerText];
}

- (IBAction)timerButtonPressed:(id)sender {
    self.isTimerRunning = !self.isTimerRunning;
    NSString *title = self.isTimerRunning ? @"Stop" : @"Start";
    [self.timerButton setTitle:title forState:UIControlStateNormal];
    if (self.isTimerRunning) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(onTimerTick) userInfo:nil repeats:YES];
    } else {
        [self.timer invalidate];
    }
}

@end