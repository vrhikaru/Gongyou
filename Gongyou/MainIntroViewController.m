//
//  MainIntroViewController.m
//  Gongyou
//
//  Created by Rex on 2017/9/21.
//  Copyright © 2017年 Rex. All rights reserved.
//

#import "MainIntroViewController.h"
#import "TimeTools.h"
#import "UserInfoManager.h"

@interface MainIntroViewController ()

@end

@implementation MainIntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  _gongyou_total_time.text = [TimeTools GetTimeString:[UserInfoManager get_total_gongyou_time]];
  _gongyo_last_time_count.text = [TimeTools GetTimeString:[UserInfoManager get_last_gongyou_time_count]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
