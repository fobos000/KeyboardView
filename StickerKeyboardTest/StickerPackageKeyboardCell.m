//
//  StickerPackageKeyboardCell.m
//  Fring
//
//  Created by Serhii.Miskiv on 6/17/15.
//  Copyright (c) 2015 fring. All rights reserved.
//

#import "StickerPackageKeyboardCell.h"

@interface StickerPackageKeyboardCell ()

@property (nonatomic, weak) IBOutlet UIView *activePackageIndicationView;

@end

@implementation StickerPackageKeyboardCell

- (void)setActive:(BOOL)active
{
    _active = active;
    self.activePackageIndicationView.hidden = !active;
}

@end
