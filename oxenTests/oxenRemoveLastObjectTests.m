//
//  oxenRemoveLastObjectTests.m
//  oxen
//
//  Created by Jackson Harper on 6/30/14.
//  Copyright (c) 2014 Harper Semiconductors, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OXNObservableArray.h"

@interface oxenRemoveLastObjectTests : XCTestCase

@property (strong, nonatomic) NSString *object;
@property (strong, nonatomic) OXNObservableArray *array;

@end

@implementation oxenRemoveLastObjectTests

- (void)setUp
{
    self.array = [[OXNObservableArray alloc] init];
    for (int i = 0; i < 10; i++) {
        [self.array addObject:[@(i) stringValue]];
    }
}


- (void)test_removeLastObject_invokesCollectionChanged
{
    __block BOOL invoked = NO;
    self.array.onCollectionChanged = ^(id<OXNChangeInfo> change) {
        invoked = YES;
    };
    [self.array removeLastObject];

    NSAssert(invoked, @"collection changed invoked");
}

- (void)test_removeLastObject_createsRemovedChangeInfo
{
    self.array.onCollectionChanged = ^(OXNChangeInfo *change) {
        NSCAssert([change isKindOfClass:[OXNItemRemovedChangeInfo class]], @"change type");
    };

    [self.array removeLastObject];
}

- (void)test_removeObjectAtIndex_setsItemInRemovedChangeInfo
{
    id other = @"__last object__";
    [self.array addObject:other];

    self.array.onCollectionChanged = ^(OXNItemRemovedChangeInfo *change) {
        NSCAssert([@"__last object__" isEqual:change.item], @"removed item");
    };

    [self.array removeLastObject];
}

- (void)test_removeObjectAtIndex_setsIndexInAddItemChangeInfo
{
    self.array.onCollectionChanged = ^(OXNItemRemovedChangeInfo *change) {
        NSCAssert(change.index == 9, @"removed item index");
    };

    [self.array removeLastObject];
}

@end
