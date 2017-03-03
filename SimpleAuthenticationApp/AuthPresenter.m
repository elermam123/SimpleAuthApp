//
//  AuthPresenter.m
//  SimpleAuthenticationApp
//
//  Created by Elerman on 24.02.17.
//  Copyright © 2017 Elerman. All rights reserved.
//

#import "AuthPresenter.h"
#import "AuthServerManager.h"

#import "AuthViewController.h"


@interface AuthPresenter()

@property (nonatomic) AuthServerManager *serverManager;

@end


@implementation AuthPresenter

@synthesize authView = _authView;


static NSUInteger failure_counter = 0;
static const NSUInteger failureMaxCount = 5;


-(id) initWithServerManagerAndView:(id <RequirementForView>) authViewControl{
    self = [super init];
    if(self){
        NSURL *url = [NSURL URLWithString:@"http://localhost:4567"];
        self.serverManager = [[AuthServerManager alloc] initWithUrl:url];
        
        self.authView = authViewControl;
        
    }
    
    return self;
}

-(void) getAuthInfoFromModel:(NSDictionary *)dictLoginPasssword{
    
    if([self setEnterDataInfoToView:dictLoginPasssword])
        return;
    
    [self.serverManager
     getAuthInfoFromServer:^(NSDictionary* dictFromServer){
         NSLog(@"getAuthInfoFromModel success %@", dictFromServer);
         
         
         if([dictFromServer isEqualToDictionary:dictLoginPasssword]){
             [self.authView setConfirmActionBasedOnServerInfo:AuthInfoMatch];
             return;
         }
         else{
             if(failure_counter == failureMaxCount){
                [self.authView setConfirmActionBasedOnServerInfo:AuthInfoIncorrectTooManyTimes];
             }
             else if (failure_counter >= 2){
                 NSUInteger tmpNum = failureMaxCount - failure_counter;
                 [self.authView warningInfoText:tmpNum];
             }
             [self.authView setConfirmActionBasedOnServerInfo:AuthInfoNotMatch];
             failure_counter++;
             return;
         }
         
         
     }
     onFailure:^(NSError *error){
         NSLog(@"error = %@, code = %ld", [error localizedDescription], [error code]);
         switch ([error code]) {
             case -1004:
                 NSLog(@"%@", [error localizedDescription]);
                 [self.authView createAlertBasedOnServerError:ServerNoConnect errorMessage:[error localizedDescription]];
                 break;
             case -1011:
                 NSLog(@"%@", [error localizedDescription]);
                 [self.authView createAlertBasedOnServerError:ServerNotFound404 errorMessage:[error localizedDescription]];
                 
                 break;
             case -1001:
                 NSLog(@"%@", [error localizedDescription]);
                 [self.authView createAlertBasedOnServerError:ServerConnectionTimeOut errorMessage:[error localizedDescription]];
                 
                 break;
                 
             default:
                 break;
         }
     }];
    
}


-(BOOL) setEnterDataInfoToView:(NSDictionary*) dictLoginPasssword{
    
    NSLog(@"%@",dictLoginPasssword);
    
    BOOL output = NO;
    NSString *loginField = [dictLoginPasssword objectForKey:@"login"];
    NSString *passwordField = [dictLoginPasssword objectForKey:@"password"];
    
    NSError *error = NULL;
    NSString *pattern = @"[a-zA-Z0-9]";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:0
                                                                             error:&error];
    
    NSUInteger numberOfMatchesInLogin = [regex numberOfMatchesInString:loginField options:0 range:NSMakeRange(0, [loginField length])];
    NSUInteger numberOfMatchesInPassword = [regex numberOfMatchesInString:passwordField options:0 range:NSMakeRange(0, [passwordField length])];
    
    if([loginField isEqual: @""] || [passwordField isEqual:@""]){
        [self.authView setConfirmActionBasedOnServerInfo:AuthInfoEmpty];
        output = YES;
    }
    
    
    if(numberOfMatchesInLogin != [loginField length] ){
        //NSLog(@"numberOfMatchesInLogin = %ld", numberOfMatchesInLogin);
        [self.authView setConfirmActionBasedOnServerInfo:AuthInfoIncorrectLoginFormat];
        output = YES;
    }
    if (numberOfMatchesInPassword !=[passwordField length]) {
        [self.authView setConfirmActionBasedOnServerInfo:AuthInfoIncorrectPasswordFormat];
        output = YES;

    }

    return output;
}

@end
