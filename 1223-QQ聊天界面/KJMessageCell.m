//
//  KJMessageCell.m
//  1223-QQ聊天界面
//
//  Created by kouhanjin on 15/12/23.
//  Copyright © 2015年 khj. All rights reserved.
//

#import "KJMessageCell.h"
#import "KJMessageFrame.h"
#import "KJMessage.h"
#import "UIImage+Extension.h"

@interface KJMessageCell ()
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UIButton *textView;
@end

@implementation KJMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
#pragma mark - 子控件的懒加载
- (UILabel *)timeLabel
{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_timeLabel];
        
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.font = [UIFont systemFontOfSize:13];
    }
    
    return _timeLabel;
}

- (UIImageView *)iconView
{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
        // 设置成圆形图片
        _iconView.layer.cornerRadius = 20;
        _iconView.layer.masksToBounds = YES;
        [self.contentView addSubview:_iconView];
    }
    
    return _iconView;
}

- (UIButton *)textView
{
    if (_textView == nil) {
        _textView = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_textView];
        _textView.titleLabel.font = [UIFont systemFontOfSize:15];
        _textView.titleLabel.numberOfLines = 0;
//        _textView.backgroundColor = [UIColor redColor];
        // 设置按钮中内容的边距
        _textView.contentEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
    }
    
    return _textView;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"messageCell";
    
    KJMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[KJMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

- (void)setMassageFrame:(KJMessageFrame *)massageFrame
{
    _massageFrame = massageFrame;
    // 设置数据
    KJMessage *msg = massageFrame.message;
    if (!msg.hiddenTime) {
        self.timeLabel.text = msg.time;
    }
    self.timeLabel.frame = massageFrame.timeF;
    
    [self.textView setTitle:msg.text forState:UIControlStateNormal];
    self.textView.frame = massageFrame.textF;
    
    NSString *imageName = msg.type == KJMessageTypeMe ? @"me" : @"other";
    self.iconView.image = [UIImage imageNamed:imageName];
    self.iconView.frame = massageFrame.iconF;
    
    // 设置消息的背景图片
    NSString *normal, *high;
    if (msg.type == KJMessageTypeMe) {
        [self.textView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        normal = @"chat_send_nor";
        high = @"chat_send_press_pic";
        
    }else
    {
        [self.textView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        normal = @"chat_recive_nor";
        high = @"chat_recive_press_pic";
        
    }
    
    [self.textView setBackgroundImage:[UIImage resizedImageNamed:normal] forState:UIControlStateNormal];
    [self.textView setBackgroundImage:[UIImage resizedImageNamed:high] forState:UIControlStateHighlighted];
}

@end
