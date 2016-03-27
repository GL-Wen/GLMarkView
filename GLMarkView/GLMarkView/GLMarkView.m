//
//  GLMarkView.m
//  AutoLayoutTest
//
//  Created by William on 16/3/25.
//  Copyright © 2016年 William. All rights reserved.
//

#import "GLMarkView.h"

@interface GLMarkImageView ()

@end

@implementation GLMarkImageView

#pragma mark - InitView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentMode = UIViewContentModeScaleAspectFill;
    }
    return self;
}

- (CGSize)intrinsicContentSize
{
    CGSize size = [super intrinsicContentSize];
    if (size.width < 0)
        size.width = 0;
    
    if (size.height < 0)
        size.height = 0;
    
    return size;
}

#pragma mark - Self

- (void)updateMarkImage
{
    if (self.markModel.isWebImage) {
        [self setImageWithURL:[NSURL URLWithString:self.markModel.markUrl] placeholderImage:[UIImage imageNamed:self.markModel.placeHoldImageName]];
    }
    else
    {
        [self setImage:[UIImage imageNamed:self.markModel.markUrl]];
    }
}

#pragma mark - Set

- (void)setImage:(UIImage *)image
{
    [super setImage:image];
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.intrinsicContentSize);
    }];
    
    [self.superview updateConstraints];
}

- (void)setMarkModel:(GLMarkModel *)markModel
{
    _markModel = nil;
    _markModel = markModel;
    
    [self updateMarkImage];
}

@end

@implementation GLMarkModel


@end

@interface GLMarkView ()

@property (nonatomic, assign) CGFloat margin;

@property (nonatomic, strong) NSMutableArray *markSubViewArray;

@property (nonatomic, strong) UILabel *markTextLabel;

@end

@implementation GLMarkView

#pragma mark - InitView

- (instancetype)initWithMarkViewMargin:(CGFloat)margin;
{
    if (self = [super init]) {

        self.margin           = margin;
        self.markSubViewArray = [NSMutableArray array];
    }
    return self;
}

#pragma mark - Self

- (void)initMarkSubView
{
    [self.markSubViewArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.markSubViewArray removeAllObjects];
    
    UIView *beforeView = nil;
    for (GLMarkModel *markModel in self.markArray) {
        
        UIView *markView = nil;
        BOOL isTextMark  = NO;
        
        if ([markModel.markText isKindOfClass:[NSString class]] && markModel.markText.length) {
            UILabel *markLabel = [UILabel new];
            markLabel.text            = markModel.markText;
            markLabel.font            = markModel.markTextFont ?: [UIFont systemFontOfSize:12];
            markLabel.textColor       = markModel.markTextColor ?: [UIColor whiteColor];
            markLabel.backgroundColor = markModel.markBackGroundColor ?: [UIColor redColor];
            markLabel.textAlignment   = NSTextAlignmentCenter;
            
            markLabel.layer.cornerRadius  = markModel.markLayerCorner;
            markLabel.layer.borderColor   = markModel.markLayerBorderColor.CGColor;
            markLabel.layer.borderWidth   = markModel.markLayerBorderWidth;
            markLabel.layer.masksToBounds = YES;
            
            markView   = markLabel;
            isTextMark = YES;
        }
        else
        {
            GLMarkImageView *markImageView = [GLMarkImageView new];
            markImageView.markModel = markModel;
            
            markView = markImageView;
        }
        
        [self addSubview:markView];
        
        CGSize contentSize = markView.intrinsicContentSize;
        if (isTextMark) {
            contentSize.width  += markModel.markTextInsets.left + markModel.markTextInsets.right;
            contentSize.height += markModel.markTextInsets.top + markModel.markTextInsets.bottom;
        }
        
        [markView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.size.mas_equalTo(contentSize);
        }];
        
        if (beforeView) {
            [markView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(beforeView.mas_right).offset(self.margin);
            }];
        }
        else
        {
            [markView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self);
            }];
        }
        
        beforeView = markView;
        [self.markSubViewArray addObject:markView];
    }
    
    UIView *markView = [self.markSubViewArray lastObject];
    if (markView) {
        [markView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right);
        }];
    }
}

#pragma mark - Set

- (void)setMarkArray:(NSArray *)markArray
{
    _markArray = nil;
    _markArray = markArray;
    
    [self initMarkSubView];
}

#pragma mark - Get

- (UILabel *)markTextLabel
{
    if (!_markTextLabel){
        _markTextLabel = [UILabel new];
    }
    return _markTextLabel;
}

@end
