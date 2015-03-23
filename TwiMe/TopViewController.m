//
//  TopViewController.m
//  TwiMe
//
//  Created by nari on 2014/11/11.
//  Copyright (c) 2014年 Taiki Sugiyama. All rights reserved.
//

#import "TopViewController.h"

@interface TopViewController ()

@end

@implementation TopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"@check_blue@2x.jpg"]];
    bgImage.layer.zPosition = -1;
    [self.view addSubview:bgImage];
    _items_ = [@[] mutableCopy];
    NSDictionary *item;
    
    for(int i=0;i<3;i++){
        item = @{
                 @"text": [NSString stringWithFormat:@"item-%d", i],
                 @"color": [UIColor blackColor]
                 };
        [_items_ addObject:item];
    }
    
    // set up iCarousel
    _carousel_ = [[iCarousel alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height / 2 - 50,self.view.frame.size.width,100)];
    [_carousel_ setBackgroundColor:[UIColor clearColor]];
    _carousel_.dataSource = self;
    _carousel_.delegate = self;
    _carousel_.type = iCarouselTypeRotary;
    _carousel_.layer.zPosition = 100;
    [self.view addSubview:_carousel_];
    
    
    UIImageView *msbox = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"msbox@2x.png"]];
    msbox.frame = CGRectMake(0, self.view.frame.size.height/2+self.view.frame.size.height/4, self.view.frame.size.width, self.view.frame.size.height/4);
    [self.view addSubview:msbox];
    _message = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/2+self.view.frame.size.height/4, self.view.frame.size.width, self.view.frame.size.height/4)];
    _message.textAlignment = NSTextAlignmentCenter;
    _message.text = @"TwitterIDから解析をします";
    _message.font = [UIFont fontWithName:@"AppleGothic" size:20];
    [self.view addSubview:_message];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [_items_ count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{

    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/2, self.view.frame.size.width/2)];
    UIImage *image;
    if (index == 0) {
        image = [UIImage imageNamed:@"kaiseki@2x.png"];
    }else if (index == 1){
        image = [UIImage imageNamed:@"setting@2x.png"];
    }else{
        image = [UIImage imageNamed:@"book@2x.png"];
    }
    UIImageView *iv = [[UIImageView alloc] initWithImage:image];
    iv.frame = view.frame;
    [view addSubview:iv];
    return view;
}
- (void)insertItem:(UIButton*)sender
{
    NSInteger index = MAX(0, _carousel_.currentItemIndex);
    [_items_ insertObject:@(_carousel_.numberOfItems) atIndex:(NSUInteger)index];
    [_carousel_ insertItemAtIndex:index animated:YES];
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionSpacing) {
        return value * 1.25f;
    }
    return value;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    if(index==0){
        ViewController *viewController = [[ViewController alloc]initWithNibName:nil bundle:nil];
        viewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:viewController animated:YES completion:nil];
    }else if(index==2){
        AlbumViewController *viewController = [[AlbumViewController alloc]initWithNibName:nil bundle:nil];
        viewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:viewController animated:YES completion:nil];
    }
}
- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    if(_carousel_.currentItemIndex==0){
        _message.text = @"TwitterIDから解析をします";
    }else if (_carousel_.currentItemIndex==1){
        _message.text = @"設定します";
    }else if(_carousel_.currentItemIndex==2){
        _message.text = @"アルバムを見ます";
    }
}


@end
