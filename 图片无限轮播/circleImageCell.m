//
//  circleImageCell.m
//  图片无限轮播
//
//  Created by Theshy on 15/8/31.
//  Copyright © 2015年 Theshy. All rights reserved.
//

#import "circleImageCell.h"

@interface circleImageCell ()
@property (weak, nonatomic) IBOutlet UIImageView *circleImageView;

@end

@implementation circleImageCell

- (void)setUrl:(NSURL *)url {
    _url = url;
    NSData *data = [NSData dataWithContentsOfURL:url];
    self.circleImageView.image = [UIImage imageWithData:data];    
}


@end
