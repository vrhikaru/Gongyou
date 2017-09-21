//
//  TimeTools.m
//  Gongyou
//
//  Created by Rex on 2017/9/21.
//  Copyright © 2017年 Rex. All rights reserved.
//

#import "TimeTools.h"

@implementation TimeTools
+ (NSString*)GetTimeString:(NSTimeInterval) time{
  
  //NSLog(@"time:%f",time);
  NSInteger tempHour = time / 3600;
  NSInteger tempMinute = time / 60 - (tempHour * 60);
  NSInteger tempSecond = time - (tempHour * 3600 + tempMinute * 60);
  
  NSString *hour = [[NSNumber numberWithInteger:tempHour] stringValue];
  NSString *minute = [[NSNumber numberWithInteger:tempMinute] stringValue];
  NSString *second = [[NSNumber numberWithInteger:tempSecond] stringValue];
  if (tempHour < 10) {
    hour = [@"0" stringByAppendingString:hour];
  }
  if (tempMinute < 10) {
    minute = [@"0" stringByAppendingString:minute];
  }
  if (tempSecond < 10) {
    second = [@"0" stringByAppendingString:second];
  }
  return [NSString stringWithFormat:@"%@:%@:%@", hour, minute, second];
}
@end
