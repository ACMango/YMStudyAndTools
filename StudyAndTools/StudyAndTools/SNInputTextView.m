//
//  SNInputTextView.m
//  SonyApp
//
//  Created by SL设计 on 2019/6/24.
//  Copyright © 2019 Chen. All rights reserved.
//

#import "SNInputTextView.h"

#define MAINSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define MAINSCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define DEFAULT_HEIGHT (130)
static const CGFloat kTextFont = 13.0;

@interface SNInputTextView ()<UITextViewDelegate>
{
    UIControl *_overView;
    BOOL      _isKeyboardShow;
    BOOL      _isThirdPartKeyboard;
    NSInteger _keyboardShowTime;
    CGFloat   _defaultConstraint;
    CGFloat   _keyboardAnimateDur;
    CGPoint   _oldOffset;
    CGRect    _keyboardFrame;
}


@property (strong, nonatomic)  UITextView *textView;
@property (strong, nonatomic)  UIButton *publishBtn;
@property (strong, nonatomic)  UILabel *placeHolderLabel;
@property (strong, nonatomic)  UILabel *checkLabel;

@end

@implementation SNInputTextView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.maxLength = 30;
        [self setup];
        [self initKeyboardObserver];
    }
    return self;
}

- (void)setup
{
    self.frame = CGRectMake(0, MAINSCREEN_HEIGHT, MAINSCREEN_WIDTH, DEFAULT_HEIGHT);
    self.backgroundColor = [UIColor whiteColor];
    
    _overView=[[UIControl alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _overView.backgroundColor=[UIColor colorWithWhite:0 alpha:0.3];
    [_overView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    typeof(self) weakSelf = self;
    CGFloat margin = 8.0;
    [self addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.left.equalTo(weakSelf).offset(margin);
        make.right.equalTo(weakSelf).offset(-margin);
        make.height.mas_equalTo(70.0);
    }];
    
    [self addSubview:self.placeHolderLabel];
    [self.placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.textView).offset(5.0);
        make.left.equalTo(weakSelf.textView).offset(7.0);
        make.width.mas_equalTo(200.0);
        make.height.mas_equalTo(20.0);
    }];
    
    [self addSubview:self.checkLabel];
    [self.checkLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.right.equalTo(weakSelf.textView).offset(-margin);
        make.bottom.equalTo(weakSelf.textView).offset(-0.6*margin);
        make.height.mas_equalTo(20.0);
        make.width.mas_equalTo(50.0);
    }];
    
    [self addSubview:self.publishBtn];
    [self.publishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.textView).offset(-3);
        make.top.equalTo(weakSelf.textView.mas_bottom).offset(1.4*margin);
        make.width.mas_equalTo(70.0);
        make.height.mas_equalTo(30.0);
    }];
}

-(void)show
{
    if (_isKeyboardShow) {
        return;
    }
    
    UIWindow * keyWindow=[UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:_overView];
    [keyWindow addSubview:self];
    [self.textView becomeFirstResponder];
    
    self.textView.text = @"";
    self.checkLabel.text = [NSString stringWithFormat:@"0/%ld", self.maxLength];
}

-(void)dismiss
{
    [self.textView resignFirstResponder];
}

- (void)publishMethod {
    
    if (_publishBlock) {
        _publishBlock(self.textView.text);
    }
    
    [self dismiss];
}

#pragma mark - 键盘事件
- (void)initKeyboardObserver
{
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
- (void)keyboardWillShow:(NSNotification*)notification
{
    
    NSValue* keyboardBoundsValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [keyboardBoundsValue CGRectValue];
    
    NSNumber* keyboardAnimationDur = [[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    float animationDur = [keyboardAnimationDur floatValue];
    
    _keyboardShowTime++;
    
    // 第三方输入法有bug,第一次弹出没有keyboardRect
    if (animationDur > 0.0f && keyboardRect.size.height == 0)
    {
        _isThirdPartKeyboard = YES;
    }
    
    // 第三方输入法,有动画间隔时,没有高度
    if (_isThirdPartKeyboard)
    {
        // 第三次调用keyboardWillShow的时候 键盘完全展开
        if (_keyboardShowTime == 3 && keyboardRect.size.height != 0 && keyboardRect.origin.y != 0)
        {
            _keyboardFrame = keyboardRect;
            
            NSLog(@"_keyboardFrame.size.height--%f",_keyboardFrame.size.height);
            //Animate change
            [UIView animateWithDuration:_keyboardAnimateDur animations:^{
                
                self.frame=CGRectMake(0,MAINSCREEN_HEIGHT- _keyboardFrame.size.height-DEFAULT_HEIGHT, MAINSCREEN_WIDTH, DEFAULT_HEIGHT);
            }];
            
        }
        if (animationDur > 0.0)
        {
            _keyboardAnimateDur = animationDur;
        }
    }
    else
    {
        if (animationDur > 0.0)
        {
            _keyboardFrame = keyboardRect;
            _keyboardAnimateDur = animationDur;
            
            //Animate change
            [UIView animateWithDuration:_keyboardAnimateDur animations:^{
                
                self.frame=CGRectMake(0,MAINSCREEN_HEIGHT- _keyboardFrame.size.height-DEFAULT_HEIGHT, MAINSCREEN_WIDTH, DEFAULT_HEIGHT);
                
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

- (void)keyboardDidHide:(NSNotification*)notification
{
    _isKeyboardShow = NO;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView;
{

    NSString * title = [NSString stringWithFormat:@"%lu/%lu",(unsigned long)self.textView.text.length, (unsigned long)self.maxLength];
    self.checkLabel.text = title;
    self.placeHolderLabel.hidden = self.textView.text.length>0?YES:NO;
}


#pragma mark - setter && getter
- (UITextView *)textView {
    
    if (!_textView) {
        _textView = [UITextView new];
        _textView.textColor = [UIColor colorWithHexString:@"#686869"];
        _textView.font = [UIFont systemFontOfSize:kTextFont];
        _textView.backgroundColor = RGB_COLOR(233, 235, 236);
        _textView.delegate = self;
    }
    return _textView;
}

- (UILabel *)placeHolderLabel {
    
    if (!_placeHolderLabel) {
        _placeHolderLabel = [UILabel new];
        _placeHolderLabel.font = [UIFont systemFontOfSize:kTextFont];
        _placeHolderLabel.textColor = [UIColor colorWithHexString:@"#686869"];
        _placeHolderLabel.text = @"请输入个性签名";
    }
    return _placeHolderLabel;
}

- (UIButton *)publishBtn {
    
    if (!_publishBtn) {
        _publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_publishBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_publishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _publishBtn.titleLabel.font = [UIFont systemFontOfSize:kTextFont+2];
        _publishBtn.layer.cornerRadius = 3.0;
        _publishBtn.layer.masksToBounds = YES;
        _publishBtn.backgroundColor = RGB_COLOR(54, 155, 254);
        [_publishBtn addTarget:self action:@selector(publishMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _publishBtn;
}

- (UILabel *)checkLabel {
    
    if (!_checkLabel) {
        _checkLabel = [UILabel new];
        _checkLabel.font = [UIFont systemFontOfSize:kTextFont];
        _checkLabel.textColor = [UIColor colorWithHexString:@"#414545"];
        _checkLabel.textAlignment = NSTextAlignmentRight;
        _checkLabel.backgroundColor = [UIColor yellowColor];
    }
    
    return _checkLabel;
}

@end
