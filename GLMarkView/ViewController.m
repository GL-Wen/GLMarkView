//
//  ViewController.m
//  GLMarkView
//
//  Created by William on 16/3/27.
//  Copyright © 2016年 William. All rights reserved.
//

#import "ViewController.h"
#import "GLMarkView.h"

@interface ViewController ()

@property (nonatomic, strong) GLMarkView *markView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.markView = [[GLMarkView alloc] initWithMarkViewMargin:4];
    [self.view addSubview:self.markView];
    
    __weak typeof(UIView *) weakView = self.view;
    
    [self.markView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakView).offset(10);
        make.top.equalTo(weakView).offset(100);
        make.height.equalTo(@20);
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSLog(@"markView = %@",self.markView);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.markView addObserver:self forKeyPath:@"bounds" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.markView removeObserver:self forKeyPath:@"bounds"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClick:(UIButton *)sender {
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
}

@end
