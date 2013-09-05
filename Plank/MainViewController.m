//
// Created by Qinsi ZHU on 8/15/13.
// Copyright (c) 2013 Qinsi ZHU. All rights reserved.
//


#import "MainViewController.h"
#import "Setting.h"
#import "TutorialViewController.h"

static NSString *const kHasAskedUsage = @"has_asked_usage";
static NSString *const kHasShownTutorial = @"has_shown_tutorial";

@implementation MainViewController {
}

- (void)viewDidLoad {
    [self askForUsage];
}

- (void)viewDidAppear:(BOOL)animated {
    if (![[NSUserDefaults standardUserDefaults] objectForKey:kHasShownTutorial]) {
        [self presentViewController:[[TutorialViewController alloc] init] animated:NO completion:nil];
        [[NSUserDefaults standardUserDefaults] setValue:@"YES" forKey:kHasShownTutorial];
    }
}

- (void)askForUsage {
    if (![[NSUserDefaults standardUserDefaults] objectForKey:kHasAskedUsage]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Beta Version Usage"
                                                        message:@"Anonymous usage statistics is collected by default in beta versions. You can turn it off in Settings."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        [[NSUserDefaults standardUserDefaults] setValue:@"YES" forKey:kHasAskedUsage];
    }
}

@end