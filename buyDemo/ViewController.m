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

/** HUD */
@property (nonatomic,strong) UILabel *hud;

@end

@implementation ViewController
-(NSArray *)shops
{
    if (!_shops)
    {
        NSString *file = [[NSBundle mainBundle] pathForResource:@"shops" ofType:@"plist"];
        _shops = [NSArray arrayWithContentsOfFile:file];
    }
    
    
    return _shops;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"buy";


    //懒加载
    
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
    
    //加载plist数据
    //凡是参数名为file，都是文件的全路径
    //只对电脑管用
//    NSString *file = @"/Users/apple/Desktop/buyDemo/buyDemo/shops.plist";
    
    //一个bundle对象对应一个资源包（图片，音频，视频，plist文件）
    //NSBundle的作用：用来访问与之对应的资源包内部的文件，可以用来获得文件的全路径
    //项目中添加的资源都会被添加到主资源包
    
   
//    NSBundle *bundle = [NSBundle mainBundle];
    
    //利用mainBundle获得plist文件在主资源包中的全路径
//    NSString *file = [bundle pathForResource:@"shops" ofType:@"plist"];
//    self.shops = [NSArray arrayWithContentsOfFile:file];

    
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
//    shopView.backgroundColor = [UIColor orangeColor];
    
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
//    iconView.backgroundColor = [UIColor blueColor];
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
    
    self.hud = [[UILabel alloc]init];
    [self.view addSubview:self.hud];
    [self.hud setFrame:CGRectMake(35, 300, 300, 30)];
    [self.hud setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1]];
    [self.hud setHidden:YES];
    [self.hud setTextAlignment:NSTextAlignmentCenter];
    
//    //显示HUD
//    if (self.removeBtn.enabled == NO)
//    {
//        //删光了
////        [self.hud setHidden:NO];
//        //定时任务
//        //SEL:对方法的包装，使用@selector包装一个SEL数据
////        [self performSelector:@selector(hideHUD) withObject:nil afterDelay:1.5];
//        self.hud.alpha = 1.0;
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            self.hud.alpha = 0.0;
//        });
//    }else if (self.addBtn.enabled == NO)
//    {
//        //加满了
//        [self.hud setText:@"加满了"];
////        [self performSelector:@selector(hideHUD) withObject:nil afterDelay:1.5];
//        self.hud.alpha = 1.0;
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            self.hud.alpha = 0.0;
//        });
////        [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(hideHUD) userInfo:nil repeats:NO];       
//    }
    
    NSString *text = nil;
    //显示HUD
    if (self.removeBtn.enabled == NO)
    {
        text = @"已经全部删除";
    }else if (self.addBtn.enabled == NO)
    {
        text = @"已经全部添加";
    }
    if (text)
    {
        self.hud.text = text;
        self.hud.alpha = 1.0;
        [self.hud setHidden:NO];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.hud.alpha = 0.0;
        });
    }
}

//HUD
//蒙板
//指示器
//遮盖

#pragma mark 隐藏HUD
-(void)hideHUD
{
    self.hud.alpha = 0.0;
}


@end
