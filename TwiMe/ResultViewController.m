//
//  ResultViewController.m
//  TwiMe
//
//  Created by nari on 2014/12/01.
//  Copyright (c) 2014年 Taiki Sugiyama. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check_blue@2x.jpg"]];
    bgImage.layer.zPosition = -2;
    [self.view addSubview:bgImage];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    
    UIImageView *whitebgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"white_bg@2x.png"]];
    whitebgImage.frame = self.view.frame;
    whitebgImage.layer.zPosition = -1;
    whitebgImage.contentMode = UIViewContentModeScaleToFill;
    whitebgImage.frame = CGRectMake(0, 0, width, height);
    whitebgImage.center = CGPointMake(width/2, height/2+20);
    [self.view addSubview:whitebgImage];
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uuid = [defaults stringForKey:@"search_id"];
    NSString *result = [defaults stringForKey:@"result"];
    
    UILabel *idName= [[UILabel alloc] initWithFrame:CGRectMake(0, height/20, width, 50)];
    idName.text = [NSString stringWithFormat:@"@%@",uuid];
    idName.font = [UIFont systemFontOfSize:20.0];
    idName.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:idName];
    
    NSArray *array = @[@"喜び度: ", @"怒り度: ", @"悲観度: ", @"楽天度: "];
    NSArray* values = [result componentsSeparatedByString:@","];
    float a = [[values objectAtIndex:0] intValue];
    float b = [[values objectAtIndex:1] intValue];
    float c = [[values objectAtIndex:2] intValue];
    float d = [[values objectAtIndex:3] intValue];
    
    float total = a + b + c + d;
    
    NSLog(@"%f",a);
    NSLog(@"%f",b);
    NSLog(@"%f",c);
    NSLog(@"%f",d);
    
    a = a/total*10;
    NSString *pa=[NSString stringWithFormat:@"%.0f",a];
    b = b/total*10;
    NSString *pb=[NSString stringWithFormat:@"%.0f",b];
    c = c/total*10;
    NSString *pc=[NSString stringWithFormat:@"%.0f",c];
    d = d/total*10;
    NSString *pd=[NSString stringWithFormat:@"%.0f",d];
    
    NSArray *per = @[pa,pb,pc,pd];
    
    for (NSInteger i = 0; i < 4; i++){
        NSString* how_val = [array objectAtIndex:i];
        NSString* value = [per objectAtIndex:i];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, height/8+25*i, width, 15)];
        label.font = [UIFont systemFontOfSize:15.0];
        label.text = [NSString stringWithFormat:@"%@ %@0％",how_val,value];
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:label];
    }
    
    int index = [self getIndex];
    
    NSLog(@"safsdfsafsafsdfsdafsdgsagg");
    NSLog(@"%d", index);
    
    NSString *imagepath;
    if (index==-1) {
        imagepath = @"noMonster@2x.png";
    }
    imagepath = [NSString stringWithFormat:@"monster%d@2x.png",index];
    
    /////
    NSData *card_data = [defaults objectForKey:@"card"];
    NSMutableArray *mcard_data = [[NSMutableArray alloc] init];
    mcard_data = [NSKeyedUnarchiver unarchiveObjectWithData:card_data];
    
    mcard_data[index] = @"1";
    
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:mcard_data];
    [defaults setObject:data forKey:@"card"];
    [defaults synchronize];
    /////


    _monsterImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imagepath]];
    _monsterImage.frame = self.view.frame;
    _monsterImage.contentMode = UIViewContentModeScaleAspectFit;
    _monsterImage.frame = CGRectMake(0, 0, 250, 250);
    _monsterImage.center = CGPointMake(width/2, height/2+height/12);
    _monsterImage.alpha = 0.0;
    [self.view addSubview:_monsterImage];
    
    NSArray *types = @[@"ウキウキ",@"ウキウキ",@"ウキウキ",@"トゲトゲ",@"トゲトゲ",@"トゲトゲ",@"ヤミヤミ",@"ヤミヤミ",@"ヤミヤミ",@"ルンルン",@"ルンルン",@"ルンルン",@"ルンウキ",@"ルンウキ",@"ルンウキ",@"ヤミトゲ",@"ヤミトゲ",@"ヤミトゲ",@"ヤミルン",@"ヤミルン",@"ヤミルン",@"トゲウキ",@"トゲウキ",@"トゲウキ"];
    _typeName = [[UILabel alloc] initWithFrame:CGRectMake(0, height/9+25*4, width, 50)];
    NSString* type = [types objectAtIndex:index];
    _typeName.text = [NSString stringWithFormat:@"タイプ:%@",type];
    _typeName.font = [UIFont systemFontOfSize:20.0];
    _typeName.textAlignment = NSTextAlignmentCenter;
    _typeName.alpha = 0.0;
    [self.view addSubview:_typeName];
    
    float x = self.view.center.x;
    UIButton *back = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    back = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    back.frame = CGRectMake(x-50,self.view.frame.size.height-20, 50, 30);
    back.center = CGPointMake(x/2,height-height/15);
    [back setBackgroundImage:[UIImage imageNamed:@"back2"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    
    
    
}




-(int) getIndex{
    int index = -1;
    int mixEmotion_cardNo = -1;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *result = [defaults stringForKey:@"result"];
    NSArray *values = [result componentsSeparatedByString:@","];
    
    int max_index = 0;
    BOOL flg = false;
    for (int i = 0; i < 4; i++){
        NSInteger x = [[values objectAtIndex:i] intValue];
        NSInteger y = [[values objectAtIndex:max_index] intValue];
        if(x>=y){
            max_index = i;
            flg = true;
        }
    }
    int second_max = 0;
    BOOL flg2 = false;
    for (int i = 0; i < 4; i++){
        NSInteger x = [[values objectAtIndex:i] intValue];
        NSInteger y = [[values objectAtIndex:second_max] intValue];
        if(max_index>x>=y){
            second_max = i;
        }
    }
    
    if ((max_index == 0 && second_max == 3) || (max_index == 3 && second_max == 0)) {
        mixEmotion_cardNo = 12;
    }else if ((max_index == 1 && second_max == 2) || (max_index == 2 && second_max == 1)) {
        mixEmotion_cardNo = 15;
    }else if ((max_index == 0 && second_max == 2) || (max_index == 2 && second_max == 0)) {
        mixEmotion_cardNo = 18;
    }else if ((max_index == 1 && second_max == 3) || (max_index == 3 && second_max == 1)) {
        mixEmotion_cardNo = 21;
    }
    
    NSInteger max_val = [[values objectAtIndex:max_index]intValue];
    NSInteger second_val = [[values objectAtIndex:second_max]intValue];
    
    if(max_val - second_val < 20){
        flg2 = true;
        if (max_val > 20 && second_val > 20) {
            mixEmotion_cardNo += 2;
            
        }else if (max_val > 15 && second_val > 15) {
            mixEmotion_cardNo += 1;
        }else if (max_val > 10 && second_val > 10) {
        }
    }
    
    
    NSInteger max = [[values objectAtIndex:max_index] intValue];
    
    
   
    
    if(max<10){
        index = max_index*3;
    }else if(max<20){
        index = max_index*3+2;
    }else{
        index = max_index*3+1;
    }
    
    NSLog(@"@@@@@@@@@@@@@@@@@@");
    NSLog(@"max %ld",(long)max);
    NSLog(@"index %d", index);
    NSLog(@"mixEmotion_cardNo %d", mixEmotion_cardNo);
    NSLog(@" ");
    if(flg2){
        return mixEmotion_cardNo;
    }else if(flg){
        return index;
    }
    else return -1;
}

- (void)backAction:(UIButton*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];//back
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [self showButton];
}



-(void) showButton{
    [UIView animateWithDuration:1.5f
                          delay:0.0f
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^(void){
                         _monsterImage.alpha = 1.0;
                         _typeName.alpha = 1.0;
                     }
                     completion:^(BOOL finished){
                     }];
}


@end
