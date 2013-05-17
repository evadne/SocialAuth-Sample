#import "SAViewController.h"

@interface SAViewController () <UIActionSheetDelegate>
@property (nonatomic, readonly, strong) SAAccountStore *accountStore;
@end

@implementation SAViewController
@synthesize accountStore = _accountStore;

- (SAAccountStore *) accountStore {
	if (!_accountStore) {
		_accountStore = [SAAccountStore new];
	}
	return _accountStore;
}

- (IBAction) handleFacebook:(id)sender {
	ACAccountType *accountType = [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
	[self.accountStore requestAccountTyped:accountType withOptions:@{
		ACFacebookAppIdKey: @"330896450372105",	//	throwaway
		ACFacebookPermissionsKey: @[ @"email" ]
	} completion:^(BOOL didFinish, ACAccount *account, NSError *error) {
		if (account) {
			[self useAccount:account];
		} else {
			[[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Error %i", error.code] message:error.localizedDescription delegate:nil cancelButtonTitle:@"D:" otherButtonTitles:nil] show];
		}
	}];
}

- (IBAction) handleTwitter:(id)sender {
	ACAccountType *accountType = [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
	[self.accountStore requestAccountTyped:accountType withOptions:nil completion:^(BOOL didFinish, ACAccount *account, NSError *error) {
		if (account) {
			[self useAccount:account];
		} else {
			[[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Error %i", error.code] message:error.localizedDescription delegate:nil cancelButtonTitle:@"D:" otherButtonTitles:nil] show];
		}
	}];
}

- (void) useAccount:(ACAccount *)account {
	[[[UIAlertView alloc] initWithTitle:@"Got Account" message:[NSString stringWithFormat:@"%@ (%@)", account.username, account.accountDescription] delegate:nil cancelButtonTitle:@":D" otherButtonTitles:nil] show];
}

@end
