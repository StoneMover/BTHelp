//
//  IconViewController.m
//  BTHelpExample
//
//  Created by apple on 2020/6/15.
//  Copyright © 2020 stonemover. All rights reserved.
//

#import "IconViewController.h"
#import "BTHelp.h"

@interface IconViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *resultImgView;

@property (nonatomic, strong) BTIconHelp * iconHelp;

@end

@implementation IconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"IconHelp";
    
    __weak IconViewController * weakSelf=self;
    self.iconHelp = [[BTIconHelp alloc] init:self];
    self.iconHelp.isClip = YES;
    self.iconHelp.isNeedWidthEqualsHeight = YES;
    self.iconHelp.block = ^(UIImage *image) {
        weakSelf.resultImgView.image = image;
    };
}


- (IBAction)goClick:(id)sender {
    [self.iconHelp go];
}

@end
