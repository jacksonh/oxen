//
//  oxenRemoveObjectTests.m
//  oxen
//
//  Created by Jackson Harper on 6/30/14.
//  Copyright (c) 2014 Harper Semiconductors, Inc.
//

#import <XCTest/XCTest.h>

#import "OXNObservableArray.h"


@interface oxenRemoveObjectTests : XCTestCase

@property (strong, nonatomic) NSString *object;
@property (strong, nonatomic) OXNObservableArray *array;

@end

@implementation oxenRemoveObjectTests

- (void)setUp
{
    self.object = @"";
    self.array = [[OXNObservableArray alloc] init];
    [self.array addObject:self.object];
}

- (void)test_removeObject_invokesCollectionChanged
{
    __block BOOL invoked = NO;
    self.array.onCollectionChanged = ^(id<OXNChangeInfo> change) {
        invoked = YES;
    };
    [self.array removeObject:self.object];

    NSAssert(invoked, @"collection changed invoked");
}

- (void)test_removeObject_createsRemovedChangeInfo
{
    self.array.onCollectionChanged = ^(OXNChangeInfo *change) {
        NSCAssert([change isKindOfClass:[OXNItemRemovedChangeInfo class]], @"change type");
    };

    [self.array removeObject:self.object];
}

- (void)test_removeObject_setsItemInRemovedChangeInfo
{
    __weak __typeof(self) weakSelf = self;
    self.array.onCollectionChanged = ^(OXNItemRemovedChangeInfo *change) {
        NSCAssert([weakSelf.object isEqual:change.item], @"removed item");
    };

    [self.array removeObject:self.object];
}

- (void)test_removeObject_setsIndexInAddItemChangeInfo
{
    id other = @"other";
    [self.array addObject:other];

    self.array.onCollectionChanged = ^(OXNItemRemovedChangeInfo *change) {
        NSCAssert(change.index == 1, @"removed item index");
    };

    [self.array removeObject:other];
}


@end
