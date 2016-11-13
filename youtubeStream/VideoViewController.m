//
//  VideoViewController.m
//  youtubeStream
//
//  Created by Mr Ruby on 13/11/16.
//  Copyright © 2016 Rnjai Lamba. All rights reserved.
//

#import "VideoViewController.h"
#import <XCDYouTubeKit/XCDYouTubeKit.h>

@interface VideoViewController ()

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
@end
