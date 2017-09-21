//
//  StartViewController.m
//  Gongyou
//
//  Created by Rex on 2017/8/2.
//  Copyright © 2017年 Rex. All rights reserved.
//

#import "GongyouViewController.h"
#import "UserInfoManager.h"
#import "TimeTools.h"

@interface GongyouViewController ()
{
  NSString* default_gongyou_time_label_string;
  NSString* default_back_hoben_btn_string;
  NSString* default_back_muryou_btn_string;
  NSString* default_back_start_btn_string;
  NSString* default_back_main_btn_string;
  NSString* default_hoben_btn_title_string;
  NSString* default_start_btn_title_string;
  NSString* default_muryou_btn_title_string;
  NSString* default_ginen_btn_title_string;
  NSString* default_endGongyou_btn_title_string;
}
@end

@implementation GongyouViewController


- (void)viewDidLoad {
    [super viewDidLoad];
  default_gongyou_time_label_string = @"勤行時間";
  
 default_back_hoben_btn_string = @"<< 回方便品";
 default_back_muryou_btn_string = @"<< 回無量壽品";
 default_back_start_btn_string = @"<< 回開始";
 default_back_main_btn_string = @"<< 回首頁";
  
 default_hoben_btn_title_string = @"方便品第二";
 default_start_btn_title_string = @"開始";
 default_muryou_btn_title_string = @"無量壽品第十六";
 default_ginen_btn_title_string = @"祈念文";
  
  default_endGongyou_btn_title_string = @"勤行結束";
  
  _currentTime = 0;
  _totalTime = [UserInfoManager get_total_gongyou_time];
    // Do any additional setup after loading the view.
  [self InitView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillDisappear:(BOOL)animated{
  [self StopTimer];
  [self StopPlayRing];
  
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller

}

- (void)InitView{
  NSString* path = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"txt"];
  NSError* error = nil;
  NSString* file_content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
  [_content_text_view setText:file_content];
  _current_step = start;
  if(_player == nil)
  {
    _player = [[AVPlayer alloc] init];
  }
  [_ringBtn addTarget:self action:@selector(Playring) forControlEvents:UIControlEventTouchDown];
  [_GoToNextBtn addTarget:self action:@selector(GoToNextScene) forControlEvents:UIControlEventTouchDown];
  
  [_giga_switch setHidden:YES];
  [_giga_switch_label setHidden:YES];
  [_giga_switch addTarget:self action:@selector(GigaState:) forControlEvents:UIControlEventValueChanged];
  
  [_font_size_stepper addTarget:self action:@selector(ChangeFontSize) forControlEvents:UIControlEventValueChanged];

  _totalTime = [UserInfoManager get_total_gongyou_time];
  _gongyou_time_label.text = default_gongyou_time_label_string;
  [_timerlabel setText:[TimeTools GetTimeString:_currentTime]];
  NSUbiquitousKeyValueStore* store = [NSUbiquitousKeyValueStore defaultStore];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(updateKVStoreItems:)
                                               name:NSUbiquitousKeyValueStoreDidChangeExternallyNotification
                                             object:store];
  
  _l_backButton = [[UIBarButtonItem alloc] initWithTitle:default_back_main_btn_string style:UIBarButtonItemStylePlain target:self action:@selector(backToRootView:)];
  self.navigationItem.leftBarButtonItem = _l_backButton;
  
  [store synchronize];
}

- (void) Playring {
  NSLog(@"Play ring");
  NSString *path = [[NSBundle mainBundle] pathForResource:@"ring" ofType:@"mp3"];
  NSURL *url = [[NSURL alloc] initFileURLWithPath: path];
  AVAsset *asset = [AVURLAsset URLAssetWithURL:url options:nil];
  AVPlayerItem *anItem = [AVPlayerItem playerItemWithAsset:asset];
  
  _player = [AVPlayer playerWithPlayerItem:anItem];
  [_player play];
}

- (void)StopPlayRing{
  if(_player){
    [_player setMuted:YES];
    _player = nil;
  }
}


- (void)GoBackScene{
  switch (_current_step) {
    case start:
    {
      [self.navigationController popToRootViewControllerAnimated:YES];
    }
      break;
    case hobanpo:
    {
      _current_step = start;
      NSString* path = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"txt"];
      NSError* error = nil;
      NSString* file_content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
      [_content_text_view setText:file_content];
      [_GoToNextBtn setTitle:default_start_btn_title_string forState:UIControlStateNormal];
      [self StopTimer];
      _totalTime+= _currentTime;
      _currentTime = 0;
      [_timerlabel setText:[TimeTools GetTimeString:_currentTime]];
      [_l_backButton setTitle:default_back_main_btn_string];
    }
      break;
    case muryou:
    {
      _current_step = hobanpo;
      NSString* path = [[NSBundle mainBundle] pathForResource:@"2" ofType:@"txt"];
      NSError* error = nil;
      NSString* file_content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
      [_content_text_view setText:file_content];
      [_GoToNextBtn setTitle:default_muryou_btn_title_string forState:UIControlStateNormal];
      //[_gongyou_time_label setText:@"勤行時間："];
      [_l_backButton setTitle:default_back_start_btn_string];
    }
      break;
    case finish:
    {
      _current_step = muryou;
      NSString* path1 = [[NSBundle mainBundle] pathForResource:@"3-1" ofType:@"txt"];
      NSError* error = nil;
      NSMutableString* file_content = [[NSMutableString alloc] initWithString:[NSString stringWithContentsOfFile:path1 encoding:NSUTF8StringEncoding error:&error]];
      NSString* path2 = [[NSBundle mainBundle] pathForResource:@"3-2" ofType:@"txt"];
      [file_content appendString:[NSString stringWithContentsOfFile:path2 encoding:NSUTF8StringEncoding error:&error]];
      [_content_text_view setText:file_content];
      [_GoToNextBtn setTitle:default_ginen_btn_title_string forState:UIControlStateNormal];
      [_l_backButton setTitle:default_back_hoben_btn_string];
    }
      break;
      
    default:
      break;
  }
  
  [_content_text_view scrollRangeToVisible:NSMakeRange(0, 0)];
  
  if(_current_step == muryou){
    if([_giga_switch_label isHidden]){
      [_giga_switch_label setHidden:NO];
    }
    if([_giga_switch isHidden]){
      [_giga_switch setHidden:NO];
    }
  }else{
    if(![_giga_switch_label isHidden]){
      [_giga_switch_label setHidden:YES];
    }
    if(![_giga_switch isHidden]){
      [_giga_switch setHidden:YES];
    }
  }

}
- (void)GoToNextScene{
  
  switch (_current_step) {
    case start:
    {
      _current_step = hobanpo;
      NSString* path = [[NSBundle mainBundle] pathForResource:@"2" ofType:@"txt"];
      NSError* error = nil;
      NSString* file_content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
      [_content_text_view setText:file_content];
      self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
      [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
      [_GoToNextBtn setTitle:default_muryou_btn_title_string forState:UIControlStateNormal];
      // [_gongyou_time_label setText:@"勤行時間："];
      [_l_backButton setTitle:default_back_start_btn_string];
    }
      break;
    case hobanpo:
    {
      _current_step = muryou;
      NSString* path1 = [[NSBundle mainBundle] pathForResource:@"3-1" ofType:@"txt"];
      NSError* error = nil;
      NSMutableString* file_content = [[NSMutableString alloc] initWithString:[NSString stringWithContentsOfFile:path1 encoding:NSUTF8StringEncoding error:&error]];
      NSString* path2 = [[NSBundle mainBundle] pathForResource:@"3-2" ofType:@"txt"];
      [file_content appendString:[NSString stringWithContentsOfFile:path2 encoding:NSUTF8StringEncoding error:&error]];
      [_content_text_view setText:file_content];
      [_GoToNextBtn setTitle:default_ginen_btn_title_string forState:UIControlStateNormal];
      [_l_backButton setTitle:default_back_hoben_btn_string];
    }
      break;
    case muryou:
    {
      _current_step = finish;
      NSString* path = [[NSBundle mainBundle] pathForResource:@"4" ofType:@"txt"];
      NSError* error = nil;
      NSString* file_content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
      [_content_text_view setText:file_content];
      [_GoToNextBtn setTitle:default_endGongyou_btn_title_string forState:UIControlStateNormal];
      [_l_backButton setTitle:default_back_muryou_btn_string];
    }
      break;
    case finish:
    {
      _current_step = start;
      NSString* path = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"txt"];
      NSError* error = nil;
      NSString* file_content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
      [_content_text_view setText:file_content];
      [_GoToNextBtn setTitle:default_start_btn_title_string forState:UIControlStateNormal];
      [self StopTimer];
      [UserInfoManager save_gongyou_time:self.currentTime];
      _currentTime = 0;
      _totalTime = [UserInfoManager get_total_gongyou_time];
      [_timerlabel setText:[TimeTools GetTimeString:0]];
       //[_gongyou_time_label setText:@"總勤行時間："];
      [_l_backButton setTitle:default_back_main_btn_string];
    }
      break;
      
    default:
      break;
  }
  
  [_content_text_view scrollRangeToVisible:NSMakeRange(0, 0)];
  
  if(_current_step == muryou){
    if([_giga_switch_label isHidden]){
      [_giga_switch_label setHidden:NO];
    }
    if([_giga_switch isHidden]){
      [_giga_switch setHidden:NO];
    }
  }else{
    if(![_giga_switch_label isHidden]){
      [_giga_switch_label setHidden:YES];
    }
    if(![_giga_switch isHidden]){
      [_giga_switch setHidden:YES];
    }
  }
 
}


-(void)updateTime:(NSTimer *)timer
{
  self.currentTime++;
  _timerlabel.text = [TimeTools GetTimeString:self.currentTime];
  
}



- (void)StopTimer{
  if(_timer != nil)
  {
    [_timer invalidate];
    _timer = nil;
  }
}

- (void)GigaState:(id)sender
{
  
  BOOL state = [sender isOn];
  if(state){
    NSString* path = [[NSBundle mainBundle] pathForResource:@"3-2" ofType:@"txt"];
    NSError* error = nil;
    NSString* file_content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    [_content_text_view setText:file_content];
  }else{
    NSString* path1 = [[NSBundle mainBundle] pathForResource:@"3-1" ofType:@"txt"];
    NSError* error = nil;
    NSMutableString* file_content = [[NSMutableString alloc] initWithString:[NSString stringWithContentsOfFile:path1 encoding:NSUTF8StringEncoding error:&error]];
    NSString* path2 = [[NSBundle mainBundle] pathForResource:@"3-2" ofType:@"txt"];
    [file_content appendString:[NSString stringWithContentsOfFile:path2 encoding:NSUTF8StringEncoding error:&error]];
    [_content_text_view setText:file_content];
  }
 
   [_content_text_view scrollRangeToVisible:NSMakeRange(0, 0)];
  NSString *rez = state == YES ? @"YES" : @"NO";
  NSLog(@"%@",rez);
}

- (void)ChangeFontSize{
  UIFont* currentFont = _content_text_view.font;
  NSString* fontName = currentFont.fontName;
  [_content_text_view setFont:[UIFont fontWithName:fontName size:_font_size_stepper.value]];
  [_content_text_view setNeedsDisplay];
}

- (void)updateKVStoreItems:(NSNotification*)notification {
  // Get the list of keys that changed.
  NSDictionary* userInfo = [notification userInfo];
  NSNumber* reasonForChange = [userInfo objectForKey:NSUbiquitousKeyValueStoreChangeReasonKey];
  NSInteger reason = -1;
  
  // If a reason could not be determined, do not update anything.
  if (!reasonForChange)
    return;
  
  // Update only for changes from the server.
  reason = [reasonForChange integerValue];
  if ((reason == NSUbiquitousKeyValueStoreServerChange) ||
      (reason == NSUbiquitousKeyValueStoreInitialSyncChange)) {
    // If something is changing externally, get the changes
    // and update the corresponding keys locally.
    NSArray* changedKeys = [userInfo objectForKey:NSUbiquitousKeyValueStoreChangedKeysKey];
    NSUbiquitousKeyValueStore* store = [NSUbiquitousKeyValueStore defaultStore];
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    
    // This loop assumes you are using the same key names in both
    // the user defaults database and the iCloud key-value store
    for (NSString* key in changedKeys) {
      id value = [store objectForKey:key];
      [userDefaults setObject:value forKey:key];
    }
  }
}


- (void) backToRootView:(id)sender {
  [self GoBackScene];
}


@end
