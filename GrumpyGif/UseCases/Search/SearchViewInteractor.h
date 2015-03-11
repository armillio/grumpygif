//
//  SearchViewInteractor.h
//  GrumpyGif
//
//  Created by Armando on 09/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import "BaseInteractor.h"
@class SearchViewProvider;

@interface SearchViewInteractor : BaseInteractor
@property (strong,nonatomic) SearchViewProvider *serachViewProvider;
- (void)serachGifsWithCompletion:(void(^)(NSArray *gifs))completion parameters:(NSDictionary *)parameters error:(void(^)(NSError *error))error;
-(void)saveGifWithDictionary:(NSDictionary *)gifs;
@end