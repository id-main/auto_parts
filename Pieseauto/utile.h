//
//  utile.h
//  Pieseauto
//
//  Created by Ioan Ungureanu on 24/02/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "DataMasterProcessor.h"
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"

@interface Utile : NSObject{
    
}
- (AFSecurityPolicy*)customSecurityPolicy;
//2.
-(AFHTTPSessionManager*)SESSIONMANAGER;
//Dictionar font icon app
-(NSMutableDictionary *)DictionarmareIcons;
-(NSString *)CodDictionarIcons:(NSString *)numeicon;
-(void)doLoginOrRegister:(NSString*) tip :(NSMutableDictionary *)emailparolasautelefon;
-(BOOL)eLogat;
-(void)doLogout;
-(NSString *)AUTHTOKEN;
//connect secure to server
-(void)primaconectare;
-(NSArray *)ialistaJudete;
-(NSArray *)ialistaLocalitatipeJudet;
-(NSArray *)ialistaProducatori;
-(NSArray *)ialistaMarciAutopeProducator;
-(BOOL)primaDatainApp; //ii prezentam alege limba
-(NSDictionary*)updatenotify_count :(NSDictionary*)getnotify_count;
-(void)getnotify_count :(NSString *)AUTHTOKEN;
-(NSDictionary*)updateprofile :(NSDictionary*)getProfile :(NSString*)authtoken;
//-(NSDictionary*)getOffer :(NSString*)ID_OFERTA :(NSString*)authtoken;
//-(NSMutableArray*)get_comments :(NSString*)CERERESAUOFERTAID :(NSString*)TIP :(NSString*)authtoken; // IA COMENT PE CERERE ID SAU PE OFERTA ID
-(void)getProfile :(NSString *)AUTHTOKEN;
-(void)changeemail :(NSString *)AUTHTOKEN :(NSString*)EMAIL;
-(void)sendforgot_password:(NSString*)email;
-(void)cerere_autocomplete :(NSString *)AUTHTOKEN;//ia ultimile 5 masini din cereri

-(void)mergiLaCerereNouaViewVC;
-(void)mergiLaMainViewVC;
-(void)mergiLaLoginVC;
-(void)set_push_token :(NSString *)AUTHTOKEN;
/////-(NSMutableDictionary*)get_member_profile :(NSString *)userid; // @"m=get_member_profile&p=" // ia user profile pe user_id sau username

@end