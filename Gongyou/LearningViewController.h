//
//  LearningViewController.h
//  Gongyou
//
//  Created by Rex on 2017/8/8.
//  Copyright © 2017年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YTPlayerView.h>

@interface LearningViewController : UIViewController <YTPlayerViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *loading_label;
@property (nonatomic, strong) IBOutlet YTPlayerView *playerView;
@end
