//
//  KJMessage.h
//  1223-QQ聊天界面
//
//  Created by kouhanjin on 15/12/23.
//  Copyright © 2015年 khj. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    KJMessageTypeMe,
    KJMessageTypeOther
} KJMessageType;

@interface KJMessage : NSObject
/**
 *  内容
 */
@property (nonatomic, copy) NSString *text;
/**
 *  聊天时间
 */
@property (nonatomic, copy) NSString *time;
/**
 *  是否隐藏时间
 */
@property (nonatomic, assign, getter=isHiddenTime) BOOL hiddenTime;
/**
 *  谁发的
 */
@property (nonatomic, assign) KJMessageType type;

- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)messageWithDic:(NSDictionary *)dic;

@end
