//
//  FeedParser.m
//  GrumpyGif
//
//  Created by Armando on 10/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import "FeedParser.h"
#import "Ponso.h"
#import "ImageEntity+Model.h"

@implementation FeedParser

+(NSArray *) parseDataToJson:(NSData *)data{
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                               options:0
                                                                 error:nil];
    NSMutableArray *parseArray = [NSMutableArray array];
    for (NSDictionary *parseDictionary in [jsonObject valueForKey:@"data"]) {
        Ponso *ponsoImage = [[Ponso alloc] init];

        ponsoImage.imageId = parseDictionary[kGifId];
        ponsoImage.imageRating = parseDictionary[kGifRating];
        ponsoImage.imageSource = parseDictionary[kGifSource];
        ponsoImage.imageUrl = parseDictionary[kGifImages][kGifOriginal][kGifURL];
        ponsoImage.imageCaption = parseDictionary[kGifCaption];
        ponsoImage.imageOriginalUrl = parseDictionary[kGifImages][kGifOriginal][kGifURL];
        ponsoImage.imageImportDate = parseDictionary[kGifImportDate];
        
        [parseArray addObject:ponsoImage];
    }
        
    return [parseArray copy];
}
@end
