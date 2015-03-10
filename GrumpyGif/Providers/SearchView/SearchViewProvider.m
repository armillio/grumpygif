//
//  SearchViewProvider.m
//  GrumpyGif
//
//  Created by Armando on 09/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import "SearchViewProvider.h"
#import "ImageEntity+Model.h"
#import "FeedParser.h"

@implementation SearchViewProvider
- (void)searchGifsWithSuccess:(void(^)(NSArray *gifs))successBlock parameters:(NSDictionary *)parameters error:(void(^)(NSError *error))errorBlock{
    /*q - search query term or phrase
     limit - (optional) number of results to return, maximum 100. Default 25.
     offset - (optional) results offset, defaults to 0.
     rating - limit results to those rated (y,g, pg, pg-13 or r).*/
    __weak typeof(self) weakSelf = self;
    [self.requestHandler GET:@"/v1/gifs/search" parameters:parameters completion:^(id data) {
        __strong typeof(weakSelf) self = weakSelf;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSMutableArray *gifs = [NSMutableArray array];
            for (NSDictionary *gifData in [FeedParser parseDataToJson:data] ) {
                ImageEntity *gifEntity = [[ImageEntity alloc] saveGifInMOC:self.managedObjectContext withDictionary:gifData];
                [gifs addObject:gifEntity];
            }
            successBlock(gifs);
        });
    } error:^(id data, NSError *error) {
    }];
}
@end
