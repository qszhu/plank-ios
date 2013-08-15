//
//  AppDelegate.m
//  Plank
//
//  Created by Qinsi ZHU on 8/15/13.
//  Copyright (c) 2013 Qinsi ZHU. All rights reserved.
//

#import "AppDelegate.h"

#import "MainViewController.h"
#import "HistoryViewController.h"
#import "TimerViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    TimerViewController *timerVC = [[TimerViewController alloc] init];
    timerVC.tabBarItem.title = @"Timer";
    timerVC.tabBarItem.image = [UIImage imageNamed:@"first"];

    HistoryViewController *historyVC = [[HistoryViewController alloc] init];
    historyVC.tabBarItem.title = @"History";
    historyVC.tabBarItem.image = [UIImage imageNamed:@"second"];

    MainViewController *mainVC = [[MainViewController alloc] init];
    [mainVC setViewControllers:@[timerVC, historyVC] animated:NO];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = mainVC;
    [self.window makeKeyAndVisible];
    return YES;
}


@end