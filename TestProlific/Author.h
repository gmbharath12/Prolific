//
//  Author.h
//  TestProlific
//
//  Created by Bharath G M on 2/3/15.
//  Copyright (c) 2015 Bharath G M. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Author : NSObject

@property (nonatomic,strong)    NSString *authorName;
@property (nonatomic,strong)    NSString *categories;
@property (nonatomic,strong)    NSString *lastCheckOut;
@property (nonatomic,strong)    NSString *lastCheckOutBy;
@property (nonatomic,strong)    NSString *publisher;
@property (nonatomic,strong)    NSString *title;
@property (nonatomic,strong)    NSString *url;

@end
