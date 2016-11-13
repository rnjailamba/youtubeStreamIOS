//
//  CollectionViewCell.m
//  youtubeStream
//
//  Created by Mr Ruby on 13/11/16.
//  Copyright © 2016 Rnjai Lamba. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)playButtonClicked:(id)sender {
    [self.delegate videoClickedAtIndexPath:self.indexPath andVideoId:self.videoId];
}
@end
