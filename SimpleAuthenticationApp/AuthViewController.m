//
//  ViewController.m
//  SimpleAuthenticationApp
//
//  Created by Elerman on 23.02.17.
//  Copyright © 2017 Elerman. All rights reserved.
//

#import "AuthViewController.h"
#import "AuthPresenter.h"


@interface AuthViewController ()

@property (weak, nonatomic) IBOutlet UITextField *loginField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UILabel *warningLoginLabel;
@property (weak, nonatomic) IBOutlet UILabel *warningPasswordLabel;

@end

@implementation AuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)loginButtonTapped:(id)sender {
    
    AuthPresenter *presenter = [[AuthPresenter alloc] initWithServerManagerAndView:self];
   
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:self.loginField.text, @"login",self.passwordField.text, @"password", nil];
    
    self.warningLoginLabel.text = @"";
    self.warningPasswordLabel.text = @"";
    
    [presenter getAuthInfoFromModel:dictionary];
    
    
}

-(void) setConfirmActionBasedOnServerInfo:(AuthenticationFlags) authFlags{
    switch (authFlags) {
        case AuthInfoMatch:{NSLog(@"AuthInfoMatch");
            UIAlertController *alertControllerOk;
            alertControllerOk = [UIAlertController alertControllerWithTitle:@"Authentication Success!!!" message:@"You have succesfully logged in :)" preferredStyle:UIAlertControllerStyleAlert];
            
            [alertControllerOk addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil]];
            UIWindow *windows = [[UIApplication sharedApplication].delegate window];
            UIViewController *vc = windows.rootViewController;
            [vc presentViewController:alertControllerOk animated:YES completion:nil];
        }break;
        case AuthInfoNotMatch: {NSLog(@"AuthInfoNotMatch");
            UIAlertController *alertControllerFail;
            alertControllerFail = [UIAlertController alertControllerWithTitle:@"Authentication Failed!!!" message:@"You entered wrong login or password" preferredStyle:UIAlertControllerStyleAlert];
            
            [alertControllerFail addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDestructive handler:nil]];
            UIWindow *windows = [[UIApplication sharedApplication].delegate window];
            UIViewController *vc = windows.rootViewController;
            [vc presentViewController:alertControllerFail animated:YES completion:nil];
            
            self.passwordField.text = @"";
            
        }break;
        case AuthInfoEmpty: {NSLog(@"AuthInfoEmpty = %@", self.loginField.text);
            if([self.loginField.text  isEqual: @""]){
                
                self.warningLoginLabel.text = @"Please enter login";
                
            }
            if([self.passwordField.text  isEqual: @""])
                self.warningPasswordLabel.text= @"Please enter password";

        }break;
        case AuthInfoIncorrectLoginFormat:{
            self.warningLoginLabel.text = @"You have entered invalid symbols.\n Valid symbols format: A-Z a-z 0-9";
        }break;
        case AuthInfoIncorrectPasswordFormat:{
            self.warningPasswordLabel.text= @"You have entered invalid symbols.\nValid symbols format: A-Z a-z 0-9";
        }break;
        case AuthInfoIncorrectTooManyTimes:{
            UIAlertController *alertControllerMegaFail;
            alertControllerMegaFail = [UIAlertController alertControllerWithTitle:@"Authentication Failed Too many times!!!" message:@"You blocked !" preferredStyle:UIAlertControllerStyleAlert];
            
            [alertControllerMegaFail addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDestructive handler:nil]];
            UIWindow *windows = [[UIApplication sharedApplication].delegate window];
            UIViewController *vc = windows.rootViewController;
            [vc presentViewController:alertControllerMegaFail animated:YES completion:nil];
        }break;
        default:
            break;
    }
    
}

-(void) warningInfoText:(NSUInteger) attempts{
    NSMutableString *mutableString = [NSMutableString stringWithString:self.warningPasswordLabel.text];
    NSString *tmpString = [NSString stringWithFormat:@"There are %ld attempts to enter a valid value!", attempts];
    [mutableString appendString:tmpString];
    self.warningPasswordLabel.text = mutableString;
}

-(void) createAlertBasedOnServerError:(ServerErrorFlags) errorFlagsFromServer errorMessage:(NSString*) message{
    UIAlertController *alertControllerServerError;
    NSString* messageError = @"";
    alertControllerServerError = [UIAlertController alertControllerWithTitle:@"Server Error!!!" message:messageError preferredStyle:UIAlertControllerStyleAlert];
    
    [alertControllerServerError addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDestructive handler:nil]];
    UIWindow *windows = [[UIApplication sharedApplication].delegate window];
    UIViewController *vc = windows.rootViewController;
    
    
    switch (errorFlagsFromServer) {
        case ServerConnectionTimeOut:{
            [alertControllerServerError setMessage:message];
            [vc presentViewController:alertControllerServerError animated:YES completion:nil];
        }break;
        case ServerNoConnect:{
            [alertControllerServerError setMessage:message];
            [vc presentViewController:alertControllerServerError animated:YES completion:nil];
        }break;
        case ServerNotFound404:{
            [alertControllerServerError setMessage:message];
            [vc presentViewController:alertControllerServerError animated:YES completion:nil];
        }break;

        default:
            break;
    }
    
}


@end
