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
        NSArray *one = @[@"72",@"72",@"72",@"72",@"72",@"72"];
        NSArray *two = @[@"72",@"72",@"72",@"72",@"72",@"72"];
        NSArray *three = @[@"72",@"72",@"72",@"72",@"72",@"72"];
        NSArray *four = @[@"72",@"72",@"72",@"72",@"72",@"72"];
        
        self.nameSectionArray = @[one,two,three,four];
    }
    
    return self;
}

@end
