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
    UINavigationController *timerNav = [[UINavigationController alloc] initWithRootViewController:timerVC];
    timerNav.tabBarItem.title = @"Timer";
    timerNav.tabBarItem.image = [UIImage imageNamed:@"first"];

    HistoryViewController *historyVC = [[HistoryViewController alloc] init];
    UINavigationController *historyNav = [[UINavigationController alloc] initWithRootViewController:historyVC];
    historyNav.tabBarItem.title = @"History";
    historyNav.tabBarItem.image = [UIImage imageNamed:@"second"];

    MainViewController *mainVC = [[MainViewController alloc] init];
    [mainVC setViewControllers:@[timerNav, historyNav] animated:NO];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = mainVC;
    [self.window makeKeyAndVisible];
    return YES;
}


@end