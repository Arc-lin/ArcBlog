//
//  UIImage+Image.h
//  ArcBlog
//
//  Created by Arclin on 15/11/17.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)


+ (instancetype)imageWithOriginalName:(NSString *)imageName;

+ (instancetype)imageWithStretchableName:(NSString *)imageName;

@end
