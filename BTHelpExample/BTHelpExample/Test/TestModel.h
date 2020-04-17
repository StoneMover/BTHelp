//
//  TestModel.h
//  BTHelpExample
//
//  Created by apple on 2020/4/17.
//  Copyright © 2020 stonemover. All rights reserved.
//

#import "BTModel.h"

@class TestChildModel;

NS_ASSUME_NONNULL_BEGIN

@interface TestModel : BTModel

@property (nonatomic, strong) NSString * title;

@property (nonatomic, strong) TestChildModel * child;

@property (nonatomic, strong) NSMutableArray * childs;

@end

@interface TestChildModel : BTModel

@property (nonatomic, strong) NSString * content;

@end

NS_ASSUME_NONNULL_END

