//
//  TimePickerViewController.h
//  Plank
//
//  Created by Qinsi ZHU on 9/7/13.
//  Copyright (c) 2013 Qinsi ZHU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimePickerViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIDatePicker *timePicker;
@property (nonatomic) UIViewController *settingViewController;

- (IBAction)cancelPressed:(id)sender;
- (IBAction)donePressed:(id)sender;
@end
