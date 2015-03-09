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
