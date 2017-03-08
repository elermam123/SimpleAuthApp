//
//  AuthPresenter.m
//  SimpleAuthenticationApp
//
//  Created by Elerman on 24.02.17.
//  Copyright © 2017 Elerman. All rights reserved.
//

#import "AuthPresenter.h"


#import "AuthViewController.h"

#define failureMaxCount 5


@interface AuthPresenter()



@end


@implementation AuthPresenter {
    NSUInteger failureCounter;
}


-(id) initWithView:(id <RequirementForView>) authViewControl{
    
    if(self = [super init]){
        
        self.authView = authViewControl;
        
        failureCounter = 0;
        
    }
    
    return self;
}

-(void) getAuthInfoFromModel:(NSDictionary *)dictLoginPasssword{
    if(!dictLoginPasssword){
        [self.authView showCredentialError];
        return ;
    }
    
    if([self setEnterDataInfoToView:dictLoginPasssword])
        return;
    
    [[AuthServerManager sharedManager] getAuthInfoFromServer:^(NSDictionary* dictFromServer){
         NSLog(@"getAuthInfoFromModel success %@", dictFromServer);
         
         
         if([dictFromServer isEqualToDictionary:dictLoginPasssword]){
             [self.authView setConfirmActionBasedOnServerInfo:AuthInfoMatch];
             failureCounter = 0;
             return;
         }
         else{
             if(failureCounter == failureMaxCount){
                [self.authView setConfirmActionBasedOnServerInfo:AuthInfoIncorrectTooManyTimes];
             }
             else if (failureCounter >= 2 && failureCounter <= failureMaxCount){
                 NSUInteger tmpNum = (NSUInteger)failureMaxCount - failureCounter;
                 [self.authView warningInfoText:tmpNum];
             }
             [self.authView setConfirmActionBasedOnServerInfo:AuthInfoNotMatch];
             failureCounter++;
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
    
    if(!dictLoginPasssword)
        return false;
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
