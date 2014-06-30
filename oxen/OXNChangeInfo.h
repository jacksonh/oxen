//
//  OXNChangeInfo.h
//  Reactions
//
//  Created by Jackson Harper on 6/30/14.
//  Copyright (c) 2014 Harper Semiconductors, Inc
//

#import <Foundation/Foundation.h>


@interface OXNChangeInfo : NSObject

@property (strong, nonatomic, readonly) NSArray *currentArray;

- (instancetype)initWithCurrentArray:(NSArray *)array;

@end


///
/// A batch of operations. Each item in the operations
/// array is of type OXNChangeInfo
///
@interface OXNBatchChangeInfo : OXNChangeInfo

@property (strong, nonatomic, readonly) NSArray *changes;

- (instancetype)initWithChanges:(NSArray *)changes andCurrentArray:(NSArray *)array;

@end

///
/// A single item was added to the collection
///
@interface OXNItemAddedChangeInfo : OXNChangeInfo

@property (strong, nonatomic, readonly) id item;

- (instancetype)initWithItem:(id)item andCurrentArray:(NSArray *)array;

@end

///
/// Significant changes have occurred and the collection should be totally reloaded
///
@interface OXNResetChangeInfo : OXNChangeInfo

@end


///
/// An item was inserted at the specified index
///
@interface OXNItemInsertedChangeInfo : OXNChangeInfo

@property (strong, nonatomic, readonly) id item;
@property (assign, nonatomic, readonly) NSUInteger insertedAt;

- (instancetype)initWithItem:(id)item insertedAtIndex:(NSUInteger)index andCurrentArray:(NSArray *)array;

@end


///
/// An item was removed from the collection
///
@interface OXNItemRemovedChangeInfo : OXNChangeInfo

@property (strong, nonatomic, readonly) id item;
@property (assign, nonatomic, readonly) NSUInteger removedAt;

- (instancetype)initWithItem:(id)item removedAtIndex:(NSUInteger)index andCurrentArray:(NSArray *)array;

@end


///
/// An item in the collection was replaced with a new item
///
@interface OXNItemReplacedChangeInfo : OXNChangeInfo

@property (strong, nonatomic, readonly) id oldItem;
@property (strong, nonatomic, readonly) id newItem;
@property (assign, nonatomic, readonly) NSUInteger replacedAt;

- (instancetype)initWithOldItem:(id)oldItem newItem:(id)newItem replacedAtIndex:(NSUInteger)index andCurrentArray:(NSArray *)array;

@end




