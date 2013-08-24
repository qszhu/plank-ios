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
#import "SettingViewController.h"
#import "TestFlight.h"

@interface AppDelegate ()
@property(strong, nonatomic) MainViewController *mainVC;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [TestFlight setDeviceIdentifier:[[UIDevice currentDevice] uniqueIdentifier]];
    [TestFlight takeOff:@"a8e05f04-c678-41c3-ad61-ee44cfe62431"];

    TimerViewController *timerVC = [[TimerViewController alloc] init];
    UINavigationController *timerNav = [[UINavigationController alloc] initWithRootViewController:timerVC];
    timerNav.tabBarItem.title = @"Timer";
    timerNav.tabBarItem.image = [UIImage imageNamed:@"first"];

    HistoryViewController *historyVC = [[HistoryViewController alloc] init];
    UINavigationController *historyNav = [[UINavigationController alloc] initWithRootViewController:historyVC];
    historyNav.tabBarItem.title = @"History";
    historyNav.tabBarItem.image = [UIImage imageNamed:@"second"];

    SettingViewController *settingVC = [[SettingViewController alloc] init];
    UINavigationController *settingNav = [[UINavigationController alloc] initWithRootViewController:settingVC];
    settingNav.tabBarItem.title = @"Setting";
    settingNav.tabBarItem.image = [UIImage imageNamed:@"first"];

    self.mainVC = [[MainViewController alloc] init];
    [self.mainVC setViewControllers:@[timerNav, historyNav, settingNav] animated:NO];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.mainVC;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    NSLog(@"received local notification");
    [self.mainVC setSelectedIndex:0];
}

@end