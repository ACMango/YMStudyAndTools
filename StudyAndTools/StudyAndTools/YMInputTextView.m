//
//  YMInputTextView.m
//  StudyAndTools
//
//  Created by SL设计 on 2019/6/25.
//  Copyright © 2019 SL设计. All rights reserved.
//

#import "YMInputTextView.h"

#define MAINSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define MAINSCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define DEFAULT_HEIGHT (175)

@interface YMInputTextView ()<UITextViewDelegate>
{
    UIControl *_overView; // 好处：可以直接添加点击事件，O(∩_∩)O哈哈哈~
    BOOL      _isKeyboardShow;
    BOOL      _isThirdPartKeyboard;
    NSInteger _keyboardShowTime;
    CGFloat   _keyboardAnimateDur;
    CGRect    _keyboardFrame;
}

// UI
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn; 
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UILabel *placeholderL;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
//


@end

@implementation YMInputTextView

#pragma mark - Life Cycle
- (void)awakeFromNib {
    
    [super awakeFromNib];
    [self initKeyboardObserver];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (instancetype)createInputTextView {
    
    YMInputTextView *inputView = [[NSBundle mainBundle] loadNibNamed:@"YMInputTextView" owner:nil options:nil].lastObject;
    [inputView configView];
    return inputView;
}

- (void)configView {
    
    self.frame = CGRectMake(0, MAINSCREEN_HEIGHT, MAINSCREEN_WIDTH, DEFAULT_HEIGHT);
    self.maxLength = 100;
    self.textView.delegate = self;
    
    _overView = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _overView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [_overView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
}

- (void)show {
    
    if (_isKeyboardShow) { // 防止重复点击
        return;
    }
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:_overView];
    [keyWindow addSubview:self];
    
    [self.textView becomeFirstResponder];
}

- (void)dismiss {
    
    [self.textView resignFirstResponder];
}

#pragma mark - User Actions
// 取消按钮点击事件
- (IBAction)cancelButtonClicked:(UIButton *)sender {
    
    [self dismiss];
}

// 确认按钮点击事件
- (IBAction)confirmButtonClicked:(UIButton *)sender {
    
    NSLog(@"点击了确定按钮");
}

// 检测按钮点击事件(用于快速删除)
- (IBAction)checkButtonClicked:(UIButton *)sender {
    
    self.textView.text = @"";
    self.placeholderL.hidden = NO;
    [self.confirmBtn setTitleColor:[UIColor colorWithWhite:0.5 alpha:1] forState:UIControlStateNormal];
    
    NSString * title = [NSString stringWithFormat:@"0/%lu ❌",(unsigned long)self.maxLength];
    [sender setTitle:title forState:UIControlStateNormal];
}

#pragma mark UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    // textView.text 为实际文字数，比textfield方便多了
    NSString * title = [NSString stringWithFormat:@"%lu/%lu ❌",(unsigned long)self.textView.text.length,(unsigned long)self.maxLength];
    [self.checkBtn setTitle:title forState:UIControlStateNormal];
    self.placeholderL.hidden = self.textView.text.length > 0 ? YES : NO;
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView;
{

    // textView.text 为实际文字数，比textfield方便多了
    NSString * title = [NSString stringWithFormat:@"%lu/%lu ❌",(unsigned long)self.textView.text.length,(unsigned long)self.maxLength];
    [self.checkBtn setTitle:title forState:UIControlStateNormal];
    self.placeholderL.hidden = self.textView.text.length > 0 ? YES : NO;
}

#pragma mark - 键盘事件
- (void)initKeyboardObserver {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}

- (void)keyboardWillShow:(NSNotification*)notification {
    
    NSValue *keyboardBoundsValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [keyboardBoundsValue CGRectValue];
    
    NSNumber *keyboardAnimationDur = [[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    float animationDur = [keyboardAnimationDur floatValue];
    
    _keyboardShowTime++;
    
    // 第三方输入法有bug,第一次弹出没有keyboardRect
    if (animationDur > 0.0f && keyboardRect.size.height == 0) {
        
        _isThirdPartKeyboard = YES;
    }
    
    // 第三方输入法,有动画间隔时,没有高度
    if (_isThirdPartKeyboard) {
        
        // 第三次调用keyboardWillShow的时候 键盘完全展开
        if (_keyboardShowTime == 3 && keyboardRect.size.height != 0 && keyboardRect.origin.y != 0) {
            
            _keyboardFrame = keyboardRect;
            
            NSLog(@"_keyboardFrame.size.height--%f",_keyboardFrame.size.height);
            //Animate change

            [UIView animateWithDuration:_keyboardAnimateDur animations:^{
                
                self.frame = CGRectMake(0, MAINSCREEN_HEIGHT - _keyboardFrame.size.height-DEFAULT_HEIGHT, MAINSCREEN_WIDTH, DEFAULT_HEIGHT);
                
                //                [self layoutIfNeeded];
                //                [self layoutSubviews];
            }];
        }
        if (animationDur > 0.0) {
            
            _keyboardAnimateDur = animationDur;
        }
        
    } else { // 苹果自带键盘
        
        if (animationDur > 0.0) {
            
            _keyboardFrame = keyboardRect;
            _keyboardAnimateDur = animationDur;
            
            //Animate change
            [UIView animateWithDuration:_keyboardAnimateDur animations:^{
                
                self.frame = CGRectMake(0, MAINSCREEN_HEIGHT - _keyboardFrame.size.height - DEFAULT_HEIGHT, MAINSCREEN_WIDTH, DEFAULT_HEIGHT);
                
                [self layoutIfNeeded];
                [self layoutSubviews];
            }];
        }
    }
}

- (void)keyboardDidShow:(NSNotification*)notification
{
    _isKeyboardShow = YES;
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    NSNumber* keyboardAnimationDur = [[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    float animationDur = [keyboardAnimationDur floatValue];
    
    _isThirdPartKeyboard = NO;
    _keyboardShowTime = 0;
    
    if (animationDur > 0.0)
    {
        
        [_overView removeFromSuperview];
        [UIView animateWithDuration:_keyboardAnimateDur animations:^{
            
            self.frame=CGRectMake(0,MAINSCREEN_HEIGHT+20, MAINSCREEN_WIDTH, DEFAULT_HEIGHT);
            [self layoutIfNeeded];
            [self layoutSubviews];
        } completion:^(BOOL finished) {
            
            [self removeFromSuperview];
        }];
    }
}

- (void)keyboardDidHide:(NSNotification*)notification {
    
    _isKeyboardShow = NO;
}

@end
