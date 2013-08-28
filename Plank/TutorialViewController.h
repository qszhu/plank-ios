//
//  TutorialViewController.h
//  Plank
//
//  Created by Qinsi ZHU on 8/28/13.
//  Copyright (c) 2013 Qinsi ZHU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorialViewController : UIViewController <UIScrollViewDelegate>
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;
@end
