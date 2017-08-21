//
//  LearningViewController.m
//  Gongyou
//
//  Created by Rex on 2017/8/8.
//  Copyright © 2017年 Rex. All rights reserved.
//

#import "LearningViewController.h"

@interface LearningViewController ()

@end

@implementation LearningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //https://youtu.be/SV7ehVgHb3w
  [self.playerView loadWithVideoId:@"SV7ehVgHb3w"];
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
