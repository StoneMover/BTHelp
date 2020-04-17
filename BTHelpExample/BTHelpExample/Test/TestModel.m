//
//  TestModel.m
//  BTHelpExample
//
//  Created by apple on 2020/4/17.
//  Copyright © 2020 stonemover. All rights reserved.
//

#import "TestModel.h"

@implementation TestModel

- (void)initSelf{
    [super initSelf];
    self.classDict = @{@"child":TestChildModel.class,@"childs":TestChildModel.class};
}

@end


@implementation TestChildModel



@end
