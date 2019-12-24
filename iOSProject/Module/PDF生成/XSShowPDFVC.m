//
//  XSShowPDFVC.m
//  iOSProject
//
//  Created by 豆豆 on 2019/12/3.
//  Copyright © 2019 软素. All rights reserved.
//

#import "XSShowPDFVC.h"
#import "XSDrawPDFView.h"

@interface XSShowPDFVC ()

@property(nonatomic,strong)XSDrawPDFView *drawPDFView;

@end

@implementation XSShowPDFVC


- (instancetype)initWIthPage:(NSInteger)page withPDFDoc:(CGPDFDocumentRef)pdfDoc
{
    self = [super init];
    if (self) {
        self.page = page;
        self.pdfDocment = pdfDoc;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    XSDrawPDFView *drawView = [[XSDrawPDFView alloc]initWithFrame:self.view.bounds atPage:self.page withPDFDoc:self.pdfDocment];

    XSDrawPDFView *drawView = [[XSDrawPDFView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), kScreenHeight-navgationHeight) atPage:self.page withPDFDoc:self.pdfDocment];
    drawView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:drawView];
    
}


@end
