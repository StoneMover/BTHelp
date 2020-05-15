//
//  ViewController.m
//  BTHelpExample
//
//  Created by Motion Code on 2019/2/13.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import "ViewController.h"
#import "BTBtnViewController.h"
#import "BTUtils.h"
#import "TestModel.h"
#import "NSDate+BTDate.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray * titles;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"BTHelp";
    self.titles=@[@"BTButton&BTTextView",@"BTModel",@"BTKeyboardHelp"];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    NSString * phone = [BTUtils phoneEncrypt:@"15623728016"];
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
    NSDate * date = [NSDate initLocalDate];
    NSString *  year = date.year;
    NSString *   month = date.month;
    NSString *  day = date.day;
    NSString * weekData = date.weekDay;
    switch (indexPath.row) {
        case 0:
        {
            UIViewController *vc = [BTUtils createVc:@"BTBtnViewController"];
            vc.title=self.titles[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            NSDictionary * dict = @{@"title":@"三国演义",@"child":@{@"content":@"东汉末年"},@"childs":@[@{@"content":@"分三国"},@{@"content":@"烽火连天不休"}]};
            TestModel * model = [TestModel modelWithDict:dict];
            NSLog(@"");
        }
            break;
        case 2:
            
            break;
        case 3:
            
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
