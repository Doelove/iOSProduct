//
//  XSDrawPDFView.m
//  iOSProject
//
//  Created by 豆豆 on 2019/12/3.
//  Copyright © 2019 软素. All rights reserved.
//

#import "XSDrawPDFView.h"

@implementation XSDrawPDFView

- (instancetype)initWithFrame:(CGRect)frame atPage:(NSInteger)page withPDFDoc:(CGPDFDocumentRef)pdfDoc
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.page = page;
        self.pdfDocment = pdfDoc;
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 调整坐标
    CGContextTranslateCTM(context, 0.0, kScreenHeight-navgationHeight); //先垂直下移height高度
    CGContextScaleCTM(context, 1.0, -1.0); //再垂直向上翻转
    
    // 绘制pdf内容
    CGPDFPageRef pageRef = CGPDFDocumentGetPage(self.pdfDocment, self.page);
    CGContextSaveGState(context);
    CGAffineTransform pdfTransform = CGPDFPageGetDrawingTransform(pageRef, kCGPDFCropBox, self.bounds, 0, true);
    CGContextConcatCTM(context, pdfTransform);
    CGContextDrawPDFPage(context, pageRef);
    CGContextRestoreGState(context);
    
}


@end
