//
//  oxenReplaceObjectAtIndex.m
//  oxen
//
//  Created by Jackson Harper on 6/30/14.
//  Copyright (c) 2014 Harper Semiconductors, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "OXNObservableArray.h"


@interface oxenReplaceObjectAtIndex : XCTestCase

@property (strong, nonatomic) NSString *object;
@property (strong, nonatomic) OXNObservableArray *array;

@end

@implementation oxenReplaceObjectAtIndex

- (void)setUp
{
    [super setUp];

    self.array = [[OXNObservableArray alloc] init];
    for (int i = 0; i < 10; i++) {
        [self.array addObject:[@(i) stringValue]];
    }
}

- (void)test_replaceObjectAtIndex_invokesCollectionChanged
{
    __block BOOL invoked = NO;
    self.array.onCollectionChanged = ^(id<OXNChangeInfo> change) {
        invoked = YES;
    };
    [self.array replaceObjectAtIndex:2 withObject:@""];
    
    NSAssert(invoked, @"collection changed invoked");
}

- (void)test_replaceObjectAtIndex_createsReplaceChangeInfo
{
    self.array.onCollectionChanged = ^(OXNChangeInfo *change) {
        NSCAssert([change isKindOfClass:[OXNItemReplacedChangeInfo class]], @"change type");
    };

    [self.array replaceObjectAtIndex:2 withObject:@""];
}

- (void)test_replaceObjectAtIndex_setsOldItemInReplaceChangeInfo
{
    self.array.onCollectionChanged = ^(OXNItemReplacedChangeInfo *change) {
        NSCAssert([@"2" isEqual:change.oldItem], @"old item");
    };

    [self.array replaceObjectAtIndex:2 withObject:@""];
}

- (void)test_replaceObjectAtIndex_setsItemInReplaceChangeInfo
{
    self.array.onCollectionChanged = ^(OXNItemReplacedChangeInfo *change) {
        NSCAssert([@"__test object__" isEqual:change.item], @"new item");
    };

    [self.array replaceObjectAtIndex:2 withObject:@"__test object__"];
}

- (void)test_replaceObjectAtIndex_setsReplacedAtIndexInReplaceChangeInfo
{
    self.array.onCollectionChanged = ^(OXNItemReplacedChangeInfo *change) {
        NSCAssert(change.replacedAt == 2, @"replacedAt index");
    };
    
    [self.array replaceObjectAtIndex:2 withObject:@""];
}
@end
