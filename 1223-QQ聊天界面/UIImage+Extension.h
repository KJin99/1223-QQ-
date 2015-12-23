//
//  UIImage+Extension.h
//  1223-QQ聊天界面
//
//  Created by kouhanjin on 15/12/23.
//  Copyright © 2015年 khj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
/**
 *  图片的拉伸
 *
 *  @param imageName 图片名字
 *
 */
+ (UIImage *)resizedImageNamed:(NSString *)imageName;
@end
