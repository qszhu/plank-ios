//
// Created by Qinsi ZHU on 8/19/13.
// Copyright (c) 2013 Qinsi ZHU. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface Setting : NSObject <NSCoding>
@property(nonatomic) BOOL isNotificationOn;
@property(strong, nonatomic) NSDate *notificationTime;

+ (void)saveSetting:(Setting *)setting;

+ (Setting *)loadSetting;
@end