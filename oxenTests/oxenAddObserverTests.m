//
//  oxenAddObserverTests.m
//  oxen
//
//  Created by Jackson Harper on 8/12/14.
//  Copyright (c) 2014 Harper Semiconductors, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "OXNObservableArray.h"

@interface oxenAddObserverTests : XCTestCase

@property (strong, nonatomic) OXNObservableArray *array;

@property (strong, nonatomic) id<OXNChangeInfo> observedChanges;
@property (strong, nonatomic) XCTestExpectation *observerExpectation;

@end

@implementation oxenAddObserverTests

- (void)setUp
{
    [super setUp];

	self.array = [[OXNObservableArray alloc] init];

	self.observedChanges = nil;
	self.observerExpectation = [self expectationWithDescription:@"observer"];

}

- (void)test_addObserverAndAddObject_invokesAddObserver
{
	[self.array addObserver:self withSelector:@selector(arrayUpdatedWithChanges:)];
	
	[self.array addObject:@""];
	[self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
		XCTAssertEqual([self.observedChanges class], [OXNItemAddedChangeInfo class], @"observed changes");
	}];
}

- (void)arrayUpdatedWithChanges:(id<OXNChangeInfo>)changes
{
	self.observedChanges = changes;
	[self.observerExpectation fulfill];
}

@end
