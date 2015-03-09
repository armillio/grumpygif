//
//  GifCatcher.m
//  GrumpyGif
//
//  Created by Armando on 08/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import "GifCatcher.h"

NSString *const apiKey = @"dc6zaTOxFJmzC";

@implementation GifCatcher

@synthesize baseDomain = _baseDomain;
@synthesize baseParameters = _baseParameters;

-(void) GET:(NSString *)endpoint parameters:(NSDictionary *)parameters
 completion:(SuccessBlock)successBlock error:(ErrorBlock)errorBlock{
    
    
    self.baseDomain = @"http://api.giphy.com/v1/gifs/search?q=grumpy+cat&api_key=dc6zaTOxFJmzC";
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config
                                                          delegate:nil
                                                     delegateQueue:NSOperationQueuePriorityNormal];
    //

    [[session dataTaskWithURL:[NSURL URLWithString:self.baseDomain]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                                           options:0
                                                                             error:nil];
                successBlock(jsonObject);
            }] resume];
}

@end
