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
#import <Social/Social.h>

@interface DetailViewController ()<UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
@property (weak, nonatomic) IBOutlet UIButton *shareImage;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *importedDateLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteImage;
@property (strong, nonatomic) NSString *originalImageUrl;
@property (strong, nonatomic) NSString *detailImageId;
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
    ImageEntity *gifImage = [detailViewInteractor getDataForDetailViewWithImageId:self.imageId];
    
    [self.detailImageView sd_setImageWithURL:[NSURL URLWithString:gifImage.imageUrl]
                                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                   }];
    self.ratingLabel.text = gifImage.imageRating;
    self.captionLabel.text = gifImage.imageCaption;
    self.detailImageId = gifImage.imageId;
    if(gifImage.imageOriginalUrl) {
        self.originalImageUrl = gifImage.imageOriginalUrl;
    }else{
        self.originalImageUrl = gifImage.imageUrl;
    }
    self.importedDateLabel.text = [NSString stringWithFormat:@"%@", gifImage.imageImportDate];
}
- (void)setupButtons {
    [self.shareImage setImage:[GrumpyGifStyleKit imageOfShareWithFrame:CGRectMake(0, 0, kButtonSize, kButtonSize)]
                     forState:UIControlStateNormal];
    [self.deleteImage setImage:[GrumpyGifStyleKit imageOfEliminateWithFrame:CGRectMake(0, 0, kButtonSize, kButtonSize)]
                      forState:UIControlStateNormal];
}
- (IBAction)shareGif:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Share this Image"
                                                             delegate:self
                                                    cancelButtonTitle:@"OK"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Post to Twitter", @"Post to Facebook", nil];
    [actionSheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.originalImageUrl]];
    UIImage *image = [UIImage imageWithData:imageData];
    switch (buttonIndex) {
        case 0:
            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
                SLComposeViewController *controllerSLCTwitter = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
                [controllerSLCTwitter addImage:image];
                [self presentViewController:controllerSLCTwitter animated:YES completion:Nil];
            }
            break;
        case 1:
            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
                SLComposeViewController *controllerSLCFacebook = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
                [controllerSLCFacebook addImage:image];
                [self presentViewController:controllerSLCFacebook animated:YES completion:Nil];
            }
            break;
        default:
            break;
    }
}
- (IBAction)deleteImageInCoreData:(id)sender {
    DetailViewInteractor *detailViewInteractor = [[DetailViewInteractor alloc] init];
    if([detailViewInteractor deleteImageWithId:self.imageId]){
        [self.navigationController popViewControllerAnimated:YES];
    }
}



@end
