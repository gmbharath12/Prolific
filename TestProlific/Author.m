//
//  Author.m
//  TestProlific
//
//  Created by Bharath G M on 2/3/15.
//  Copyright (c) 2015 Bharath G M. All rights reserved.
//

#import "Author.h"

@implementation Author

@synthesize authorName,description,publisher,lastCheckOut,lastCheckOutBy,categories,title,url;

- (id)init
{
    self = [super init];
    if (self)
    {
        authorName = nil;
        description = nil;
        publisher = nil;
        lastCheckOut = nil;
        lastCheckOutBy = nil;
        categories = nil;
        title = nil;
        url = nil;
    }
    return self;
}

@end
