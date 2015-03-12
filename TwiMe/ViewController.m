//
//  ViewController.m
//  TwiMe
//
//  Created by Taiki on 2014/11/11.
//  Copyright (c) 2014年 Taiki Sugiyama. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check_blue@2x.jpg"]];
    bgImage.layer.zPosition = -1;
    [self.view addSubview:bgImage];
    
    // UITextFieldのインスタンスを生成
    CGRect rect = CGRectMake(10, 10, 250, 25);
    _textField = [[UITextField alloc]initWithFrame:rect];
    float x = self.view.center.x;
    float y = self.view.center.y;
    CGPoint textpoint = CGPointMake(x, y-100);
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.font = [UIFont fontWithName:@"Helvetica" size:14];
    _textField.placeholder = @"Twitter ID";
    _textField.keyboardType = UIKeyboardTypeDefault;
    _textField.returnKeyType = UIReturnKeyDefault;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.delegate = self;
    _textField.center = textpoint;
    [self.view addSubview:_textField];
    
    UIButton *submit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    submit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    submit.frame = CGRectMake(x-50,self.view.frame.size.height-50, 40, 30);
    submit.center = CGPointMake(x, y+10);
    [submit setBackgroundImage:[UIImage imageNamed:@"touroku"] forState:UIControlStateNormal];
//    [submit setTitle:@"登録" forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submit];
    
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    back = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    back.frame = CGRectMake(x-50,self.view.frame.size.height, 50, 30);
    back.center = CGPointMake(x-5, y+60);
    [back setBackgroundImage:[UIImage imageNamed:@"back2"] forState:UIControlStateNormal];
//    [back setTitle:@"もどる" forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
}

- (void)backAction:(UIButton*)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];//back
}

- (void)registerAction:(UIButton*)sender
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *params = @{@"foo[id]": _textField.text};
    NSString *ip = @"http://twime.sakura.ne.jp/app/neosearch_id.php";
    [manager POST:ip
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject){
              NSLog(@"success");
              
              NSString *result = [responseObject objectForKey:@"result"];
              NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
              [defaults setObject:_textField.text forKey:@"search_id"];
              [defaults setObject:result forKey:@"result"];
              ResultViewController *viewController = [[ResultViewController alloc]initWithNibName:nil bundle:nil];
              [self presentViewController:viewController animated:YES completion:nil];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    NSTimeInterval duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        CGAffineTransform transform = CGAffineTransformMakeTranslation(0, -keyboardRect.size.height);
        self.view.transform = transform;
    } completion:NULL];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSTimeInterval duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    __weak typeof(self) _self = self;
    [UIView animateWithDuration:duration animations:^{
        _self.view.transform = CGAffineTransformIdentity;
    } completion:NULL];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}




@end
