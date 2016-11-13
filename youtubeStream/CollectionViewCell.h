//
//  CollectionViewCell.h
//  youtubeStream
//
//  Created by Mr Ruby on 13/11/16.
//  Copyright © 2016 Rnjai Lamba. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CollectionViewCellDelegate <NSObject>

-(void)videoClickedAtIndexPath:(NSIndexPath *)indexPath andVideoId:(NSString *)videoID andTitle:(NSString *)title;

@end

@interface CollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *trainImage;
@property (weak, nonatomic) IBOutlet UIImageView *videoImage;
@property (weak, nonatomic) IBOutlet UIImageView *playImage;
- (IBAction)playButtonClicked:(id)sender;
@property (nonatomic) NSIndexPath *indexPath;
@property (nonatomic) id<CollectionViewCellDelegate> delegate;
@property (nonatomic) NSString *videoId;
@property (nonatomic) NSString *videoTitle;

@end
