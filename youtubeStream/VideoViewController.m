//
//  VideoViewController.m
//  youtubeStream
//
//  Created by Mr Ruby on 13/11/16.
//  Copyright © 2016 Rnjai Lamba. All rights reserved.
//

#import "VideoViewController.h"
#import <XCDYouTubeKit/XCDYouTubeKit.h>
#import "RecommendViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface VideoViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *videoView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
- (IBAction)closeButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *videoViewHt;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *recommendedHt;
- (IBAction)videoTapped:(id)sender;
@property (nonatomic) BOOL tapped;

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initProps];
    [self setViewBounds];
    [self playVideo];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)initProps{
    self.tapped = false;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"RecommendViewCell" bundle:nil  ] forCellWithReuseIdentifier:@"cell"];
}

-(void)setViewBounds{
    self.view.frame = [[UIScreen mainScreen] bounds];
    self.videoViewHt.constant = self.view.frame.size.height - 50;
    self.recommendedHt.constant = 0;
}

-(void)playVideo{
        XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:self.videoId];
        [videoPlayerViewController presentInView:self.videoView];
        [videoPlayerViewController.moviePlayer play];
}

- (IBAction)closeButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)videoTapped:(id)sender {
    if(self.tapped == false){
        self.videoViewHt.constant = self.view.frame.size.height - 150;
        self.recommendedHt.constant = 100;
    }
    else{
        self.videoViewHt.constant = self.view.frame.size.height - 50;
        self.recommendedHt.constant = 0;
    }
    self.tapped = !self.tapped;

}

#pragma UICollectionViewDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    RecommendViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if(self.allData.count > indexPath.row + 4){
        NSMutableDictionary *dict = [self.allData objectAtIndex:indexPath.row + 4 + (self.indexPath.row+1)];
        NSString *title = [dict objectForKey:@"title"];
        NSString *url = [dict objectForKey:@"url"];
        NSLog(@"data: %@ %@", title,url);
        NSArray *comp1 = [url componentsSeparatedByString:@"?"];
        NSString *query = [comp1 lastObject];
        NSArray *queryElements = [query componentsSeparatedByString:@"&"];
        for (NSString *element in queryElements) {
            NSArray *keyVal = [element componentsSeparatedByString:@"="];
            if (keyVal.count > 0) {
                NSString *variableKey = [keyVal objectAtIndex:0];
                NSString *value = (keyVal.count == 2) ? [keyVal lastObject] : nil;
                if([variableKey isEqualToString:@"v"]){
                    NSLog(@"value: %@", value);
                    //                        http://img.youtube.com/vi/lNmXqinHhDY/0.jpg
                    NSString *finalImageUrl = [NSString stringWithFormat:@"https://img.youtube.com/vi/%@/0.jpg",value];
                    [cell.videoImage sd_setImageWithURL:[NSURL URLWithString:finalImageUrl] placeholderImage:nil];
                    cell.videoId = value;
                }
            }
        }
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(150, 100);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {

    NSMutableDictionary *dict = [self.allData objectAtIndex:indexPath.row + 4 + (self.indexPath.row+1)];
    NSString *title = [dict objectForKey:@"title"];
    NSString *url = [dict objectForKey:@"url"];
    NSLog(@"data: %@ %@", title,url);
    NSArray *comp1 = [url componentsSeparatedByString:@"?"];
    NSString *query = [comp1 lastObject];
    NSArray *queryElements = [query componentsSeparatedByString:@"&"];
    for (NSString *element in queryElements) {
        NSArray *keyVal = [element componentsSeparatedByString:@"="];
        if (keyVal.count > 0) {
            NSString *variableKey = [keyVal objectAtIndex:0];
            NSString *value = (keyVal.count == 2) ? [keyVal lastObject] : nil;
            if([variableKey isEqualToString:@"v"]){
                NSLog(@"value: %@", value);
                //                        http://img.youtube.com/vi/lNmXqinHhDY/0.jpg
                NSString *finalImageUrl = [NSString stringWithFormat:@"https://img.youtube.com/vi/%@/0.jpg",value];
                self.videoId = value;
            }
        }
    }
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:self.indexPath.row + 2 inSection:1];
    self.indexPath = newIndexPath;
    [self playVideo];
    [self.collectionView reloadData];

}

@end
