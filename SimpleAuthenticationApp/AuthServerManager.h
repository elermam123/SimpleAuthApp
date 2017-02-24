//
//  AuthServerManager.h
//  SimpleAuthenticationApp
//
//  Created by Elerman on 24.02.17.
//  Copyright © 2017 Elerman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthAppProtocol.h"

@interface AuthServerManager : NSObject<RequirementForServerManager>

-(id) initWithUrl:(NSURL *)url;

-(void) getAuthInfoFromServer:(NSDictionary*) dictLoginPassword
                     onSuccess:(void(^)(NSDictionary* logPassFromServ)) success
                     onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;


@end
