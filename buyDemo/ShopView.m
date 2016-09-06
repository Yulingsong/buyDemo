//
//  ShopView.m
//  buyDemo
//
//  Created by yulingsong on 16/6/13.
//  Copyright © 2016年 yulingsong. All rights reserved.
//

#import "ShopView.h"
#import "Shop.h"

@interface ShopView ()
/** 图片控件 */
@property (nonatomic,strong) UIImageView *iconView;
/** 名字图片 */
@property (nonatomic,strong) UILabel *nameLabel;
@end

@implementation ShopView

-(instancetype)init
{
    if (self = [super init])
    {
        self.backgroundColor = [UIColor orangeColor];

//        CGFloat shopW = self.frame.size.width;
//        CGFloat shopH = self.frame.size.height;
    
        UIImageView *iconView = [[UIImageView alloc]init];
//        iconView.frame = CGRectMake(0, 0, shopW, shopW);
        iconView.backgroundColor = [UIColor blueColor];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        UILabel *nameLabel = [[UILabel alloc]init];
//        nameLabel.frame = CGRectMake(0, shopW, shopW, shopH-shopW);
        nameLabel.font = [UIFont systemFontOfSize:11];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.backgroundColor = [UIColor redColor];
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
    }
    return self;
}

/**
 init方法内部会自动调用initWithFrame:方法
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor orangeColor];
        
        // 添加图片
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.backgroundColor = [UIColor blueColor];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        // 添加文字
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:11];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.backgroundColor = [UIColor redColor];
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
    }
    return self;
}




/**
 这个方法专门布局子控件，一般在这里设置子控件的frame
 当控件本身的尺寸发生改变的时候，系统会自动调用这个方法
 */
-(void)layoutSubviews
{
    //一定要调用这个方法
    [super layoutSubviews];
    
    CGFloat shopW = self.frame.size.width;
    CGFloat shopH = self.frame.size.height;
    
    self.iconView.frame = CGRectMake(0, 0, shopW, shopH);
    self.nameLabel.frame = CGRectMake(0, shopW, shopW, shopH-shopW);
}

-(void)setShop:(Shop *)shop
{
    _shop = shop;
    
    self.nameLabel.text = shop.name;
    self.iconView.image = [UIImage imageNamed:shop.icon];
}


@end
