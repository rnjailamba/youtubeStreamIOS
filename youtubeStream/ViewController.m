//
//  ViewController.m
//  youtubeStream
//
//  Created by Mr Ruby on 12/11/16.
//  Copyright © 2016 Rnjai Lamba. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"


@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navbarFix];
    [self collectionViewStuff];
    [self registerCells];
}

-(void)collectionViewStuff{
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

-(void)registerCells{
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil  ] forCellWithReuseIdentifier:@"cell"];
}

-(void)navbarFix{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(320, 260);
}



@end
