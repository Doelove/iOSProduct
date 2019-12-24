//
//  XSDrawPDFView.h
//  iOSProject
//
//  Created by 豆豆 on 2019/12/3.
//  Copyright © 2019 软素. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XSDrawPDFView : UIView

@property(nonatomic,assign)CGPDFDocumentRef pdfDocment;
@property(nonatomic,assign)NSInteger page;

- (instancetype)initWithFrame:(CGRect)frame atPage:(NSInteger)page withPDFDoc:(CGPDFDocumentRef)pdfDoc;


@end

NS_ASSUME_NONNULL_END
