//
//  OXNChangeInfo.m
//  Reactions
//
//  Created by Jackson Harper on 6/30/14.
//  Copyright (c) 2014 Harper Semiconductors, Inc
//

#import "OXNChangeInfo.h"

@interface OXNChangeInfo()

@property (strong, nonatomic, readwrite) NSArray *currentArray;

@end

@interface OXNBatchChangeInfo()

@property (strong, nonatomic, readwrite) NSArray *changes;

@end

@interface OXNItemAddedChangeInfo()

@property (strong, nonatomic, readwrite) id item;

@end

@interface OXNItemInsertedChangeInfo()

@property (strong, nonatomic, readwrite) id item;
@property (assign, nonatomic, readwrite) NSUInteger insertedAt;

@end

@interface OXNItemRemovedChangeInfo()

@property (strong, nonatomic, readwrite) id item;
@property (assign, nonatomic, readwrite) NSUInteger removedAt;

@end

@interface OXNItemReplacedChangeInfo()

@property (strong, nonatomic, readwrite) id item;
@property (strong, nonatomic, readwrite) id oldItem;
@property (assign, nonatomic, readwrite) NSUInteger replacedAt;

@end


@implementation OXNChangeInfo

- (instancetype)initWithCurrentArray:(NSArray *)array
{
    self = [super init];
    if (self) {
        _currentArray = [array copy];
    }
    return self;
}

@end


@implementation OXNBatchChangeInfo

- (instancetype)initWithChanges:(NSArray *)changes andCurrentArray:(NSArray *)array
{
    self = [super initWithCurrentArray:array];
    if (self) {
        _changes = [changes copy];
    }
    return self;
}

@end


@implementation OXNItemAddedChangeInfo

- (instancetype)initWithItem:(id)item andCurrentArray:(NSArray *)array
{
    self = [super initWithCurrentArray:array];
    if (self) {
        _item = [item copy];
    }
    return self;
}

@end

@implementation OXNResetChangeInfo

@end

@implementation OXNItemInsertedChangeInfo

- (instancetype)initWithItem:(id)item insertedAtIndex:(NSUInteger)index andCurrentArray:(NSArray *)array
{
    self = [super initWithCurrentArray:array];
    if (self) {
        _item = [item copy];
        _insertedAt = index;
    }
    return self;
}

@end


@implementation OXNItemRemovedChangeInfo

- (instancetype)initWithItem:(id)item removedAtIndex:(NSUInteger)index andCurrentArray:(NSArray *)array
{
    self = [super initWithCurrentArray:array];
    if (self) {
        _item = [item copy];
        _removedAt = index;
    }
    return self;
}

@end


@implementation OXNItemReplacedChangeInfo

- (instancetype)initWithOldItem:(id)oldItem newItem:(id)newItem replacedAtIndex:(NSUInteger)index andCurrentArray:(NSArray *)array
{
    self = [super initWithCurrentArray:array];
    if (self) {
        _oldItem = [oldItem copy];
        _item = [newItem copy];
        _replacedAt = index;
    }
    return self;
}

@end



