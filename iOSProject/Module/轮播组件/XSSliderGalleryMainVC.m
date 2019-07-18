//
//  XSSliderGalleryMainVC.m
//  iOSProject
//
//  Created by 豆豆 on 2019/7/18.
//  Copyright © 2019 软素. All rights reserved.
//

#import "XSSliderGalleryMainVC.h"
#import "XSSliderGalleryVC.h"

@interface XSSliderGalleryMainVC ()<SliderGalleryDelegate>

@property(nonatomic,strong)XSSliderGalleryVC *sliderGallery;
@property(nonatomic,strong)NSArray *images;

@end

@implementation XSSliderGalleryMainVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.images = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504004923313&di=290336ef2d0ef2f52b43402e9bbb6c74&imgtype=0&src=http%3A%2F%2Fimg1.qq.com%2Fauto%2Fpics%2F4465%2F4465381.jpg",
    @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504004923308&di=9ad44bf39d30b972566fc8e31ded4906&imgtype=0&src=http%3A%2F%2Fimg1.gtimg.com%2Fluxury%2Fpics%2Fhv1%2F245%2F196%2F674%2F43877075.jpg",
    @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504004923322&di=9a9865223172c8dcf3f488e484eab29b&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fphotoblog%2F1311%2F27%2Fc13%2F29070478_29070478_1385557908649_mthumb.jpg"];
    
    
//    self.sliderGallery.view.frame = CGRectMake(0, 0, kScreenWidth, kScaleWidth(200));
//    [self addChildViewController:self.sliderGallery];
    [self.view addSubview:self.sliderGallery];
    
    
    
    
}

- (XSSliderGalleryVC *)sliderGallery{
    if (!_sliderGallery) {
        _sliderGallery = [[XSSliderGalleryVC alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScaleWidth(200)) size:CGSizeMake(kScreenWidth, kScaleWidth(200)) dataSource:self.images];
    }
    return _sliderGallery;
}

- (NSArray *)galleryDataSource{
    return self.images;
}

- (CGSize)galleryScrollerViewSize{
    return CGSizeMake(kScreenWidth, kScaleWidth(200));
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
