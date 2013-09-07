//
// Created by Qinsi ZHU on 8/19/13.
// Copyright (c) 2013 Qinsi ZHU. All rights reserved.
//


#import "Setting.h"
#import "Utils.h"

@implementation Setting {

}

+ (BOOL)notify {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kIsNotificationOn];
}

+ (void)setNotify:(BOOL)notify {
    [[NSUserDefaults standardUserDefaults] setBool:notify forKey:kIsNotificationOn];
}

+ (NSDate *)notificationTime {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kNotificationTime];
}

+ (void)setNotificationTime:(NSDate *)notificationTime {
    [[NSUserDefaults standardUserDefaults] setObject:notificationTime forKey:kNotificationTime];
}

+ (BOOL)sendUsage {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kSendUsage];
}

+ (void)setSendUsage:(BOOL)sendUsage {
    [[NSUserDefaults standardUserDefaults] setBool:sendUsage forKey:kSendUsage];
}

@end