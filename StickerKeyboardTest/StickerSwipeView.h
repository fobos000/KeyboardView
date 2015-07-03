//
//  StickerSwipeView.h
//  StickerKeyboardTest
//
//  Created by Ostap Horbach on 7/1/15.
//  Copyright (c) 2015 Ostap Horbach. All rights reserved.
//

#import "SwipeView.h"

@class StickerSwipeView;

@protocol StickerSwipeViewDataSource <NSObject>

- (NSInteger)numberOfItemsInSwipeView:(StickerSwipeView *)swipeView;
- (UIView *)swipeView:(StickerSwipeView *)swipeView viewForItemAtIndex:(NSInteger)index;

@end

@protocol StickerSwipeViewDelegate <NSObject>

- (void)swipeView:(StickerSwipeView *)swipeView didSwipeToItemAtIndex:(NSInteger)index;

@end

@interface StickerSwipeView : UIView

@property (nonatomic, weak) IBOutlet id<StickerSwipeViewDataSource> dataSource;
@property (nonatomic, weak) IBOutlet id<StickerSwipeViewDelegate> delegate;

- (void)reloadData;
- (void)scrollToItemAtIndex:(NSUInteger)index;


@end
