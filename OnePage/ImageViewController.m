//
//  ImageViewController.m
//  OnePage
//
//  Created by lanouhn on 15/7/30.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import "ImageViewController.h"
#import "UIImageView+WebCache.h"

@interface ImageViewController ()
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.view.backgroundColor = [UIColor blackColor];
    
    //添加imageView,让imageView的中心点是屏幕的中心点
    self.imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.imageView.center = self.view.center;
    //让图片进行居中显示.这个居中是包括了，横向和纵向都是居中。图片不会拉伸或者压缩，就是按照imageView的frame和图片的大小来居中显示的
    self.imageView.contentMode =  UIViewContentModeCenter; ;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.imageURL] placeholderImage:[UIImage imageNamed:@"Profile_filter_ImageIcon"]];
    self.imageView.userInteractionEnabled = YES;
    
    //添加轻拍手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    //设置长按手势的时间
    longPress.minimumPressDuration = 0.5;
    [self.imageView addGestureRecognizer:longPress];
    
    [self.view addSubview:self.imageView];
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)longPress {
    //判断手势的状态,当识别是长按手势时处理事件
    if (longPress.state == UIGestureRecognizerStateBegan) {
        //获取长按手势的视图对象
        UIImageView *saveImage = (UIImageView *)longPress.view;
        //将长按图片把保存到相册
        UIImageWriteToSavedPhotosAlbum(saveImage.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
    }
}

#pragma mark - 判断图片是否保存成功
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (!error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"存储照片成功" message:@"您已将照片存储于图片库中，打开图库即可查看。" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];

    }else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"存储照片失败" message:@"亲,请检查您的网络." delegate:self cancelButtonTitle:@"OK"
            otherButtonTitles:nil];
        [alert show];

    }
}




- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
