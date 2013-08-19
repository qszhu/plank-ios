//
// Created by Qinsi ZHU on 8/18/13.
// Copyright (c) 2013 Qinsi ZHU. All rights reserved.
//


#import "History.h"

static NSString *const kDate = @"date";
static NSString *const kDuration = @"duration";

@implementation History {

}

- (id)init {
    self = [self initWithDuration:0];
    return self;
}

- (id)initWithDuration:(NSInteger)duration {
    self = [super init];
    if (self) {
        self.date = [NSDate date];
        self.duration = duration;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [self init];
    if (self) {
        self.date = [coder decodeObjectForKey:kDate];
        self.duration = [coder decodeIntegerForKey:kDuration];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.date forKey:kDate];
    [coder encodeInteger:self.duration forKey:kDuration];
}

@end