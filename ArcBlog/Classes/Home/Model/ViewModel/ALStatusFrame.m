//
//  ALStatusFrame.m
//  ArcBlog
//
//  Created by Arclin on 15/12/19.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "ALStatusFrame.h"
#import "ALStatus.h"
#import "ALUser.h"

@implementation ALStatusFrame
- (void)setStatus:(ALStatus *)status{
    
    _status = status;
    
    // 计算原创微博
    [self setUpOriginalViewFrame];
    
    CGFloat toolBarY = CGRectGetMaxY(_originalViewFrame);
    
    if (status.retweeted_status) {
        
        // 计算转发微博
        [self setUpRetweetViewFrame];
        
        toolBarY = CGRectGetMaxY(_retweetViewFrame);
    
    }
    
    // 计算工具条
    CGFloat toolBarX = 0;
    CGFloat toolBarW = ALScreenW;
    CGFloat toolBarH = 35;
    _toolBarFrame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    // 计算cell高度
    _cellHeight = CGRectGetMaxY(_toolBarFrame);
}
#pragma mark - 计算原创微博
- (void)setUpOriginalViewFrame{
    // 头像
    CGFloat imageX = ALStatusCellMargin;
    CGFloat imageY = imageX;
    CGFloat imageWH = 35;
    _originalIconFrame = CGRectMake(imageX, imageY, imageWH,imageWH);
    
    // 昵称
    CGFloat nameX = CGRectGetMaxX(_originalIconFrame) + ALStatusCellMargin;
    CGFloat nameY = imageY;
    CGSize nameSize = [_status.user.name sizeWithAttributes:@{NSFontAttributeName:ALNameFont}];
    _originalNameFrame = (CGRect){{nameX,nameY},nameSize};
    
    // vip
    if (_status.user.vip) {
        CGFloat vipX = CGRectGetMaxX(_originalNameFrame) + ALStatusCellMargin;
        CGFloat vipY = nameY;
        CGFloat vipWH = 14;
        _originalVipFrame = CGRectMake(vipX, vipY, vipWH, vipWH);
    }
    
//    // 时间
//    CGFloat timeX = nameX;
//    CGFloat timeY = CGRectGetMaxY(_originalNameFrame) + ALStatusCellMargin * 0.5;
//    CGSize timeSize = [_status.created_at sizeWithAttributes:@{NSFontAttributeName:ALTimeFont}];
//    _originalTimeFrame = (CGRect){{timeX,timeY},timeSize};
//    
//    // 来源
//    CGFloat sourceX = CGRectGetMaxX(_originalTimeFrame) + ALStatusCellMargin;
//    CGFloat sourceY = timeY;
//    CGSize  sourceSize = [_status.source sizeWithAttributes:@{NSFontAttributeName:ALSourceFont}];
//    _originalSourceFrame = (CGRect){{sourceX,sourceY},sourceSize};
    
    // 正文
    CGFloat textX = imageX;
    CGFloat textY = CGRectGetMaxY(_originalIconFrame) + ALStatusCellMargin;
    CGFloat screenW = ALScreenW;
    CGFloat textW = screenW - 2 * ALStatusCellMargin;
    CGSize textSize = [_status.text boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:ALTextFont} context:nil].size;
//    CGSize textSize = [_status.text sizeWithFont:ALTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _originalTextFrame = (CGRect){{textX,textY},textSize};
    
    // 原创微博的frame
    CGFloat originX = 0;
    CGFloat originY = 10;
    CGFloat originW = ALScreenW;
    CGFloat originH = CGRectGetMaxY(_originalTextFrame) + ALStatusCellMargin;
    _originalViewFrame = CGRectMake(originX, originY, originW, originH);
    
}


#pragma mark - 计算转发微博
- (void)setUpRetweetViewFrame{
    
    // 昵称frame
    CGFloat nameX = ALStatusCellMargin;
    CGFloat nameY = nameX;
    // 注意：一定要是转发微博的用户昵称
    CGSize nameSize = [_status.retweetName sizeWithAttributes:@{NSFontAttributeName:ALNameFont}];
    _retweetNameFrame = (CGRect){{nameX,nameY},nameSize};
    
    // 正文frame
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(_retweetNameFrame) + ALStatusCellMargin;
    
    CGFloat textW = ALScreenW - 2 * ALStatusCellMargin;
    CGSize textSize = [_status.retweeted_status.text boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:ALTextFont} context:nil].size;
    _retweetTextFrame = (CGRect){{textX,textY},textSize};

    // 转发微博frame
    CGFloat retweetX = 0;
    CGFloat retweetY = CGRectGetMaxY(_originalViewFrame);
    CGFloat retweetW = ALScreenW;
    CGFloat retweetH = CGRectGetMaxY(_retweetTextFrame) + ALStatusCellMargin;
    _retweetViewFrame = CGRectMake(retweetX, retweetY, retweetW, retweetH);

}
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:nil];
    return dic;
}

@end
