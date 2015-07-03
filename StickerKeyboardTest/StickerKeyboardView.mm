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
#import "StickerRecentTabCell.h"
#import "UIViewAdditions.h"
#import "StickerSwipeView.h"

#define NUM_OF_PACKAGES_TO_SHOW_LARGE_MARKET_BUTTON 4
#define MARKET_BUTTON_CORNER_RADIUS 5

@interface StickerKeyboardView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, StickerSwipeViewDataSource, StickerSwipeViewDelegate>
{
    StickerKeyboardCell *cellForSize;
}

@property (strong, nonatomic) IBOutlet UICollectionView *stickerPackageCollectionView;
@property (strong, nonatomic) IBOutlet StickerSwipeView *stickerSwipeView;
@property (strong, nonatomic) IBOutlet UIView *plusButton;
@property (strong, nonatomic) IBOutlet UIView *goToMarketButton;
@property (strong, nonatomic) IBOutlet UIView *packageCollectionViewContainer;
@property (strong, nonatomic) NSMutableArray *array;
@property (strong, nonatomic) UIView *marketButton;
@property (strong, nonatomic) StickerPackageKeyboardCell *recentCell;

@property (assign, nonatomic) NSInteger selectedTabIndex;
@property (assign, nonatomic) NSInteger requestedTabIndex;

@end

@implementation StickerKeyboardView

#pragma mark - Initialization
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
//        [self _registerEvents];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    NSArray *bundleArray = [[NSBundle mainBundle] loadNibNamed:@"StickerKeyboardView" owner:self options:nil];
    UIView *keyboardView = bundleArray[0];
    keyboardView.frame = self.bounds;
    [self addSubview:keyboardView];
    
    self.stickerPackageCollectionView.delegate = self;
    self.stickerPackageCollectionView.dataSource = self;
    
    self.stickerSwipeView.delegate = self;
    self.stickerSwipeView.dataSource = self;
    
    [self.stickerPackageCollectionView registerNib:[UINib nibWithNibName:@"StickerPackageKeyboardCell" bundle:nil] forCellWithReuseIdentifier:@"stickerPackageCell"];
    
    [self.stickerPackageCollectionView registerNib:[UINib nibWithNibName:@"StickerRecentTabCell" bundle:nil] forCellWithReuseIdentifier:@"recentCell"];
    
    
    self.marketButton = self.goToMarketButton;
    [self configureMarketButtons];
    
    _selectedTabIndex = 0;
}

//-(void) dealloc
//{
//    [self _unregisterEvents];
//}

- (void)configureMarketButtons
{
    [self.marketButton.layer setCornerRadius:MARKET_BUTTON_CORNER_RADIUS];
    [self.plusButton.layer setCornerRadius:MARKET_BUTTON_CORNER_RADIUS];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutMarketButton];
}

- (void)setMarketButton:(UIView *)marketButton
{
    [_marketButton removeFromSuperview];
    _marketButton = marketButton;
    [self addSubview:_marketButton];
    [self setNeedsLayout];
}

- (void)layoutMarketButton
{
    self.stickerPackageCollectionView.width = self.packageCollectionViewContainer.width - self.marketButton.width;
    self.marketButton.centerY = CGRectGetMidY(self.packageCollectionViewContainer.bounds);
    self.marketButton.right = self.packageCollectionViewContainer.right;
}

//#pragma mark - Events
//-(void) _registerEvents
//{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_refreshLayout) name:STICKER_PACKAGES_DOWNLOADED object:nil];
//}
//-(void) _unregisterEvents
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:STICKER_PACKAGES_DOWNLOADED object:nil];
//}

-(void) _refreshLayout
{
    [_stickerPackageCollectionView reloadData];
//    [_sti reloadData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.stickerPackageCollectionView) {
        NSUInteger numberOfTabs = [self.dataSouce numberOfStickerPackagesInStickerKeyboadView:self] + 1;
        if (numberOfTabs > NUM_OF_PACKAGES_TO_SHOW_LARGE_MARKET_BUTTON) {
            self.marketButton = self.plusButton;
        }
        return numberOfTabs;
    } else {
        if (self.requestedTabIndex == 0) { // recent tab
            return [self.dataSouce numberOfRecentStickersInStickerKeyboadView:self];
        } else {
            return [self.dataSouce numberOfStickersInStickerKeyboadView:self forStickerPackageAtIndex:self.requestedTabIndex - 1];
        }
        
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell;
    if (collectionView == self.stickerPackageCollectionView) {
        cell = [self cellForTabCollectionViewAtIndexPath:indexPath];
    } else {
        cell = [self stickerCellForIndexPath:indexPath forCollectionView:collectionView];
    }
    return cell;
}

#pragma mark - StickerSwipeViewDataSource

- (NSInteger)numberOfItemsInSwipeView:(StickerSwipeView *)swipeView
{
    return [self.dataSouce numberOfStickerPackagesInStickerKeyboadView:self] + 1;
}

- (UIView *)swipeView:(StickerSwipeView *)swipeView viewForItemAtIndex:(NSInteger)index
{
    self.requestedTabIndex = index;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *stickerCollectionView = [[UICollectionView alloc] initWithFrame:swipeView.bounds collectionViewLayout:layout];
    stickerCollectionView.dataSource = self;
    stickerCollectionView.delegate = self;
    [stickerCollectionView registerNib:[UINib nibWithNibName:@"StickerKeyboardCell" bundle:nil] forCellWithReuseIdentifier:@"stickerCell"];
    
    return stickerCollectionView;
}

#pragma mark - StickerSwipeViewDelegate

- (void)swipeView:(StickerSwipeView *)swipeView didSwipeToItemAtIndex:(NSInteger)index
{
    self.selectedTabIndex = index;
}

#pragma mark - Cell Configuration

- (UICollectionViewCell *)cellForTabCollectionViewAtIndexPath:(NSIndexPath *)indexPath
{
    __weak StickerPackageKeyboardCell *cell = nil;
    
    if (indexPath.item == 0) {
        cell = [self recentCell];
    } else {
        
        cell = [self.stickerPackageCollectionView dequeueReusableCellWithReuseIdentifier:@"stickerPackageCell" forIndexPath:indexPath];
        
        [self.dataSouce stickerKeyboardView:self imageForStickerPackageAtIndex:indexPath.item - 1 responseCallback:^(UIImage *image) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                cell.stickerPackageImageView.image = image;
            });
//            UIImage *stickerPackageImage = image;
        }];
    }
    cell.active = (indexPath.item == _selectedTabIndex);
    
    return cell;
}

- (UICollectionViewCell *)recentCell
{
    if (!_recentCell) {
        _recentCell = [self.stickerPackageCollectionView dequeueReusableCellWithReuseIdentifier:@"recentCell" forIndexPath:nil];
    }
    return _recentCell;
}

//- (StickerPackageKeyboardCell *)packageCellWithImage:(UIImage *)image indexPath:(NSIndexPath *)indexPath{
//    
//    StickerPackageKeyboardCell *packageCell = [self.stickerPackageCollectionView dequeueReusableCellWithReuseIdentifier:@"stickerPackageCell" forIndexPath:indexPath];
//    
//    packageCell.stickerPackageImageView.image = image;
//    
//    return packageCell;
//}

- (StickerKeyboardCell *)stickerCellForIndexPath:(NSIndexPath *)indexPath forCollectionView:(UICollectionView* )collectionView
{
    StickerKeyboardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"stickerCell" forIndexPath:indexPath];
    
    __block UIImage *stickerImage = nil;
    
    void (^loadImageBloack)(UIImage * image) = ^(UIImage * image) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            stickerImage = image;
            cell.imageView.image = stickerImage;
        });
    };
    
    if (self.requestedTabIndex == 0) { //recent tab
        [self.dataSouce stickerKeyboardView:self imageForRecentStickerAtIndex:indexPath.item responseCallback:loadImageBloack];
    } else {
        NSIndexPath *stickerIndexPath = [NSIndexPath indexPathForItem:indexPath.item inSection:self.requestedTabIndex - 1];
        [self.dataSouce stickerKeyboardView:self imageForStickerAtIndexPath:stickerIndexPath responseCallback:loadImageBloack];
    }
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == self.stickerPackageCollectionView) {
        CGFloat tabHeight = collectionView.bounds.size.height;
        return CGSizeMake(tabHeight, tabHeight);
    } else {
        if (self.requestedTabIndex == 0) {
            return [self.dataSouce stickerKeyboardView:self sizeForRecentStickerImageAtIndex:indexPath.item];
        } else {
            NSIndexPath *stickerIndexPath = [NSIndexPath indexPathForItem:indexPath.item inSection:self.requestedTabIndex - 1];
            return [self.dataSouce stickerKeyboardView:self sizeForStickerImageAtIndexPath:stickerIndexPath];
        }
    }
}

- (void)setSelectedTabIndex:(NSInteger)selectedTabIndex
{
    NSIndexPath *previousSelectedIndexPath = [NSIndexPath indexPathForItem:self.selectedTabIndex inSection:0];
    StickerPackageKeyboardCell *previousSelectedCell = (StickerPackageKeyboardCell *)[self.stickerPackageCollectionView cellForItemAtIndexPath:previousSelectedIndexPath];
    previousSelectedCell.active = NO;
    
    NSIndexPath *currentSelectedIndexPath = [NSIndexPath indexPathForItem:selectedTabIndex inSection:0];
    StickerPackageKeyboardCell *currentSelectedCell = (StickerPackageKeyboardCell *)[self.stickerPackageCollectionView cellForItemAtIndexPath:currentSelectedIndexPath];
    currentSelectedCell.active = YES;
    
    _selectedTabIndex = selectedTabIndex;
    
//    [self.stickerSwipeView reloadData];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.stickerPackageCollectionView) {
        if (indexPath.item != self.selectedTabIndex) {
            self.selectedTabIndex = indexPath.item;
            
            if ([self.delegate respondsToSelector:@selector(stickerKeyboardView:didSelectStickerPackageAtIndex:)]) {
                [self.delegate stickerKeyboardView:self didSelectStickerPackageAtIndex:indexPath.item];
            }
        }
    } else {
        if (_selectedTabIndex == 0) { // recent tab
            if ([self.delegate respondsToSelector:@selector(stickerKeyboardView:didSelectRecentStickerAtIndex:)]) {
                [self.delegate stickerKeyboardView:self didSelectRecentStickerAtIndex:indexPath.item];
            }
        } else {
            if ([self.delegate respondsToSelector:@selector(stickerKeyboardView:didSelectStickerAtIndexPath:)]) {
                NSIndexPath *stickerIndexPath = [NSIndexPath indexPathForItem:indexPath.item inSection:_selectedTabIndex - 1];
                [self.delegate stickerKeyboardView:self didSelectStickerAtIndexPath:stickerIndexPath];
            }
        }
    }
}

#pragma mark - View

- (void)refresh
{
    [self _refreshLayout];
}

#pragma mark - Actions

- (IBAction)marketButtonTapped:(UIButton *)marketButton
{
    if ([self.delegate respondsToSelector:@selector(stickerKeyboardViewDidTapOnMarketButton:)]) {
        [self.delegate stickerKeyboardViewDidTapOnMarketButton:self];
    }
}

@end
