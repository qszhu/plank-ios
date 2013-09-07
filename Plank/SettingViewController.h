//
// Created by Qinsi ZHU on 8/19/13.
// Copyright (c) 2013 Qinsi ZHU. All rights reserved.
//


#import <Foundation/Foundation.h>

@class Setting;


@interface SettingViewController : UITableViewController
@property(strong, nonatomic) Setting *setting;

@property(strong, nonatomic) IBOutlet UISwitch *notificationSwitch;
@property(strong, nonatomic) IBOutlet UILabel *timeLabel;
@property(strong, nonatomic) IBOutlet UISwitch *sendUsageSwitch;

- (IBAction)notifySwitched:(id)sender;
- (IBAction)sendUsageSwitched:(id)sender;
@end