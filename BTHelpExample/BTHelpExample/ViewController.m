//
//  ViewController.m
//  BTHelpExample
//
//  Created by Motion Code on 2019/2/13.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import "ViewController.h"
#import "BTUtils.h"
#import "TestModel.h"
#import "BTUtils.h"
#import "TimerViewController.h"
#import "IconViewController.h"
#import "KeyboardViewController.h"
#import "BTPermission.h"
#import "PayViewController.h"
#import "BTDownloadMananger.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray * titles;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"BTHelp";
    self.titles=@[@"BTModel",@"BTTimer",@"BTIconHelp",@"BTKeyboard",@"BTPermission",@"Pay"];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
}

#pragma mark tableView data delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCellId"];
    cell.textLabel.text=self.titles[indexPath.row];
    return cell;
}


#pragma mark tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            NSDictionary * dict = @{@"title":@"三国演义",@"child":@{@"content":@"东汉末年"},@"childs":@[@{@"content":@"分三国"},@{@"content":@"烽火连天不休"}]};
            TestModel * model = [TestModel modelWithDict:dict];
            NSLog(@"下个断点看有没有解析成功");
        }
            break;
        case 1:
        {
            
            TimerViewController * vc = (TimerViewController*)[BTUtils createVc:@"TimerViewController" storyBoardName:@"Main"];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            IconViewController * vc = (IconViewController*)[BTUtils createVc:@"IconViewController" storyBoardName:@"Main"];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            KeyboardViewController * vc = (KeyboardViewController*)[BTUtils createVc:@"KeyboardViewController" storyBoardName:@"Main"];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            [[BTPermission share] getMicPermission:@"当前暂无麦克风权限，请打开后重试" success:^{
                
            }];
            
            [[BTPermission share] getAlbumPermission:^{
                
            }];
        }
            break;
        case 5:
        {
            PayViewController * vc=[PayViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 6:
        {
            [[BTDownloadMananger share] downLoad:@"下载地址"];
            [[BTDownloadMananger share] addDelegate:self];
            [[BTDownloadMananger share] removeDelegate:self];
            [[BTDownloadMananger share] cancel:@"下载地址"];
            [[BTDownloadMananger share] isDownloading:@"下载地址"];
        }
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

@end
