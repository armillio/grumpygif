//
//  SearchViewController.m
//  GrumpyGif
//
//  Created by Armando on 09/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//
#import "UIColor+RandomColors.h"
#import "MainViewCell.h"
#import "SearchViewController.h"
#import "ImageEntity+Model.h"
#import "UIImage+animatedGIF.h"

NSString *const kSearchCellIdentifier = @"collectionCell";

@interface SearchViewController() <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, UISearchControllerDelegate, UISearchDisplayDelegate, UISearchResultsUpdating>
@property (strong, nonatomic) UICollectionView *searchCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *regularLayout;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) NSArray *gifSearchArray;
@property (nonatomic, assign) CGFloat statusBarHeight;
@property (nonatomic, assign) CGFloat navigationBarHeight;
@end
@implementation SearchViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatusAndNavigationHeightVariables];
}
- (void)loadSearchBar {
    self.searchBar.delegate = self;
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,
                                                                   (self.statusBarHeight + self.navigationBarHeight),
                                                                   self.view.bounds.size.width,
                                                                   44)];
    [self.searchCollectionView addSubview:self.searchBar];
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor randomColor];
    self.title = @"GrumpyGif";
    [self loadImageData];
    [self loadLayout];
    [self loadCollectionView];
    [self loadCollectionCell];
    [self loadSearchBar];
}
-(void) setStatusAndNavigationHeightVariables{
    self.statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    self.navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
}
-(void) loadCollectionView{
    self.searchCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                             collectionViewLayout:self.regularLayout];
    self.searchCollectionView.dataSource = self;
    self.searchCollectionView.delegate = self;
    
    self.searchCollectionView.backgroundColor = [UIColor randomColor];
    [self.view addSubview:self.searchCollectionView];
}
-(void) loadCollectionCell{
    [self.searchCollectionView registerClass:[MainViewCell class] forCellWithReuseIdentifier:kSearchCellIdentifier];
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
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MainViewCell *cell = [self.searchCollectionView dequeueReusableCellWithReuseIdentifier:kSearchCellIdentifier forIndexPath:indexPath];
    
    if(cell == nil){
        cell = [[MainViewCell alloc] init];
    }
    
    ImageEntity *gif = self.gifSearchArray[indexPath.row];
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       // cell.imageView.image = [UIImage animatedImageWithAnimatedGIFURL:[NSURL URLWithString:gif.imageUrl]];
         cell.imageView.image = [UIImage imageNamed:self.gifSearchArray[indexPath.row]];
    });
    return cell;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.gifSearchArray.count;
}
-(NSArray *)gifSearchArray{
    if(_gifSearchArray == nil){
        _gifSearchArray = [[NSArray alloc] init];
    }
    
    return _gifSearchArray;
}
@end
