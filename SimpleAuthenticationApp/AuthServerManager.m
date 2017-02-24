//
//  AuthServerManager.m
//  SimpleAuthenticationApp
//
//  Created by Elerman on 24.02.17.
//  Copyright © 2017 Elerman. All rights reserved.
//

#import "AuthServerManager.h"
#import "AFNetworking.h"

@interface AuthServerManager ()

@property (strong, nonatomic) AFHTTPSessionManager *requestOperationManager;

@end

@implementation AuthServerManager



-(id) initWithUrl:(NSURL *)url{
    
    self = [super init];
    if(self){
        
        self.requestOperationManager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    }
    
    return self;
}


-(void) getAuthInfoFromServer:(NSDictionary*) dictLoginPassword
                    onSuccess:(void(^)(NSDictionary* logPassFromServ)) success
                    onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure{
    

}






@end
