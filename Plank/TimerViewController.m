//
// Created by Qinsi ZHU on 8/15/13.
// Copyright (c) 2013 Qinsi ZHU. All rights reserved.
//


#import "TimerViewController.h"
#import "Utils.h"
#import "HistoryList.h"
#import "History.h"

@interface TimerViewController ()
@property(nonatomic) NSUInteger elapsedMilliSeconds;
@property(nonatomic) BOOL isTimerRunning;
@property(strong, nonatomic) NSTimer *timer;
@property(strong, nonatomic) HistoryList *historyList;
@end

@implementation TimerViewController {
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self setTitle:@"Timer"];
    self.historyList = [HistoryList getHistoryList];
    self.elapsedMilliSeconds = 0;
    self.isTimerRunning = NO;
}

- (void)onTimerTick {
    self.elapsedMilliSeconds += 10;
    self.timerLabel.text = [Utils formatDuration:self.elapsedMilliSeconds];
}

- (IBAction)timerButtonPressed:(id)sender {
    self.isTimerRunning = !self.isTimerRunning;
    NSString *title = self.isTimerRunning ? @"Stop" : @"Start";
    [self.timerButton setTitle:title forState:UIControlStateNormal];
    if (self.isTimerRunning) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                      target:self
                                                    selector:@selector(onTimerTick)
                                                    userInfo:nil
                                                     repeats:YES];
    } else {
        [self.timer invalidate];
        [self.historyList addHistory:[[History alloc] initWithDuration:self.elapsedMilliSeconds]];

        [HistoryList saveHistoryList:self.historyList];

        self.elapsedMilliSeconds = 0;
        self.timerLabel.text = [Utils formatDuration:self.elapsedMilliSeconds];
    }
}

@end