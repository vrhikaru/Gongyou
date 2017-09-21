//
//  UserInfoManager.h
//  Gongyou
//
//  Created by Rex on 2017/9/19.
//  Copyright © 2017年 Rex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoManager : NSObject

+(void)save_gongyou_time:(NSTimeInterval)currentTime;
+ (NSTimeInterval)get_total_gongyou_time;
+ (NSTimeInterval)get_last_gongyou_time_count;
@end
