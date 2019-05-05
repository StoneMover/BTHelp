//
//  BTBtnViewController.m
//  BTHelpExample
//
//  Created by stonemover on 2019/3/31.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import "BTBtnViewController.h"
#import "BTTextInputView.h"
#import "BTUtils.h"

@interface BTBtnViewController ()

@property (nonatomic, strong) BTTextInputView * inputView;

@end

@implementation BTBtnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)commitClick:(id)sender {
    if (!self.inputView) {
        self.inputView=[[BTTextInputView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    
    [self.inputView show:BTUtils.APP_WINDOW];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
