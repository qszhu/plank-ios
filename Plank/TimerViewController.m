//
// Created by Qinsi ZHU on 8/15/13.
// Copyright (c) 2013 Qinsi ZHU. All rights reserved.
//


#import "TimerViewController.h"
#import "Utils.h"
#import "HistoryList.h"
#import "History.h"
#import "Setting.h"
#import "VoicePlayer.h"
#import "TestFlight.h"

static NSTimeInterval const kSensorSampleInterval = 0.5;

@interface TimerViewController ()
@property(nonatomic) NSUInteger elapsedMilliSeconds;
@property(nonatomic) BOOL isTimerRunning;
@property(nonatomic) BOOL isTimerReady;
@property(strong, nonatomic) NSTimer *timer;
@property(strong, nonatomic) HistoryList *historyList;
@property(nonatomic) NSUInteger bestDuration;
@property(nonatomic) NSUInteger oldHistoryCount;
@property(nonatomic) NSTimeInterval sensorLastSample;
@property(nonatomic) BOOL isSensorEnabled;
@property(strong, nonatomic) VoicePlayer *voicePlayer;
@end

@implementation TimerViewController {
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.voicePlayer = [[VoicePlayer alloc] init];
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

    self.isSensorEnabled = [self enableSensor];
    if (self.isSensorEnabled) {
        [self startSensor];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    if (self.isSensorEnabled) {
        [self stopSensor];
        [self disableSensor];
    }
}

- (BOOL)enableSensor {
    UIDevice *device = [UIDevice currentDevice];
    device.proximityMonitoringEnabled = YES;
    return device.isProximityMonitoringEnabled;
}

- (void)disableSensor {
    UIDevice *device = [UIDevice currentDevice];
    device.proximityMonitoringEnabled = NO;
}

- (void)stopSensor {
    [self.timerButton setHidden:NO];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)startSensor {
    [self.timerButton setHidden:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleProximityChange:)
                                                 name:UIDeviceProximityStateDidChangeNotification
                                               object:nil];
}

- (void)handleProximityChange:(NSNotification *)notification {
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    if (now - self.sensorLastSample < kSensorSampleInterval) {
        return;
    }
    self.sensorLastSample = now;
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
    if (self.elapsedMilliSeconds % 1000 == 0) {
        [self announce];
    }
}

- (void)stopTimer {
    [self.timer invalidate];
    [self.historyList addHistory:[[History alloc] initWithDuration:self.elapsedMilliSeconds]];
    self.bestDuration = [self.historyList getBest].duration;

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

- (NSString *)messageForTime {
    NSString *msg = @"";
    NSUInteger minutes = self.elapsedMilliSeconds / 1000 % 3600 / 60;
    NSUInteger seconds = self.elapsedMilliSeconds / 1000 % 60;
    if (seconds % 10 != 0) {
        return msg;
    }
    if (minutes > 0) {
        msg = [msg stringByAppendingFormat:@"%d %@", minutes, minutes == 1 ? @"minute" : @"minutes"];
    }
    if (seconds > 0) {
        if (minutes > 0) {
            msg = [msg stringByAppendingString:@" and "];
        }
        msg = [msg stringByAppendingFormat:@"%d seconds", seconds];
    }
    return msg;
}

- (void)announce {
    NSString *text = [self messageForTime];
    if ([text isEqual:@""]) {
        return;
    }
    NSLog(@"%@", text);
    [self.voicePlayer playText:text];
}

@end