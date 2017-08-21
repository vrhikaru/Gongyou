//
//  StartViewController.h
//  Gongyou
//
//  Created by Rex on 2017/8/2.
//  Copyright © 2017年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

enum {
  start = 0,
  hobanpo,
  muryou,
  finish
};

@interface GongyouViewController : UIViewController <AVAudioPlayerDelegate>
@property (atomic, assign) NSUInteger current_step;
@property (weak, nonatomic) IBOutlet UIButton *ringBtn;
@property (weak, nonatomic) IBOutlet UIButton *GoToNextBtn;

@property (weak, nonatomic) IBOutlet UITextView *content_text_view;
@property (assign, nonatomic) NSTimeInterval currentTime;
@property (assign, atomic) NSTimeInterval totalTime;
@property (weak, nonatomic) IBOutlet UILabel *timerlabel;
@property (weak, nonatomic) IBOutlet UIStepper *font_size_stepper;
@property (weak, nonatomic) IBOutlet UILabel *gongyou_time_label;
@property (strong, nonatomic) AVPlayer* player;
@property (strong, nonatomic) NSTimer* timer;
@property (weak, nonatomic) IBOutlet UISwitch *giga_switch;
@property (weak, nonatomic) IBOutlet UILabel *giga_switch_label;

@property (strong, nonatomic) UIBarButtonItem *l_backButton;
@end
