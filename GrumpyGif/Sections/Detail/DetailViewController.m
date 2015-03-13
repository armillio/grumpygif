//
//  DetailViewController.m
//  GrumpyGif
//
//  Created by Armando on 10/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImage+animatedGIF.h"
#import "DetailViewInteractor.h"
#import "UIColor+RandomColors.h"
#import "ImageEntity+Model.h"
#import "UIImageView+WebCache.h"
#import "GrumpyGifStyleKit.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
@property (weak, nonatomic) IBOutlet UIButton *shareImage;
@end

@implementation DetailViewController

- (void)setupShareButton {
    //self.shareImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shareImage setImage:[GrumpyGifStyleKit imageOfShareWithFrame:CGRectMake(0,
                                                                                  0,
                                                                                  80,
                                                                                  80)]
                     forState:UIControlStateNormal];
}
- (IBAction)shareButton:(UIButton *)sender {
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDetailView];
    self.view.backgroundColor = [UIColor randomColor];
    [self setupShareButton];
}
-(void)loadDetailView{
    DetailViewInteractor *detailViewInteractor = [[DetailViewInteractor alloc] init];
    ImageEntity *imageDetail = [detailViewInteractor getDataForDetailViewWithImageId:self.imageId];

    [self.detailImageView sd_setImageWithURL:[NSURL URLWithString:imageDetail.imageUrl]
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                             }];
}
@end
