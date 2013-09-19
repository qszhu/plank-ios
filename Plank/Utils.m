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

+ (NSString *)formatTime:(NSDate *)date {
    return [NSDateFormatter localizedStringFromDate:date
                                          dateStyle:NSDateFormatterNoStyle
                                          timeStyle:NSDateFormatterShortStyle];
}

+ (NSInteger)daysBetween:(NSDate *)startDate and:(NSDate *)endDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger startDay = [calendar ordinalityOfUnit:NSDayCalendarUnit
                                             inUnit:NSEraCalendarUnit forDate:startDate];
    NSInteger endDay = [calendar ordinalityOfUnit:NSDayCalendarUnit
                                           inUnit:NSEraCalendarUnit forDate:endDate];
    return endDay - startDay;
}

+ (BOOL)sameDay:(NSDate *)date1 fromDate:(NSDate *)date2 {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *comps1 = [cal components:(NSMonthCalendarUnit| NSYearCalendarUnit | NSDayCalendarUnit)
                                      fromDate:date1];
    NSDateComponents *comps2 = [cal components:(NSMonthCalendarUnit| NSYearCalendarUnit | NSDayCalendarUnit)
                                      fromDate:date2];

    return ([comps1 day] == [comps2 day]
            && [comps1 month] == [comps2 month]
            && [comps1 year] == [comps2 year]);
}

+ (NSDate *)dateByOffset:(NSInteger)offset fromDate:(NSDate *)date {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = offset;

    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar dateByAddingComponents:components toDate:date options:0];
}

@end