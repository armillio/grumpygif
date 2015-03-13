//
//  SearchViewInteractor.m
//  GrumpyGif
//
//  Created by Armando on 09/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import "SearchViewInteractor.h"
#import "SearchViewProvider.h"

@implementation SearchViewInteractor
- (void)searchGifsWithCompletion:(void(^)(NSArray *gifs))completion
                      parameters:(NSDictionary *)parameters
                           error:(void(^)(NSError *error))error{
    [self.searchViewProvider searchGifsWithSuccess:^(NSArray *gifs) {
        completion(gifs);
    } parameters:parameters error:^(NSError *error) {
        
    }];
}
-(void)saveGifWithEntity:(Ponso *)ponsoImage{
    [self.searchViewProvider saveGifWithEntity:ponsoImage];
}
-(SearchViewProvider *)searchViewProvider{
    if(_searchViewProvider == nil){
        _searchViewProvider = [[SearchViewProvider alloc] init];
    }
    return _searchViewProvider;
}
@end
