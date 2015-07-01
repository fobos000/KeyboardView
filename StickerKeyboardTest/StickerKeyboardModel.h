//
//  StickerKeyboardModel.h
//  Fring
//
//  Created by Ostap Horbach on 6/23/15.
//  Copyright (c) 2015 fring. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StickerKeyboardView.h"

@class StickerKeyboardModel;
@class Sticker;

@protocol StickerKeyboardModelDelegate <NSObject>

- (void)didSelectSticker:(Sticker *)sticker;
- (void)marketButtonTapped;

@end

@interface StickerKeyboardModel : NSObject <StickerKeyboardViewDataSource, StickerKeyboardViewDelegate>

@property (nonatomic, weak) id<StickerKeyboardModelDelegate> delegate;

@end
