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
@property (strong,nonatomic) NSString *iconName;
@property (strong,nonatomic) AFHTTPRequestOperationManager *manager;
@property (strong,nonatomic) UIButton *finishButton;
//
//@property (strong,nonatomic) NSLayoutManager *layoutManager;
@end

@implementation HackEditViewController

//设置状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //_layoutManager = [[NSLayoutManager alloc]init];
    //self.layoutManager.delegate = self;
    [self setupBackground];
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
    self.iconName = name;
    self.iconView.image = [UIImage imageNamed:name];
   // self.titleField.text = name;
}

#pragma mark -View delegate
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.textView resignFirstResponder];
}

#pragma mark -setupView

- (void)setupBackground
{
    UIImageView *backGroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"便签3 背景"]];
    [self.view addSubview:backGroundView];
}

- (void)setupIconView
{
    _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(250/2, 192/2, 140/2, 140/2)];
    [self.view addSubview:self.iconView];
}

- (void)setupTitleAndContentView
{
    _titleField = [[UITextField alloc]initWithFrame:CGRectMake(200/2, 374/2, 240/2, 38/2)];
    self.titleField.delegate = self;;
    self.titleField.textColor = [UIColor colorWithRed:119/255.0 green:82/255.0 blue:42/255.0 alpha:1];
    self.titleField.placeholder = @"请输入标题";
    self.titleField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.titleField];
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(68/2, 445/2, 504/2, 170/2)];
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.font = [UIFont systemFontOfSize:18];
    self.textView.textColor = [UIColor colorWithRed:119/255.0 green:82/255.0 blue:42/255.0 alpha:1];
    self.textView.delegate = self;
    [self.view addSubview:self.textView];
}

#pragma mark -setupButton

- (void)setupButtons
{
    _finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.finishButton setImage:[UIImage imageNamed:@"完成键"] forState:UIControlStateNormal];
    [self.finishButton addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    self.finishButton.frame = CGRectMake(40/2, 720/2, 560/2, 88/2);
    [self.view addSubview:self.finishButton];
    
    UIButton *addToHomeScrrenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addToHomeScrrenButton addTarget:self action:@selector(saveAndAddToHomeScreen) forControlEvents:UIControlEventTouchUpInside];
    addToHomeScrrenButton.frame = CGRectMake(40, 840/2, 320, 120/2);
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

- (void)finish
{
    // 本地保存
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSArray *iconNameArray = [userDefault objectForKey:@"iconName"];
    NSArray *titleArray = [userDefault objectForKey:@"title"];
    NSArray *contentArray = [userDefault objectForKey:@"content"];
    if (iconNameArray == nil)
    {
        iconNameArray = @[self.iconName];
        titleArray = @[self.titleField.text];
        contentArray =@[self.textView.text];
        
        [userDefault setObject:iconNameArray forKey:@"iconName"];
        [userDefault setObject:titleArray forKey:@"title"];
        [userDefault setObject:contentArray forKey:@"content"];
    }
    else
    {
        NSMutableArray *newIconNameArray = [iconNameArray mutableCopy];
        [newIconNameArray addObject:self.iconName];
        NSMutableArray *newTitle = [titleArray mutableCopy];
        [newTitle addObject:self.titleField.text];
        NSMutableArray *newContentArray = [contentArray mutableCopy];
        [newContentArray addObject:self.textView.text];
        
        [userDefault setObject:newIconNameArray forKey:@"iconName"];
        [userDefault setObject:newTitle forKey:@"title"];
        [userDefault setObject:newContentArray forKey:@"content"];
    }
    [userDefault synchronize];
    
    //跳转回
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveAndAddToHomeScreen
{
    // 本地保存
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSArray *iconNameArray = [userDefault objectForKey:@"iconName"];
    NSArray *titleArray = [userDefault objectForKey:@"title"];
    NSArray *contentArray = [userDefault objectForKey:@"content"];
    if (iconNameArray == nil)
    {
        iconNameArray = @[self.iconName];
        titleArray = @[self.titleField.text];
        contentArray =@[self.textView.text];
        
        [userDefault setObject:iconNameArray forKey:@"iconName"];
        [userDefault setObject:titleArray forKey:@"title"];
        [userDefault setObject:contentArray forKey:@"content"];
    }
    else
    {
        NSMutableArray *newIconNameArray = [iconNameArray mutableCopy];
        [newIconNameArray addObject:self.iconName];
        NSMutableArray *newTitle = [titleArray mutableCopy];
        [newTitle addObject:self.titleField.text];
        NSMutableArray *newContentArray = [contentArray mutableCopy];
        [newContentArray addObject:self.textView.text];
        
        [userDefault setObject:newIconNameArray forKey:@"iconName"];
        [userDefault setObject:newTitle forKey:@"title"];
        [userDefault setObject:newContentArray forKey:@"content"];
    }
    [userDefault synchronize];

    //Post请求生成动态页面
    NSDictionary *parameters = @{@"pic_id":self.iconName,@"title":self.titleField.text,@"content":self.textView.text};
    [self.manager POST:@"http://hackday213.duapp.com/add.php" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        
        //跳转safari
        NSString *id = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        //去掉首尾空格
        NSString *newId = [id stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        //生成URL
        NSString *newURL = [NSString stringWithFormat:@"http://hackday213.duapp.com/index.php?id=%@",newId];
        NSLog(@"%@",newURL);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:newURL]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

#pragma mark -TextView delegate
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    CGRect newFrame = self.view.frame;
    newFrame.origin.y -= 80;
    self.view.frame = newFrame;
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    CGRect newFrame = self.view.frame;
    newFrame.origin.y += 80;
    self.view.frame =newFrame;
    return YES;
}

#pragma mark -TextField delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    CGRect newFrame = self.view.frame;
    newFrame.origin.y -= 80;
    self.view.frame = newFrame;
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    CGRect newFrame = self.view.frame;
    newFrame.origin.y += 80;
    self.view.frame =newFrame;
    return YES;
}

@end
