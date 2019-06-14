//
//  TFAccessoryController.m
//  StudyAndTools
//
//  Created by SL设计 on 2019/6/13.
//  Copyright © 2019 SL设计. All rights reserved.
//

#import "TFAccessoryController.h"
#import "YMTFInputAccessoryView.h"

@interface TFAccessoryController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation TFAccessoryController

#pragma mark Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.textField.delegate = self;
    
    YMTFInputAccessoryView *testAccessoryView = [YMTFInputAccessoryView new];
    self.textField.inputAccessoryView = testAccessoryView;
    testAccessoryView.labCenter.text = self.textField.placeholder;
    testAccessoryView.doneBlock = ^{
        [self.view endEditing:YES];
    };
}


#pragma mark - textfield Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    [self textFieldChangeCenterTextWithTitleString:textField.text textField:textField];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSLog(@"textFieldText:%@ === range:%@ === replaceString:%@", textField.text, NSStringFromRange(range), string);
    
    NSString *allStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [self textFieldChangeCenterTextWithTitleString:allStr textField:textField];
    return YES;
}

// 显示textField中间数据
- (void)textFieldChangeCenterTextWithTitleString:(NSString *)titleStr textField:(UITextField *)textField {
    
    YMTFInputAccessoryView *accView = (YMTFInputAccessoryView *)textField.inputAccessoryView;
    if (!accView) {
        return;
    }
    if (titleStr.length == 0) {
        accView.labCenter.text = textField.placeholder;
        accView.labCenter.textColor = [UIColor colorWithRed:(198.0/255.0) green:(201.0/255.0) blue:(208.0/255.0) alpha:1.0];
    } else {
        accView.labCenter.text = titleStr;
        accView.labCenter.textColor = [UIColor blackColor];
    }
}

@end
