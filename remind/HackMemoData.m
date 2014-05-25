//
//  HackMemoData.m
//  remind
//
//  Created by Mango on 14-5-24.
//  Copyright (c) 2014年 Mango. All rights reserved.
//

#import "HackMemoData.h"

@interface HackMemoData ()

@property (strong,nonatomic) NSArray *nameSectionArray;


@end

@implementation HackMemoData

+(HackMemoData *)sharedInstance
{
    static HackMemoData *_sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[HackMemoData alloc] init];
        
    });
    return _sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self != nil) {
        NSArray *one = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15"];
        
        self.nameSectionArray = @[one];
    }
    
    return self;
}

@end
