//
//  UserInfoManager.m
//  Gongyou
//
//  Created by Rex on 2017/9/19.
//  Copyright © 2017年 Rex. All rights reserved.
//

#import "UserInfoManager.h"

@implementation UserInfoManager

+(void)save_gongyou_time:(NSTimeInterval)currentTime
{
  NSUserDefaults *user_defaults = [NSUserDefaults standardUserDefaults];
  
  NSNumber* last_time = [NSNumber numberWithDouble:currentTime];
  NSNumber* total_time = [user_defaults valueForKey:@"gongyou_time_total"];
  
  total_time = [NSNumber numberWithInt:([total_time intValue] + [last_time intValue])];
  [user_defaults setValue:total_time forKey:@"gongyou_time_total"];
  [user_defaults setValue:last_time forKey:@"gongyou_last_count_time"];
  BOOL sync_data_state = [user_defaults synchronize];
  if(!sync_data_state){
    NSLog(@"user gongyou time save failed!!!!");
  }
  
}

+ (NSTimeInterval)get_total_gongyou_time{
  NSUserDefaults *user_defaults = [NSUserDefaults standardUserDefaults];

  NSNumber* total_time = [user_defaults valueForKey:@"gongyou_time_total"];
  NSLog(@"total_time:%f",[total_time doubleValue]);
  return [total_time doubleValue];
}

+ (NSTimeInterval)get_last_gongyou_time_count{
  
  NSUserDefaults *user_defaults = [NSUserDefaults standardUserDefaults];
  
  NSNumber* last_time = [user_defaults valueForKey:@"gongyou_last_count_time"];
  NSLog(@"last_time:%f",[last_time doubleValue]);
  return [last_time doubleValue];
}
@end
