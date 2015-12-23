//
//  ViewController.m
//  1223-QQ聊天界面
//
//  Created by kouhanjin on 15/12/23.
//  Copyright © 2015年 khj. All rights reserved.
//

#import "ViewController.h"
#import "KJMessageFrame.h"
#import "KJMessageCell.h"
#import "KJMessage.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTablewView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UITextField *msgTextField;

@property (nonatomic, strong) NSMutableArray *messageFrames;

@end

@implementation ViewController

/**
 *  数据的懒加载
 */
- (NSMutableArray *)messageFrames
{
    if (_messageFrames == nil) {
        // 获取frame数据
        _messageFrames = [KJMessageFrame messageFrameList];
    }
    return _messageFrames;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 去掉分割线
    self.myTablewView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 不能选中cell
    self.myTablewView.allowsSelection = NO;
    self.myTablewView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    
    // 监听键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // 文本框左边间距
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 0)];
    self.msgTextField.leftView = view;
    self.msgTextField.leftViewMode = UITextFieldViewModeAlways;
    
    /** 给tableview添加手势,UITableView是不会响应touchesBegan:withEvent:之类的UIResponder的方法的。因此，加在其上的所有视图的响应者链就断了。如果在UITableView其上加任何的自身不具备类似UIButton一样有目标动作机制的UIView及其子类控件的时候，这个控件也不会响应touchesBegan:withEvent:方法。即便是设置该控件的userInteractionEnabled为YES也没用。
    
        如此一来，如果想要这些控件具有交互性能怎么办？有一种很直观的方法，给这个控件加上手势识别器
     */
    // 给tableview添加点击手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesturedDetected:)];
    
    [self.myTablewView addGestureRecognizer:tapGesture];
}

- (void)tapGesturedDetected:(UITapGestureRecognizer *)recognizer

{
    // 取消所有的响应者
    [self.view endEditing:YES];
}
#pragma mark - 监听键盘的改变
- (void)keyboardWillChangeFrame:(NSNotification *)noti
{
//    NSLog(@"noti:%@",noti);
    // 设置窗口颜色
    self.view.window.backgroundColor = self.myTablewView.backgroundColor;

    // 获取键盘弹出的时间
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 弹出键盘时候的y值
    CGFloat keyboardY = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    CGFloat offsetY = keyboardY - self.view.frame.size.height;
    
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, offsetY);
    }];
}

#pragma mark - 数据源的代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messageFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建cell
    KJMessageCell *cell = [KJMessageCell cellWithTableView:tableView];
    
    // 取出模型frame 设置
    cell.massageFrame = self.messageFrames[indexPath.row];
    return cell;
}

#pragma mark - tableview的代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KJMessageFrame *messageF = self.messageFrames[indexPath.row];
    return messageF.cellHight;
}
#pragma mark - 隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark -UIScrollView的代理
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{

    [self.view endEditing:YES];
}

#pragma mark - 发送消息
- (void)sendMsg:(NSString *)msg type:(KJMessageType)type
{
    KJMessageFrame *msgFrame = [[KJMessageFrame alloc] init];
    KJMessage *message = [[KJMessage alloc] init];
    message.text = msg;
    
    NSDate *date = [NSDate date];
    // 时间格式化
    NSDateFormatter *ndf = [[NSDateFormatter alloc] init];
    // @"yyyy-MM-dd HH:mm:ss"
    ndf.dateFormat = @"HH:mm";
    
    message.time = [ndf stringFromDate:date];
    message.type = type;
    
    // 取出上一条消息
    KJMessageFrame *lastMsgFrame = self.messageFrames.lastObject;
    KJMessage *lastMsg = lastMsgFrame.message;
    if ([message.time isEqualToString:lastMsg.time]) {
        message.hiddenTime = YES;
    }
    
    msgFrame.message = message;
    
    
    // 添加到数组中
    [self.messageFrames addObject:msgFrame];
    // 刷新表格
    [self.myTablewView reloadData];
    
    // 滚动到底部
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.messageFrames.count - 1 inSection:0];
    [self.myTablewView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
#pragma mark - UITextFieldDelegate的代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"textfilef:%@",textField.text);
    // 发送消息
    NSString *msg = textField.text;
    
    [self sendMsg:msg type:KJMessageTypeMe];
    
    // 回复消息
    [self sendMsg:[NSString stringWithFormat:@"%@你个蛋啊！",msg] type:KJMessageTypeOther];
    
    textField.text = nil;
    return NO;
}

- (void)dealloc
{
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
