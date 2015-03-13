//
//  MainViewInteractor.h
//  GrumpyGif
//
//  Created by Armando on 08/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import "BaseInteractor.h"
@class MainViewProvider;

@interface MainViewInteractor : BaseInteractor
@property (strong,nonatomic) MainViewProvider *mainViewProvider;
- (void)loadGifsFromCoreDataWithCompletion:(void(^)(NSArray *gifs))completion
                                     error:(void(^)(NSError *error))error;
@end
