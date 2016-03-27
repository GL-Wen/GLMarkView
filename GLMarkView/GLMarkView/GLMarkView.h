//
//  GLMarkView.h
//  AutoLayoutTest
//
//  Created by William on 16/3/25.
//  Copyright © 2016年 William. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLMarkModel : NSObject

/*图片标签属性*/
@property (nonatomic, copy) NSString *markUrl;
@property (nonatomic, copy) NSString *placeHoldImageName;

@property (nonatomic, assign) BOOL isWebImage;

/*文本标签属性*/
//文本标签，如果该字段不为空，不会加载网络图片链接
@property (nonatomic, copy  ) NSString *markText;

@property (nonatomic, strong) UIColor  *markTextColor;
@property (nonatomic, strong) UIColor  *markBackGroundColor;
@property (nonatomic, assign) UIColor  *markLayerBorderColor;

@property (nonatomic, strong) UIFont   *markTextFont;

@property (nonatomic, assign) CGFloat markLayerCorner;
@property (nonatomic, assign) CGFloat markLayerBorderWidth;

@property (nonatomic, assign) UIEdgeInsets markTextInsets;

@end

@interface GLMarkImageView : UIImageView

@property (nonatomic, strong) GLMarkModel *markModel;

@end

@interface GLMarkView : UIView

- (instancetype)initWithMarkViewMargin:(CGFloat)margin;

@property (nonatomic, strong) NSArray *markArray;

@end
