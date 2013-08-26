//
// Created by Qinsi ZHU on 8/15/13.
// Copyright (c) 2013 Qinsi ZHU. All rights reserved.
//


#import "MainViewController.h"
#import "Setting.h"

static NSString *const kHasAskedUsage = @"has_asked_usage";

@implementation MainViewController {
}

- (void)viewDidLoad {
    [self askForUsage];
}

- (void)askForUsage {
    if (![[NSUserDefaults standardUserDefaults] objectForKey:kHasAskedUsage]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Usage statistics"
                                                        message:@"Send anonymous usage statistics to help us improve the application? You can change that later in Settings."
                                                       delegate:self
                                              cancelButtonTitle:@"No"
                                              otherButtonTitles:@"Yes", nil];
        [alert show];
        [[NSUserDefaults standardUserDefaults] setValue:@"YES" forKey:kHasAskedUsage];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    Setting *setting = [Setting loadSetting];
    setting.sendUsage = buttonIndex != alertView.cancelButtonIndex;
    [Setting saveSetting:setting];
}

@end