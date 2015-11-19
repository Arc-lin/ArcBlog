//
//  UIImage+Image.m
//  ArcBlog
//
//  Created by Arclin on 15/11/17.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)
// instancetype 默认会识别当前是哪个类或者对象调用，就回转换成相对应的对象
// UIImage *

// 加载最原始的图片，没有渲染
+ (instancetype)imageWithOriginalName:(NSString *)imageName{
    
    UIImage *selImage = [UIImage imageNamed:imageName];
    
    selImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return selImage;
}

//创建一个内容可拉伸，而边角不拉伸的图片，需要两个参数，第一个是左边不拉伸区域的宽度，第二个参数是上面不拉伸的高度。

//根据设置的宽度和高度，将接下来的一个像素进行左右扩展和上下拉伸。

+ (instancetype)imageWithStretchableName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}


@end
