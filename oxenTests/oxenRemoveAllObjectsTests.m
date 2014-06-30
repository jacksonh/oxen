//
//  oxenRemoveAllObjectsTests.m
//  oxen
//
//  Created by Jackson Harper on 6/30/14.
//  Copyright (c) 2014 Harper Semiconductors, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OXNObservableArray.h"


@interface oxenRemoveAllObjectsTests : XCTestCase

@property (strong, nonatomic) NSString *object;
@property (strong, nonatomic) OXNObservableArray *array;

@end

@implementation oxenRemoveAllObjectsTests

- (void)setUp
{
    self.array = [[OXNObservableArray alloc] init];
    for (int i = 0; i < 10; i++) {
        [self.array addObject:[@(i) stringValue]];
    }
}

- (void)test_removeAllObjects_invokesCollectionChanged
{
    __block BOOL invoked = NO;
    self.array.onCollectionChanged = ^(id<OXNChangeInfo> change) {
        invoked = YES;
    };
    [self.array removeAllObjects];

    NSAssert(invoked, @"collection changed invoked");
}

- (void)test_removeAllObjects_createsRemovedChangeInfo
{
    self.array.onCollectionChanged = ^(OXNChangeInfo *change) {
        NSCAssert([change isKindOfClass:[OXNResetChangeInfo class]], @"change type");
    };

    [self.array removeAllObjects];
}

@end
