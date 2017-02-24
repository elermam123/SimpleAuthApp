//
//  AuthPresenter.h
//  SimpleAuthenticationApp
//
//  Created by Elerman on 24.02.17.
//  Copyright © 2017 Elerman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthAppProtocol.h"

@interface AuthPresenter : NSObject<RequirementForPresenter>

-(void) getAuthInfoFromModel:(NSDictionary *)dictLoginPasssword;
-(void) setConfirmInfoToView;


@end
