//
//  ViewController.m
//  BTHelpExample
//
//  Created by Motion Code on 2019/2/13.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import "ViewController.h"
#import "BTIconHelp.h"

@interface ViewController ()

@property (nonatomic, strong) BTIconHelp * help;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)click:(id)sender {
    if (!self.help) {
        self.help=[[BTIconHelp alloc] init:self];
        self.help.imgSize=200;
        self.help.isNeedWidthEqualsHeight=YES;
    }
    __weak ViewController * weakSelf=self;
    self.help.block = ^(UIImage *image) {
        weakSelf.imgView.image=image;
    };
    [self.help go];
    
}

@end
