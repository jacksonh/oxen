//
//  OXNObserver.h
//  oxen
//
//  Created by Jackson Harper on 8/12/14.
//  Copyright (c) 2014 Harper Semiconductors, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OXNChangeInfo;


@interface OXNObserver : NSObject

- (instancetype)initWithObject:(id)object andSelector:(SEL)selector;

- (void)sendChangeInfo:(id<OXNChangeInfo>)changeInfo;

@end
