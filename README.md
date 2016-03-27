该控件依赖Masonry自动布局、UIImageView+AFNetworking图片下载框架

1.#import "GLMarkView.h"

2.创建标签视图对象并布局
    self.markView = [[GLMarkView alloc] initWithMarkViewMargin:4];
    [self.view addSubview:self.markView];
    
    __weak typeof(UIView *) weakView = self.view;
    
    [self.markView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakView).offset(10);
        make.top.equalTo(weakView).offset(100);
        make.height.equalTo(@20);
    }];
    
3.添加标签model，model有一些属性可供配置
    //文本标签
    NSArray *titleMarkArray = @[@"标签1", @"标签2", @"标签3", @"标签4"];
    
    //图片标签
    NSArray *imageMarkArray = @[@"http://static.qccr.com/storetag/tag/icon_opening@2x.png"];
    
    NSMutableArray *markModelArray = [NSMutableArray array];
    
    for (NSString *titleMark in titleMarkArray) {
        GLMarkModel *markModel = [GLMarkModel new];
        markModel.markText       = titleMark;
        markModel.markTextInsets = UIEdgeInsetsMake(1, 2, 1, 2);
        
        [markModelArray addObject:markModel];
    }
    
    for (NSString *imageMark in imageMarkArray) {
        GLMarkModel *markModel = [GLMarkModel new];
        markModel.markUrl    = imageMark;
        markModel.isWebImage = YES;
        
        [markModelArray addObject:markModel];
    }
    
    self.markView.markArray = markModelArray;
    
ps：图片标签下载是异步操作，所以整个视图标签的宽度是动态变化的，如果最后你想拿到标签视图的宽度，可以添加kvo，demo中有些
