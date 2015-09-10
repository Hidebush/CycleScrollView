//
//  cycleViewController.m
//  图片无限轮播
//
//  Created by Theshy on 15/8/31.
//  Copyright © 2015年 Theshy. All rights reserved.
//

#import "cycleViewController.h"
#import "circleImageCell.h"


@interface cycleViewController ()
@property (nonatomic, strong) NSArray *imageUrls;

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (nonatomic, assign) NSInteger imageIndex;

@end

@implementation cycleViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self prepareLayout];
}
- (void)prepareLayout {
    self.layout.minimumInteritemSpacing = 0;
    self.layout.minimumLineSpacing = 0;
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.layout.itemSize = self.view.bounds.size;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
//    self.collectionView.contentSize = CGSizeMake(kScreenSize.width * self.imageUrls.count, 200);
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
    [self.collectionView scrollToItemAtIndexPath: indexPath atScrollPosition:0 animated:NO];
    
}

#pragma mark - 数据源方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageUrls.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    circleImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[circleImageCell alloc] init];
    }
    
    // 显示图片索引
    // indexPath.item 上边已经设置为显示1   减去1 表示为0  item的值也为 -1 0 1 决定拖动时候下一个cell的图片  去掉后拖动时下一张图片是当前图片 拖动完毕才显示应该显示的图片
    NSInteger index = (indexPath.item - 1 + self.imageUrls.count + self.imageIndex) % self.imageUrls.count;
    NSLog(@"self.imageIndex=========%zd",self.imageIndex);
    NSLog(@"indexPath.item=========%zd",indexPath.item);
    cell.url = self.imageUrls[index];
    return cell;
}

#pragma mark - 代理方法

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger offset = scrollView.contentOffset.x / scrollView.bounds.size.width - 1;
    NSLog(@"%zd",offset);
    // 当前图片索引 加上 offset值  为下一个图片索引   offset -1 、0 、 1 变化 决定方向
    self.imageIndex = (self.imageIndex + offset + self.imageUrls.count) % self.imageUrls.count;
    [scrollView setContentOffset:CGPointMake(self.view.bounds.size.width, 0)];
}


- (NSArray *)imageUrls {
    if (_imageUrls == nil) {
        NSMutableArray *arrM = [NSMutableArray array];
        for (int i = 0; i<10; i++) {
            NSURL *url = [[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"%02d.jpg",i +1] withExtension:nil];
            [arrM addObject:url];
        }
        _imageUrls = arrM.copy;
    }
    return _imageUrls;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
