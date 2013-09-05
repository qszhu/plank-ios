//
// Created by Qinsi ZHU on 8/15/13.
// Copyright (c) 2013 Qinsi ZHU. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface TimerViewController : UIViewController
@property(strong, nonatomic) IBOutlet UILabel *timerLabel;
@property(strong, nonatomic) IBOutlet UIButton *timerButton;
@property(strong, nonatomic) IBOutlet UIView *bestView;
@property(strong, nonatomic) IBOutlet UILabel *bestScoreLabel;

- (IBAction)timerButtonPressed:(id)sender;
@end