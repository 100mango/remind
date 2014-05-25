//
//  HackMainViewController.m
//  remind
//
//  Created by Mango on 14-5-22.
//  Copyright (c) 2014年 Mango. All rights reserved.
//

#import "HackMainViewController.h"
#import "HackCollectionViewCell.h"
#import "HackEditViewController.h"
#import "HackMemoData.h"

@interface HackMainViewController ()

@property (strong,nonatomic) UICollectionView *collectionView;
@property (strong,nonatomic) HackMemoData *memoData;

@end

static NSString *reuseIdentifier = @"reuseCell";

@implementation HackMainViewController

//设置状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self.navigationController setNavigationBarHidden:YES];
    self.memoData = [HackMemoData sharedInstance];
    
    UIImageView *backGround = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"便签2 背景"]];
    [self.view addSubview:backGround];
    
    [self setupCollectionView];
    [self setupGestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -setupView

- (void)setupCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 36/2;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(40/2, 88/2, 560/2, 668/2)
                                        collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[HackCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.scrollEnabled = NO;
    
    [self.view addSubview:self.collectionView];
}

#pragma mark -setupGestureRecognizer
- (void)setupGestureRecognizer
{
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(backTSaveUI)];
    recognizer.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:recognizer];
}

#pragma mark -handle Touch Event
- (void)backTSaveUI
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -Collection View Data Source

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.memoData.nameSectionArray.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[self.memoData.nameSectionArray objectAtIndex:section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HackCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSString *imageName = [[self.memoData.nameSectionArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    [cell setCellWithIconName:imageName];
    return cell;
}

#pragma mark -Collection View delegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *imageName = [[[[HackMemoData sharedInstance] nameSectionArray] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    HackEditViewController *viewController = [[HackEditViewController alloc]init];
    [self presentViewController:viewController animated:YES completion:^{
        [viewController updateControllerWithIconName:imageName];
    }];
}

#pragma mark -Flowlayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(140/2, 140/2);
}

/*
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 20, 20, 20);
}
 */
@end
