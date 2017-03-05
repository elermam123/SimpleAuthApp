//
//  AuthPresenter.h
//  SimpleAuthenticationApp
//
//  Created by Elerman on 24.02.17.
//  Copyright © 2017 Elerman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthAppProtocol.h"
#import "AuthServerManager.h"

@protocol RequirementForView;


@interface AuthPresenter : NSObject<RequirementForPresenter>


@property(nonatomic, strong) id<RequirementForView> authView;

@property (nonatomic) AuthServerManager *serverManager;


@end
