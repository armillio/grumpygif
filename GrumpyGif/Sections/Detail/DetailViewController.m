//
//  DetailViewController.m
//  GrumpyGif
//
//  Created by Armando on 10/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImage+animatedGIF.h"
#import "DetailViewController.h"
#import "UIColor+RandomColors.h"
#import "ImageEntity+Model.h"
#import "UIImageView+WebCache.h"
#import "GrumpyGifStyleKit.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIButton *shareImage;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor randomColor];
    self.shareImage.imageView.image = [GrumpyGifStyleKit imageOfShareWithFrame:CGRectMake(0, 0, 30, 30)];
}
- (IBAction)shareButton:(UIButton *)sender {
}

@end
