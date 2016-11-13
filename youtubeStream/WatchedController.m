//
//  WatchedController.m
//  youtubeStream
//
//  Created by Mr Ruby on 13/11/16.
//  Copyright © 2016 Rnjai Lamba. All rights reserved.
//

#import "WatchedController.h"
#import "WatchedCell.h"
#import <SDWebImage/UIImageView+WebCache.h>



@interface WatchedController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic) NSMutableArray *watchedData;
- (IBAction)closeClicked:(id)sender;

@end

@implementation WatchedController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initdata];
    [self setupCollection];
    [self getSavedData];
}

-(void)getSavedData{

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *arrData = [userDefaults mutableArrayValueForKey:@"watched"];
    self.watchedData = arrData;
    if(self.watchedData.count > 0){
        self.nothing.hidden = YES;
    }
    [self.collectionView reloadData];
}

-(void)initdata{
    self.watchedData = [NSMutableArray new];
}

-(void)setupCollection{
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"WatchedCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
}

#pragma UICollectionViewDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.watchedData.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    WatchedCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSMutableDictionary *dict = [self.watchedData objectAtIndex:indexPath.row];
    NSString *title = [dict objectForKey:@"title"];
    NSString *id = [dict objectForKey:@"id"];
    NSString *finalImageUrl = [NSString stringWithFormat:@"https://img.youtube.com/vi/%@/0.jpg",id];
    [cell.videoImage sd_setImageWithURL:[NSURL URLWithString:finalImageUrl] placeholderImage:nil];
    cell.videoLabel.text = title;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(320, 200);
}


- (IBAction)closeClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
