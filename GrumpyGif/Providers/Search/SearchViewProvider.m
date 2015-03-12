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
#import "Ponso.h"

@interface SearchViewProvider()
@end

@implementation SearchViewProvider
- (void)searchGifsWithSuccess:(void(^)(NSArray *gifs))successBlock
                   parameters:(NSDictionary *)parameters
                        error:(void(^)(NSError *error))errorBlock{
    [self.requestHandler GET:@"/v1/gifs/search" parameters:parameters completion:^(id data) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSMutableArray *gifs = [NSMutableArray array];
            for (Ponso *gifPonso in [FeedParser parseDataToJson:data] ) {
                [gifs addObject:gifPonso];
            }
            successBlock(gifs);
        });
    } error:^(id data, NSError *error) {
    }];
}

-(void)saveGifWithEntity:(Ponso *)gifs{
    [[ImageEntity alloc] saveGifWithEntity:gifs withMoc:self.managedObjectContext];
}
@end
