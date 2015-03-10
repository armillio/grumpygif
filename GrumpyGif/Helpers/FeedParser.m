//
//  FeedParser.m
//  GrumpyGif
//
//  Created by Armando on 10/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import "FeedParser.h"

@implementation FeedParser

-(NSArray *) parseDataToJson:(NSData *)data{
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                               options:0
                                                                 error:nil];
    
    
    return jsonObject;
}
@end
