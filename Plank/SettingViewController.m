//
// Created by Qinsi ZHU on 8/19/13.
// Copyright (c) 2013 Qinsi ZHU. All rights reserved.
//


#import "SettingViewController.h"
#import "FKFormModel.h"
#import "Setting.h"
#import "FKFormMapping.h"
#import "TestFlight.h"
#import "Setting.h"

@implementation SettingViewController {

}

- (id)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([Setting sendUsage]) {
        [TestFlight passCheckpoint:@"setting view did appear"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationItem setTitle:@"Settings"];

    self.formModel = [FKFormModel formTableModelForTableView:self.tableView
                                        navigationController:self.navigationController];
    self.setting = [Setting loadSetting];

    [FKFormMapping mappingForClass:[Setting class] block:^(FKFormMapping *formMapping) {
        [formMapping sectionWithTitle:@"Notification" identifier:@"notification"];
        [formMapping mapAttribute:@"isNotificationOn" title:@"Notification" type:FKFormAttributeMappingTypeBoolean];
        [formMapping mapAttribute:@"notificationTime" title:@"Time" type:FKFormAttributeMappingTypeTime dateFormat:@"hh:mm a"];

        [formMapping sectionWithTitle:@"Usage" identifier:@"usage"];
        [formMapping mapAttribute:@"sendUsage" title:@"Send usage info" type:FKFormAttributeMappingTypeBoolean];

        [self.formModel registerMapping:formMapping];
    }];

    [self.formModel setDidChangeValueWithBlock:^(id object, id value, NSString *keyPath) {
        [Setting saveSetting:self.setting];
    }];

    [self.formModel loadFieldsWithObject:self.setting];
}

@end