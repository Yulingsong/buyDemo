//
//  ViewController.m
//  buyDemo
//
//  Created by yulingsong on 16/6/1.
//  Copyright © 2016年 yulingsong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
/** 存放所有商品的view */
@property (nonatomic,strong) UIView *shopsView;

//添加按钮    单行注释
/* 添加按钮 */  //多行注释
/** 添加按钮 */  //文档注释
@property (nonatomic,strong) UIButton *addBtn;
/** 删除按钮 */
@property (nonatomic,strong) UIButton *removeBtn;

/** 全部商品数据 */
@property (nonatomic,strong) NSArray *shops;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"buy";
    
    //数据
    self.shops = @[
                       @{
                           @"icon":@"danjianbao",
                           @"name":@"单肩包"
                           },
                       @{
                           @"icon":@"liantiaobao",
                           @"name":@"链条包"
                           },
                       @{
                           @"icon":@"qianbao",
                           @"name":@"钱包"
                           },
                       @{
                           @"icon":@"shoutibao",
                           @"name":@"手提包"
                           },
                       @{
                           @"icon":@"shuangjianbao",
                           @"name":@"双肩包"
                           },
                       @{
                           @"icon":@"xiekuabao",
                           @"name":@"斜挎包"
                           },
                       @{
                           @"icon":@"danjianbao",
                           @"name":@"单肩包"
                           },
                       @{
                           @"icon":@"liantiaobao",
                           @"name":@"链条包"
                           },
                       @{
                           @"icon":@"qianbao",
                           @"name":@"钱包"
                           }
                       ];

    [self setSubViews];
    
}

//可以将按钮的一些属性什么的进行一下封装，以便于调用
-(UIButton *)addButtonsWithImage:(NSString *)image highImage:(NSString *)highImage disabledImage:(NSString *)disabledImage frame:(CGRect)frame tag:(NSInteger)tag action:(SEL)action
{
    UIButton *btn = [[UIButton alloc]init];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [btn setBackgroundImage:[UIImage imageNamed:disabledImage] forState:UIControlStateDisabled];
    [btn setFrame:frame];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTag:tag];
    [self.view addSubview:btn];
    return btn;
}

//添加子控件的方法
-(void)setSubViews
{
    //调用了简单封装方法创建按钮，可以根据tag值啦寻找控件
    self.addBtn = [self addButtonsWithImage:@"add" highImage:@"add_highlighted" disabledImage:@"add_disabled" frame:CGRectMake(30, 100, 50, 50) tag:10 action:@selector(add)];
    //添加删除按钮
    self.removeBtn = [self addButtonsWithImage:@"remove" highImage:@"remove_highlighted" disabledImage:@"remove_disabled" frame:CGRectMake(295, 100, 50, 50) tag:11 action:@selector(remove)];
    self.removeBtn.enabled = NO;
    
    UIButton *changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:changeBtn];
    [changeBtn setFrame:CGRectMake(137.5, 100, 100, 50)];
    [changeBtn setTitle:@"切换界面" forState:UIControlStateNormal];
    [changeBtn setBackgroundColor:[UIColor lightGrayColor]];
    [changeBtn addTarget:self action:@selector(changeview) forControlEvents:UIControlEventTouchUpInside];
    
    self.shopsView = [[UIView alloc]init];
    [self.view addSubview:self.shopsView];
    [self.shopsView setFrame:CGRectMake(30, 200, 310, 350)];
    [self.shopsView setBackgroundColor:[UIColor lightGrayColor]];
    
}

-(void)add
{
    NSLog(@"添加");
    
    self.shopsView.clipsToBounds = YES;
    //每一个商品的尺寸
    CGFloat shopW = 80;
    CGFloat shopH = 100;
    
    //一行三列
    int cols = 3;
    
    //每一列的间距
    CGFloat marginCol = (self.shopsView.frame.size.width - cols * shopW)/(cols - 1);
    
    //每一行的间距
    CGFloat marginRow = 18;
    
    //创建一个父控件（整体：存放图片和文字)
    UIView *shopView = [[UIView alloc]init];
    shopView.backgroundColor = [UIColor orangeColor];
    
    //商品的索引
    NSInteger index = self.shopsView.subviews.count;
    
    //商品的x值
    NSInteger col = index % cols;
    CGFloat shopX = col * (shopW + marginCol);
    
    //商品的y值
    NSInteger row = index / cols;
    CGFloat shopY = row * (shopH + marginRow);
    
    shopView.frame = CGRectMake(shopX, shopY, shopW, shopH);
    [self.shopsView addSubview:shopView];
    
        NSDictionary *shop = self.shops[index];
    
    
    UIImageView *iconView = [[UIImageView alloc]init];
    iconView.image = [UIImage imageNamed:shop[@"icon"]];
    iconView.backgroundColor = [UIColor blueColor];
    iconView.frame = CGRectMake(0, 0, shopW, shopW);
    [shopView addSubview:iconView];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = shop[@"name"];
    label.frame = CGRectMake(0, shopW, shopW, shopH-shopW);
    label.font = [UIFont systemFontOfSize:11];
    label.textAlignment = NSTextAlignmentCenter;
    [shopView addSubview:label];
    
    //来控制按钮的可用性
    [self checkState];
}

-(void)remove
{
    NSLog(@"删除");
    [[self.shopsView.subviews lastObject] removeFromSuperview];
    [self checkState];
}

-(void)changeview
{
    NSLog(@"1234");
}

-(void)checkState
{
    //删除按钮什么时候可以点击，商品个数 > 0
    self.removeBtn.enabled = (self.shopsView.subviews.count != 0);
    //添加按钮什么时候可以点击，商品个数 < 总数
    self.addBtn.enabled = (self.shopsView.subviews.count != self.shops.count);
}

@end
