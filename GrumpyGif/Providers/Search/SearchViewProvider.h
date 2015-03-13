//
//  SearchViewProvider.h
//  GrumpyGif
//
//  Created by Armando on 09/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import "BaseProvider.h"
@class ImageEntity;
@class Ponso;

@interface SearchViewProvider : BaseProvider
- (void)searchGifsWithSuccess:(void(^)(NSArray *gifs))successBlock
                   parameters:(NSDictionary *)parameters
                        error:(void(^)(NSError *error))errorBlock;
-(void)saveGifWithEntity:(Ponso *)ponsoImage;
@end
