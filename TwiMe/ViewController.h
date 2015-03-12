//
//  ViewController.h
//  TwiMe
//
//  Created by Taiki on 2014/11/11.
//  Copyright (c) 2014年 Taiki Sugiyama. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPRequestOperationManager.h"
#import "ResultViewController.h"
#import "TopViewController.h"
@interface ViewController : UIViewController <UITextFieldDelegate>
@property UILabel *myLabel;
@property UITextField *textField;
- (void)registerAction:(UIButton*)sender;
- (void)backAction:(UIButton*)sender;
@end

