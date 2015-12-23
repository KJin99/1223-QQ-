//
//  KJMessageFrame.m
//  1223-QQ聊天界面
//
//  Created by kouhanjin on 15/12/23.
//  Copyright © 2015年 khj. All rights reserved.
//

#import "KJMessageFrame.h"
#import "KJMessage.h"
#import "NSString+Extension.h"

#define kTextFont [UIFont systemFontOfSize:15]
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

@implementation KJMessageFrame

/**
 *  重写message的set方法，计算frame
 *
*/
- (void)setMessage:(KJMessage *)message
{
    _message = message;
    
    CGFloat margin = 10;
    
    if (message.hiddenTime == NO) {
        CGFloat timeX = 0;
        CGFloat timeY = 0;
        CGFloat timeW = SCREEN_WIDTH;
        CGFloat timeH = 35;
        
        _timeF = CGRectMake(timeX, timeY, timeW, timeH);
    }
    
    // 头像
    CGFloat iconW = 40;
    CGFloat iconH = iconW;
    CGFloat iconX;
    CGFloat iconY = CGRectGetMaxY(_timeF) + margin;
    
    iconX = (message.type == KJMessageTypeMe)? (SCREEN_WIDTH - iconW - margin) : (margin);
    
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 内容
    CGFloat textW = 150;
    CGFloat textY = iconY;
    CGFloat textX;
    NSDictionary *textDic = @{NSFontAttributeName:kTextFont};

    CGSize textSize = [message.text textRectWithSize:CGSizeMake(textW, MAXFLOAT) attributes:textDic].size;
    textSize = CGSizeMake(textSize.width + 40, textSize.height + 40);
    
    if (message.type == KJMessageTypeMe) {
        textX = iconX - margin - textSize.width;
    }else
    {
        textX = CGRectGetMaxX(_iconF) + margin;
    }
    
    _textF = (CGRect){{textX,textY},textSize};
    
    // 计算行高
    CGFloat iconMaxY = CGRectGetMaxY(_iconF);
    CGFloat textMaxY = CGRectGetMaxY(_textF);
    
    // 比较谁大
    _cellHight = MAX(iconMaxY, textMaxY) + margin;;
}

+ (NSMutableArray *)messageFrameList
{
    // 1, 从plist中加载数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil];
    
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    // 定义一个可变数组，用于添加模型的frame数据
    NSMutableArray *arrayM = [NSMutableArray array];
    KJMessage *lastMsg;
    
    for (NSDictionary *dic in array) {
        // 2, 把字典转为模型
        KJMessage *message = [KJMessage messageWithDic:dic];
        // 取得上一个msg的时间
        if ([message.time isEqualToString:lastMsg.time]) {
            message.hiddenTime = YES;
        }
        // 3, 计算模型的frame
        KJMessageFrame *messageFrame = [[KJMessageFrame alloc] init];
        messageFrame.message = message;
        
        [arrayM addObject:messageFrame];
        
        lastMsg = message;
    }
    
    return arrayM;
}
@end
