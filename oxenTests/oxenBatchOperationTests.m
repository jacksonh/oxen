//
//  oxenBatchOperationTests.m
//  oxen
//
//  Created by Jackson Harper on 8/12/14.
//  Copyright (c) 2014 Harper Semiconductors, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "OXNObservableArray.h"


@interface oxenBatchOperationTests : XCTestCase

@property (strong, nonatomic) OXNObservableArray *array;

@end


@implementation oxenBatchOperationTests

- (void)setUp
{
    [super setUp];

	self.array = [[OXNObservableArray alloc] init];
}

- (void)test_addObjectInBatch_hasCorrectChangeCount
{
	__block NSInteger changesCount = 0;

	self.array.onCollectionChanged = ^(OXNBatchChangeInfo *change) {
		changesCount = change.changes.count;
	};

	[self.array performBatchUpdates:^{
		[self.array addObject:@""];
		[self.array addObject:@""];
	}];

	XCTAssertEqual(changesCount, 2, @"Number of changes in batch");
}

- (void)test_addObjectsFromArray_createsBatchWithCorrectCount
{
	__block NSInteger changesCount = 0;

	self.array.onCollectionChanged = ^(OXNBatchChangeInfo *change) {
		changesCount = change.changes.count;
	};

	[self.array addObjectsFromArray:@[ @"", @"" ]];

	XCTAssertEqual(changesCount, 2, @"Number of changes in batch");
}

- (void)test_removeObjectInBatch_hasCorrectChangeCount
{
	__block NSInteger changesCount = 0;
	id obj1 = @"one";
	id obj2 = @"two";

	[self.array addObjectsFromArray:@[ obj1, obj2 ]];

	self.array.onCollectionChanged = ^(OXNBatchChangeInfo *change) {
		changesCount = change.changes.count;
	};

	[self.array performBatchUpdates:^{
		[self.array removeObject:obj1];
		[self.array removeObject:obj2];
	}];

	XCTAssertEqual (changesCount, 2, @"Number of changes in batch");
}

- (void)test_removeObjectsInArray_createsBatchWithCorrectCount
{
	__block NSInteger changesCount = 0;
	id obj1 = @"one";
	id obj2 = @"two";

	[self.array addObjectsFromArray:@[ obj1, obj2 ]];

	self.array.onCollectionChanged = ^(OXNBatchChangeInfo *change) {
		changesCount = change.changes.count;
	};

	[self.array removeObjectsInArray:@[ obj1, obj2 ]];

	XCTAssertEqual (changesCount, 2, @"Number of changes in batch");
}

- (void)test_addObjectsFromArrayWhilePerformingBatch_hasCorrectChangeCount
{
	__block NSInteger changesCount = 0;

	self.array.onCollectionChanged = ^(OXNBatchChangeInfo *change) {
		changesCount += change.changes.count;
	};

	[self.array performBatchUpdates:^{
		[self.array addObjectsFromArray:@[ @"", @"", @"" ]];
		[self.array removeObjectAtIndex:0];
	}];

	XCTAssertEqual(changesCount, 4, @"Number of changes in batch");
}

@end
