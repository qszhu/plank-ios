//
//  TutorialViewController.m
//  Plank
//
//  Created by Qinsi ZHU on 8/28/13.
//  Copyright (c) 2013 Qinsi ZHU. All rights reserved.
//

#import "TutorialViewController.h"

@interface TutorialViewController ()

@end

@implementation TutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *imageArray = [[NSArray alloc] initWithObjects:@"Icon-Small", @"Icon", @"Icon-72", nil];

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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}

@end
