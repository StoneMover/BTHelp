//
//  PayViewController.m
//  BTHelpExample
//
//  Created by apple on 2020/6/15.
//  Copyright © 2020 stonemover. All rights reserved.
//

#import "PayViewController.h"
#import "BTApplePay.h"

@interface PayViewController ()<ApplePayDelegate>

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Pay";
    
    [BTApplePay share].userId = @"唯一用户标识";
    [BTApplePay share].delegate = self;
    
    //这里可以给个Loading
    [[BTApplePay share] requestProducts];
}

//检查本地是否有未上传的凭证
- (void)checkUnUploadPayment{
    BTApplePayReceiptModel * model = [[BTApplePay share] checkLostReceiptModel];
    if (model != nil) {
        //提示用户是否进行上传凭证服务器验证逻辑，如果验证成功移除凭证
        [[BTApplePay share] removeReceiptModel:model.receipt];
    }
}

- (void)BTApplePayRequestSuccess:(NSArray *)dictArray{
    NSDictionary * dict = dictArray[0];
    NSString * productId = dict[@"productIdentifier"];
    [[BTApplePay share] buy:productId applicationUsername:@"用户名,没有随便传"];
}

- (void)BTApplePayRequestFail:(NSError *)error{
    //如果有Loading这里取消，并给出错误提示
}

- (void)BTApplePayRequestFinish{
    //可不做任何处理
}

- (void)BTApplePayBuySuccess:(NSString *)payment{
    //购买成功将凭证上传服务器验证，验证完成移除本地凭证
    [[BTApplePay share] removeReceiptModel:payment];
}

- (void)BTApplePayBuyFail:(NSString *)failInfo{
    //如果有Loading这里取消,购买失败给出对应提示
    
}

@end
