//
//  KJMessageFrame.h
//  1223-QQ聊天界面
//
//  Created by kouhanjin on 15/12/23.
//  Copyright © 2015年 khj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class KJMessage;

@interface KJMessageFrame : NSObject
// 时间的frame
@property (nonatomic, assign, readonly) CGRect timeF;
// 头像的frame
@property (nonatomic, assign, readonly) CGRect iconF;
// 内容的frame
@property (nonatomic, assign, readonly) CGRect textF;
// cell的行高
@property (nonatomic, assign, readonly) CGFloat cellHight;

@property (nonatomic, strong) KJMessage *message;

+ (NSMutableArray *)messageFrameList;
@end
