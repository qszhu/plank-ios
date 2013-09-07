//
// Created by Qinsi ZHU on 8/19/13.
// Copyright (c) 2013 Qinsi ZHU. All rights reserved.
//


#import "SettingViewController.h"
#import "Setting.h"
#import "Utils.h"
#import "TimePickerViewController.h"
#import "TestFlight.h"

@implementation SettingViewController {

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([Setting sendUsage]) {
        [TestFlight passCheckpoint:@"setting view did appear"];
    }

    [self.notificationSwitch setOn:[Setting notify]];
    [self.timeLabel setText:[Utils formatTime:[Setting notificationTime]]];
    [self.sendUsageSwitch setOn:[Setting sendUsage]];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationItem setTitle:@"Settings"];
}

- (IBAction)sendUsageSwitched:(id)sender {
    [Setting setSendUsage:[self.sendUsageSwitch isOn]];
}

- (IBAction)notifySwitched:(id)sender {
    [Setting setNotify:[self.notificationSwitch isOn]];
    if ([Setting notify]) {
        NSDate *notificationTime = [Setting notificationTime];
        [Utils scheduleLocalNotificationAt:notificationTime alert:@"Time to exercise!"];
        NSLog(@"notification set for %@", notificationTime);
    } else {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        NSLog(@"cancel all notifications");
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 1) {
        TimePickerViewController *timePickerVC = [[TimePickerViewController alloc] init];
        timePickerVC.settingViewController = self;
        [self presentViewController:timePickerVC animated:YES completion:nil];
    }
}

@end