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
    
    
    self.baseDomain = @"http://api.giphy.com/v1/gifs/search?api_key=dc6zaTOxFJmzC&q=";
    self.baseDomain = [NSString stringWithFormat:@"%@%@", self.baseDomain, [parameters[@"q"] stringByReplacingOccurrencesOfString:@" " withString:@"+" ]];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config
                                                          delegate:nil
                                                     delegateQueue:NSOperationQueuePriorityNormal];

    [[session dataTaskWithURL:[NSURL URLWithString:self.baseDomain]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                
                successBlock(data);
            }] resume];
}

@end
