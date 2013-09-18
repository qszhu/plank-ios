//
// Created by Qinsi ZHU on 8/15/13.
// Copyright (c) 2013 Qinsi ZHU. All rights reserved.
//


#import "MainViewController.h"
#import "Setting.h"
#import "TestFlight.h"

static NSString *const kHasAskedUsage = @"has_asked_usage";
static NSString *const kHasShownTutorial = @"has_shown_tutorial";

@implementation MainViewController {
}

- (void)viewDidLoad {
    [self askForUsage];
}

- (void)viewDidAppear:(BOOL)animated {
    if (![[NSUserDefaults standardUserDefaults] objectForKey:kHasShownTutorial]) {
        MYIntroductionPanel *panel1 = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"plank0"] title:@"Ready" description:@"Approach the device until you hear ready."];
        MYIntroductionPanel *panel2 = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"plank1"] title:@"Start" description:@"Leave the device far enough to start timing."];
        MYIntroductionPanel *panel3 = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"plank2"] title:@"Done" description:@"Approach the device again to stop timing"];
        MYIntroductionView *introductionView = [[MYIntroductionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
                                                                             headerImage:nil
                                                                                  panels:@[panel1, panel2, panel3]];
        [introductionView setBackgroundColor:[UIColor colorWithRed:37.0/255 green:104.0/255 blue:154.0/255 alpha:1.0]];
        introductionView.delegate = self;
        [introductionView showInView:self.view animateDuration:0];
        [[NSUserDefaults standardUserDefaults] setValue:@"YES" forKey:kHasShownTutorial];
    }
}

-(void)introductionDidFinishWithType:(MYFinishType)finishType{
    if (finishType == MYFinishTypeSkipButton) {
        [TestFlight passCheckpoint:@"skipped tutorial"];
    } else if (finishType == MYFinishTypeSwipeOut){
        [TestFlight passCheckpoint:@"finished tutorial"];
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