//
// Created by Qinsi ZHU on 8/15/13.
// Copyright (c) 2013 Qinsi ZHU. All rights reserved.
//


#import "TimerViewController.h"
#import "Utils.h"
#import "HistoryList.h"
#import "History.h"
#import "TestFlight.h"
#import "Setting.h"

@interface TimerViewController ()
@property(nonatomic) NSUInteger elapsedMilliSeconds;
@property(nonatomic) BOOL isTimerRunning;
@property(nonatomic) BOOL isTimerReady;
@property(strong, nonatomic) NSTimer *timer;
@property(strong, nonatomic) HistoryList *historyList;
@property(nonatomic) NSUInteger bestDuration;
@property(nonatomic) NSUInteger oldHistoryCount;
@end

@implementation TimerViewController {
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if ([Setting sendUsage]) {
        [TestFlight passCheckpoint:@"timer view did appear"];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self setTitle:@"Timer"];
    self.historyList = [HistoryList loadHistoryList];
    self.oldHistoryCount = self.historyList.count;
    self.elapsedMilliSeconds = 0;
    self.isTimerRunning = NO;
    self.isTimerReady = NO;

    History *bestHistory = [self.historyList getBest];
    self.bestDuration = bestHistory == nil ? 0 : bestHistory.duration;
    [self.bestScoreLabel setText:[Utils formatDuration:self.bestDuration]];

    UIDevice *device = [UIDevice currentDevice];
    device.proximityMonitoringEnabled = YES;
    if (device.isProximityMonitoringEnabled) {
        [self.timerButton setHidden:YES];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleProximityChange:)
                                                     name:UIDeviceProximityStateDidChangeNotification
                                                   object:nil];
    }
}

- (void)handleProximityChange:(NSNotification *)notification {
    BOOL close = [[UIDevice currentDevice] proximityState];
    NSLog(@"%s proximityState=%d", __FUNCTION__, close);
    if (close) {
        if (self.isTimerRunning) {
            if ([Setting sendUsage]) {
                [TestFlight passCheckpoint:@"censor stop timer"];
            }
            self.isTimerRunning = NO;
            self.isTimerReady = NO;
            [self stopTimer];
        } else {
            if ([Setting sendUsage]) {
                [TestFlight passCheckpoint:@"censor timer ready"];
            }
            self.isTimerReady = YES;
        }
    } else if (self.isTimerReady && !self.isTimerRunning) {
        if ([Setting sendUsage]) {
            [TestFlight passCheckpoint:@"censor start timer"];
        }
        self.isTimerRunning = YES;
        [self startTimer];
    }
}

- (void)startTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                  target:self
                                                selector:@selector(onTimerTick)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)onTimerTick {
    self.elapsedMilliSeconds += 10;
    NSString *scoreText = [Utils formatDuration:self.elapsedMilliSeconds];
    self.timerLabel.text = scoreText;
    if (self.elapsedMilliSeconds < self.bestDuration) {
        self.timerLabel.textColor = [UIColor redColor];
    } else {
        self.timerLabel.textColor = [UIColor greenColor];
        [self.bestScoreLabel setText:scoreText];
    }
}

- (void)stopTimer {
    [self.timer invalidate];
    [self.historyList addHistory:[[History alloc] initWithDuration:self.elapsedMilliSeconds]];

    [HistoryList saveHistoryList:self.historyList];
    [self.tabBarController.tabBar.items[1]
            setBadgeValue:[NSString stringWithFormat:@"%i", self.historyList.count - self.oldHistoryCount]];

    self.elapsedMilliSeconds = 0;
    self.timerLabel.text = [Utils formatDuration:self.elapsedMilliSeconds];
    self.timerLabel.textColor = [UIColor blackColor];
}

- (IBAction)timerButtonPressed:(id)sender {
    if ([Setting sendUsage]) {
        [TestFlight passCheckpoint:@"timer button pressed"];
    }
    self.isTimerRunning = !self.isTimerRunning;
    NSString *title = self.isTimerRunning ? @"Stop" : @"Start";
    [self.timerButton setTitle:title forState:UIControlStateNormal];
    if (self.isTimerRunning) {
        [self startTimer];
    } else {
        [self stopTimer];
    }
}

@end