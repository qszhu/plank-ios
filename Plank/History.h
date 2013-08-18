//
// Created by Qinsi ZHU on 8/18/13.
// Copyright (c) 2013 Qinsi ZHU. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface History : NSObject <NSCoding>
@property(strong, nonatomic) NSDate *date;
@property(nonatomic) NSInteger duration;

- (id)initWithDuration:(NSInteger)duration;
@end