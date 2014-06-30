oxen
====

Observable collections in Objective-C 

oxen generates changesets when collections are modified. The main use-case for observable collections are when binding a collection to a UITableView or a UICollectionView.

Oxen changesets include the types of changes made to the collection and a snapshot of the collection after the changes hace been completed. This snapshot should be used as the backing object for table/collection views, and gives a stable model while updates are occurring.

```Objective-C
    self.array.onCollectionChanged = ^(id<OXNChangeInfo> change) {
    	self.itemsArray = change.currentArray;
        if ([change isKindOfClass:[OXNItemAddedChangeInfo class]]) {
        	[self.collectionView inserItemAtIndex:[NSIndexPath indexPathForItem:change.index inSection:1]];
        }
        ... handle other cases
    };
```

Because each oxen change creates a copy of the backing array, users are encouraged to batch updates.

```Objective-C
	[array performBatchUpdates:^{
        [array insertObject:@"" atIndex:1];
        [array removeObject:@"test"];
    }];
```

When batch operations occur, the collectionChanged block will be invoked with a OXNBatchChangeInfo that can be enumerated.

```Objective-C
	self.array.onCollectionChanged = ^(id<OXNChangeInfo> change) {
    	self.itemsArray = change.currentArray;
        if ([change isKindOfClass:[OXNBatchChangeInfo class]]) {
        	for (id<OXNChangeInfo> change in change.changes) {
        		... handle each change
        	}
        }
        ... handle other cases
    };
```
