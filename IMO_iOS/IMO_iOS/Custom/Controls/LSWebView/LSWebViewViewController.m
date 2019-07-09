//
//  LSWebViewViewController.m
//  LSPlanet
//
//  Created by 许必杨 on 2018/5/22.
//  Copyright © 2018年 com.InZiqi. All rights reserved.
//

#import "LSWebViewViewController.h"
#import <WebKit/WebKit.h>
@interface LSWebViewViewController ()<WKUIDelegate,UIScrollViewDelegate,WKNavigationDelegate,UIWebViewDelegate>

@property (strong, nonatomic) WKWebView *webView;

@property (strong, nonatomic) UIProgressView *progressView;

@property (nonatomic ,strong) UIView *navBarBackView;

@end

@implementation LSWebViewViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    WKWebViewConfiguration*config = [[WKWebViewConfiguration alloc] init];
    config.preferences = [[WKPreferences alloc] init];
    config.preferences.minimumFontSize =10;
    config.preferences.javaScriptEnabled =YES;
    config.preferences.javaScriptCanOpenWindowsAutomatically =NO;
    
    NSMutableString *javascript = [NSMutableString string];
    [javascript appendString:@"document.documentElement.style.webkitTouchCallout='none';"];//禁止长按
    [javascript appendString:@"document.documentElement.style.webkitUserSelect='none';"];//禁止选择
    WKUserScript *noneSelectScript = [[WKUserScript alloc] initWithSource:javascript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) configuration:config];
     [_webView.configuration.userContentController addUserScript:noneSelectScript];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    _webView.scrollView.delegate = self;
//    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.scrollView.backgroundColor = [UIColor whiteColor];
    
//    _webView.delegate = self;
    if (@available(iOS 11.0, *)) {
        [_webView.scrollView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    } else {
        // Fallback on earlier versions
    }
    [self.view addSubview:_webView];
    _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,2)];
    _progressView.tintColor = [UIColor blueColor];
    [self.view addSubview:_progressView];
    
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
    
    if (self.content) {
       [_webView loadHTMLString:self.content baseURL:nil];
    }else{
       [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.loadUrlString]]];
    }

    [self.view addSubview:self.navBarBackView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, NavHeight - 44, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"Path"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(actionForBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, NavHeight - 44, ScreenWidth, 44)];
    title.font = [UIFont systemFontOfSize:18];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    title.text = self.customTitle;
    [self.view addSubview:title];
    
    
    if (self.fullScreen == NO) {
        self.navBarBackView.alpha = 1;
        _webView.frame = CGRectMake(0, NavHeight, ScreenWidth, ScreenHeight - NavHeight);
        _progressView.frame = CGRectMake(0,NavHeight, ScreenWidth,2);
    }
    
}

- (void)actionForBack{
    if (_webView.canGoBack == YES) {
        [_webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.fullScreen == NO) {
        self.navBarBackView.alpha = 1;
        return;
    }
    
    if (scrollView.contentOffset.y <= 0) {
        self.navBarBackView.alpha = 0;
    }else if (scrollView.contentOffset.y > 0 && scrollView.contentOffset.y < NavHeight ){
        CGFloat alphaParama = scrollView.contentOffset.y / NavHeight;
        self.navBarBackView.alpha = alphaParama;
    }else{
        self.navBarBackView.alpha = 1;
    }
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqual: @"estimatedProgress"] && object == _webView) {
        [self.progressView setAlpha:1.0f];
        [self.progressView setProgress:_webView.estimatedProgress animated:YES];
        if(_webView.estimatedProgress >= 1.0f)
        {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


- (void)dealloc {
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_webView setNavigationDelegate:nil];
    [_webView setUIDelegate:nil];
}

- (UIView*)navBarBackView {
    if (!_navBarBackView) {
        _navBarBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,NavHeight)];
        _navBarBackView.backgroundColor = [UIColor lightGrayColor];
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0,NavHeight - 0.5,ScreenWidth, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [_navBarBackView addSubview:line];
        _navBarBackView.alpha = 0;
    }
    return _navBarBackView;
}

@end
