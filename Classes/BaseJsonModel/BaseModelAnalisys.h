//
//  BaseModelAnalisys.h
//  framework
//
//  Created by whbt_mac on 16/5/19.
//  Copyright © 2016年 StoneMover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface BaseModelAnalisys : NSObject

-(void)analysisDict:(NSDictionary*)dict withModel:(BaseModel*)model;


-(NSDictionary*)autoDataToDictionary:(BaseModel*)model;
@end
