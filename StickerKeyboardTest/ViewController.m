//
//  ViewController.m
//  StickerKeyboardTest
//
//  Created by Ostap Horbach on 6/21/15.
//  Copyright (c) 2015 Ostap Horbach. All rights reserved.
//

#import "ViewController.h"
#import "StickerKeyboardView.h"
#import "StickerKeyboardModel.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet StickerKeyboardView *keyboardView;
@property (strong, nonatomic) StickerKeyboardModel *keyboardViewDataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.keyboardViewDataSource = [[StickerKeyboardModel alloc] init];
    self.keyboardView.dataSouce = self.keyboardViewDataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
