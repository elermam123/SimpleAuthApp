//
//  AuthAppProtocol.h
//  SimpleAuthenticationApp
//
//  Created by Elerman on 24.02.17.
//  Copyright © 2017 Elerman. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark Protocol for Model

@protocol RequirementForServerManager

@required

- (id) initWithUrl:(NSURL*) url;
- (void) getAuthInfoFromServer:(NSDictionary*) dictLoginPassword
                     onSuccess:(void(^)(NSDictionary* logPassFromServ)) success
                     onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

@end


#pragma mark Protocol for Presenter

@protocol RequirementForPresenter

@required
-(id) initWithServerManager;
-(void) getAuthInfoFromModel:(NSDictionary*) dictLoginPasssword;
-(void) setConfirmInfoToView;


@end


#pragma mark Protocol for View
@protocol RequirementForView

@required
-(void) setConfirmActionBasedOnServerInfo:(NSUInteger) confirmActionFlag;

@end




