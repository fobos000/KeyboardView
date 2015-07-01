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



@end

@interface StickerSwipeView : UIView

@property (nonatomic, weak) id<StickerSwipeViewDataSource> dataSource;
@property (nonatomic, weak) id<StickerSwipeViewDelegate> delegate;

@end
