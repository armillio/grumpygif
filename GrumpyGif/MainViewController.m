//
//  MainViewController.m
//  GrumpyGif
//
//  Created by Armando on 07/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import "MainViewController.h"
#import "UIColor+RandomColors.m"
#import "MainViewCell.h"
#import "GrumpyGifStyleKit.h"

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

-(void) loadSearchButton{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
                                    initWithImage:[GrumpyGifStyleKit imageOfSearchWithFrame:CGRectMake(0, 0, 20, 20)]
                                    style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(loadSearchView)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

-(void)loadSearchView{
    
}

-(void) setStatusAndNavigationHeightVariables{
    self.statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    self.navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"GrumpyGif";
    
    [self loadImageData];
    [self loadLayout];
    [self loadCollectionView];
    [self loadCollectionCell];
}

-(void) loadImageData{
    self.gifArray = @[@"giphy.gif",@"giphy.gif",@"giphy.gif",@"giphy.gif",@"giphy.gif",
                      @"giphy.gif",@"giphy.gif",@"giphy.gif",@"giphy.gif",@"giphy.gif"];
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
    [self.collectionView registerClass:[MainViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
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
    
    MainViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    if(cell == nil){
        cell = [[MainViewCell alloc] init];
    }
    
    NSString *imageName = self.gifArray[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:imageName];
    
    return cell;
}

@end
