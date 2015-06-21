//
//  StickerKeyboardView.m
//  Fring
//
//  Created by Yehonatan Yochpaz on 5/11/15.
//  Copyright (c) 2015 fring. All rights reserved.
//

#import "StickerKeyboardView.h"
#import "StickerPackageKeyboardCell.h"
#import "StickerKeyboardCell.h"
#import "UIViewAdditions.h"

#define STICKER_GO_TO_MARKET_BUTTON_PADDING 120
#define STICKER_PLUS_BUTTON_PADDING 50


@interface StickerKeyboardView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate>
{
    StickerKeyboardCell *cellForSize;
}

@property (retain, nonatomic) IBOutlet UICollectionView *stickerPackageCollectionView;
@property (retain, nonatomic) IBOutlet UICollectionView *stickerCollectionView;
@property (retain, nonatomic) IBOutlet UIButton *plusButton;
@property (retain, nonatomic) IBOutlet UIButton *goToMarketButton;
@property (strong, nonatomic) NSMutableArray *array;
@property (strong, nonatomic) StickerKeyboardCell *myCell;
@property (strong, nonatomic) NSIndexPath  *selectedStickerIndexPath;

@property (nonatomic) NSInteger selectedTabIndex;

@end

@implementation StickerKeyboardView

#pragma mark - Initialization
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *bundleArray = [[NSBundle mainBundle] loadNibNamed:@"StickerKeyboardView" owner:self options:nil];
        [self addSubview:bundleArray[0]];

        self.stickerPackageCollectionView.delegate = self;
        self.stickerPackageCollectionView.dataSource = self;
        
        self.stickerCollectionView.delegate = self;
        self.stickerCollectionView.dataSource = self;
        
        [self.stickerPackageCollectionView registerNib:[UINib nibWithNibName:@"StickerPackageKeyboardCell" bundle:nil] forCellWithReuseIdentifier:@"stickerPackageCell"];
        
        [self.stickerCollectionView registerNib:[UINib nibWithNibName:@"StickerKeyboardCell" bundle:nil] forCellWithReuseIdentifier:@"stickerCell"];
        
        self.stickerPackageCollectionView.width -= STICKER_GO_TO_MARKET_BUTTON_PADDING;
        [self addSubview:self.goToMarketButton];
        self.goToMarketButton.left = self.stickerPackageCollectionView.right;
        
        self.selectedStickerIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    }
    return self;
}

#pragma mark - StickerKeyboardViewDataSource
#pragma mark - StickerKeyboardViewDelegate

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.stickerPackageCollectionView) {
        return [self.dataSouce numberOfStickersInStickerKeyboadView:self forStickerPackageAtIndex:section];
    } else if (collectionView == self.stickerCollectionView) {
        return [self.dataSouce numberOfStickersInStickerKeyboadView:self forStickerPackageAtIndex:section];
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell;
    if (collectionView == self.stickerPackageCollectionView) {
        UIImage *stickerPackageImage = [self.dataSouce stickerKeyboardView:self imageForStickerPackageAtIndex:indexPath.item];
        cell = [self packageCellForIndexPath:indexPath];
    } else if (collectionView == self.stickerCollectionView) {
        NSIndexPath *stickerIndexPath = [NSIndexPath indexPathForItem:indexPath.item inSection:self.selectedTabIndex];
        UIImage *stickerImage = [self.dataSouce stickerKeyboardView:self imageForStickerAtIndexPath:stickerIndexPath];
        cell = [self stickerCellForIndexPath:indexPath];
    }
    return cell;
}

#pragma mark - Cell Configuration
- (StickerPackageKeyboardCell *)packageCellForIndexPath:(NSIndexPath *)indexPath {
    
    StickerPackageKeyboardCell *packageCell = [self.stickerPackageCollectionView dequeueReusableCellWithReuseIdentifier:@"stickerPackageCell" forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        packageCell.stickerPackageImageView.backgroundColor = [UIColor greenColor];
    } else {
        packageCell.stickerPackageImageView.backgroundColor = [UIColor redColor];
    }
    
    if (indexPath.row == self.selectedStickerIndexPath.row) {
        packageCell.activePackageIndicationView.backgroundColor = [UIColor orangeColor];
    } else {
        packageCell.activePackageIndicationView.backgroundColor = [UIColor clearColor];
    }
    
    return packageCell;
}

- (StickerKeyboardCell *)stickerCellForIndexPath:(NSIndexPath *)indexPath {

    StickerKeyboardCell *cell = [self.stickerCollectionView dequeueReusableCellWithReuseIdentifier:@"stickerCell" forIndexPath:indexPath];
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(StickerKeyboardCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row  == 0) {
        cell.label.text = @"Long";
    }
    if (indexPath.row  == 1) {
        cell.label.text = @"Long";
    }
    if (indexPath.row  == 2) {
        cell.label.text = @"Long";
    }
    if (indexPath.row  == 3) {
        cell.label.text = @"Long";
    }
    if (indexPath.row  == 4) {
        cell.label.text = @"LongLong";
    }
    if (indexPath.row  == 5) {
        cell.label.text = @"Long";
    }
    if (indexPath.row  == 6) {
        cell.label.text = @"LongLong";
    }
    if (indexPath.row  == 7) {
        cell.label.text = @"Long";
    }
    if (indexPath.row  == 8) {
        cell.label.text = @"Long";
    }
    if (indexPath.row  == 9) {
        cell.label.text = @"LongLong";
    }

}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == self.stickerCollectionView) {
    
        [self configureCell:cellForSize forIndexPath:indexPath];
        CGSize sizeOfCell = [cellForSize systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        sizeOfCell.height += 20.5;
        return sizeOfCell;
    } else {
        return CGSizeMake(50, 50);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    if (collectionView == self.stickerPackageCollectionView) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    } else {
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (collectionView == self.stickerPackageCollectionView) {
        return 0.0f;
    } else {
        return 5.0f;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    if (collectionView == self.stickerPackageCollectionView) {
        return 0.0f;
    } else {
        return 10.0f;
    }
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.stickerPackageCollectionView) {
        
        if (indexPath.row != self.selectedStickerIndexPath.row) {
            
            StickerPackageKeyboardCell *previousSelectedCell = (StickerPackageKeyboardCell *)[collectionView cellForItemAtIndexPath:self.selectedStickerIndexPath];
            previousSelectedCell.activePackageIndicationView.backgroundColor = [UIColor clearColor];
            
            StickerPackageKeyboardCell *currentSelectedCell = (StickerPackageKeyboardCell *)[collectionView cellForItemAtIndexPath:indexPath];
            currentSelectedCell.activePackageIndicationView.backgroundColor = [UIColor orangeColor];
            
            self.selectedStickerIndexPath = indexPath;
        }
    }
}

#pragma mark - Actions
- (void)changePlusButtons {
    
    [self.goToMarketButton removeFromSuperview];
    self.stickerPackageCollectionView.width += STICKER_GO_TO_MARKET_BUTTON_PADDING - STICKER_PLUS_BUTTON_PADDING;
    [self addSubview:self.plusButton];
    self.plusButton.left = self.stickerPackageCollectionView.right;
}
- (void)revertChangeButtons {
    
    [self.plusButton removeFromSuperview];
    [self addSubview:self.goToMarketButton];
    self.stickerPackageCollectionView.width -= STICKER_GO_TO_MARKET_BUTTON_PADDING - STICKER_PLUS_BUTTON_PADDING;
    self.plusButton.left = self.stickerPackageCollectionView.right;
}

- (IBAction)plusButtonClicked:(id)sender {
    
//    if ([self.array count] < 10 && !arrayFilled) {
//        
//        [self.array addObject:@1];
//        [self.stickerPackageCollectionView reloadData];
//    } else {
//        
//        arrayFilled = YES;
//        [self.array removeLastObject];
//        [self.stickerPackageCollectionView reloadData];
//        
//        if (self.array != nil && [self.array count] < 3) {
//            arrayFilled = NO;
//            [self revertChangeButtons];
//        }
//    }
}

- (IBAction)goToMarketButtonClicked:(id)sender {
    
    [self.array addObject:@2];
    [self.stickerPackageCollectionView reloadData];
    
    if ([self.array count] > 3) {
        [self changePlusButtons];
    }
}

@end
