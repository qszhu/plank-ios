//
// Created by Qinsi ZHU on 8/18/13.
// Copyright (c) 2013 Qinsi ZHU. All rights reserved.
//


#import "Utils.h"


@implementation Utils {

}

+ (NSString *)formatDuration:(NSInteger)duration {
    NSInteger minutes = duration % 3600000 / 60000;
    NSInteger seconds = duration % 60000 / 1000;
    NSUInteger milliseconds = duration % 1000;
    return [NSString stringWithFormat:@"%02d:%02d.%02d", minutes, seconds, milliseconds / 10];
}

+ (NSString *)formatDate:(NSDate *)date {
    return [NSDateFormatter localizedStringFromDate:date
                                          dateStyle:NSDateFormatterLongStyle
                                          timeStyle:NSDateFormatterMediumStyle];
}

@end