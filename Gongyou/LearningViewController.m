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
  self.playerView.delegate = self;
    // Do any additional setup after loading the view.
    //https://youtu.be/SV7ehVgHb3w
  [self.playerView loadWithVideoId:@"SV7ehVgHb3w"];
  
  UIBarButtonItem *l_backButton = [[UIBarButtonItem alloc] initWithTitle:@"<< 回首頁" style:UIBarButtonItemStylePlain target:self action:@selector(backToRootView:)];
  self.navigationItem.leftBarButtonItem = l_backButton;
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
- (void) backToRootView:(id)sender {
  [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)playerViewDidBecomeReady:(YTPlayerView *)playerView{
  [_loading_label setHidden:YES];
}

@end
