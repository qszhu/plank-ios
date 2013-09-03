//
//  TutorialViewController.m
//  Plank
//
//  Created by Qinsi ZHU on 8/28/13.
//  Copyright (c) 2013 Qinsi ZHU. All rights reserved.
//

#import "TutorialViewController.h"
#import "Setting.h"
#import "TestFlight.h"

@interface TutorialViewController ()

@end

@implementation TutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *imageArray = [[NSArray alloc] initWithObjects:@"plank0", @"plank1", @"plank2", nil];

    for (int i = 0; i < imageArray.count; i++) {
        CGRect frame;
        frame.origin.x = self.scrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.scrollView.frame.size;

        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.image = [UIImage imageNamed:[imageArray objectAtIndex:i]];
        imageView.contentMode = UIViewContentModeScaleToFill;
        [self.scrollView addSubview:imageView];
    }

    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * imageArray.count, self.scrollView.frame.size.height);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([Setting sendUsage]) {
        [TestFlight passCheckpoint:@"tutorial view did appear"];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
    [self.dismissButton setHidden:page != 2];
}

- (IBAction)dismissTutorial:(id)sender {
    if ([Setting sendUsage]) {
        [TestFlight passCheckpoint:@"dismiss tutorial"];
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
