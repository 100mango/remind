//
//  HackSaveViewController.m
//  remind
//
//  Created by Mango on 14-5-24.
//  Copyright (c) 2014年 Mango. All rights reserved.
//

#import "HackSaveViewController.h"

@interface HackSaveViewController ()

@property (strong,nonatomic) UITableView *tableView;
@end

@implementation HackSaveViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -setupViews

- (void)setupTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 400)];
}

@end
