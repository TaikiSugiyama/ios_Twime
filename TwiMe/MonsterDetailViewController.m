//
//  MonsterDetailViewController.m
//  TwiMe
//
//  Created by Taiki on 2014/12/05.
//  Copyright (c) 2014年 Taiki Sugiyama. All rights reserved.
//

#import "MonsterDetailViewController.h"

@interface MonsterDetailViewController ()

@end

@implementation MonsterDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger tagNum = [defaults integerForKey:@"index"];
    NSLog(@"%ld",(long)tagNum);
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"@check_red@2x.jpg"]];
    bgImage.frame = self.view.frame;
    bgImage.layer.zPosition = -2;
    [self.view addSubview:bgImage];
    
    
    NSString *num = [NSString stringWithFormat:@"%ld", (long)tagNum];
    NSString *imageName = [@"monster" stringByAppendingString:num];
    UIImageView *monster = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    monster.frame = self.view.frame;
    monster.frame = CGRectMake(width/2, height/2, 250, 250);
    monster.center = CGPointMake(width/2, height/2);
    [self.view addSubview:monster];
    
    
    NSArray *types = @[@"ウキウキ",@"ウキウキ",@"ウキウキ",@"トゲトゲ",@"トゲトゲ",@"トゲトゲ",@"ヤミヤミ",@"ヤミヤミ",@"ヤミヤミ",@"ルンルン",@"ルンルン",@"ルンルン",@"ルンウキ",@"ルンウキ",@"ルンウキ",@"ヤミトゲ",@"ヤミトゲ",@"ヤミトゲ",@"ヤミルン",@"ヤミルン",@"ヤミルン",@"トゲウキ",@"トゲウキ",@"トゲウキ"];
    _typeName = [[UILabel alloc] initWithFrame:CGRectMake(0, height/5, width, 50)];
    _typeName.text = [NSString stringWithFormat:@"タイプ:%@",types[tagNum]];
    _typeName.font = [UIFont systemFontOfSize:20.0];
    _typeName.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_typeName];

    UIImageView *whitebgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"white_bg@2x.png"]];
    whitebgImage.frame = self.view.frame;
    whitebgImage.layer.zPosition = -1;
    whitebgImage.contentMode = UIViewContentModeScaleToFill;
    whitebgImage.frame = CGRectMake(0, 0, width, height);
    whitebgImage.center = CGPointMake(width/2, height/2+20);
    [self.view addSubview:whitebgImage];
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    back = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    back.frame = CGRectMake(0, 30, 50, 30);
    [back setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//    [back setTitle:@"＜" forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backAction:(UIButton*)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
