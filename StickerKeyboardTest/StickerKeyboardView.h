//
//  StickerKeyboardView.h
//  Fring
//
//  Created by Yehonatan Yochpaz on 5/11/15.
//  Copyright (c) 2015 fring. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class StickerKeyboardView;

#warning Ostap - documentation please
@protocol StickerKeyboardViewDelegate <NSObject>
@optional

- (void)stickerKeyboardView:(StickerKeyboardView *)stickerKeyboardView didSelectStickerPackageAtIndex:(NSUInteger)index;
- (void)stickerKeyboardViewDidSelectRecentTab:(StickerKeyboardView *)stickerKeyboardView;
- (void)stickerKeyboardView:(StickerKeyboardView *)stickerKeyboardView didSelectStickerAtIndexPath:(NSIndexPath *)indexPath;
- (void)stickerKeyboardView:(StickerKeyboardView *)stickerKeyboardView didSelectRecentStickerAtIndex:(NSUInteger)index;
- (void)stickerKeyboardViewDidTapOnMarketButton:(StickerKeyboardView *)stickerKeyboardView;

@end

@protocol StickerKeyboardViewDataSource <NSObject>
@required

- (NSUInteger)numberOfStickerPackagesInStickerKeyboadView:(StickerKeyboardView *)stickerKeyboardView;
- (NSUInteger)numberOfStickersInStickerKeyboadView:(StickerKeyboardView *)stickerKeyboardView forStickerPackageAtIndex:(NSUInteger)stickerPackageIndex;
- (NSUInteger)numberOfRecentStickersInStickerKeyboadView:(StickerKeyboardView *)stickerKeyboardView;

//- (UIImage *)stickerKeyboardView:(StickerKeyboardView *)stickerKeyboardView imageForStickerAtIndexPath:(NSIndexPath *)indexPath;
//- (UIImage *)stickerKeyboardView:(StickerKeyboardView *)stickerKeyboardView imageForRecentStickerAtIndex:(NSUInteger)index;
//- (UIImage *)stickerKeyboardView:(StickerKeyboardView *)stickerKeyboardView imageForStickerPackageAtIndex:(NSUInteger)index;
- (CGSize)stickerKeyboardView:(StickerKeyboardView *)stickerKeyboardView sizeForStickerImageAtIndexPath:(NSIndexPath *)indexPath;
- (CGSize)stickerKeyboardView:(StickerKeyboardView *)stickerKeyboardView sizeForRecentStickerImageAtIndex:(NSUInteger)index;

//Async methods
- (void)stickerKeyboardView:(StickerKeyboardView *)stickerKeyboardView imageForStickerAtIndexPath:(NSIndexPath *)indexPath responseCallback:(void(^)(UIImage * image))responseCallback;
- (void)stickerKeyboardView:(StickerKeyboardView *)stickerKeyboardView imageForRecentStickerAtIndex:(NSUInteger)index responseCallback:(void(^)(UIImage * image))responseCallback;
- (void)stickerKeyboardView:(StickerKeyboardView *)stickerKeyboardView imageForStickerPackageAtIndex:(NSUInteger)index responseCallback:(void(^)(UIImage * image))responseCallback;

@end


@interface StickerKeyboardView : UIView

@property (nonatomic, weak) id <StickerKeyboardViewDelegate> delegate;
@property (nonatomic, weak) id <StickerKeyboardViewDataSource> dataSouce;

- (void)refresh;

@end