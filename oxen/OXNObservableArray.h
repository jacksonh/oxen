//
//  OXNObservableArray.h
//  Reactions
//
//  Created by Jackson Harper on 6/29/14.
//  Copyright (c) 2014 Harper Semiconductors, Inc
//

#import <Foundation/Foundation.h>
#import "OXNChangeInfo.h"


@interface OXNObservableArray : NSMutableArray

- (void)performBatchUpdates:(void (^)(void))updates;
- (void)addObserver:(NSObject *)observer withSelector:(SEL)selector;

@property (nonatomic, copy) void (^onCollectionChanged)(id<OXNChangeInfo>);

@end
