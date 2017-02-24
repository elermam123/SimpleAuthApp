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
@property (nonatomic) AuthViewController *authView;


@end

@implementation AuthPresenter

-(id) initWithServerManager{
    self = [super init];
    if(self){
        NSURL *url = [NSURL URLWithString:@"http://localhost:4567"];
        self.serverManager = [[AuthServerManager alloc] initWithUrl:url];
    }
    
    return self;}

-(void) getAuthInfoFromModel:(NSDictionary *)dictLoginPasssword{
    
    
    
}


-(void) setConfirmInfoToView{
    
}

@end
