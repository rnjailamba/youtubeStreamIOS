//
//  RecommendViewCell.h
//  youtubeStream
//
//  Created by Mr Ruby on 13/11/16.
//  Copyright © 2016 Rnjai Lamba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *videoImage;
@property (weak, nonatomic) IBOutlet UIButton *videoButton;
@property (nonatomic) NSIndexPath *indexPath;
@property (nonatomic) NSString *videoId;

@end
