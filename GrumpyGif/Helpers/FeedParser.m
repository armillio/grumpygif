//
//  FeedParser.m
//  GrumpyGif
//
//  Created by Armando on 10/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import "FeedParser.h"
#import "Poyo.h"
#import "ImageEntity+Model.h"

@implementation FeedParser

+(NSArray *) parseDataToJson:(NSData *)data{
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                               options:0
                                                                 error:nil];
    /*NSMutableArray *parseArray = [NSMutableArray array];
    for (NSDictionary *parseDictionary in [jsonObject valueForKey:@"data"]) {
        Poyo *poyoImage = [[Poyo alloc] init];

        poyoImage.imageId = parseDictionary[kGifId];
        poyoImage.imageRated = parseDictionary[kGifRated];
        poyoImage.imageSource = parseDictionary[kGifSource];
        poyoImage.imageUrl = parseDictionary[kGifImages][kGifOriginal][kGifURL];
        
        NSMutableDictionary *fakeDictionary = [NSMutableDictionary dictionary];
        [fakeDictionary addEntriesFromDictionary:@{@"imageId" : parseDictionary[kGifId],
                                                   @"imageRated" : parseDictionary[kGifRated],
                                                   @"imageSource" : parseDictionary[kGifSource],
                                                   @"imageUrl" : parseDictionary[kGifImages][kGifOriginal][kGifURL]}];
        
        [parseArray addObject:[fakeDictionary copy]];
    }*/
    
    return [jsonObject valueForKey:@"data"];
    
    //return parseArray;
}
@end
