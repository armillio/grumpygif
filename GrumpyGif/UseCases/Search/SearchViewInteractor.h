//
//  SearchViewInteractor.h
//  GrumpyGif
//
//  Created by Armando on 09/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import "BaseInteractor.h"
@class SearchViewProvider;
@class Ponso;

@interface SearchViewInteractor : BaseInteractor
@property (strong,nonatomic) SearchViewProvider *searchViewProvider;
- (void)searchGifsWithCompletion:(void(^)(NSArray *gifs))completion
                      parameters:(NSDictionary *)parameters
                           error:(void(^)(NSError *error))error;
-(void)saveGifWithEntity:(Ponso *)ponsoImage;
@end