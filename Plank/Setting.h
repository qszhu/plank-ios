//
// Created by Qinsi ZHU on 8/19/13.
// Copyright (c) 2013 Qinsi ZHU. All rights reserved.
//


#import <Foundation/Foundation.h>

static NSString *const kIsNotificationOn = @"is_notification_on";
static NSString *const kNotificationTime = @"notification_time";
static NSString *const kSendUsage = @"send_usage";

@interface Setting : NSObject

+ (BOOL)notify;
+ (void)setNotify:(BOOL)notify;

+ (NSDate *)notificationTime;
+ (void)setNotificationTime:(NSDate *)notificationTime;

+ (BOOL)sendUsage;
+ (void)setSendUsage:(BOOL)sendUsage;

@end