//
// Created by Qinsi ZHU on 8/18/13.
// Copyright (c) 2013 Qinsi ZHU. All rights reserved.
//


#import "HistoryList.h"
#import "Utils.h"
#import "History.h"

static NSString *const kHistory = @"history";
static NSString *const kModelPath = @"history.model";

@interface HistoryList ()
@property(strong, nonatomic) NSArray *history;
@end

@implementation HistoryList {

}
- (id)init {
    self = [super init];
    if (self) {
        self.history = [[NSArray alloc] init];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [self init];
    if (self) {
        self.history = [coder decodeObjectForKey:kHistory];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.history forKey:kHistory];
}

- (NSUInteger)count {
    return self.history.count;
}

- (History *)historyAtIndex:(NSUInteger)index {
    return [self.history objectAtIndex:index];
}

- (void)removeHistoryAtIndex:(NSUInteger)index {
    NSMutableArray *temp = [NSMutableArray arrayWithArray:self.history];
    [temp removeObjectAtIndex:index];
    self.history = [NSArray arrayWithArray:temp];
}

- (History *)getBest {
    __block History *res = nil;
    __block NSInteger maxDuration = 0;
    [self.history enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        History *history = obj;
        if (history.duration > maxDuration) {
            maxDuration = history.duration;
            res = history;
        }
    }];
    return res;
}

- (void)addHistory:(History *)history {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:history];
    [array addObjectsFromArray:self.history];
    self.history = [NSArray arrayWithArray:array];
}

+ (void)saveHistoryList:(HistoryList *)historyList {
    [NSKeyedArchiver archiveRootObject:historyList toFile:[Utils getPathToArchive:kModelPath]];
}

+ (HistoryList *)loadHistoryList {
    HistoryList *historyList = [NSKeyedUnarchiver unarchiveObjectWithFile:[Utils getPathToArchive:kModelPath]];
    if (historyList == nil) {
        historyList = [[HistoryList alloc] init];
    }
    return historyList;
}

@end