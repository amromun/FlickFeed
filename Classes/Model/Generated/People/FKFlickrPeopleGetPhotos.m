//
//  FKFlickrPeopleGetPhotos.m
//  FlickrKit
//
//  Generated by FKAPIBuilder on 12 Jun, 2013 at 17:19.
//  Copyright (c) 2013 DevedUp Ltd. All rights reserved. http://www.devedup.com
//
//  DO NOT MODIFY THIS FILE - IT IS MACHINE GENERATED


#import "FKFlickrPeopleGetPhotos.h" 

@implementation FKFlickrPeopleGetPhotos

- (BOOL) needsLogin {
    return YES;
}

- (BOOL) needsSigning {
    return YES;
}

- (FKPermission) requiredPerms {
    return 0;
}

- (NSString *) name {
    return @"flickr.people.getPhotos";
}

- (BOOL) isValid:(NSError **)error {
    BOOL valid = YES;
	NSMutableString *errorDescription = [[NSMutableString alloc] initWithString:@"You are missing required params: "];
	if(!self.user_id) {
		valid = NO;
		[errorDescription appendString:@"'user_id', "];
	}

	if(error != NULL) {
		if(!valid) {	
			NSDictionary *userInfo = @{NSLocalizedDescriptionKey: errorDescription};
			*error = [NSError errorWithDomain:FKFlickrKitErrorDomain code:FKErrorInvalidArgs userInfo:userInfo];
		}
	}
    return valid;
}

- (NSDictionary *) args {
    NSMutableDictionary *args = [NSMutableDictionary dictionary];
	if(self.user_id) {
		[args setValue:self.user_id forKey:@"user_id"];
	}
	if(self.safe_search) {
		[args setValue:self.safe_search forKey:@"safe_search"];
	}
	if(self.min_upload_date) {
		[args setValue:self.min_upload_date forKey:@"min_upload_date"];
	}
	if(self.max_upload_date) {
		[args setValue:self.max_upload_date forKey:@"max_upload_date"];
	}
	if(self.min_taken_date) {
		[args setValue:self.min_taken_date forKey:@"min_taken_date"];
	}
	if(self.max_taken_date) {
		[args setValue:self.max_taken_date forKey:@"max_taken_date"];
	}
	if(self.content_type) {
		[args setValue:self.content_type forKey:@"content_type"];
	}
	if(self.privacy_filter) {
		[args setValue:self.privacy_filter forKey:@"privacy_filter"];
	}
	if(self.extras) {
		[args setValue:self.extras forKey:@"extras"];
	}
	if(self.per_page) {
		[args setValue:self.per_page forKey:@"per_page"];
	}
	if(self.page) {
		[args setValue:self.page forKey:@"page"];
	}

    return [args copy];
}

- (NSString *) descriptionForError:(NSInteger)error {
    switch(error) {
		case FKFlickrPeopleGetPhotosError_RequiredArgumentsMissing:
			return @"Required arguments missing";
		case FKFlickrPeopleGetPhotosError_UnknownUser:
			return @"Unknown user";
		case FKFlickrPeopleGetPhotosError_InvalidSignature:
			return @"Invalid signature";
		case FKFlickrPeopleGetPhotosError_MissingSignature:
			return @"Missing signature";
		case FKFlickrPeopleGetPhotosError_LoginFailedOrInvalidAuthToken:
			return @"Login failed / Invalid auth token";
		case FKFlickrPeopleGetPhotosError_UserNotLoggedInOrInsufficientPermissions:
			return @"User not logged in / Insufficient permissions";
		case FKFlickrPeopleGetPhotosError_InvalidAPIKey:
			return @"Invalid API Key";
		case FKFlickrPeopleGetPhotosError_ServiceCurrentlyUnavailable:
			return @"Service currently unavailable";
		case FKFlickrPeopleGetPhotosError_FormatXXXNotFound:
			return @"Format \"xxx\" not found";
		case FKFlickrPeopleGetPhotosError_MethodXXXNotFound:
			return @"Method \"xxx\" not found";
		case FKFlickrPeopleGetPhotosError_InvalidSOAPEnvelope:
			return @"Invalid SOAP envelope";
		case FKFlickrPeopleGetPhotosError_InvalidXMLRPCMethodCall:
			return @"Invalid XML-RPC Method Call";
		case FKFlickrPeopleGetPhotosError_BadURLFound:
			return @"Bad URL found";
  
		default:
			return @"Unknown error code";
    }
}

@end
