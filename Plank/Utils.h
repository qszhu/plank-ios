//
// Created by Qinsi ZHU on 8/18/13.
// Copyright (c) 2013 Qinsi ZHU. All rights reserved.
//


#import <Foundation/Foundation.h>

static NSString * const kDidPickNotificationTimeNotification = @"DidPickNotificationTime";

@interface Utils : NSObject
+ (void)scheduleLocalNotificationAt:(NSDate *)date alert:(NSString *)alert;

+ (NSString *)getPathToArchive:(NSString *)path;

+ (NSString *)formatDuration:(NSInteger)duration;

+ (NSString *)formatDate:(NSDate *)date;

+ (NSString *)formatTime:(NSDate *)date;

@end