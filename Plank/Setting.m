//
// Created by Qinsi ZHU on 8/19/13.
// Copyright (c) 2013 Qinsi ZHU. All rights reserved.
//


#import "Setting.h"
#import "Utils.h"

static NSString *const kIsNotificationOn = @"is_notification_on";
static NSString *const kNotificationTime = @"notification_time";
static NSString *const kSendUsage = @"send_usage";
static NSString *const kModelPath = @"model.setting";

@implementation Setting {

}

static Setting *gInstance = nil;

+ (Setting *)instance {
    @synchronized(self) {
        if (gInstance == nil) {
            gInstance = [self loadSetting];
        }
    }
    return gInstance;
}

+ (BOOL)sendUsage {
    return [Setting instance].sendUsage;
}

- (id)init {
    self = [super init];
    if (self) {
        self.isNotificationOn = NO;
        self.notificationTime = [NSDate date];
        self.sendUsage = NO;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [self init];
    if (self) {
        self.isNotificationOn = [coder decodeBoolForKey:kIsNotificationOn];
        self.notificationTime = [coder decodeObjectForKey:kNotificationTime];
        self.sendUsage = [coder decodeBoolForKey:kSendUsage];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeBool:self.isNotificationOn forKey:kIsNotificationOn];
    [coder encodeObject:self.notificationTime forKey:kNotificationTime];
    [coder encodeBool:self.sendUsage forKey:kSendUsage];
}

+ (void)saveSetting:(Setting *)setting {
    [NSKeyedArchiver archiveRootObject:setting toFile:[Utils getPathToArchive:kModelPath]];
    if (setting.isNotificationOn) {
        [Utils scheduleLocalNotificationAt:setting.notificationTime alert:@"Time to exercise!"];
        NSLog(@"notification set for %@", setting.notificationTime);
    } else {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        NSLog(@"cancel all notifications");
    }
    gInstance = setting;
}

+ (Setting *)loadSetting {
    Setting *setting = [NSKeyedUnarchiver unarchiveObjectWithFile:[Utils getPathToArchive:kModelPath]];
    if (setting == nil) {
        setting = [[Setting alloc] init];
    }
    return setting;
}

@end