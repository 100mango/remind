//
//  HackSaveViewController.m
//  remind
//
//  Created by Mango on 14-5-24.
//  Copyright (c) 2014年 Mango. All rights reserved.
//

#import "HackSaveViewController.h"
#import "HackTableViewCell.h"
#import "HackMainViewController.h"

@interface HackSaveViewController ()

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSArray *iconNameArray;
@property (strong,nonatomic) NSArray *titleArray;
@property (strong,nonatomic) NSArray *contentArray;
@property (strong,nonatomic) UIButton *addNewbutton;
@end

static NSString *reuseIdentifier = @"reuseTableCell";


@implementation HackSaveViewController

//设置状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    
    UIImageView *backGroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"save背景"]];
    [self.view addSubview:backGroundView];
    
    [self setupTableView];
    [self setupButtons];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refleshTableView
{
    //取数据
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    _iconNameArray = [userDefault objectForKey:@"iconName"];
    _titleArray = [userDefault objectForKey:@"title"];
    _contentArray = [userDefault objectForKey:@"content"];
    //刷新数据
    [self.tableView reloadData];
}

#pragma mark -view
-(void)viewWillAppear:(BOOL)animated
{
    //取数据
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    _iconNameArray = [userDefault objectForKey:@"iconName"];
    _titleArray = [userDefault objectForKey:@"title"];
    _contentArray = [userDefault objectForKey:@"content"];
    //刷新数据
    [self.tableView reloadData];
}

#pragma mark -setupViews

- (void)setupTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 840/2)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[HackTableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    [self.view addSubview:self.tableView];
}
- (void)setupButtons
{
    _addNewbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addNewbutton addTarget:self action:@selector(addNewMemo) forControlEvents:UIControlEventTouchUpInside];
    self.addNewbutton.frame = CGRectMake(0, 840/2, 320, 60);
    [self.view addSubview:self.addNewbutton];
}

#pragma mark -handle Event
- (void)addNewMemo
{
    HackMainViewController *mainViewController =  [[HackMainViewController alloc]init];
    [self presentViewController:mainViewController animated:YES completion:nil];
}

#pragma mark -Table View dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%d",self.iconNameArray.count);
    return [self.iconNameArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HackTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell configureCellWithNumber:indexPath.row IconName:[self.iconNameArray objectAtIndex:indexPath.row] Titile:[self.titleArray objectAtIndex:indexPath.row]];
    return cell;
}
#pragma mark -Table View delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

@end
