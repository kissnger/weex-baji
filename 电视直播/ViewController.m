//
//  ViewController.m
//  电视直播
//
//  Created by Massimo on 2017/2/15.
//  Copyright © 2017年 Massimo. All rights reserved.
//

#import "ViewController.h" 
#import <WeexSDK/WXSDKInstance.h>

@interface ViewController ()
@property (nonatomic, strong)WXSDKInstance *instance;
@property (nonatomic, strong)UIView *weexView;
@property (nonatomic, assign) CGFloat weexHeight;
@end

@implementation ViewController


- (instancetype)initWithJs:(NSString *)filePath{
  self = [super self];
  if (self ) {
    
    //    缓存js
    //    NSString *fullPath =  [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:filePath];
    //
    //    NSURL *urla = [NSURL URLWithString:[@"file://" stringByAppendingPathComponent:fullPath]];
    //    远程js
    //    NSString *path = [NSString stringWithFormat:@"http://lexch.cn/weexjs/%@",filePath];
    //
    //    jsUrl = [NSURL URLWithString:path];
    //
    //    [self requestCache:jsUrl file:filePath];
    //
    
    //    本地js
    NSString *path = [NSString stringWithFormat:@"file://%@/dist/%@",[NSBundle mainBundle].bundlePath,filePath];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.url = [NSURL URLWithString:path];
    NSLog(@" ----- self.url  ---- \n %@",self.url);
    
  }
  return self;
}
- (void)requestCache:(NSURL*)url file:(NSString*)filePath{
  NSURLSession *urlSession = [NSURLSession sharedSession];
  NSURLSessionTask*task = [urlSession downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
    
    NSString *fullPath =  [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
    NSError *err =nil;
    
    [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL URLWithString:[@"file://" stringByAppendingPathComponent:fullPath]] error:&err];
    
    if (err) {
      NSLog(@"\n---------err --------\n %@ \n----------- ",err);
    }
    
  }];
  [task resume];
  
  
}



- (void)saveFile:(id)data file:(NSString*)filePath{
  NSString *newText = [[NSString alloc]
                       initWithData:data
                       encoding:NSUTF8StringEncoding];
  
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *documentsDirectory = [paths objectAtIndex:0];
  NSString *mypath = [documentsDirectory stringByAppendingPathComponent:filePath];
}


- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  self.navigationController.navigationBar.hidden = YES;
  CGFloat width = self.view.frame.size.width;
  _instance = [[WXSDKInstance alloc]init];
  _instance.viewController = self;
  _weexHeight = self.view.frame.size.height ;
  _instance.frame =  CGRectMake(self.view.frame.size.width-width, 0, width, _weexHeight);
  
  __weak typeof(self) weakSelf = self;
  
  [_instance setOnCreate:^(UIView *view) {
    [weakSelf.weexView removeFromSuperview];
    weakSelf.weexView = view;
    [weakSelf.view addSubview:weakSelf.weexView];
  }];
  
  [_instance setOnFailed:^(NSError *err) {
    NSLog(@"加载失败： %@",err);
  }];
  [_instance setRenderFinish:^(UIView *view) {
    NSLog(@"加载完成");
  }];
  
  if (!self.url) {
    return;
  }
  
  [_instance renderWithURL:self.url options:@{@"bundleUrl":[self.url absoluteString]} data:nil];
  self.view.backgroundColor=[UIColor whiteColor];
  
}
- (void)viewDidLayoutSubviews
{
  _weexHeight = self.view.frame.size.height;
}
- (void)dealloc
{
  [_instance destroyInstance];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}



@end
