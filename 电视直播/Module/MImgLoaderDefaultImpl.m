//
//  MImgLoaderDefaultImpl.m
//  WeexTEST
//
//  Created by Massimo on 2017/1/13.
//  Copyright © 2017年 Massimo. All rights reserved.
//
#import <SDWebImage/UIImageView+WebCache.h>

#import "MImgLoaderDefaultImpl.h"



@implementation MImgLoaderDefaultImpl

- (id<WXImageOperationProtocol>)downloadImageWithURL:(NSString *)url imageFrame:(CGRect)imageFrame userInfo:(NSDictionary *)userInfo completed:(void(^)(UIImage *image,  NSError *error, BOOL finished))completedBlock
{
  if ([url hasPrefix:@"//"]) {
    url = [@"http:" stringByAppendingString:url];
  }
  return (id<WXImageOperationProtocol>)[[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:url] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    
  } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
    if (completedBlock) {
      completedBlock(image, error, finished);
    }
  }];
}
@end
