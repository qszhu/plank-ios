//
// Created by Qinsi ZHU on 8/15/13.
// Copyright (c) 2013 Qinsi ZHU. All rights reserved.
//


#import "HistoryViewController.h"
#import "HistoryList.h"
#import "History.h"
#import "Utils.h"
#import "TestFlight.h"

@interface HistoryViewController ()
@property(strong, nonatomic) HistoryList *historyList;
@end

@implementation HistoryViewController {

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [TestFlight passCheckpoint:@"history view did appear"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self setTitle:@"History"];
    self.historyList = [HistoryList loadHistoryList];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.historyList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }

    History *history = [self.historyList historyAtIndex:(NSUInteger) indexPath.row];
    cell.textLabel.text = [Utils formatDuration:history.duration];
    cell.detailTextLabel.text = [Utils formatDate:history.date];
    return cell;
}

@end