//
//  ViewController.m
//  sample
//
//  Created by Taiki on 2014/12/03.
//  Copyright (c) 2014年 Taiki Sugiyama. All rights reserved.
//

#import "AlbumViewController.h"

@interface UIViewController ()

@end

@implementation AlbumViewController
@synthesize buttons;

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"@check_red@2x.jpg"]];
    bgImage.frame = self.view.frame;
    bgImage.layer.zPosition = -2;
    [self.view addSubview:bgImage];
    
    NSInteger pageSize = 5;
    scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    scrollView.pagingEnabled = YES;
    scrollView.userInteractionEnabled = YES;
    scrollView.delegate = self;
    [scrollView setContentSize:CGSizeMake((pageSize * width), height-100)];
    [self.view addSubview:scrollView];
    
    
    NSMutableArray	*array = [NSMutableArray array];
    [array addObject:[NSNumber numberWithInt:self.view.frame.size.width/4]];
    [array addObject:[NSNumber numberWithInt:self.view.frame.size.width/2]];
    [array addObject:[NSNumber numberWithInt:self.view.frame.size.width/4+self.view.frame.size.width/2]];
   
    //////
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"card"];
    NSArray *mutable = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    //////
    
    for (NSInteger p = 0; p < pageSize; p++) {
        UIImageView *whitebgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"white_bg@2x.png"]];
        whitebgImage.contentMode = UIViewContentModeScaleToFill;
        whitebgImage.frame = CGRectMake(0, 0, width, height);
        whitebgImage.center = CGPointMake(p*width+width/2, height/2+30);
        [scrollView addSubview:whitebgImage];
        for (NSInteger i = 0; i < 5; i++){
            for(NSInteger s = 0; s < 3; s++){
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                if([mutable[p*15+i*3+s]  isEqual: @"1"]){
                    NSString *num = [NSString stringWithFormat:@"%d", p*15+i*3+s];
                    NSString *monsterName = [@"monster" stringByAppendingString:num];
                    [button setBackgroundImage:[UIImage imageNamed:monsterName] forState:UIControlStateNormal];
                    
                }else{
                    [button setBackgroundImage:[UIImage imageNamed:@"noMonster@2x.png"] forState:UIControlStateNormal];
                }
                ///////
                
                button.frame = CGRectMake(0 ,0 ,height/7 ,height/7);
                button.tag = p*15+i*3+s;
                button.center = CGPointMake([[array objectAtIndex:s] intValue]+p*width, i*height/7+60+height/14+i*10);
                [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [scrollView addSubview:button];
            }
        }
    }
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-75,height-50, 150, 30)];
    pageControl.backgroundColor = [UIColor clearColor];
    pageControl.numberOfPages = pageSize;
    pageControl.currentPage = 0;
    pageControl.userInteractionEnabled = YES;
    [pageControl addTarget:self
                    action:@selector(pageControl_Tapped:)
          forControlEvents:UIControlEventValueChanged];
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:0.286 green:0.486 blue:0.749 alpha:1.0];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0.475 green:0.682 blue:0.949 alpha:0.5];
    [self.view addSubview:pageControl];
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    back = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    back.frame = CGRectMake(0,30, 50, 30);
    [back setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//    [back setTitle:@"<" forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
}

- (void)backAction:(UIButton*)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];//back
}

- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    if ((NSInteger)fmod(scrollView.contentOffset.x , pageWidth) == 0) {
        pageControl.currentPage = scrollView.contentOffset.x / pageWidth;
    }
}

- (void)pageControl_Tapped:(id)sender{
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * pageControl.currentPage;
    [scrollView scrollRectToVisible:frame animated:YES];
}


- (void)buttonClicked:(id)sender{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger tagNum = [sender tag];
    [defaults setInteger:tagNum forKey:@"index"];
    NSData *card_data = [defaults objectForKey:@"card"];
    NSMutableArray *card = [NSKeyedUnarchiver unarchiveObjectWithData:card_data];
    if([card[tagNum]  isEqual: @"1"]){
        MonsterDetailViewController *viewController = [[MonsterDetailViewController alloc]initWithNibName:nil bundle:nil];
        [self presentViewController:viewController animated:YES completion:nil];
        
    }else{
        NSLog(@"noMonster");
        return;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
