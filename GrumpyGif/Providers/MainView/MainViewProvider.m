//
//  MainViewProvider.m
//  GrumpyGif
//
//  Created by Armando on 08/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import "MainViewProvider.h"
#import "ImageEntity+Model.h"

@implementation MainViewProvider
- (void)loadGifsWithSuccess:(void(^)(NSArray *gifs))successBlock error:(void(^)(NSError *error))errorBlock
{
    /*q - search query term or phrase
     limit - (optional) number of results to return, maximum 100. Default 25.
     offset - (optional) results offset, defaults to 0.
     rating - limit results to those rated (y,g, pg, pg-13 or r).*/
    
    //NSDictionary *parameters=@{@"q":@"Grumpy+Cat"};

    [self.requestHandler GET:@"/v1/gifs/search" parameters:nil completion:^(id data) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{

            NSMutableArray *gifs = [NSMutableArray array];
            for (NSDictionary *gifData in [data valueForKey:@"data"]) {

                ImageEntity *gifEntity = [[ImageEntity alloc] saveGifInMOC:self.managedObjectContext withDictionary:gifData];
                
                [gifs addObject:gifEntity];
            }
            successBlock(gifs);
        });
    } error:^(id data, NSError *error) {
        
    }];
}

- (void)loadGifsFromCoreDataWithSuccess:(void(^)(NSArray *gifs))successBlock error:(void(^)(NSError *error))errorBlock{
    NSFetchRequest *fetchResults = [ImageEntity fetchAllRequest];
    //NSSortDescriptor *nameSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:kImageId ascending:YES];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchResults
                                                                        managedObjectContext:self.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:@"Master"];
    
    // Cache
    //aFetchedResultsController.delegate = (NSFetchedResultsController *)self;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    successBlock([self.fetchedResultsController fetchedObjects]);
}
@end
