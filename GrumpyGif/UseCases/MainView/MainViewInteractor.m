//
//  MainViewInteractor.m
//  GrumpyGif
//
//  Created by Armando on 08/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import "MainViewInteractor.h"
#import "MainViewProvider.h"

@implementation MainViewInteractor
- (void)loadGifsWithCompletion:(void(^)(NSArray *gifs))completion{
    [self.mainViewProvider loadGifsWithSuccess:^(NSArray *gifs) {
        completion(gifs);
    } error:^(NSError *error) {
        
    }];
}
-(MainViewProvider *)mainViewProvider{
    if(_mainViewProvider == nil){
        _mainViewProvider = [[MainViewProvider alloc] init];
        _mainViewProvider.managedObjectContext = self.managedObjectContext;
    }
    return _mainViewProvider;
}
@end
