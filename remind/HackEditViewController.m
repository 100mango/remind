//
//  HackEditViewController.m
//  remind
//
//  Created by Mango on 14-5-24.
//  Copyright (c) 2014年 Mango. All rights reserved.
//

#import "HackEditViewController.h"
#import "AFNetworking.h"

@interface HackEditViewController ()

@property (strong,nonatomic) UIImageView *iconView;
@property (strong,nonatomic) UITextField *titleField;
@property (strong,nonatomic) UITextView *textView;
@property (strong,nonatomic) AFHTTPRequestOperationManager *manager;
@end

@implementation HackEditViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [self setupButtons];
    [self setupIconView];
    [self setupTitleAndContentView];
    [self setupGestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateControllerWithIconName:(NSString*)name
{
    self.iconView.image = [UIImage imageNamed:name];
    self.titleField.text = name;
}

#pragma mark -setupView
- (void)setupIconView
{
    _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 100, 100)];
    [self.view addSubview:self.iconView];
}

- (void)setupTitleAndContentView
{
    _titleField = [[UITextField alloc]initWithFrame:CGRectMake(20, 120, 200, 50)];
    self.titleField.placeholder = @"请输入标题";
    [self.view addSubview:self.titleField];
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(20, 150, 320, 200)];
    [self.view addSubview:self.textView];
}

#pragma mark -setupButton
- (void)setupButtons
{
    UIButton *addToHomeScrrenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addToHomeScrrenButton addTarget:self action:@selector(addToHomeScreen) forControlEvents:UIControlEventTouchUpInside];
    addToHomeScrrenButton.frame = CGRectMake(0, 430, 320, 30);
    addToHomeScrrenButton.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:addToHomeScrrenButton];
}

#pragma mark -setupGestureRecognizer

- (void)setupGestureRecognizer
{
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(backToIconUI)];
    recognizer.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:recognizer];
}

#pragma mark -handle Event
- (void)backToIconUI
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)addToHomeScreen
{
    NSDictionary *parameters = @{@"pic_id":@"1",@"title":@"asd",@"content":@"nihao"};
    
    [self.manager POST:@"http://hackday213.duapp.com/add.php" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSString *URL = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",URL);
        //NSLog(@"%d",[[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"http://www.baidu.com"]]);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://hackday213.duapp.com/search.php?id=10"]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}
@end
