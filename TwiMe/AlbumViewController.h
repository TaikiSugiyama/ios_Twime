//
//  ViewController.h
//  sample
//
//  Created by Taiki on 2014/12/03.
//  Copyright (c) 2014年 Taiki Sugiyama. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MonsterDetailViewController.h"
@interface AlbumViewController : UIViewController<UIScrollViewDelegate,UIAlertViewDelegate>{
    UIScrollView *scrollView;
    UIPageControl *pageControl;
    NSMutableArray *buttons;
}
@property (nonatomic, retain)NSMutableArray *buttons;
- (void)buttonClicked:(id)sender;
@end

