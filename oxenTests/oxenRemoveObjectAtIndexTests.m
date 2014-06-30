//
//  oxenRemoveObjectAtIndexTests.m
//  oxen
//
//  Created by Jackson Harper on 6/30/14.
//  Copyright (c) 2014 Harper Semiconductors, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "OXNObservableArray.h"


@interface oxenRemoveObjectAtIndexTests : XCTestCase

@property (strong, nonatomic) NSString *object;
@property (strong, nonatomic) OXNObservableArray *array;

@end

@implementation oxenRemoveObjectAtIndexTests

- (void)setUp
{
    self.array = [[OXNObservableArray alloc] init];
    for (int i = 0; i < 10; i++) {
        [self.array addObject:[@(i) stringValue]];
    }
}


- (void)test_removeObjectAtIndex_invokesCollectionChanged
{
    __block BOOL invoked = NO;
    self.array.onCollectionChanged = ^(id<OXNChangeInfo> change) {
        invoked = YES;
    };
    [self.array removeObjectAtIndex:2];

    NSAssert(invoked, @"collection changed invoked");
}

- (void)test_removeObject_createsRemovedChangeInfo
{
    self.array.onCollectionChanged = ^(OXNChangeInfo *change) {
        NSCAssert([change isKindOfClass:[OXNItemRemovedChangeInfo class]], @"change type");
    };

    [self.array removeObjectAtIndex:2];
}

- (void)test_removeObjectAtIndex_setsItemInRemovedChangeInfo
{
    self.array.onCollectionChanged = ^(OXNItemRemovedChangeInfo *change) {
        NSCAssert([@"2" isEqual:change.item], @"removed item");
    };

    [self.array removeObjectAtIndex:2];
}

- (void)test_removeObjectAtIndex_setsIndexInAddItemChangeInfo
{
    id other = @"other";
    [self.array addObject:other];
    
    self.array.onCollectionChanged = ^(OXNItemRemovedChangeInfo *change) {
        NSCAssert(change.removedAt == 2, @"removed item index");
    };
    
    [self.array removeObjectAtIndex:2];
}

@end
