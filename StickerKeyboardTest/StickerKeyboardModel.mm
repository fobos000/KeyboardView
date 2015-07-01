//
//  StickerKeyboardModel.m
//  Fring
//
//  Created by Ostap Horbach on 6/23/15.
//  Copyright (c) 2015 fring. All rights reserved.
//

#import "StickerKeyboardModel.h"

static NSString const * kStickerSize = @"size";
static NSString const * kStickerImage = @"image";

static NSString const * kPackageImage = @"image";
static NSString const * kPackageStickers = @"stickers";

typedef enum : NSUInteger {
    StickerSizeRegular,
    StickerSizeHalf,
} StickerSize;

@interface StickerKeyboardModel ()

@property (nonatomic, strong) NSArray *packages;

@end

@implementation StickerKeyboardModel

- (id)init
{
    self = [super init];
    if (self) {
        _packages = [self generatePackages];
    }
    return self;
}

- (NSArray *)generatePackages
{
    NSMutableArray *packages = [NSMutableArray array];
    
    int numberOfPackages = 10;
    for (int i = 0; i < numberOfPackages; i++) {
        [packages addObject:[self generatePackage]];
    }
    
    return packages;
}

- (NSDictionary *)generatePackage
{
    NSDictionary *package;
    
    package = @{kPackageImage: [UIImage imageNamed:@"packageImage"],
                kPackageStickers: [self generateStickers]};
    
    return package;
}

- (NSArray *)generateStickers
{
    NSMutableArray *stickers = [NSMutableArray array];
    
    int numberOfStickers = [self randomNumberInRange:15 to:20];
    for (int i = 0; i < numberOfStickers; i++) {
        [stickers addObject:[self generateSticker]];
    }
    
    return [NSArray arrayWithArray:stickers];
}

- (NSDictionary *)generateSticker
{
    NSDictionary *sticker;
    
    StickerSize sizeType = [self randomStickerSizeType];
    
    NSValue *sizeValue = [NSValue valueWithCGSize:[self stickerSizeForSizeType:sizeType]];
    UIImage *image = [self stickerImageWithSizeType:sizeType];
    
    sticker = @{kStickerImage: image,
                kStickerSize: sizeValue};
    
    return sticker;
}

- (CGSize)stickerSizeForSizeType:(StickerSize)sizeType
{
    // 164X164, 82X164
    if (sizeType == StickerSizeRegular) {
        return CGSizeMake(164, 164);
    } else {
        return CGSizeMake(82, 164);
    }
}

- (StickerSize)randomStickerSizeType
{
    if ([self randomNumberInRange:0 to:100] % 2) {
        return StickerSizeRegular;
    } else {
        return StickerSizeHalf;
    }
}

- (UIImage *)stickerImageWithSizeType:(StickerSize)size
{
    if (size == StickerSizeRegular) {
        return [UIImage imageNamed:@"stickerImaegRegular"];
    } else {
        return [UIImage imageNamed:@"stickerImaegHalf"];
    }
}

- (int)randomNumberInRange:(int)lowerBound to:(int)upperBound
{
    return lowerBound + arc4random() % (upperBound - lowerBound);
}

#pragma mark StickerKeyboardViewDataSource

- (NSUInteger)numberOfStickerPackagesInStickerKeyboadView:(StickerKeyboardView *)stickerKeyboardView
{
    return self.packages.count;
}

- (NSUInteger)numberOfRecentStickersInStickerKeyboadView:(StickerKeyboardView *)stickerKeyboardView
{
    return 0;
}

- (NSUInteger)numberOfStickersInStickerKeyboadView:(StickerKeyboardView *)stickerKeyboardView forStickerPackageAtIndex:(NSUInteger)stickerPackageIndex
{
    NSUInteger numberOfStickersInStickerKeyboadView = 0;
    if (stickerPackageIndex < self.packages.count) {
        NSDictionary *stickerPackage = self.packages[stickerPackageIndex];
        NSArray *stickers = stickerPackage[kPackageStickers];
        numberOfStickersInStickerKeyboadView = stickers.count;
    }
    return numberOfStickersInStickerKeyboadView;
}

- (void)stickerKeyboardView:(StickerKeyboardView *)stickerKeyboardView imageForStickerPackageAtIndex:(NSUInteger)index responseCallback:(void(^)(UIImage * image))responseCallback
{
    NSDictionary *package = self.packages[index];
    responseCallback(package[kPackageImage]);
}

- (void)stickerKeyboardView:(StickerKeyboardView *)stickerKeyboardView imageForStickerAtIndexPath:(NSIndexPath *)indexPath responseCallback:(void(^)(UIImage * image))responseCallback
{
    NSDictionary *sticker = [self stickerForIndexPath:indexPath];
    responseCallback(sticker[kStickerImage]);
}

- (void)stickerKeyboardView:(StickerKeyboardView *)stickerKeyboardView imageForRecentStickerAtIndex:(NSUInteger)index responseCallback:(void(^)(UIImage * image))responseCallback
{
    
}

- (CGSize)stickerKeyboardView:(StickerKeyboardView *)stickerKeyboardView sizeForStickerImageAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *sticker = [self stickerForIndexPath:indexPath];
    return [self sizeForSticker:sticker];
}

- (CGSize)stickerKeyboardView:(StickerKeyboardView *)stickerKeyboardView sizeForRecentStickerImageAtIndex:(NSUInteger)index
{
    return CGSizeZero;
}

#pragma mark StickerKeyboardViewDelegate

- (void)stickerKeyboardView:(StickerKeyboardView *)stickerKeyboardView didSelectStickerAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)stickerKeyboardView:(StickerKeyboardView *)stickerKeyboardView didSelectRecentStickerAtIndex:(NSUInteger)index
{
    
}

- (void)stickerKeyboardViewDidTapOnMarketButton:(StickerKeyboardView *)stickerKeyboardView
{
    
}

#pragma mark Helpers

- (NSDictionary *)stickerForIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *package = self.packages[indexPath.section];
    NSArray *stickers = package[kPackageStickers];
    NSDictionary *sticker = stickers[indexPath.item];
    return sticker;
}

- (CGSize)sizeForSticker:(NSDictionary *)sticker
{
    return [sticker[kStickerSize] CGSizeValue];
}

@end
