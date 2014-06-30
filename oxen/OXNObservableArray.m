//
//  OXNObservableArray.m
//
//  Created by Jackson Harper on 6/29/14.
//  Copyright (c) 2014 Harper Semiconductors, Inc
//

#import "OXNObservableArray.h"
#import "OXNChangeInfo.h"


@interface OXNObservableArray()

@property (strong, nonatomic) NSMutableArray *backing;

@property (assign, nonatomic) BOOL isBatching;
@property (strong, nonatomic) NSMutableArray *currentBatch;

@end


@implementation OXNObservableArray

- (instancetype)init
{
    self = [self initWithArray:@[]];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithArray:(NSArray *)array
{
    self = [super init];
    if (self) {
        _backing = [[NSMutableArray alloc] init];
        for (id item in array)
            [self addObject:item];
    }
    return self;
}

- (NSUInteger)count
{
    return self.backing.count;
}

- (id)objectAtIndex:(NSUInteger)index
{
    return [self.backing objectAtIndex:index];
}

- (void)emit:(id<OXNChangeInfo>)change
{
    if (self.onCollectionChanged)
        self.onCollectionChanged (change);
}

- (void)emitPending
{
    OXNChangeInfo *change = [[OXNBatchChangeInfo alloc] initWithChanges:self.currentBatch andCurrentArray:self.backing];
    [self.currentBatch removeAllObjects];
    [self emit:change];
}

- (void)performBatchUpdates:(void (^)(void))updates
{
    self.isBatching = YES;

    @try {
        updates ();
    }
    @finally {
        self.isBatching = NO;
    }
    
    
    [self emitPending];
}

- (void)addChange:(OXNChangeInfo *)change
{
    if (self.isBatching) {
        [self.currentBatch addObject:change];
    } else {
        [self emit:change];
    }
}

- (void)addObject:(id)item
{
    [self.backing addObject:item];
    [self addChange:[[OXNItemAddedChangeInfo alloc] initWithItem:item andCurrentArray:self.backing]];
}

- (void)removeAllObjects
{
    [self.backing removeAllObjects];
    [self addChange:[[OXNResetChangeInfo alloc] initWithCurrentArray:self.backing]];
}

- (void)insertObject:(id)object atIndex:(NSUInteger)index
{
    [self.backing insertObject:object atIndex:index];
    [self addChange:[[OXNItemInsertedChangeInfo alloc] initWithItem:object insertedAtIndex:index andCurrentArray:self.backing]];
}

- (void)removeObjectAtIndex:(NSUInteger)index
{
    id object = [self.backing objectAtIndex:index];

    [self.backing removeObjectAtIndex:index];
    [self addChange:[[OXNItemRemovedChangeInfo alloc] initWithItem:object removedAtIndex:index andCurrentArray:self.backing]];
}

- (void)removeLastObject
{
    NSInteger lastIndex = self.backing.count - 1;
    [self removeObjectAtIndex:lastIndex];
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)item
{
    id oldItem = [self.backing objectAtIndex:index];

    [self.backing replaceObjectAtIndex:index withObject:item];
    [self addChange:[[OXNItemReplacedChangeInfo alloc] initWithOldItem:oldItem newItem:item replacedAtIndex:index andCurrentArray:self.backing]];
}

@end
