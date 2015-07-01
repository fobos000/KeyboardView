//
//  StickerRecentTabCell.m
//  Fring
//
//  Created by Ostap Horbach on 6/23/15.
//  Copyright (c) 2015 fring. All rights reserved.
//

#import "StickerRecentTabCell.h"

@implementation StickerRecentTabCell

-(void)setActive:(BOOL)active
{
    [super setActive:active];
    
    if (active) {
        self.stickerPackageImageView.image = [UIImage imageNamed:@"sticker_keyboard_recent_pressed"];
    } else {
        self.stickerPackageImageView.image = [UIImage imageNamed:@"sticker_keyboard_recent_normal"];
    }
}

@end
