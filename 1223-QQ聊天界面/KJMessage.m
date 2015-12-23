//
//  KJMessage.m
//  1223-QQ聊天界面
//
//  Created by kouhanjin on 15/12/23.
//  Copyright © 2015年 khj. All rights reserved.
//

#import "KJMessage.h"

@implementation KJMessage
- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)messageWithDic:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}
@end
