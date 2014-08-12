//
//  oxenAddObserverMethodSignatureTests.m
//  oxen
//
//  Created by Jackson Harper on 8/12/14.
//  Copyright (c) 2014 Harper Semiconductors, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "OXNObservableArray.h"


@interface oxenAddObserverMethodSignatureTests : XCTestCase

@property (strong, nonatomic) OXNObservableArray *array;

@end


@implementation oxenAddObserverMethodSignatureTests

- (void)setUp
{
	[super setUp];
	
	self.array = [[OXNObservableArray alloc] init];
}

- (void)test_addObserverWithInvalidSignature_throws
{
	XCTAssertThrows([self.array addObserver:self withSelector:@selector(boolSelectorWithParam:)], @"return type");
	XCTAssertThrows([self.array addObserver:self withSelector:@selector(twoParamSelectorWithOne:andTwo:)], @"param count");
}

- (void)test_addObserverWithValidSignature_doesNotThrow
{
	XCTAssertNoThrow ([self.array addObserver:self withSelector:@selector(validSelectorWithChangeInfo:)], @"valid signature");
}


#pragma mark - dummy selectors

- (BOOL)boolSelectorWithParam:(id)arg
{
	return YES;
}

- (void)twoParamSelectorWithOne:(id)one andTwo:(id)two
{
}

- (void)validSelectorWithChangeInfo:(id)arg
{
}

@end
