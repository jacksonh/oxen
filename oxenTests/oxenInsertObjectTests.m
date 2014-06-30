//
//  oxenInsertObjectTests.m
//  oxen
//
//  Created by Jackson Harper on 6/30/14.
//  Copyright (c) 2014 Harper Semiconductors, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "OXNObservableArray.h"


@interface oxenInsertObjectTests : XCTestCase

@property (strong, nonatomic) NSString *object;
@property (strong, nonatomic) OXNObservableArray *array;

@end

@implementation oxenInsertObjectTests

- (void)setUp
{
    [super setUp];

    self.array = [[OXNObservableArray alloc] init];
    for (int i = 0; i < 10; i++) {
        [self.array addObject:[@(i) stringValue]];
    }
}


- (void)test_insertObjectAtIndex_invokesCollectionChanged
{
    __block BOOL invoked = NO;
    self.array.onCollectionChanged = ^(id<OXNChangeInfo> change) {
        invoked = YES;
    };
    [self.array insertObject:@"" atIndex:2];

    NSAssert(invoked, @"collection changed invoked");
}

- (void)test_insertObjectAtIndex_createsRemovedChangeInfo
{
    self.array.onCollectionChanged = ^(OXNChangeInfo *change) {
        NSCAssert([change isKindOfClass:[OXNItemInsertedChangeInfo class]], @"change type");
    };

    [self.array insertObject:@"" atIndex:2];
}

- (void)test_insertObjectAtIndex_setsItemInRemovedChangeInfo
{
    self.array.onCollectionChanged = ^(OXNItemInsertedChangeInfo *change) {
        NSCAssert([@"__test object__" isEqual:change.item], @"removed item");
    };

    [self.array insertObject:@"__test object__" atIndex:2];
}

- (void)test_insertObjectAtIndex_setsIndexInAddItemChangeInfo
{
    self.array.onCollectionChanged = ^(OXNItemInsertedChangeInfo *change) {
        NSCAssert(change.index == 2, @"removed item index");
    };

    [self.array insertObject:@"" atIndex:2];
}

@end
