//
//  Shop.h
//  buyDemo
//
//  Created by yulingsong on 16/6/12.
//  Copyright © 2016年 yulingsong. All rights reserved.
//  存放商品数据的模型

#import <Foundation/Foundation.h>

@interface Shop : NSObject
/** 商品名称 */
@property (nonatomic,strong) NSString *name;
/** 图标 */
@property (nonatomic,strong) NSString *icon;

-(instancetype)initWidtDict:(NSDictionary *)dict;
+(instancetype)shopWidtDict:(NSDictionary *)dict;

@end
