//
//  ViewController.h
//  电视直播
//
//  Created by Massimo on 2017/2/15.
//  Copyright © 2017年 Massimo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) NSURL *url;
- (instancetype)initWithJs:(NSString*)filePath;


@end

