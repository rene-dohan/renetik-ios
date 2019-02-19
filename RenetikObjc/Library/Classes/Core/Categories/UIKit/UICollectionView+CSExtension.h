//
// Created by Rene Dohan on 05/11/14.
// Copyright (c) 2014 Rene Dohan. All rights reserved.
//

@import UIKit;

@interface UICollectionView (CSExtension)

- (instancetype)setupCollection:(id <UICollectionViewDelegate, UICollectionViewDataSource>)parent;

- (__kindof UICollectionViewCell *)dequeueCell:(NSString *)identifier :(NSIndexPath *)path;

- (__kindof UICollectionViewCell *)dequeueCellForView:(Class)identifier :(NSIndexPath *)path;

- (instancetype)registerForCellView;

- (instancetype)registerEmptyCell:(Class)cellClass;

- (instancetype)registerEmptyHeader;

- (UICollectionViewCell *)cellView:(Class)viewClass :(NSIndexPath *)path :(void (^)(UICollectionViewCell *))onCreate;

- (__kindof UICollectionReusableView *)dequeEmptyHeader:(NSIndexPath *)path;

@end