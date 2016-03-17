//
//  ViewController.m
//  GraffitBoard
//
//  Created by  haole on 16/3/17.
//  Copyright © 2016年 yl. All rights reserved.
//

#import "ViewController.h"
#import "GraffitiBoardView.h"
@interface ViewController ()
{
    GraffitiBoardView *graffitiView;
    NSTimer *timer;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   


    graffitiView = [[GraffitiBoardView alloc] init];
    graffitiView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:graffitiView];
    graffitiView.pathColor = [UIColor redColor];
    graffitiView.pathWith = 10;
    graffitiView.lineCap = kCGLineCapSquare;
    graffitiView.linejoin = kCGLineJoinRound;

    
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor redColor];
    label.text = @"缩放手势可以清屏";
    [self.view addSubview:label];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;

        label.translatesAutoresizingMaskIntoConstraints = NO;
        graffitiView.translatesAutoresizingMaskIntoConstraints = NO;

        NSArray *gw = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:nil views:@{@"view":graffitiView}];
        NSArray *lw = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:nil views:@{@"view":label}];
        NSArray *h = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[l(==35)]-25-[view]-0-|" options:0 metrics:nil views:@{@"view":graffitiView,@"l":label}];
        [self.view addConstraints:gw];
        [self.view addConstraints:lw];
        [self.view addConstraints:h];

    
    } else {
        graffitiView.frame = CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height - 130);
        graffitiView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        label.frame = CGRectMake(0, 40, self.view.bounds.size.width, 35);
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        

    }
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(setPathInfo) userInfo:nil repeats:YES];

    

}

- (void)dealloc
{
    [timer invalidate];
    timer = nil;
    graffitiView = nil;
}

- (void)setPathInfo
{
    static int i = 0;
    switch (i%3) {
        case 0:
            graffitiView.pathColor = [UIColor redColor];
            graffitiView.pathWith = 10;
            graffitiView.lineCap = kCGLineCapSquare;
            graffitiView.linejoin = kCGLineJoinRound;
            break;
        case 1:
            graffitiView.pathColor = [UIColor greenColor];
            graffitiView.pathWith = 10;
            graffitiView.lineCap = kCGLineCapButt;
            graffitiView.linejoin = kCGLineJoinMiter;
            break;
        case 2:
            graffitiView.pathColor = [UIColor yellowColor];
            graffitiView.pathWith = 10;
            graffitiView.lineCap = kCGLineCapRound;
            graffitiView.linejoin = kCGLineJoinBevel;
            break;
        default:
            break;
    }

    i ++;

}
- (void) clear
{
    [graffitiView clear];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
    NSLog(@"%@",NSStringFromCGRect([UIScreen mainScreen].bounds));

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
