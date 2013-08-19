//
// Created by Qinsi ZHU on 8/19/13.
// Copyright (c) 2013 Qinsi ZHU. All rights reserved.
//


#import <Foundation/Foundation.h>

@class Setting;
@class FKFormModel;


@interface SettingViewController : UITableViewController
@property(strong, nonatomic) FKFormModel *formModel;
@property(strong, nonatomic) Setting *setting;
@end