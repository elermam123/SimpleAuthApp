//
//  AuthAppProtocol.h
//  SimpleAuthenticationApp
//
//  Created by Elerman on 24.02.17.
//  Copyright © 2017 Elerman. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef enum AuthenticationFlags:NSUInteger{
    AuthInfoMatch,
    AuthInfoNotMatch,
    AuthInfoEmpty,
    AuthInfoIncorrectLoginFormat,
    AuthInfoIncorrectPasswordFormat,
    AuthInfoIncorrectTooManyTimes
} AuthenticationFlags;

typedef enum ServerErrorFlags:NSUInteger{
    ServerConnectionTimeOut,
    ServerNoConnect,
    ServerNotFound404
} ServerErrorFlags;

#pragma mark Protocol for Model

@protocol RequirementForServerManager

@required

- (id) initWithUrl:(NSURL*) url;
- (void) getAuthInfoFromServer:(void(^)(NSDictionary* logPassFromServ)) success
                     onFailure:(void(^)(NSError* error)) failure;


@end



#pragma mark Protocol for View
@protocol RequirementForView

@required
-(void) setConfirmActionBasedOnServerInfo:(AuthenticationFlags) authFlags;
-(void) createAlertBasedOnServerError:(ServerErrorFlags) errorFlagsFromServer errorMessage:(NSString*) message;

@optional
-(void) warningInfoText:(NSUInteger) attempts;


@end

#pragma mark Protocol for Presenter

@protocol RequirementForPresenter

@required
-(id) initWithView:(id <RequirementForView>) authViewControl;
-(void) getAuthInfoFromModel:(NSDictionary*) dictLoginPasssword;

@optional
-(BOOL) setEnterDataInfoToView:(NSDictionary*) dictLoginPasssword;

@end




