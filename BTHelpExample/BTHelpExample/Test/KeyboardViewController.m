//
//  KeyboardViewController.m
//  BTHelpExample
//
//  Created by apple on 2020/6/15.
//  Copyright © 2020 stonemover. All rights reserved.
//

#import "KeyboardViewController.h"
#import "BTHelp.h"

@interface KeyboardViewController ()

@property (weak, nonatomic) IBOutlet UIView *displayView;

@property (nonatomic, strong) BTKeyboardHelp * help;

@property (weak, nonatomic) IBOutlet UITextField *textField;


@end

@implementation KeyboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"KeyboardHelp";
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.help.isPause = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.help.isPause = NO;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.help == nil) {
        self.help = [[BTKeyboardHelp alloc] initWithShowView:self.textField moveView:self.displayView margin:0];
        [self.textField becomeFirstResponder];
    }
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
