//
// Created by Qinsi ZHU on 8/18/13.
// Copyright (c) 2013 Qinsi ZHU. All rights reserved.
//


#import <Foundation/Foundation.h>

@class History;


@interface HistoryList : NSObject <NSCoding>
- (NSUInteger)count;

- (History *)historyAtIndex:(NSUInteger)index;

- (void)addHistory:(History *)history;

+ (void)saveHistoryList:(HistoryList *)historyList;

+ (HistoryList *)loadHistoryList;

@end