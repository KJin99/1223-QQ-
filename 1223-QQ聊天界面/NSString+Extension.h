//
//  NSString+Extension.h
//  1223-QQ聊天界面
//
//  Created by kouhanjin on 15/12/23.
//  Copyright © 2015年 khj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)
/**
 *  计算字符串的CGRect
 *
 */
- (CGRect)textRectWithSize:(CGSize)size attributes:(NSDictionary *)attributes;
@end
