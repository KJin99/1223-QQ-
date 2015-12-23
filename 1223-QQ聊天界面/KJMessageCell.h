//
//  KJMessageCell.h
//  1223-QQ聊天界面
//
//  Created by kouhanjin on 15/12/23.
//  Copyright © 2015年 khj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KJMessageFrame;

@interface KJMessageCell : UITableViewCell
@property (nonatomic, strong) KJMessageFrame *massageFrame;
// 创建cell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
