//
//  BaseModel.m
//  freeuse
//
//  Created by whbt_mac on 16/4/25.
//  Copyright © 2016年 StoneMover. All rights reserved.
//

#import "BaseModel.h"
#import "BaseModelAnalisys.h"


@implementation BaseModel

+(instancetype)modelWithDict:(NSDictionary*)dict{
    return [[self alloc]initWithDict:dict];
}

-(instancetype)init{
    self=[super init];
    [self initSelf];
    return self;
}

-(instancetype)initWithDict:(NSDictionary*)dict{
    self=[self init];
    [self analisys:dict];
    return self;
}



-(void)initSelf{
    
}

-(void)analisys:(NSDictionary*)dict{
    BaseModelAnalisys * analysis=[[BaseModelAnalisys alloc]init];
    [analysis analysisDict:dict withModel:self];
}


-(NSDictionary*)autoDataToDictionary{
    BaseModelAnalisys * analysis=[[BaseModelAnalisys alloc]init];
    return [analysis autoDataToDictionary:self];
}

@end
