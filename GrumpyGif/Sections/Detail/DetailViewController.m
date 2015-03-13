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
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *importedDateLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteImage;
@end

CGFloat const kButtonSize = 40.0f;

@implementation DetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDetailView];
    [self setupButtons];
}
-(void)loadDetailView{
    DetailViewInteractor *detailViewInteractor = [[DetailViewInteractor alloc] init];
    ImageEntity *imageDetail = [detailViewInteractor getDataForDetailViewWithImageId:self.imageId];
    
    [self.detailImageView sd_setImageWithURL:[NSURL URLWithString:imageDetail.imageUrl]
                                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                   }];
    self.ratingLabel.text = imageDetail.imageRating;
    self.captionLabel.text = imageDetail.imageCaption;
    self.sourceLabel.text = imageDetail.imageSource;
    self.importedDateLabel.text = [NSString stringWithFormat:@"%@", imageDetail.imageImportDate];
}
- (void)setupButtons {
    [self.shareImage setImage:[GrumpyGifStyleKit imageOfShareWithFrame:CGRectMake(0, 0, kButtonSize, kButtonSize)]
                     forState:UIControlStateNormal];
    [self.deleteImage setImage:[GrumpyGifStyleKit imageOfEliminateWithFrame:CGRectMake(0, 0, kButtonSize, kButtonSize)]
                      forState:UIControlStateNormal];}
- (IBAction)shareGif:(id)sender {
}
- (IBAction)deleteImageInCoreData:(id)sender {
}



@end
