//
//  OXNObserver.m
//  oxen
//
//  Created by Jackson Harper on 8/12/14.
//  Copyright (c) 2014 Harper Semiconductors, Inc. All rights reserved.
//

#import "OXNObserver.h"

@interface OXNObserver()

@property (weak, nonatomic) id object;
@property (assign, nonatomic) SEL selector;

@end


@implementation OXNObserver

- (instancetype)initWithObject:(id)object andSelector:(SEL)selector
{
	self = [super init];
	if (self) {
		_object = object;
		_selector = selector;

#if DEBUG
		NSMethodSignature *signature = [self.object methodSignatureForSelector:self.selector];
		NSAssert (signature.numberOfArguments == 3, @"Observer method signature argument count");
		NSAssert (signature.methodReturnLength == 0, @"Observer methods must return void");
#endif
	}
	return self;
}

- (void)sendChangeInfo:(id<OXNChangeInfo>)changeInfo
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
	[self.object performSelector:self.selector withObject:changeInfo];
#pragma clang diagnostic pop
}

@end
