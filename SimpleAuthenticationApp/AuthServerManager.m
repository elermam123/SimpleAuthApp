//
//  AuthServerManager.m
//  SimpleAuthenticationApp
//
//  Created by Elerman on 24.02.17.
//  Copyright © 2017 Elerman. All rights reserved.
//

#import "AuthServerManager.h"
#import "AFNetworking.h"

#define urlString "http://localhost:4567"

@interface AuthServerManager ()

@property (strong, nonatomic) AFHTTPSessionManager *requestOperationManager;

@end

@implementation AuthServerManager


+ (AuthServerManager*) sharedManager{
    
    static AuthServerManager* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:@(urlString)];
        manager = [[AuthServerManager alloc] initWithUrl:url];
    });
    
    
    return manager;
}



-(id) initWithUrl:(NSURL *)url{
    
    if(self = [super init]){
        
        self.requestOperationManager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    }
    
    return self;
}


-(void) getAuthInfoFromServer:(void(^)(NSDictionary* logPassFromServ)) success
                    onFailure:(void(^)(NSError* error)) failure{
    
    [self.requestOperationManager GET:@"auth"
                           parameters:nil
                             progress:nil
                              success:^(NSURLSessionTask *task, id responseObject) {
                                  NSLog(@"JSON: %@", responseObject);
                                  NSDictionary *dictFromServ = [responseObject objectForKey:@"auth"];
                                  NSLog(@" respobj = %@",dictFromServ);
                                  if(success){
                                      success(dictFromServ);
                                  }
                                  
                                  
                              } failure:^(NSURLSessionTask *operation, NSError *error) {
                                  NSLog(@"Error: %@", error);
                                  
                                  if(failure){
                                      failure(error);
                                  }
                                  
                              }];

    
    
}






@end
