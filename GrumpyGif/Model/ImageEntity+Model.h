//
//  ImageEntity+Model.h
//  GrumpyGif
//
//  Created by Armando on 08/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import "ImageEntity.h"
@class Ponso;

extern NSString *const kImageEntity;

extern NSString *const kImageId;
extern NSString *const kImageUrl;
extern NSString *const kImageRated;
extern NSString *const kImageSource;

extern NSString *const kGifId;
extern NSString *const kGifImages;
extern NSString *const kGifOriginal;
extern NSString *const kGifURL;
extern NSString *const kGifSource;
extern NSString *const kGifRated;

@interface ImageEntity (Model)
+(NSFetchRequest *) fetchAllRequest;
+(NSArray *) fetchAllRequestWithMOC:(NSManagedObjectContext *)moc;
-(void)saveGifWithEntity:(Ponso *)gifs
                 withMoc:(NSManagedObjectContext *)moc;
@end
