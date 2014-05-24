//
//  HackMemoData.h
//  remind
//
//  Created by Mango on 14-5-24.
//  Copyright (c) 2014年 Mango. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HackMemoData : NSObject

@property (strong,readonly,nonatomic) NSArray *nameSectionArray;

+(HackMemoData *)sharedInstance;
@end
