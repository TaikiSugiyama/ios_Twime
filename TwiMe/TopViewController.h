//
//  TopViewController.h
//  TwiMe
//
//  Created by nari on 2014/11/11.
//  Copyright (c) 2014年 Taiki Sugiyama. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "AlbumViewController.h"
#import "iCarousel.h"
@interface TopViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>
@property iCarousel *carousel_;
@property NSMutableArray *items_;
@property UILabel *message;
@end
