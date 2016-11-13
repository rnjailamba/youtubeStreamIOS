//
//  ViewController.m
//  youtubeStream
//
//  Created by Mr Ruby on 12/11/16.
//  Copyright © 2016 Rnjai Lamba. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import <AFNetworking/AFNetworking.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <XCDYouTubeKit/XCDYouTubeKit.h>
#import "VideoViewController.h"


@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,CollectionViewCellDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NSMutableArray *allData;
@property (weak, nonatomic) IBOutlet UIView *videoPlayingView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navbarFix];
    [self initData];
    [self collectionViewStuff];
    [self registerCells];
    [self fetchData];
}

-(void)initData{
    self.allData = [NSMutableArray new];
}

-(void)fetchData{
    
    NSDictionary *parameters = @{@"format":@"json",
                                 @"action":@"query",
                                 @"generator":@"search",
                                 @"gsrnamespace":@"0",
                                 @"gsrsearch":@"dsds",
                                 @"gsrlimit":@"10",
                                 @"prop":@"pageimages|extracts",
                                 @"pilimit":@"max",
                                 @"exintro":@"",
                                 @"explaintext":@"",
                                 @"exlimit":@"max",
                                 @"exsentences":@"1"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:@"https://api.myjson.com/bins/42nrw.json" parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        if([responseObject isKindOfClass:[NSArray class]]){
            NSMutableArray *arr = responseObject;
            NSLog(@"count of objects: %lu", (unsigned long)arr.count);
            self.allData = arr;
            [self.collectionView reloadData];
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
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

#pragma UICollectionViewDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if(indexPath.row == 0){
        [cell.trainImage setImage:[UIImage imageNamed:@"front.png"]];
        cell.videoImage.hidden = YES;
        cell.playImage.hidden = YES;
    }
    else{
        [cell.trainImage setImage:[UIImage imageNamed:@"back.png"]];
        cell.videoImage.hidden = NO;
        cell.playImage.hidden = NO;
        if(self.allData.count > indexPath.row + 4){
            NSMutableDictionary *dict = [self.allData objectAtIndex:indexPath.row + 4];
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
                        cell.videoImage.alpha = 1;
                        cell.videoId = value;
                    }
                }
            }
        }
    }
    cell.indexPath = indexPath;
    cell.delegate = self;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(320, 260);
}

#pragma CollectionViewCellDelegate

-(void)videoClickedAtIndexPath:(NSIndexPath *)indexPath{
    [self playVideo];
    
}

- (void) playVideo
{
//    XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:@"3xqqj9o7TgA"];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerPlaybackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:videoPlayerViewController.moviePlayer];
//    [self presentMoviePlayerViewControllerAnimated:videoPlayerViewController];

//    XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:@"3xqqj9o7TgA"];
//    [videoPlayerViewController presentInView:self.videoPlayingView];
//    [videoPlayerViewController.moviePlayer play];
    VideoViewController *videoVC = [[VideoViewController alloc]initWithNibName:@"VideoViewController" bundle:nil];
    [self presentViewController:videoVC animated:YES completion:nil];


}

//- (void) moviePlayerPlaybackDidFinish:(NSNotification *)notification
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:notification.object];
//    MPMovieFinishReason finishReason = [notification.userInfo[MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] integerValue];
//    if (finishReason == MPMovieFinishReasonPlaybackError)
//    {
//        NSError *error = notification.userInfo[XCDMoviePlayerPlaybackDidFinishErrorUserInfoKey];
//        // Handle error
//    }
//}


@end
