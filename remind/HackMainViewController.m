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

NSString *reuseIdentifier = @"reuseCell";

@implementation HackMainViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self.navigationController setNavigationBarHidden:YES];
    self.memoData = [HackMemoData sharedInstance];
    
    [self setupCollectionView];
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
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[HackCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    //
    self.collectionView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.collectionView];
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
    return CGSizeMake(100, 130);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 20, 20, 20);
}
@end
