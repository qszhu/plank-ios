//
// Created by Qinsi ZHU on 8/18/13.
// Copyright (c) 2013 Qinsi ZHU. All rights reserved.
//


#import "Utils.h"


@implementation Utils {

}

+ (void)scheduleLocalNotificationAt:(NSDate *)date alert:(NSString *)alert {
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = date;
    localNotification.alertBody = alert;
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.repeatInterval = NSDayCalendarUnit;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

+ (NSString *)getPathToArchive:(NSString *)path {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [paths objectAtIndex:0];
    return [docsDir stringByAppendingPathComponent:path];
}

+ (NSString *)formatDuration:(NSInteger)duration {
    NSInteger minutes = duration % 3600000 / 60000;
    NSInteger seconds = duration % 60000 / 1000;
    NSInteger milliseconds = duration % 1000;
    return [NSString stringWithFormat:@"%02d:%02d.%02d", minutes, seconds, milliseconds / 10];
}

+ (NSString *)formatDate:(NSDate *)date {
    return [NSDateFormatter localizedStringFromDate:date
                                          dateStyle:NSDateFormatterLongStyle
                                          timeStyle:NSDateFormatterMediumStyle];
}

@end