//
//  StickerSwipeView.m
//  StickerKeyboardTest
//
//  Created by Ostap Horbach on 7/1/15.
//  Copyright (c) 2015 Ostap Horbach. All rights reserved.
//

#import "StickerSwipeView.h"

@interface StickerSwipeView () <UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *swipeView;

@property (nonatomic, strong) NSMutableArray *cachedViews;
@property (nonatomic) NSUInteger numberOfViews;
@property (nonatomic) NSUInteger cacheRadius;
@property (nonatomic) NSInteger currentPage;

@end

@implementation StickerSwipeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSwipeView];
        
        _currentPage = 0;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupSwipeView];
    }
    return self;
}

- (void)setupSwipeView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.swipeView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    self.swipeView.pagingEnabled = YES;
    [self.swipeView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.swipeView setPagingEnabled:YES];
    self.swipeView.dataSource = self;
    self.swipeView.delegate = self;

    
    [self addSubview:self.swipeView];
    
    self.autoresizesSubviews = YES;
    
    NSDictionary *viewsDictionary = @{@"swipeView": self.swipeView};
    NSArray *constraint_POS_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[swipeView]-0-|"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:viewsDictionary];
    
    NSArray *constraint_POS_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[swipeView]-0-|"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:viewsDictionary];
    [self addConstraints:constraint_POS_H];
    [self addConstraints:constraint_POS_V];
    self.swipeView.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.swipeView.collectionViewLayout;
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setMinimumInteritemSpacing:0.0f];
    [flowLayout setMinimumLineSpacing:0.0f];
    [flowLayout setItemSize:self.bounds.size];
    
//    self.swipeView.frame = self.bounds;
}

//- (void)commonInit
//{
//    
//}

//- (void)didMoveToWindow
//{
//    [super didMoveToWindow];
//    
//
//}

//- (NSArray *)cachedViewsIndexes
//{
//    NSMutableArray *cachedViewsIndexes = [NSMutableArray array];
//    [cachedViewsIndexes addObject:@(self.currentPage)];
//    
//    
//}
//
//- (void)setupCachedViews
//{
//    _cachedViews = [NSMutableArray arrayWithCapacity:self.numberOfCachedViews];
//    for (int i = 0; i < self.numberOfCachedViews; i++) {
//        [_cachedViews addObject:[NSNull null]];
//    }
//    
//    
//}

- (void)reloadData
{
    [self.swipeView reloadData];
}

- (void)scrollToItemAtIndex:(NSUInteger)index
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [self.swipeView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataSource numberOfItemsInSwipeView:self];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [self.swipeView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    UIView *viewForIndex = [self.dataSource swipeView:self viewForItemAtIndex:indexPath.item];
    [cell.contentView addSubview:viewForIndex];
    
    return cell;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self didScroll];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self didScroll];
}

- (void)didScroll
{
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.swipeView.collectionViewLayout;
    
    NSInteger currentIndex = (self.swipeView.contentOffset.x) / layout.itemSize.width;
    if ([self.delegate respondsToSelector:@selector(swipeView:didSwipeToItemAtIndex:)]) {
        [self.delegate swipeView:self didSwipeToItemAtIndex:currentIndex];
    }
}

@end
