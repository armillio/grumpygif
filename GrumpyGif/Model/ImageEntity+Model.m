//
//  ImageEntity+Model.m
//  GrumpyGif
//
//  Created by Armando on 08/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import "ImageEntity+Model.h"

@interface ImageEntity() <NSCopying>

@end

NSString *const kImageEntity = @"ImageEntity";

NSString *const kImageId = @"imageId";
NSString *const kImageUrl = @"imageUrl";
NSString *const kImageRated = @"imageRated";
NSString *const kImageSource = @"imageSource";

NSString *const kGifId = @"id";
NSString *const kGifImages = @"images";
NSString *const kGifOriginal = @"original";
NSString *const kGifURL = @"url";
NSString *const kGifSource = @"source";
NSString *const kGifRated = @"rated";

@implementation ImageEntity (Model)

-(ImageEntity *)saveGifInMOC:(NSManagedObjectContext *)moc withDictionary:(NSDictionary *)gifs{
    
    ImageEntity *gifImage;
    
    gifImage = [NSEntityDescription insertNewObjectForEntityForName:kImageEntity inManagedObjectContext:moc];
    
    gifImage.imageId = gifs[kGifId];
    gifImage.imageRated = gifs[kGifRated];
    gifImage.imageSource = gifs[kGifSource];
    gifImage.imageUrl = gifs[kGifImages][kGifOriginal][kGifURL];
    
    NSError *error = nil;
    if (![moc save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return gifImage;
}

#pragma mark - Fetchs

+(NSArray *) fetchAllRequestWithMOC:(NSManagedObjectContext *)moc
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:kImageEntity];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"Error: %@\n%@", [error localizedDescription], [error userInfo]);
        return nil;
    }
    
    return results;
}
+(NSFetchRequest *) fetchAllRequest{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:kImageEntity];
    
    fetchRequest.fetchBatchSize = 9;
    
    NSSortDescriptor *nameSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:kImageId ascending:YES];
    fetchRequest.sortDescriptors = @[nameSortDescriptor];
    
    return fetchRequest;
}

+(BOOL) checkIfImageIsAlreadyAddedToCoreData
{
    //NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:kImageEntity];
    return nil;
}

@end
