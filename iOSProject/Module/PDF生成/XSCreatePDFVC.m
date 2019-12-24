//
//  XSCreatePDFVC.m
//  iOSProject
//
//  Created by 豆豆 on 2019/11/29.
//  Copyright © 2019 软素. All rights reserved.
//

#import "XSCreatePDFVC.h"
#import <WebKit/WebKit.h>
#import <QuickLook/QuickLook.h>
#import "XSShowPDFVC.h"

@interface XSCreatePDFVC ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler,QLPreviewControllerDelegate,QLPreviewControllerDataSource,UIDocumentInteractionControllerDelegate,UIPageViewControllerDataSource>

@property(nonatomic,strong)UIButton *webBtn;
@property(nonatomic,strong)UIButton *qlPCBtn;
@property(nonatomic,strong)UIButton *docBtn;
@property(nonatomic,strong)UIButton *drawPDFBtn;

@property(nonatomic,copy)NSString *pdfFilePath;
@property(nonatomic,strong)WKWebView *webView;
@property(nonatomic,strong)QLPreviewController *qlPC;


@end

@implementation XSCreatePDFVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self createPDFFile];
    
    [self.view addSubview:self.webBtn];
    [self.view addSubview:self.qlPCBtn];
    [self.view addSubview:self.docBtn];
    [self.view addSubview:self.drawPDFBtn];
    [self addNavBar];
}

- (void)addNavBar{
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(handleShare)];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

- (void)handleShare{
    NSURL *fileUrl = [NSURL fileURLWithPath:self.pdfFilePath];
    NSData *shareData = [NSData dataWithContentsOfURL:fileUrl];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:@[shareData,fileUrl] applicationActivities:@[]];
    activityVC.excludedActivityTypes = @[UIActivityTypePostToTwitter,UIActivityTypePostToWeibo,UIActivityTypePostToTencentWeibo,UIActivityTypePostToFacebook];
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (completed) {
            [SVProgressHUD showInfoWithStatus:@"success"];
        }else{
            [SVProgressHUD showInfoWithStatus:@"failed"];
        }
    };
    [self presentViewController:activityVC animated:YES completion:nil];
}

/**
 清理缓存
 */
- (void)clearWbCache {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[NSURLCache sharedURLCache] setDiskCapacity:0];
    [[NSURLCache sharedURLCache] setMemoryCapacity:0];
}

- (NSString *)configUrl{
    return self.pdfFilePath;
}

#pragma mark -- qlPC
- (QLPreviewController *)qlPC{
    if (!_qlPC) {
        _qlPC = [[QLPreviewController alloc]init];
        _qlPC.delegate = self;
        _qlPC.dataSource = self;
    }
    return _qlPC;
}

#pragma mark -- qlpcdelegate
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return 1;
}

- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    return [NSURL fileURLWithPath:self.pdfFilePath];
}

#pragma mark -- wkwebView
- (WKWebView *)webView{
    if (!_webView) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-navgationHeight) configuration:config];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
    }
    return _webView;
}


- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [SVProgressHUD show];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [SVProgressHUD dismissWithDelay:1];
}

#pragma mark -- create pdf
- (void)createPDFFile{
    // 1.创建media box
    CGRect mediaBox = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    
    // 2.设置pdf文档存储的路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = paths.firstObject;
    NSString *filePath = [documentsDir stringByAppendingString:@"/test.pdf"];
    self.pdfFilePath = filePath;
    const char *cfilePath = [filePath UTF8String];
    CFStringRef pathRef = CFStringCreateWithCString(NULL, cfilePath, kCFStringEncodingUTF8);
    
    // 3.设置当前pdf页面的属性
    CFStringRef myKeys[3];
    CFTypeRef myValues[3];
    myKeys[0] = kCGPDFContextMediaBox;
    myValues[0] = (CFTypeRef)CFDataCreate(NULL, (const UInt8 *)&mediaBox, sizeof(CGRect));
    myKeys[1] = kCGPDFContextTitle;
    myValues[1] = CFSTR("testPDF");
    myKeys[2] = kCGPDFContextCreator;
    myValues[2] = CFSTR("DOE");
    CFDictionaryRef pageDictionary = CFDictionaryCreate(NULL, (const void **) myKeys, (const void **) myValues, 3, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    
    // 4.获取pdf绘图上下文
    CGContextRef myPDFContext = MyPDFContextCreate(&mediaBox, pathRef);
    
    // 5.开始第一页
    CGPDFContextBeginPage(myPDFContext, pageDictionary);
    CGContextSetRGBFillColor(myPDFContext, 1, 0, 0, 1);
    CGContextFillRect(myPDFContext, CGRectMake(0, 0, 200, 200));
    CGContextSetRGBFillColor(myPDFContext, 0, 0, 1, .5);
    CGContextFillRect(myPDFContext, CGRectMake(0, 0, 100, 100));
    
    // 为一个矩形设置URL链接www.baidu.com
    CFURLRef baiduURL = CFURLCreateWithString(NULL, CFSTR("http://www.baidu.com"), NULL);
    CGContextSetRGBFillColor(myPDFContext, 0, 0, 0, 1);
    CGContextFillRect(myPDFContext, CGRectMake(200, 200, 100, 200));
    CGPDFContextSetURLForRect(myPDFContext, baiduURL, CGRectMake(200, 200, 100, 200));
//
//    // 为一个矩形设置一个跳转终点
    CGPDFContextAddDestinationAtPoint(myPDFContext, CFSTR("page"), CGPointMake(120, 400));
    CGPDFContextSetDestinationForRect(myPDFContext, CFSTR("page"), CGRectMake(50, 300, 100, 100));
    CGContextSetRGBFillColor(myPDFContext, 0, 0, 0.5, 0.5);
    CGContextFillEllipseInRect(myPDFContext, CGRectMake(50, 300, 100, 100));
    
    
    CGPDFContextEndPage(myPDFContext);
    
    // 6.第二页
    CFDictionaryRef page2Dictionary = CFDictionaryCreate(NULL, (const void **) myKeys, (const void **)myValues, 3, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    
    CGPDFContextBeginPage(myPDFContext, page2Dictionary);
    //左下角画两个矩形
    CGContextSetRGBFillColor(myPDFContext, 1, 0, 0, 1);
    CGContextFillRect(myPDFContext, CGRectMake(0, 0, 200, 200));
    CGContextSetRGBFillColor(myPDFContext, 0, 0, 1, .5);
    CGContextFillRect(myPDFContext, CGRectMake(0, 0, 100, 200));
    CGPDFContextEndPage(myPDFContext);
    
//    // 7.第三页
    CFDictionaryRef page3Dictionary = CFDictionaryCreate(NULL, (const void **)myKeys, (const void **)myValues, 3, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    CGPDFContextBeginPage(myPDFContext, page3Dictionary);
    UIImage *pdfImg = [UIImage imageNamed:@"mineBanner"];
    CGContextDrawImage(myPDFContext, CGRectMake(0, kScreenHeight-kScaleWidth(200), kScreenWidth, kScaleWidth(200)), [pdfImg CGImage]);
    
    CGPDFContextEndPage(myPDFContext);
    
    CFRelease(page3Dictionary);
    CFRelease(page2Dictionary);
    CFRelease(pageDictionary);
    CFRelease(myValues[0]);
    CGContextRelease(myPDFContext);
    
}

CGContextRef MyPDFContextCreate(const CGRect *inMediaBox, CFStringRef path){
    CGContextRef myOutContext = NULL;
    CFURLRef url;
    CGDataConsumerRef dataConsumer;
    
    url = CFURLCreateWithFileSystemPath(NULL, path, kCFURLPOSIXPathStyle, false);
    if (url != NULL) {
        dataConsumer = CGDataConsumerCreateWithURL(url);
        if (dataConsumer != NULL) {
            myOutContext = CGPDFContextCreate(dataConsumer, inMediaBox, NULL);
            CGDataConsumerRelease(dataConsumer);
        }
        CFRelease(url);
    }
    return myOutContext;
    
}

#pragma mark -- webbtn
- (UIButton *)webBtn{
    if (!_webBtn) {
        _webBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _webBtn.frame = CGRectMake(kScaleWidth(20), kScaleWidth(100), kScreenWidth-kScaleWidth(40), kScaleWidth(44));
        _webBtn.backgroundColor = [XSTool colorWithHexString:navcolor];
        _webBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kScaleWidth(16)];
        [_webBtn setTitle:@"web方式" forState:UIControlStateNormal];
        [_webBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_webBtn addTarget:self action:@selector(handleSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _webBtn;
}

- (void)handleSelectAction:(UIButton *)sender{
    [self.view addSubview:self.webView];
    [self clearWbCache];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[self configUrl]]]];
}

#pragma mark -- qlpc btn
- (UIButton *)qlPCBtn{
    if (!_qlPCBtn) {
        _qlPCBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _qlPCBtn.frame = CGRectMake(kScaleWidth(20), kScaleWidth(150), kScreenWidth-kScaleWidth(40), kScaleWidth(44));
        _qlPCBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kScaleWidth(16)];
        _qlPCBtn.backgroundColor = [XSTool colorWithHexString:navcolor];
        [_qlPCBtn setTitle:@"QLPreviewController方式" forState:UIControlStateNormal];
        [_qlPCBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_qlPCBtn addTarget:self action:@selector(handleQLPCAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _qlPCBtn;
}

- (void)handleQLPCAction:(UIButton *)sender{
    [self pushVC:self.qlPC];
}

- (UIButton *)docBtn{
    if (!_docBtn) {
        _docBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _docBtn.frame = CGRectMake(kScaleWidth(20), CGRectGetMaxY(self.qlPCBtn.frame)+kScaleWidth(6), CGRectGetWidth(self.qlPCBtn.frame), CGRectGetHeight(self.qlPCBtn.frame));
        _docBtn.backgroundColor = [XSTool colorWithHexString:navcolor];
        _docBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kScaleWidth(16)];
        [_docBtn setTitle:@"UIDocumentInteractionController" forState:UIControlStateNormal];
        [_docBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_docBtn addTarget:self action:@selector(handleSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _docBtn;
}

- (void)handleDocAction:(UIButton *)sender{
    UIDocumentInteractionController *docVC = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:self.pdfFilePath]];
    docVC.delegate = self;
    [docVC presentPreviewAnimated:YES];
}

#pragma mark -- doc 代理
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    return self;
}

- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller{
    return self.view;
}

- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller{
    return self.view.frame;
}


#pragma mark -- drawPDFBtn
- (UIButton *)drawPDFBtn{
    if (!_drawPDFBtn) {
        _drawPDFBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _drawPDFBtn.frame = CGRectMake(kScaleWidth(20), CGRectGetMaxY(self.docBtn.frame)+kScaleWidth(6), CGRectGetWidth(self.docBtn.frame), CGRectGetHeight(self.docBtn.frame));
        _drawPDFBtn.backgroundColor = [XSTool colorWithHexString:navcolor];
        _drawPDFBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kScaleWidth(16)];
        [_drawPDFBtn setTitle:@"draw+UIPageViewController" forState:UIControlStateNormal];
        [_drawPDFBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_drawPDFBtn addTarget:self action:@selector(handleDrawAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _drawPDFBtn;
}

- (void)handleDrawAction:(UIButton *)sender{
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin] forKey:UIPageViewControllerOptionSpineLocationKey];
    UIPageViewController *pageC = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:dic];
    
    pageC.dataSource = self;
    XSShowPDFVC *pdfVC = [self getVCWithPage:1];
    
    NSArray *vcs = [NSArray arrayWithObject:pdfVC];
    [pageC setViewControllers:vcs direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [self pushVC:pageC];
    
    
}


- (XSShowPDFVC *)getVCWithPage:(NSInteger)page{
    
    
    const char *cfilePath = [self.pdfFilePath UTF8String];
    CFStringRef pathRef = CFStringCreateWithCString(NULL, cfilePath, kCFStringEncodingUTF8);
    CFURLRef url = CFURLCreateWithFileSystemPath(NULL, pathRef, kCFURLPOSIXPathStyle, false);
    CGPDFDocumentRef pdfDocument = CGPDFDocumentCreateWithURL(url);
    XSShowPDFVC *pdfVC = [[XSShowPDFVC alloc]initWIthPage:page withPDFDoc:pdfDocument];
    return pdfVC;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    XSShowPDFVC *pdfVC = (XSShowPDFVC *)viewController;
    if (pdfVC.page - 1 < 1) {
        return nil;
    }
    return [self getVCWithPage:pdfVC.page-1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    XSShowPDFVC *pdfVC = (XSShowPDFVC *)viewController;
    long pageSum = CGPDFDocumentGetNumberOfPages(pdfVC.pdfDocment);

    if (pdfVC.page + 1 > pageSum) {
        return nil;
    }
    return [self getVCWithPage:pdfVC.page+1];
}

@end
