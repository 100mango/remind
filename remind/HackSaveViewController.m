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
@property (strong,nonatomic) NSMutableArray *iconNameArray;
@property (strong,nonatomic) NSMutableArray *titleArray;
@property (strong,nonatomic) NSMutableArray *contentArray;
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
    _iconNameArray = [[userDefault objectForKey:@"iconName"] mutableCopy];
    _titleArray = [[userDefault objectForKey:@"title"] mutableCopy];
    _contentArray = [[userDefault objectForKey:@"content"] mu];
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


//删除选择列，更新颜色值数组
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.iconNameArray removeObjectAtIndex:indexPath.row];
    [self.titleArray removeObjectAtIndex:indexPath.row];
    [self.contentArray removeObjectAtIndex:indexPath.row];
    //保存进本地
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:self.iconNameArray forKey:@"iconName"];
    [userDefault setObject:self.titleArray forKey:@"title"];
    [userDefault setObject:self.contentArray forKey:@"content"];
    [userDefault synchronize];
    
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark -Table View delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

// 返回cell editing的样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
@end
