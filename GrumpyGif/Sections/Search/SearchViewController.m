//
//  SearchViewController.m
//  GrumpyGif
//
//  Created by Armando on 09/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//
#import "UIColor+RandomColors.h"
#import "DefaultCollectionViewCell.h"
#import "SearchViewController.h"
#import "ImageEntity+Model.h"
#import "UIImage+animatedGIF.h"
#import "SearchViewInteractor.h"
#import "UIImageView+WebCache.h"

NSString *const kSearchCellIdentifier = @"collectionCell";
NSString *const kDictionaryImages = @"images";
NSString *const kDictionaryOriginal = @"original";
NSString *const kDictionaryFixedWidth = @"fixed_width";
NSString *const kDictionaryURL = @"url";

@interface SearchViewController() <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, GestureProtocol>
@property (strong, nonatomic) UICollectionView *searchCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *regularLayout;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) NSArray *gifSearchArray;
@property (nonatomic, assign) CGFloat statusBarHeight;
@property (nonatomic, assign) CGFloat navigationBarHeight;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (nonatomic,strong) SearchViewInteractor *loadSearchViewInteractor;
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
-(void)createActivityIndicator{
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.frame = CGRectMake(self.view.bounds.size.width / 2,
                                              self.view.bounds.size.height / 2,
                                              20,
                                              20);
    [self.view addSubview:self.activityIndicator];
}
- (void)startActivityIndicator {
    [self.activityIndicator setHidden:NO];
    [self.activityIndicator startAnimating];
}
- (void)stopActivityIndicator {
    [self.activityIndicator startAnimating];
    self.activityIndicator.hidden = YES;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor randomColor];
    self.title = @"GrumpyGif";

    [self loadLayout];
    [self loadCollectionView];
    [self loadCollectionCell];
    [self loadSearchBar];
    [self createActivityIndicator];
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
    [self.searchCollectionView registerClass:[DefaultCollectionViewCell class] forCellWithReuseIdentifier:kSearchCellIdentifier];
}
-(void) loadLayout{
    self.regularLayout = [[UICollectionViewFlowLayout alloc] init];
    self.regularLayout.minimumInteritemSpacing = 0;
    self.regularLayout.minimumLineSpacing = 0;
    self.regularLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.regularLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.regularLayout.itemSize = CGSizeMake(self.view.frame.size.width,
                                             (self.view.frame.size.height - self.statusBarHeight - self.navigationBarHeight) / 3.31);
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DefaultCollectionViewCell *cell = [self.searchCollectionView dequeueReusableCellWithReuseIdentifier:kSearchCellIdentifier
                                                                              forIndexPath:indexPath];

    NSDictionary *gif = self.gifSearchArray[indexPath.row];
    cell.indexPath = indexPath;
    cell.whoCalledMe = NSStringFromClass([SearchViewController class]);
    [cell configureCell];
    cell.delegate = self;
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:gif[kGifImages][kGifOriginal][kGifURL]]
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                             }];
    return cell;
}
-(void)swipeToSave:(id)sender{
    CGPoint tappedPoint = [sender locationInView:self.searchCollectionView];
    NSIndexPath *tappedCellPath = [self.searchCollectionView indexPathForItemAtPoint:tappedPoint];
    NSDictionary *gif = self.gifSearchArray[tappedCellPath.row];
    [self.loadSearchViewInteractor saveGifWithDictionary:gif];
    //[self animateCell:tappedCellPath];
}

-(SearchViewInteractor *)loadSearchViewInteractor{
    if(_loadSearchViewInteractor == nil){
        _loadSearchViewInteractor = [[SearchViewInteractor alloc] init];
    }
    return _loadSearchViewInteractor;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = YES;
    searchBar.autocorrectionType = UITextAutocorrectionTypeDefault;
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = NO;
    [self getResultsFromAPI:searchBar];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    searchBar.text = @"";
}
- (void)getResultsFromAPI:(UISearchBar *)searchBar
{
    [self startActivityIndicator];
    self.gifSearchArray = nil;
    [self.searchCollectionView reloadData];

    NSDictionary *parameters=@{@"q":searchBar.text};
    __weak typeof(self) weakSelf = self;
    [self.loadSearchViewInteractor serachGifsWithCompletion:^(NSArray *gifs) {
        __strong typeof(weakSelf) self = weakSelf;
        self.gifSearchArray = [gifs copy];
        [self.searchCollectionView reloadData];
        [self stopActivityIndicator];
    } parameters:parameters error:^(NSError *error) {
        
    }];
    [searchBar resignFirstResponder];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self getResultsFromAPI:searchBar];
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
