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
#import "SearchViewInteractor.h"

NSString *const kSearchCellIdentifier = @"collectionCell";
NSString *const kDictionaryImages = @"images";
NSString *const kDictionaryOriginal = @"original";
NSString *const kDictionaryURL = @"url";

@interface SearchViewController() <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate>
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
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,
                                                                   (self.statusBarHeight + self.navigationBarHeight),
                                                                   self.view.bounds.size.width,
                                                                   44)];
    self.searchBar.delegate = self;
    [self.searchCollectionView addSubview:self.searchBar];
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor randomColor];
    self.title = @"GrumpyGif";
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
    
    NSDictionary *gif = self.gifSearchArray[indexPath.row];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        cell.imageView.image = [UIImage animatedImageWithAnimatedGIFURL:[NSURL URLWithString:gif[kDictionaryImages][kDictionaryOriginal][kDictionaryURL]]];
    });
        
        
    return cell;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = YES;
    searchBar.autocorrectionType = UITextAutocorrectionTypeDefault;
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = NO;
    [self getResultsFromAPI:searchBar];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    searchBar.text = @"";
}
- (void)getResultsFromAPI:(UISearchBar *)searchBar
{
    NSDictionary *parameters=@{@"q":searchBar.text};
    
    __weak typeof(self) weakSelf = self;
    SearchViewInteractor *loadSearchViewInteractor =[[SearchViewInteractor alloc] init];
    [loadSearchViewInteractor serachGifsWithCompletion:^(NSArray *gifs) {
        __strong typeof(weakSelf) self = weakSelf;
        self.gifSearchArray = [gifs copy];
        [self.searchCollectionView reloadData];
    } parameters:parameters error:^(NSError *error) {
        
    }];
    [searchBar resignFirstResponder];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self getResultsFromAPI:searchBar];
}
-(void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar{
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
