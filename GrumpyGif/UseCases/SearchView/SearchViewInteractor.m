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
- (void)serachGifsWithCompletion:(void(^)(NSArray *gifs))completion parameters:(NSDictionary *)parameters error:(void(^)(NSError *error))error{
    [self.serachViewProvider searchGifsWithSuccess:^(NSArray *gifs) {
        completion(gifs);
    } parameters:parameters error:^(NSError *error) {
        
    }];
}
-(SearchViewProvider *)serachViewProvider{
    if(_serachViewProvider == nil){
        _serachViewProvider = [[SearchViewProvider alloc] init];
    }
    return _serachViewProvider;
}
@end
