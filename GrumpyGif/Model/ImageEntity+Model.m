//
//  ImageEntity+Model.m
//  GrumpyGif
//
//  Created by Armando on 08/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import "ImageEntity+Model.h"
#import "Ponso.h"

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

-(void)saveGifInMOC:(NSManagedObjectContext *)moc withEntity:(Ponso *)gifs{
    
    if(![self checkIfImageIsAlreadyAddedToCoreDataWithId:gifs.imageId inMOC:moc]){

        [self transformPonsoToImageEntity:gifs withMoc:moc];

        NSError *error = nil;
        if (![moc save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}
-(void)saveGifWithEntity:(Ponso *)gifs withMoc:(NSManagedObjectContext *)moc{
    [self saveGifInMOC:moc withEntity:gifs];
}
-(void)transformPonsoToImageEntity:(Ponso *)gif withMoc:(NSManagedObjectContext *)moc{
    
    ImageEntity *gifImage = [NSEntityDescription insertNewObjectForEntityForName:kImageEntity inManagedObjectContext:moc];
    
    gifImage.imageId = gif.imageId;
    gifImage.imageRated = gif.imageRated;
    gifImage.imageSource = gif.imageSource;
    gifImage.imageUrl = gif.imageUrl;
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

-(BOOL) checkIfImageIsAlreadyAddedToCoreDataWithId:(NSString *)imageId inMOC:(NSManagedObjectContext*)moc{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:kImageEntity];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"%K = %@", kImageId, imageId];
    NSError *error;
    NSArray *fetchResult=[moc executeFetchRequest:fetchRequest error:&error];
    
    return fetchResult.count?[fetchResult firstObject]:nil;
}
@end
