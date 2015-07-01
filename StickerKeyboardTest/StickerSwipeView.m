//
//  StickerSwipeView.m
//  StickerKeyboardTest
//
//  Created by Ostap Horbach on 7/1/15.
//  Copyright (c) 2015 Ostap Horbach. All rights reserved.
//

#import "StickerSwipeView.h"
#import "SwipeView.h"

@interface StickerSwipeView () <SwipeViewDataSource, SwipeViewDelegate>

@property (nonatomic, strong) SwipeView *swipeView;

@property (nonatomic, strong) NSMutableArray *cachedViews;
@property (nonatomic) NSUInteger numberOfViews;
@property (nonatomic) NSUInteger numberOfCachedViews;

@end

@implementation StickerSwipeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _swipeView = [[SwipeView alloc] initWithFrame:frame];
        _swipeView.pagingEnabled = YES;
        _swipeView.itemsPerPage = 1;
    }
    return self;
}

//- (instancetype)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//        [self commonInit];
//    }
//    return self;
//}

//- (void)commonInit
//{
//    
//}

- (void)didMoveToWindow
{
    [super didMoveToWindow];
    
    if (!self.dataSource) {
        return;
    }
    
    self.numberOfViews = [self.dataSource numberOfItemsInSwipeView:self];
    [self setupCachedViews];
}

- (void)setupCachedViews
{
    _cachedViews = [NSMutableArray arrayWithCapacity:self.numberOfCachedViews];
    for (int i = 0; i < self.numberOfCachedViews; i++) {
        [_cachedViews addObject:[NSNull null]];
    }
}

#pragma mark - SwipeViewDataSource

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return self.numberOfViews;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    NSAssert(index < self.cachedViews.count, @"Invalid index");
    
    return self.cachedViews[index];
}

@end
