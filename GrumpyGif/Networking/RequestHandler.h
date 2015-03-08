//
//  RequestHandler.h
//  GrumpyGif
//
//  Created by Armando on 08/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SuccessBlock)(id data);
typedef void (^ErrorBlock)(id data,NSError *error);

@protocol RequestHandler <NSObject>
@property (copy,nonatomic) NSString *baseDomain;
@property (copy,nonatomic) NSDictionary *baseParameters;
- (void)GET:(NSString *)endpoint parameters:(NSDictionary *)parameters completion:(SuccessBlock)successBlock error:(ErrorBlock)errorBlock;
@end
