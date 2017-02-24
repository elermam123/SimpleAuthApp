//
//  ViewController.h
//  SimpleAuthenticationApp
//
//  Created by Elerman on 23.02.17.
//  Copyright © 2017 Elerman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuthAppProtocol.h"

@interface AuthViewController : UIViewController<RequirementForView>

-(void) setConfirmActionBasedOnServerInfo:(NSUInteger) confirmActionFlag;


@end

