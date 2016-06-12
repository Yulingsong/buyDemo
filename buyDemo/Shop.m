//
//  Shop.m
//  buyDemo
//
//  Created by yulingsong on 16/6/12.
//  Copyright © 2016年 yulingsong. All rights reserved.
//

#import "Shop.h"

@implementation Shop

-(instancetype)initWidtDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.name = dict[@"name"];
        self.icon = dict[@"icon"];
    }
    return self;
}

+(instancetype)shopWidtDict:(NSDictionary *)dict
{
    return [[self alloc]initWidtDict:dict];
}
@end
