//
//  MainViewProvider.m
//  GrumpyGif
//
//  Created by Armando on 08/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import "MainViewProvider.h"
#import "ImageEntity+Model.h"

NSString *const kShowId = @"showId";
NSString *const kGifImages = @"images";
NSString *const kGifOriginal = @"original";

@implementation MainViewProvider
- (void)loadGifsWithSuccess:(void(^)(NSArray *gifs))successBlock error:(void(^)(NSError *error))errorBlock
{
    /*q - search query term or phrase
     limit - (optional) number of results to return, maximum 100. Default 25.
     offset - (optional) results offset, defaults to 0.
     rating - limit results to those rated (y,g, pg, pg-13 or r).*/
    
    NSDictionary *parameters=@{@"q":@"Grumpy+Cat"};

    [self.requestHandler GET:@"/v1/gifs/search" parameters:parameters completion:^(id data) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{

            NSMutableArray *gifs = [NSMutableArray array];
            for (NSDictionary *gifData in [data valueForKey:@"data"]) {
                //ImageEntity *show = [ImageEntity updateOrInsertIntoManagedObjectContext:self.managedObjectContext withDictionary:showData];
                //[gifs addObject:gif];
                //ImageEntity *imageGif = [[ImageEntity alloc] init];
                //imageGif.imageId = gifData[kShowId];
                //imageGif.name = gifData[kShowId];
                //imageGif.url = gifData[kGifImages][kGifOriginal];
                
                //[gifs addObject:imageGif];
            }
            successBlock(gifs);
        });
    } error:^(id data, NSError *error) {
        
    }];
}
@end
