//
//  StickerKeyboardView.h
//  Fring
//
//  Created by Yehonatan Yochpaz on 5/11/15.
//  Copyright (c) 2015 fring. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StickerKeyboardView;

@protocol StickerKeyboardViewDelegate <NSObject>
@required

- (void)stickerKeyboardView:(StickerKeyboardView *)stickerKeyboardView didSelectStickerPackageAtIndex:(NSUInteger)index;
- (void)stickerKeyboardViewDidSelectRecentTab:(StickerKeyboardView *)stickerKeyboardView;
- (void)stickerKeyboardView:(StickerKeyboardView *)stickerKeyboardView didSelectStickerAtIndex:(NSUInteger)index;

@end

@protocol StickerKeyboardViewDataSource <NSObject>
@required

- (NSUInteger)numberOfStickerPackagesInStickerKeyboadView:(StickerKeyboardView *)stickerKeyboardView;
- (NSUInteger)numberOfStickersInStickerKeyboadView:(StickerKeyboardView *)stickerKeyboardView forStickerPackageAtIndex:(NSUInteger)stickerPackageIndex;
- (NSUInteger)numberOfRecentStickersInStickerKeyboadView:(StickerKeyboardView *)stickerKeyboardView;

- (UIImage *)stickerKeyboardView:(StickerKeyboardView *)stickerKeyboardView imageForStickerAtIndexPath:(NSIndexPath *)indexPath;
- (UIImage *)stickerKeyboardView:(StickerKeyboardView *)stickerKeyboardView imageForRecentStickerAtIndexPath:(NSUInteger)index;
- (UIImage *)stickerKeyboardView:(StickerKeyboardView *)stickerKeyboardView imageForStickerPackageAtIndex:(NSUInteger)index;

@end


@interface StickerKeyboardView : UIView

@property (nonatomic, weak) id <StickerKeyboardViewDelegate> delegate;
@property (nonatomic, weak) id <StickerKeyboardViewDataSource> dataSouce;

@end




