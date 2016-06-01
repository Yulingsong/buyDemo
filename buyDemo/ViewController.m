//
//  ViewController.m
//  buyDemo
//
//  Created by yulingsong on 16/6/1.
//  Copyright © 2016年 yulingsong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) UIView *view1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"buy";
    
    
    
    [self setSubViews];
    
}

-(void)setSubViews
{
    UIButton *btn1 = [[UIButton alloc]init];
    [self.view addSubview:btn1];
    [btn1 setFrame:CGRectMake(30, 100, 50, 50)];
    [btn1 setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"add_highlighted"] forState:UIControlStateHighlighted];
    [btn1 setImage:[UIImage imageNamed:@"add_disabled"] forState:UIControlStateDisabled];
    [btn1 addTarget:self action:@selector(clickBtn1) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn2];
    [btn2 setFrame:CGRectMake(295, 100, 50, 50)];
    [btn2 setImage:[UIImage imageNamed:@"remove"] forState:UIControlStateNormal];;
    [btn2 setImage:[UIImage imageNamed:@"remove_highlighted"] forState:UIControlStateHighlighted];
    [btn2 setImage:[UIImage imageNamed:@"remove_disabled"] forState:UIControlStateDisabled];
    [btn2 addTarget:self action:@selector(clickBtn2) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:changeBtn];
    [changeBtn setFrame:CGRectMake(137.5, 100, 100, 50)];
    [changeBtn setTitle:@"切换界面" forState:UIControlStateNormal];
    [changeBtn setBackgroundColor:[UIColor lightGrayColor]];
    [changeBtn addTarget:self action:@selector(changeview) forControlEvents:UIControlEventTouchUpInside];
    
    self.view1 = [[UIView alloc]init];
    [self.view addSubview:self.view1];
    [self.view1 setFrame:CGRectMake(80, 200, 224, 394)];
    [self.view1 setBackgroundColor:[UIColor lightGrayColor]];
    
    
    
}

-(void)clickBtn1
{
    NSLog(@"123");
    [self.view addSubview:self.view1];
}

-(void)clickBtn2
{
    NSLog(@"321");
    [self.view1 removeFromSuperview];
}

-(void)changeview
{
    NSLog(@"1234");
    UIImageView *imageview = [[UIImageView alloc]init];
    [imageview setFrame:CGRectMake(0, 0, 224, 394)];
    [self.view1 addSubview:imageview];
    [imageview setImage:[UIImage imageNamed:@"IMG_2592"]];
}


@end
