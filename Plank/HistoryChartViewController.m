//
//  HistoryChartViewController.m
//  Plank
//
//  Created by Qinsi ZHU on 9/20/13.
//  Copyright (c) 2013 Qinsi ZHU. All rights reserved.
//

#import "HistoryChartViewController.h"
#import "History.h"
#import "HistoryList.h"
#import "Utils.h"
#import "LineChartView.h"

@interface HistoryChartViewController ()

@end

@implementation HistoryChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:[self createHistoryChart]];
    [self setTitle:@"History Chart"];
}

- (LineChartView *)createHistoryChart {
    HistoryList *historyList = [HistoryList loadHistoryList];

    LineChartData *d = [LineChartData new];
    d.xMin = 1;
    d.xMax = 31;
    d.title = @"Plank duration in 1 month";
    d.color = [UIColor blueColor];
    d.itemCount = 31;

    NSDate *today = [NSDate date];
    d.getData = ^(NSUInteger item) {
        float x = item;
        NSDate *date = [Utils dateByOffset:x-30 fromDate:today];
        History *history = [historyList historyAtDate:date];
        float y = history == nil ? 0 : history.duration;
        NSString *labelX = [Utils formatDate:history.date];
        NSString *labelY = [Utils formatDuration:history.duration];
        return [LineChartDataItem dataItemWithX:x y:y xLabel:labelX dataLabel:labelY];
    };

    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width,
                             self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height
                             - self.navigationController.navigationBar.frame.size.height);
    LineChartView *chartView = [[LineChartView alloc] initWithFrame:rect];
    chartView.yMin = 0;
    chartView.yMax = [historyList getBest].duration * 1.5;
    chartView.data = @[d];

    return chartView;
}

@end
