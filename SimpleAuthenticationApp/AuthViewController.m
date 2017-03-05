//
//  ViewController.m
//  SimpleAuthenticationApp
//
//  Created by Elerman on 23.02.17.
//  Copyright © 2017 Elerman. All rights reserved.
//

#import "AuthViewController.h"
#import "AuthPresenter.h"

#define authSuccess NSLocalizedString(@"Authentication Success!!!", @"Authentication Success")
#define authFailed NSLocalizedString(@"Authentication Failed !!!", @"authFailed")
#define okay NSLocalizedString(@"Okay", @"okay")
#define messageAboutEnteringData NSLocalizedString(@"You enetered a wrong password too many times.\nYou blocked !", @"messageAboutEnteringData")
#define messageAboutSymbolFormat NSLocalizedString(@"You have entered invalid symbols.\n Valid symbols format: A-Z a-z 0-9", @"messageAboutSymbolFormat")
#define successLogin NSLocalizedString(@"You have successfully logged in :)", @"successLogin")
#define wrongLoginPassword NSLocalizedString(@"You entered wrong login or password", @"wrongLoginPassword")
#define serverError NSLocalizedString(@"Server Error!!!", @"serverError")
#define requestLogin NSLocalizedString(@"Please enter login", @"requestLogin")
#define requestPassword NSLocalizedString(@"Please enter password", @"requestPassword")


@interface AuthViewController ()

@property (weak, nonatomic) IBOutlet UITextField *loginField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UILabel *warningLoginLabel;
@property (weak, nonatomic) IBOutlet UILabel *warningPasswordLabel;

@end

@implementation AuthViewController{
    AuthPresenter *presenter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    presenter = [[AuthPresenter alloc] initWithView:self];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)loginButtonTapped:(id)sender {
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:self.loginField.text, @"login",self.passwordField.text, @"password", nil];
    
    self.warningLoginLabel.text = @"";
    self.warningPasswordLabel.text = @"";
    
    [presenter getAuthInfoFromModel:dictionary];
    
}

-(void) setConfirmActionBasedOnServerInfo:(AuthenticationFlags) authFlags{
    switch (authFlags) {
        case AuthInfoMatch:{
            NSLog(@"AuthInfoMatch");
            UIAlertController *alertControllerOk;
            
            alertControllerOk = [UIAlertController alertControllerWithTitle:authSuccess message:successLogin preferredStyle:UIAlertControllerStyleAlert];
            
            [alertControllerOk addAction:[UIAlertAction actionWithTitle:okay style:UIAlertActionStyleDefault handler:nil]];
            UIWindow *windows = [[UIApplication sharedApplication].delegate window];
            UIViewController *vc = windows.rootViewController;
            [vc presentViewController:alertControllerOk animated:YES completion:nil];
            break;
        }
        case AuthInfoNotMatch: {
            NSLog(@"AuthInfoNotMatch");
            UIAlertController *alertControllerFail;
            alertControllerFail = [UIAlertController alertControllerWithTitle:authFailed message:wrongLoginPassword preferredStyle:UIAlertControllerStyleAlert];
            
            [alertControllerFail addAction:[UIAlertAction actionWithTitle:okay style:UIAlertActionStyleDestructive handler:nil]];
            UIWindow *windows = [[UIApplication sharedApplication].delegate window];
            UIViewController *vc = windows.rootViewController;
            [vc presentViewController:alertControllerFail animated:YES completion:nil];
            
            self.passwordField.text = @"";
            break;
        }
        case AuthInfoEmpty: {
            NSLog(@"AuthInfoEmpty = %@", self.loginField.text);
            if([self.loginField.text  isEqual: @""]){
                self.warningLoginLabel.text = requestLogin;
            }
            
            if([self.passwordField.text  isEqual: @""]){
                self.warningPasswordLabel.text= requestPassword;
            }
            break;
        }
        case AuthInfoIncorrectLoginFormat:{
            self.warningLoginLabel.text = messageAboutSymbolFormat;
            break;
        }
        case AuthInfoIncorrectPasswordFormat:{
            self.warningPasswordLabel.text= messageAboutSymbolFormat;
            break;
        }
        case AuthInfoIncorrectTooManyTimes:{
            UIAlertController *alertControllerMegaFail;
            alertControllerMegaFail = [UIAlertController alertControllerWithTitle:authFailed message:messageAboutEnteringData preferredStyle:UIAlertControllerStyleAlert];
            
            [alertControllerMegaFail addAction:[UIAlertAction actionWithTitle:okay style:UIAlertActionStyleDestructive handler:nil]];
            UIWindow *windows = [[UIApplication sharedApplication].delegate window];
            UIViewController *vc = windows.rootViewController;
            [vc presentViewController:alertControllerMegaFail animated:YES completion:nil];
            break;
        }
        default:
            break;
    }
    
}

-(void) warningInfoText:(NSUInteger) attempts{
    NSMutableString *mutableString = [NSMutableString stringWithString:self.warningPasswordLabel.text];
    NSString *tmpString = [NSString stringWithFormat:NSLocalizedString(@"There are %ld attempts to enter a valid value!", nil), attempts];
    [mutableString appendString:tmpString];
    self.warningPasswordLabel.text = mutableString;
}

-(void) createAlertBasedOnServerError:(ServerErrorFlags) errorFlagsFromServer errorMessage:(NSString*) message{
    UIAlertController *alertControllerServerError;
    NSString* messageError = @"";
    alertControllerServerError = [UIAlertController alertControllerWithTitle:serverError message:messageError preferredStyle:UIAlertControllerStyleAlert];
    
    [alertControllerServerError addAction:[UIAlertAction actionWithTitle:okay style:UIAlertActionStyleDestructive handler:nil]];
    UIWindow *windows = [[UIApplication sharedApplication].delegate window];
    UIViewController *vc = windows.rootViewController;
    
    
    switch (errorFlagsFromServer) {
        case ServerConnectionTimeOut:{
            [alertControllerServerError setMessage:message];
            [vc presentViewController:alertControllerServerError animated:YES completion:nil];
            break;
        }
        case ServerNoConnect:{
            [alertControllerServerError setMessage:message];
            [vc presentViewController:alertControllerServerError animated:YES completion:nil];
            break;
        }
        case ServerNotFound404:{
            [alertControllerServerError setMessage:message];
            [vc presentViewController:alertControllerServerError animated:YES completion:nil];
            break;
        }

        default:
            break;
    }
    
}


@end
