//
//  OXNObservableArray.h
//  Reactions
//
//  Created by Jackson Harper on 6/29/14.
//  Copyright (c) 2014 Harper Semiconductors, Inc
//

#import <Foundation/Foundation.h>

@class RACSignal;

@interface OXNObservableArray : NSObject

- (void)addObject:(id)item;
- (void)performBatchUpdates:(void (^)(void))updates;

//
// A signal of OXNChangeInfo objects, representing changes
// to the underlying array.
//
@property (strong, nonatomic, readonly) RACSignal *changes;

@end
