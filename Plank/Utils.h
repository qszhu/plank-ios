//
// Created by Qinsi ZHU on 8/18/13.
// Copyright (c) 2013 Qinsi ZHU. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface Utils : NSObject
+ (void)scheduleLocalNotificationAt:(NSDate *)date alert:(NSString *)alert;

+ (NSString *)getPathToArchive:(NSString *)path;

+ (NSString *)formatDuration:(NSInteger)duration;

+ (NSString *)formatDate:(NSDate *)date;

+ (NSString *)formatTime:(NSDate *)date;

+ (NSDate *)dateByOffset:(NSInteger)offset fromDate:(NSDate *)date;

+ (BOOL)sameDay:(NSDate *)date1 fromDate:(NSDate *)date2;

+ (NSInteger)daysBetween:(NSDate *)startDate and:(NSDate *)endDate;

@end