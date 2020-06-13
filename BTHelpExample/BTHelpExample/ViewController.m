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
#import "NSDate+BTDate.h"
#import "BTTimerHelp.h"
#import "BTIconHelp.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray * titles;

@property (nonatomic, strong) BTTimerHelp * timer;

@property (nonatomic, strong) BTIconHelp * iconHelp;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"BTHelp";
    self.titles=@[@"BTModel",@"BTKeyboardHelp",@"BTTimer",@"BTIconHelp"];
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
            
        }
            break;
        case 2:
        {
            if (self.timer == nil) {
                self.timer = [[BTTimerHelp alloc] init];
                self.timer.changeTime = 1;
                self.timer.block = ^{
                    
                };
                [self.timer start];
                [self.timer stop];
            }
        }
            break;
        case 3:
        {
            if (self.iconHelp == nil) {
                self.iconHelp = [[BTIconHelp alloc] init:self];
                self.iconHelp.block = ^(UIImage *image) {
                    
                };
                [self.iconHelp go];
            }
        }
            break;
        case 4:
            
            break;
        case 5:
            
            break;
        case 6:
            
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

@end
