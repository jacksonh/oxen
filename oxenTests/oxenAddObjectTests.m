//
//  oxenAddObjectTests.m
//  oxenTests
//
//  Created by Jackson Harper on 6/30/14.
//  Copyright (c) 2014 Harper Semiconductors, Inc.
//

#import <XCTest/XCTest.h>

#import "OXNObservableArray.h"

@interface oxenAddObjectTests : XCTestCase

@end

@implementation oxenAddObjectTests


- (void)test_addObject_invokesCollectionChanged
{
    OXNObservableArray *array = [[OXNObservableArray alloc] init];
    __block BOOL invoked = NO;

    array.onCollectionChanged = ^(OXNChangeInfo *change) {
        invoked = YES;
    };
    
    [array addObject:@""];
    NSAssert(invoked, @"collection changed invoked");
}

- (void)test_addObject_createsAddItemChangeInfo
{
    OXNObservableArray *array = [[OXNObservableArray alloc] init];

    array.onCollectionChanged = ^(OXNChangeInfo *change) {
        NSAssert([change isKindOfClass:[OXNItemAddedChangeInfo class]], @"change type");
    };
 
    [array addObject:@""];
}

- (void)test_addObject_setsItemInAddItemChangeInfo
{
    OXNObservableArray *array = [[OXNObservableArray alloc] init];
    
    array.onCollectionChanged = ^(OXNItemAddedChangeInfo *change) {
        NSAssert([change.item isEqualToString:@"__test string__"], @"item value");
    };
    
    [array performBatchUpdates:^{
        [array insertObject:@"" atIndex:1];
        [array removeObject:@"test"];
    }];
    [array addObject:@"__test string__"];
}

@end

