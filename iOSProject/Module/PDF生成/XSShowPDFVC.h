//
//  XSShowPDFVC.h
//  iOSProject
//
//  Created by 豆豆 on 2019/12/3.
//  Copyright © 2019 软素. All rights reserved.
//

#import "XSBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface XSShowPDFVC : XSBaseVC

@property(nonatomic,assign)CGPDFDocumentRef pdfDocment;
@property(nonatomic,assign)NSInteger page;

- (instancetype)initWIthPage:(NSInteger)page withPDFDoc:(CGPDFDocumentRef)pdfDoc;

@end

NS_ASSUME_NONNULL_END
