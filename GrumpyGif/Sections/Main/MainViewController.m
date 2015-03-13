//
//  MainViewController.m
//  GrumpyGif
//
//  Created by Armando on 07/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//
#import "UIImage+animatedGIF.h"
#import "MainViewController.h"
#import "UIColor+RandomColors.h"
#import "DefaultCollectionViewCell.h"
#import "GrumpyGifStyleKit.h"
#import "MainViewInteractor.h"
#import "ImageEntity+Model.h"
#import "SearchViewController.h"
#import "UIImageView+WebCache.h"
#import "DetailViewController.h"

NSString *const kCellIdentifier = @"collectionCell";

@interface MainViewController() <UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *regularLayout;
@property (nonatomic, assign) CGFloat statusBarHeight;
@property (nonatomic, assign) CGFloat navigationBarHeight;
@property (nonatomic, strong) NSArray *gifArray;
@end

@implementation MainViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatusAndNavigationHeightVariables];
    [self loadSearchButton];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadImageData];
}
-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"GrumpyGif";
    
    [self loadLayout];
    [self loadCollectionView];
    [self loadCollectionCell];
}
-(void) loadSearchButton{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
                                    initWithImage:[GrumpyGifStyleKit imageOfSearchWithFrame:CGRectMake(0, 0, 20, 20)]
                                    style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(loadSearchView)];
    self.navigationItem.rightBarButtonItem = rightButton;
}
-(void)loadSearchView{
    SearchViewController *svc = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:svc animated:YES];
}
-(void) setStatusAndNavigationHeightVariables{
    self.statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    self.navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
}
-(NSArray *)gifArray{
    if(_gifArray == nil){
        _gifArray = [[NSArray alloc] init];
    }
    return _gifArray;
}
-(void) loadImageData{
    MainViewInteractor *loadMainViewInteractor =[[MainViewInteractor alloc] init];
    __weak typeof(self) weakSelf = self;
    [loadMainViewInteractor  loadGifsFromCoreDataWithCompletion:^(NSArray *gifs) {
        __strong typeof(weakSelf) self = weakSelf;
        self.gifArray = [gifs copy];
        [self.collectionView reloadData];
    } error:^(NSError *error) {
    }];
}
-(void) loadCollectionView{
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                             collectionViewLayout:self.regularLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    self.collectionView.backgroundColor = [UIColor randomColor];
    [self.view addSubview:self.collectionView];
}
-(void) loadCollectionCell{
    [self.collectionView registerClass:[DefaultCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
}
-(void) loadLayout
{
    self.regularLayout = [[UICollectionViewFlowLayout alloc] init];
    self.regularLayout.minimumInteritemSpacing = 0;
    self.regularLayout.minimumLineSpacing = 0;
    self.regularLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.regularLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.regularLayout.itemSize = CGSizeMake(self.view.frame.size.width,
                                             (self.view.frame.size.height - self.statusBarHeight - self.navigationBarHeight) / 3.31);
}
-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section{

    return self.gifArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DefaultCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
        
    cell.indexPath = indexPath;
    cell.whoCalledMe = NSStringFromClass([MainViewController class]);
    [cell reloadInputViews];
    ImageEntity *gifImage = self.gifArray[indexPath.row];
    cell.imageId = gifImage.imageId;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:gifImage.imageUrl]
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                             }];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *dvc = [[DetailViewController alloc] initWithNibName:NSStringFromClass([DetailViewController class]) bundle:nil];
    DefaultCollectionViewCell *selectedCell = (DefaultCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    dvc.imageId = selectedCell.imageId;
    
    [self.navigationController pushViewController:dvc animated:YES];
}
@end
