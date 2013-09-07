//
//  TimePickerViewController.m
//  Plank
//
//  Created by Qinsi ZHU on 9/7/13.
//  Copyright (c) 2013 Qinsi ZHU. All rights reserved.
//

#import "TimePickerViewController.h"
#import "Setting.h"
#import "TestFlight.h"

@interface TimePickerViewController ()

@end

@implementation TimePickerViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [TestFlight passCheckpoint:@"time picker view appear"];
}

- (IBAction)cancelPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)donePressed:(id)sender {
    [Setting setNotificationTime:[self.timePicker date]];
    [self dismissViewControllerAnimated:YES completion:^{
        // TODO: use protocol
        [self.settingViewController viewDidAppear:YES];
    }];
}

@end
