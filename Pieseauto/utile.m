//
//  utile.m
//  Pieseauto
//
//  Created by Ioan Ungureanu on 24/02/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//
#import "utile.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import "SBJson4.h"
#import "SBJson4Writer.h"
#import "EcranCerereTrimisaViewController.h"
#import "RIButtonItem.h"
#import "UIAlertView+Blocks.h"
#import "Reachability.h"

@interface Utile(){
    NSMutableArray* array;
}
@end

@implementation Utile
//font
-(NSMutableDictionary *)DictionarmareIcons {
    NSMutableDictionary *Dictionaricon = [[NSMutableDictionary alloc]init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"piese" ofType:@"plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]){
        NSMutableArray *Arieicons = [[NSMutableArray alloc]init];
        Dictionaricon = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
        for (NSDictionary* dict in Dictionaricon) {
            //      NSLog(@"current dic: %@", Dictionaricon);
            [Arieicons addObject:dict];
            //  NSLog(@"Plist does not exist");
        }
        /*  NSLog(@"cate icons %lu",(unsigned long)Arieicons.count);
         for(NSString *key in [Dictionaricon allKeys]) {
         
         NSLog(@"key %@ & valoare %@",key,[Dictionaricon objectForKey:key]);
         
         }*/
    }
    return Dictionaricon;
}
-(NSString *)CodDictionarIcons:(NSString *)numeicon {
    
    NSString *SIMBOL = [[NSString alloc]init];
    if(numeicon) {
        AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        for(NSString *key in [del.DICTIONARICONS allKeys]) {
            if ([key isEqualToString:numeicon]) {
                SIMBOL= [NSString stringWithFormat:@"%@",[del.DICTIONARICONS objectForKey:key]];
                NSLog(@"SIMBOL %@",SIMBOL);
                break;
            }
        }
    }
    return SIMBOL;
}
-(id)getObjectForKey:(NSString*)key{
    NSUserDefaults* prefs=[NSUserDefaults standardUserDefaults];
    return [prefs objectForKey:key];
}

//database -> toate varchar pt a evita int la insert etc.
/*
 CREATE TABLE "judete" ("id" VARCHAR, "name" VARCHAR)
 CREATE TABLE "localitati" ("county_id" VARCHAR, "id" VARCHAR, "name" VARCHAR)
 CREATE TABLE "marci" ("carmaker_id" VARCHAR, "id" VARCHAR, "name" VARCHAR, "year_end" VARCHAR, "year_start" VARCHAR)
 CREATE TABLE "producatori" ("id" VARCHAR, "name" VARCHAR)
 */

//Vom folosi 1 si 2 tot timpul la requesturi
//1.
- (AFSecurityPolicy*)customSecurityPolicy {
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"dev5.activesoft" ofType:@"cer"];
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    [securityPolicy setAllowInvalidCertificates:YES];
    [securityPolicy setValidatesDomainName:NO];
    [securityPolicy setValidatesCertificateChain:NO];
    [securityPolicy setPinnedCertificates:@[certData]];
    return securityPolicy;
}
//2.
-(AFHTTPSessionManager*)SESSIONMANAGER {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy =[self customSecurityPolicy];
    //  manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    return manager;
}
-(BOOL)eLogat{
    BOOL LOGAT =NO;
    NSUserDefaults* prefs=[NSUserDefaults standardUserDefaults];
    NSString *elogat = [NSString stringWithFormat:@"%@",[prefs objectForKey:@"E_LOGAT"]];
    int verifica = (int)[elogat integerValue];
    NSLog(@"verifica %i",verifica);
    if(verifica==1) {
        LOGAT =YES;
    } else {
        LOGAT =NO;
    }
    return LOGAT;
}
-(void)doLogout{
    [DataMasterProcessor delogheazatotiuserii];
    NSUserDefaults* prefs=[NSUserDefaults standardUserDefaults];
    [prefs setValue:@"0" forKey:@"E_LOGAT"];
    [prefs synchronize];
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    del.NOTIFY_COUNT = [[NSDictionary alloc]init];
    NSLog(@"del.NOTIFY_COUNTdel.NOTIFY_COUNT %@",del.NOTIFY_COUNT);
 }


-(NSString *)AUTHTOKEN {
    NSDictionary *userd =[DataMasterProcessor getLOGEDACCOUNT];
    NSString *U_authtoken= [NSString stringWithFormat:@"%@",userd[@"U_authtoken"]];
   //// JNSLog(@"userul logat dictionar %@",userd);
    return  U_authtoken;
}




/* carmakers =  array  (
 {
 id = 1;
 name = Acura;
 }
 carmodels = array        (
 {
 "carmaker_id" = 1;
 id = 1;
 name = Integra;
 "year_end" = 2016;
 "year_start" = 1980;
 }
 
 counties  array (
 {
 id = 1;
 name = Alba;
 }
 */
/*
 METODE  -> SE SETEAZA pt cheia m
 cerere_add
 init
 login
 
 */

-(void)mergiLaCerereNouaViewVC {
    //    UINavigationController *ivcnavigationController= [UIApplication sharedApplication].keyWindow.rootViewController.navigationController;
    UINavigationController *nav=(UINavigationController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController;
    int index =0;
    for(int i=0; i< nav.viewControllers.count;i++) {
        UIViewController *view  = [nav.viewControllers objectAtIndex:i];
        NSLog(@"vv %@",view.restorationIdentifier);
        if([view.restorationIdentifier isEqualToString:@"CerereNouaViewVC"]) {//se bifeaza use rest.id ca si storyboardid ... avem  nevoie ca sa il ducem acolo dupa push
            NSLog(@"cat e index i %d",i);
            index =i;
            break;
        }
    }
    [nav popToViewController:[[nav viewControllers] objectAtIndex:index] animated:YES];
}
-(void)mergiLaMainViewVC {
    NSInteger index = 0;
    
    UINavigationController *nav=(UINavigationController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController;
    for(int i=0; i< nav.viewControllers.count;i++) {
        UIViewController *view  = [nav.viewControllers objectAtIndex:i];
        NSLog(@"vv %@",view.restorationIdentifier);
        if([view.restorationIdentifier isEqualToString:@"TutorialHomeVC"]) {//se bifeaza use rest.id ca si storyboardid ... avem  nevoie ca sa il ducem acolo dupa push
            NSLog(@"cat e index i %d",i);
            index =i;
            break;
        }
    }
    [nav popToViewController:[[nav viewControllers] objectAtIndex:index] animated:YES];
}
-(void)mergiLaLoginVC {
    NSInteger index = 0;
    
    UINavigationController *nav=(UINavigationController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController;
    for(int i=0; i< nav.viewControllers.count;i++) {
        UIViewController *view  = [nav.viewControllers objectAtIndex:i];
        NSLog(@"vv %@",view.restorationIdentifier);
        if([view.restorationIdentifier isEqualToString:@"LoginVC"]) {//se bifeaza use rest.id ca si storyboardid ... avem  nevoie ca sa il ducem acolo dupa push
            NSLog(@"cat e index i %d",i);
            index =i;
            break;
        }
    }
    [nav popToViewController:[[nav viewControllers] objectAtIndex:index] animated:YES];
}

-(NSDictionary*)updatenotify_count :(NSDictionary*)getnotify_count {
    NSDictionary *notify_count = getnotify_count;
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    del.NOTIFY_COUNT = [[NSDictionary alloc]init]; //se goleste mereu la login si logout
    del.NOTIFY_COUNT = notify_count;
    NSLog(@"del.NOTIFY_COUNT %@",del.NOTIFY_COUNT);
    //"feedback_needed_count":0,"unread_offers_count":0}}
    return notify_count;
}



-(NSDictionary*)updateprofile :(NSDictionary*)getProfile :(NSString*)authtoken {
    NSDictionary *get_Profile = getProfile;
    NSMutableDictionary *DATEUSER = [[NSMutableDictionary alloc]init];
    [DATEUSER setValue:authtoken forKey:@"U_authtoken"];
    //nu uita sa verifici daca au facut last update pentru user
    [DATEUSER setValue:@"0" forKey:@"U_lastupdate"];
    /*  date GET PROFILE raspuns {
     address = "";
     email = "ioan.ungureanu@activesoft.ro";
     "first_name" = "";
     "last_name" = "";
     "localitate_id" = 0;
     notify = 3;
     phone1 = 0726744222;
     //+ judet
     "user_id" = 1198327;
     username = ioanungureanu;
     "zip_code" = "";
     }*/
    ///////"user_id" = 1198327;////////
    if(getProfile[@"user_id"]) {
        NSString *user_id = [NSString stringWithFormat:@"%@",getProfile[@"user_id"]];
        [DATEUSER setValue:user_id forKey:@"U_userid"];
    } else {
        [DATEUSER setValue:@"" forKey:@"U_userid"];
    }
    
    if(getProfile[@"address"]) {
        NSString *adresa = [NSString stringWithFormat:@"%@",getProfile[@"address"]];
        [DATEUSER setValue:adresa forKey:@"U_adresa"];
    } else {
        [DATEUSER setValue:@"" forKey:@"U_adresa"];
    }
    if(getProfile[@"email"]) {
        NSString *adresa = [NSString stringWithFormat:@"%@",getProfile[@"email"]];
        [DATEUSER setValue:adresa forKey:@"U_email"];
    } else {
        [DATEUSER setValue:@"" forKey:@"U_email"];
    }
    if(getProfile[@"last_name"]) {
        NSString *last_name = [NSString stringWithFormat:@"%@",getProfile[@"last_name"]];
        [DATEUSER setValue:last_name forKey:@"U_nume"];
    } else {
        [DATEUSER setValue:@"" forKey:@"U_nume"];
    }
    if(getProfile[@"first_name"]) {
        NSString *first_name = [NSString stringWithFormat:@"%@",getProfile[@"first_name"]];
        [DATEUSER setValue:first_name forKey:@"U_prenume"];
    } else {
        [DATEUSER setValue:@"" forKey:@"U_prenume"];
    }
    if(getProfile[@"localitate_id"]) {
        NSString *localitate_id = [NSString stringWithFormat:@"%@",getProfile[@"localitate_id"]];
        [DATEUSER setValue:localitate_id forKey:@"U_localitate"];
        NSDictionary *getLocalitate=[DataMasterProcessor getLocalitate:localitate_id];
        if(getLocalitate[@"county_id"]) {
            //ia judet
            NSString *judet_id = [NSString stringWithFormat:@"%@",getLocalitate[@"county_id"]];
            NSDictionary *judbaza = [DataMasterProcessor getJudet:judet_id];
            if(judbaza && judbaza[@"id"]) {
                NSString *JUDETID = [NSString stringWithFormat:@"%@",judbaza[@"id"]];
                [DATEUSER setValue:JUDETID forKey:@"U_judet"];
            } else {
                [DATEUSER setValue:@"" forKey:@"U_judet"];
            }
        } else {
            [DATEUSER setValue:@"" forKey:@"U_judet"];
        }
    } else {
        [DATEUSER setValue:@"" forKey:@"U_localitate"];
        [DATEUSER setValue:@"" forKey:@"U_judet"];
        
    }
    if(getProfile[@"notify"]) {
        NSString *notify = [NSString stringWithFormat:@"%@",getProfile[@"notify"]];
        [DATEUSER setValue:notify forKey:@"U_preferinte_notificari"];
    } else {
        [DATEUSER setValue:@"3" forKey:@"U_preferinte_notificari"];
    }
    if(getProfile[@"phone1"]) {
        NSString *phone1 = [NSString stringWithFormat:@"%@",getProfile[@"phone1"]];
        [DATEUSER setValue:phone1 forKey:@"U_telefon"];
    } else {
        [DATEUSER setValue:@"" forKey:@"U_telefon"];
    }
    if(getProfile[@"phone2"]) {
        NSString *phone2 = [NSString stringWithFormat:@"%@",getProfile[@"phone2"]];
        [DATEUSER setValue:phone2 forKey:@"U_telefon2"];
    } else {
        [DATEUSER setValue:@"" forKey:@"U_telefon2"];
    }
    if(getProfile[@"phone3"]) {
        NSString *phone3 = [NSString stringWithFormat:@"%@",getProfile[@"phone3"]];
        [DATEUSER setValue:phone3 forKey:@"U_telefon3"];
    } else {
        [DATEUSER setValue:@"" forKey:@"U_telefon3"];
    }
    if(getProfile[@"phone4"]) {
        NSString *phone4 = [NSString stringWithFormat:@"%@",getProfile[@"phone4"]];
        [DATEUSER setValue:phone4 forKey:@"U_telefon4"];
    } else {
        [DATEUSER setValue:@"" forKey:@"U_telefon4"];
    }
    if(getProfile[@"username"]) {
        NSString *username = [NSString stringWithFormat:@"%@",getProfile[@"username"]];
        [DATEUSER setValue:username forKey:@"U_username"];
    } else{
        [DATEUSER setValue:@"" forKey:@"U_username"];
    }
    if(getProfile[@"zip_code"]) {
        NSString *zip_code = [NSString stringWithFormat:@"%@",getProfile[@"zip_code"]];
        [DATEUSER setValue:zip_code forKey:@"U_cod_postal"];
    } else {
        [DATEUSER setValue:@"" forKey:@"U_cod_postal"];
    }
    
    BOOL  ok=    [DataMasterProcessor updateUsers:DATEUSER];
    
    NSLog(@"dateuser dupa sync %@ e ok ? %i",DATEUSER,ok);
    return get_Profile;
}
//METODA_CHANGE_EMAIL -> email modificat de user
-(void)changeemail :(NSString *)AUTHTOKEN :(NSString*)EMAIL{
    Reachability *internetReach = [Reachability reachabilityForInternetConnection];
    [internetReach startNotifier];
    NetworkStatus netStatus = [internetReach currentReachabilityStatus];
    //ComNSLog(@"netstatus %u", netStatus);
    BOOL maideparte =NO;
    switch (netStatus)
    {
        case NotReachable:
        {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Eroare" message:@"Telefonul tău nu este conectat la internet. Te rugăm să încerci mai târziu" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertView show];
            break;
        }
            
        case ReachableViaWWAN:  case ReachableViaWiFi:
        {
            maideparte =YES;
            break;
        }
    }
    if(maideparte ==YES ) {
        
        NSMutableDictionary *dic2= [[NSMutableDictionary alloc]init];
        NSString *compus =@"";
        __block NSString *eroare = @"";
        //////////
        NSError * err;
        // __block BOOL logatcusucces =NO;
        NSString *currentSysVer = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] systemVersion]];
        [dic2 setObject:@"iOS" forKey:@"os"];
        [dic2 setObject:currentSysVer forKey:@"version"]; //  vers iOS
        [dic2 setObject:@"ro" forKey:@"lang"];
        [dic2 setObject:AUTHTOKEN forKey:@"authtoken"];
        NSString *U_email= EMAIL;
        [dic2 setObject:U_email forKey:@"email"];
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic2 options:0 error:&err];
        NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        compus =[NSString stringWithFormat:@"%@%@",METODA_CHANGE_EMAIL, myString];
        
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://%@",base_url]]];
        [request setHTTPMethod:@"POST"];
        NSMutableData *postBody = [NSMutableData data];
        [postBody appendData:[compus dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:postBody];
        NSLog(@"my strin %@", compus);
        AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        op.securityPolicy = [self customSecurityPolicy];
        op.responseSerializer = [AFJSONResponseSerializer serializer];
        [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
            NSMutableDictionary *DictionarErori= [[NSMutableDictionary alloc]init];
            NSDictionary *REZULTAT_NOTIFY_COUNT = responseObject;
            if(REZULTAT_NOTIFY_COUNT[@"errors"]) {
                NSMutableArray *erori = [[NSMutableArray alloc]init];
                if(REZULTAT_NOTIFY_COUNT[@"errors"]) {
                    DictionarErori = REZULTAT_NOTIFY_COUNT[@"errors"];
                    for(id cheie in [DictionarErori allKeys]) {
                        NSLog(@"dds %@",[DictionarErori valueForKey:cheie]);
                        [erori addObject:[NSString stringWithFormat:@"%@",[DictionarErori valueForKey:cheie]]];
                    }
                }
                
                NSLog(@"ERORS %@",erori);
                if(erori.count >0) {
                    eroare =    [erori componentsJoinedByString:@" "];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                        message:eroare
                                                                       delegate:nil
                                                              cancelButtonTitle:@"Ok"
                                                              otherButtonTitles:nil];
                    [alertView show];
                }   else  if(  REZULTAT_NOTIFY_COUNT[@"data"]) {
                    NSDictionary *multedate = REZULTAT_NOTIFY_COUNT[@"data"];
                    NSLog(@"date schimba email raspuns %@",multedate);
                    if(multedate[@"okmsg"]) {
                        NSString *mesajchangeemailserver=[NSString stringWithFormat:@"%@",multedate[@"okmsg"]];
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"PieseAuto"
                                                                            message:mesajchangeemailserver
                                                                           delegate:nil
                                                                  cancelButtonTitle:@"Ok"
                                                                  otherButtonTitles:nil];
                        [alertView show];
                    }
                    
                }
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                message:[error localizedDescription]
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
            
        }];
        [[NSOperationQueue mainQueue] addOperation:op];
    }
}
//METODA_GET_PROFILE -> la intrare in app daca e logat sau la login si dupa ce modifica datele
-(void)getProfile :(NSString *)AUTHTOKEN {
    Reachability *internetReach = [Reachability reachabilityForInternetConnection];
    [internetReach startNotifier];
    NetworkStatus netStatus = [internetReach currentReachabilityStatus];
    //ComNSLog(@"netstatus %u", netStatus);
    BOOL maideparte =NO;
    switch (netStatus)
    {
        case NotReachable:
        {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Eroare" message:@"Telefonul tău nu este conectat la internet. Te rugăm să încerci mai târziu" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertView show];
            break;
        }
            
        case ReachableViaWWAN:  case ReachableViaWiFi:
        {
            maideparte =YES;
            break;
        }
    }
    if(maideparte ==YES ) {
        
        NSMutableDictionary *dic2= [[NSMutableDictionary alloc]init];
        NSString *compus =@"";
        __block NSString *eroare = @"";
        //////////
        NSError * err;
        // __block BOOL logatcusucces =NO;
        NSString *currentSysVer = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] systemVersion]];
        [dic2 setObject:@"iOS" forKey:@"os"];
        [dic2 setObject:currentSysVer forKey:@"version"]; //  vers iOS
        [dic2 setObject:@"ro" forKey:@"lang"];
        [dic2 setObject:AUTHTOKEN forKey:@"authtoken"];
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic2 options:0 error:&err];
        NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        compus =[NSString stringWithFormat:@"%@%@",METODA_GET_PROFILE, myString];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://%@",base_url]]];
        [request setHTTPMethod:@"POST"];
        NSMutableData *postBody = [NSMutableData data];
        [postBody appendData:[compus dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:postBody];
        NSLog(@"my strin %@", compus);
        AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        op.securityPolicy = [self customSecurityPolicy];
        op.responseSerializer = [AFJSONResponseSerializer serializer];
        [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
            NSMutableDictionary *DictionarErori= [[NSMutableDictionary alloc]init];
            NSDictionary *REZULTAT_NOTIFY_COUNT = responseObject;
            if(REZULTAT_NOTIFY_COUNT[@"errors"]) {
                NSMutableArray *erori = [[NSMutableArray alloc]init];
                if(REZULTAT_NOTIFY_COUNT[@"errors"]) {
                    DictionarErori = REZULTAT_NOTIFY_COUNT[@"errors"];
                    for(id cheie in [DictionarErori allKeys]) {
                        NSLog(@"dds %@",[DictionarErori valueForKey:cheie]);
                        [erori addObject:[NSString stringWithFormat:@"%@",[DictionarErori valueForKey:cheie]]];
                    }
                }
                
                NSLog(@"ERORS %@",erori);
                if(erori.count >0) {
                    eroare=    [erori componentsJoinedByString:@" "];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                        message:eroare
                                                                       delegate:nil
                                                              cancelButtonTitle:@"Ok"
                                                              otherButtonTitles:nil];
                    [alertView show];
                }   else  if(  REZULTAT_NOTIFY_COUNT[@"data"]) {
                    NSDictionary *multedate = REZULTAT_NOTIFY_COUNT[@"data"];
                    NSLog(@"date GET PROFILE raspuns %@",multedate);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self updateprofile:multedate:AUTHTOKEN];
                    });
                }
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                message:[error localizedDescription]
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
            
        }];
        [[NSOperationQueue mainQueue] addOperation:op];
    }
    
}
//METODA_FORGOT_PASSWORD ->
-(void)sendforgot_password:(NSString*)email{
    Reachability *internetReach = [Reachability reachabilityForInternetConnection];
    [internetReach startNotifier];
    NetworkStatus netStatus = [internetReach currentReachabilityStatus];
    //ComNSLog(@"netstatus %u", netStatus);
    BOOL maideparte =NO;
    switch (netStatus)
    {
        case NotReachable:
        {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Eroare" message:@"Telefonul tău nu este conectat la internet. Te rugăm să încerci mai târziu" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertView show];
            
            
            
            break;
        }
            
        case ReachableViaWWAN:  case ReachableViaWiFi:
        {
            maideparte =YES;
            break;
        }
    }
    if(maideparte ==YES ) {
        
        NSMutableDictionary *dic2= [[NSMutableDictionary alloc]init];
        NSString *compus =@"";
        __block NSString *eroare = @"";
        __block NSString *mesajsucces = @"";
        //////////
        NSError * err;
        // __block BOOL logatcusucces =NO;
        NSString *currentSysVer = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] systemVersion]];
        [dic2 setObject:@"iOS" forKey:@"os"];
        [dic2 setObject:currentSysVer forKey:@"version"]; //  vers iOS
        [dic2 setObject:@"ro" forKey:@"lang"];
        [dic2 setObject:email forKey:@"email"];
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic2 options:0 error:&err];
        NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        compus =[NSString stringWithFormat:@"%@%@",METODA_FORGOT_PASSWORD, myString];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://%@",base_url]]];
        [request setHTTPMethod:@"POST"];
        NSMutableData *postBody = [NSMutableData data];
        [postBody appendData:[compus dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:postBody];
        NSLog(@"my strin %@", compus);
        AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        op.securityPolicy = [self customSecurityPolicy];
        op.responseSerializer = [AFJSONResponseSerializer serializer];
        [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
            NSMutableDictionary *DictionarErori= [[NSMutableDictionary alloc]init];
            NSDictionary *REZULTAT_NOTIFY_COUNT = responseObject;
            if(REZULTAT_NOTIFY_COUNT[@"errors"]) {
                NSMutableArray *erori = [[NSMutableArray alloc]init];
                if(REZULTAT_NOTIFY_COUNT[@"errors"]) {
                    DictionarErori = REZULTAT_NOTIFY_COUNT[@"errors"];
                    for(id cheie in [DictionarErori allKeys]) {
                        NSLog(@"dds %@",[DictionarErori valueForKey:cheie]);
                        [erori addObject:[NSString stringWithFormat:@"%@",[DictionarErori valueForKey:cheie]]];
                    }
                }
                
                NSLog(@"ERORS %@",erori);
                if(erori.count >0) {
                    eroare = [erori componentsJoinedByString:@" "];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                        message:eroare
                                                                       delegate:nil
                                                              cancelButtonTitle:@"Ok"
                                                              otherButtonTitles:nil];
                    [alertView show];
                }   else  if(  REZULTAT_NOTIFY_COUNT[@"data"]) {
                    NSDictionary *multedate = REZULTAT_NOTIFY_COUNT[@"data"];
                    /*   okmsg = "\U0162i-am trimis un e-mail pe adresa specificat\U0103 cu un link c\U0103tre o pagin\U0103 de unde po\U0163i schimba parola."; */
                    if(multedate[@"okmsg"]) {
                        mesajsucces = [NSString stringWithFormat:@"%@",multedate[@"okmsg"]];
                        
                        RIButtonItem *ok = [RIButtonItem item];
                        ok.label = @"Ok";
                        ok.action = ^{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                [self mergiLaLoginVC];
                            });
                        };
                        
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"PieseAuto"
                                                                            message:mesajsucces
                                                                   cancelButtonItem:nil
                                                                   otherButtonItems:ok,nil];
                        [alertView show];
                    }
                    
                    
                }
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                message:[error localizedDescription]
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
            
        }];
        [[NSOperationQueue mainQueue] addOperation:op];
    }
}

-(void)getnotify_count :(NSString *)AUTHTOKEN {
    Reachability *internetReach = [Reachability reachabilityForInternetConnection];
    [internetReach startNotifier];
    NetworkStatus netStatus = [internetReach currentReachabilityStatus];
    //ComNSLog(@"netstatus %u", netStatus);
    BOOL maideparte =NO;
    switch (netStatus)
    {
        case NotReachable:
        {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Eroare" message:@"Telefonul tău nu este conectat la internet. Te rugăm să încerci mai târziu" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertView show];
            break;
        }
            
        case ReachableViaWWAN:  case ReachableViaWiFi:
        {
            maideparte =YES;
            break;
        }
    }
    if(maideparte ==YES ) {
        NSMutableDictionary *dic2= [[NSMutableDictionary alloc]init];
        NSString *compus =@"";
        __block NSString *eroare = @"";
        //////////
        NSError * err;
        // __block BOOL logatcusucces =NO;
        NSString *currentSysVer = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] systemVersion]];
        [dic2 setObject:@"iOS" forKey:@"os"];
        [dic2 setObject:currentSysVer forKey:@"version"]; //  vers iOS
        [dic2 setObject:@"ro" forKey:@"lang"];
        [dic2 setObject:AUTHTOKEN forKey:@"authtoken"];
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic2 options:0 error:&err];
        NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        compus =[NSString stringWithFormat:@"%@%@",METODA_NOTIFY_COUNT, myString];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://%@",base_url]]];
        [request setHTTPMethod:@"POST"];
        NSMutableData *postBody = [NSMutableData data];
        [postBody appendData:[compus dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:postBody];
        NSLog(@"my strin %@", compus);
        AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        op.securityPolicy = [self customSecurityPolicy];
        op.responseSerializer = [AFJSONResponseSerializer serializer];
        [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
            NSMutableDictionary *DictionarErori= [[NSMutableDictionary alloc]init];
            NSDictionary *REZULTAT_NOTIFY_COUNT = responseObject;
            if(REZULTAT_NOTIFY_COUNT[@"errors"]) {
                NSMutableArray *erori = [[NSMutableArray alloc]init];
                if(REZULTAT_NOTIFY_COUNT[@"errors"]) {
                    DictionarErori = REZULTAT_NOTIFY_COUNT[@"errors"];
                    for(id cheie in [DictionarErori allKeys]) {
                        NSLog(@"dds %@",[DictionarErori valueForKey:cheie]);
                        [erori addObject:[NSString stringWithFormat:@"%@",[DictionarErori valueForKey:cheie]]];
                    }
                }
                
                NSLog(@"ERORS %@",erori);
                if(erori.count >0) {
                    eroare=    [erori componentsJoinedByString:@" "];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                        message:eroare
                                                                       delegate:nil
                                                              cancelButtonTitle:@"Ok"
                                                              otherButtonTitles:nil];
                    [alertView show];
                }   else  if(  REZULTAT_NOTIFY_COUNT[@"data"]) {
                    NSDictionary *multedate = REZULTAT_NOTIFY_COUNT[@"data"];
                  NSLog(@"date getnotify_count %@",multedate);
                    //dispatch_async(dispatch_get_main_queue(), ^{
                    [self updatenotify_count:multedate];
                    // });
                }
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
//                                                                message:[error localizedDescription]
//                                                               delegate:nil
//                                                      cancelButtonTitle:@"Ok"
//                                                      otherButtonTitles:nil];
//            [alertView show];
            
        }];
        [[NSOperationQueue mainQueue] addOperation:op];
    }
}
-(BOOL)MyStringisEmpty:(NSString *)str
{
    if(str.length==0 || [str isKindOfClass:[NSNull class]] || [str isEqualToString:@""]||[str  isEqualToString:@"NULL"]||[str isEqualToString:@"(null)"]|| [str isEqualToString:@"<null>"] || [str isEqualToString:@"null"] ||str==nil){
        return YES;
    }
    return NO;
}
-(void)doLoginOrRegister:(NSString*) tip :(NSMutableDictionary *)emailparolasautelefon {
    /*
     elenaciobanu1
     lambina
     ioan.ungureanu@activesoft.ro
     ioanungureanu
     wHdspd4DVAc
     */
      AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    Reachability *internetReach = [Reachability reachabilityForInternetConnection];
    [internetReach startNotifier];
    NetworkStatus netStatus = [internetReach currentReachabilityStatus];
    //ComNSLog(@"netstatus %u", netStatus);
    BOOL maideparte =NO;
    switch (netStatus)
    {
        case NotReachable:
        {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Eroare" message:@"Telefonul tău nu este conectat la internet. Te rugăm să încerci mai târziu" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertView show];
            break;
        }
            
        case ReachableViaWWAN:  case ReachableViaWiFi:
        {
            maideparte =YES;
            break;
        }
    }
    if(maideparte ==YES ) {
        NSMutableDictionary *dic2= [[NSMutableDictionary alloc]init];
        NSString *emailuser =@""; //camp email
        NSString *passworduser =@""; //camp parola
        NSString *telefonuser =@""; //camp telefon
        NSString *compus =@""; //e string compus pentru metoda (login sau register si json)
        NSError * err;
        // __block BOOL logatcusucces =NO;
        
        
        NSUserDefaults* prefs=[NSUserDefaults standardUserDefaults];
        NSString *currentSysVer = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] systemVersion]];
        NSString *tipmetoda = [NSString stringWithFormat:@"%@",tip];
        if([tipmetoda isEqualToString:@"Login"]) {
            emailuser = [NSString stringWithFormat:@"%@", emailparolasautelefon[@"email"]];
            passworduser = [NSString stringWithFormat:@"%@", emailparolasautelefon[@"password"]];
             [dic2 setObject:emailuser  forKey:@"email"];
             [dic2 setObject:passworduser  forKey:@"password"];
//            [dic2 setObject:@"ioan.ungureanu@activesoft.ro"  forKey:@"email"];
//            [dic2 setObject:@"123456"  forKey:@"password"];
            [dic2 setObject:@"iOS" forKey:@"os"];
            [dic2 setObject:currentSysVer forKey:@"version"]; //  vers iOS
            [dic2 setObject:@"ro" forKey:@"lang"];
        } else
            if([tipmetoda isEqualToString:@"Register"]) {
                emailuser = [NSString stringWithFormat:@"%@", emailparolasautelefon[@"email"]];
                telefonuser = [NSString stringWithFormat:@"%@", emailparolasautelefon[@"tel"]];
                /*  [dic2 setObject:emailuser  forKey:@"email"];
                 [dic2 setObject:passworduser  forKey:@"emailtel"];*/
              //  [dic2 setObject:@"ioan.ungureanu@activesoft.ro"  forKey:@"email"];
                //[dic2 setObject:@""  forKey:@"email"];
               //  [dic2 setObject:@"0726744222"  forKey:@"tel"];
                [dic2 setObject:telefonuser  forKey:@"tel"];
                [dic2 setObject:@"iOS" forKey:@"os"];
                [dic2 setObject:currentSysVer forKey:@"version"]; //  vers iOS
                [dic2 setObject:@"ro" forKey:@"lang"];
            }
        __block NSString *eroare = @"";
        
        //  NSDictionary *params = @{@"email": @"ioan.ungureanu@activesoft.ro", @"password": @"wHdspd4DVAc"};
        //  my strin m=login&p={"password":"wHdspd4DVAc","email":"ioan.ungureanu@activesoft.ro"}
        
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic2 options:0 error:&err];
        NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        if([tipmetoda isEqualToString:@"Login"]) {
            compus =[NSString stringWithFormat:@"%@%@",METODA_LOGIN, myString];
        } else
            if([tipmetoda isEqualToString:@"Register"]) {
                compus =[NSString stringWithFormat:@"%@%@",METODA_REGISTER, myString];
            }
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://%@",base_url]]];
        [request setHTTPMethod:@"POST"];
        NSMutableData *postBody = [NSMutableData data];
        [postBody appendData:[compus dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:postBody];
        NSLog(@"my strin %@", compus);
        
        AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        op.securityPolicy = [self customSecurityPolicy];
        op.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"JSON: %@", responseObject);
            if([tipmetoda isEqualToString:@"Login"]) {
                NSMutableDictionary *RASPUNS_LOGIN = [[NSMutableDictionary alloc]init];
                NSMutableDictionary *DictionarErori= [[NSMutableDictionary alloc]init];
                RASPUNS_LOGIN = responseObject;
                NSMutableArray *erori = [[NSMutableArray alloc]init];
                if(RASPUNS_LOGIN[@"errors"]) {
                    DictionarErori = RASPUNS_LOGIN[@"errors"];
                    for(id cheie in [DictionarErori allKeys]) {
                        NSLog(@"dds %@",[DictionarErori valueForKey:cheie]);
                        [erori addObject:[NSString stringWithFormat:@"%@",[DictionarErori valueForKey:cheie]]];
                    }
                }
                NSLog(@"ERORS %@",erori);
                if(erori.count >0) {
                    [prefs setValue:@"0" forKey:@"E_LOGAT"];
                    [prefs synchronize];
                    eroare=     [erori componentsJoinedByString:@" "];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                        message:eroare
                                                                       delegate:nil
                                                              cancelButtonTitle:@"Ok"
                                                              otherButtonTitles:nil];
                    [alertView show];
                } else {
                    /*   data =     { authtoken = "1248f7g56f1661dgQjLCI41nTdioxQ0S7F4ZsGJL6_Tb9-vvDVcdphM7Onw"; username = ioanungureanu; }; errors =  {  };   */
                    NSMutableDictionary *DictionarDate= [[NSMutableDictionary alloc]init];
                    if(RASPUNS_LOGIN[@"data"])  DictionarDate = RASPUNS_LOGIN[@"data"];
                    
                    if([DictionarDate objectForKey:@"authtoken"] && [DictionarDate objectForKey:@"username"]) {
                        
                        NSString *AUTH_TOKEN = [NSString stringWithFormat:@"%@",[DictionarDate objectForKey:@"authtoken"]];
                        NSString *USERNAME = [NSString stringWithFormat:@"%@",[DictionarDate objectForKey:@"username"]];
                        NSString *USERID = [NSString stringWithFormat:@"%@",[DictionarDate objectForKey:@"user_id"]];
                        NSLog(@"autohtoken %@",AUTH_TOKEN );
                        NSMutableDictionary *DATEUSER = [[NSMutableDictionary alloc]init];
                        DATEUSER = [NSMutableDictionary dictionaryWithDictionary:[DataMasterProcessor getUSERACCOUNT:USERID]];
                        NSLog(@"dateuser but not in %@",DATEUSER);
                        /*
                         
                         CREATE TABLE "users" ("U_authtoken" VARCHAR,
                         "U_lastupdate" VARCHAR,
                         "U_username" VARCHAR,
                         "U_logat" VARCHAR,
                         "U_preferinte_notificari" VARCHAR,
                         "U_prenume" VARCHAR,
                         "U_nume" VARCHAR,
                         "U_email" VARCHAR,
                         "U_telefon" VARCHAR,
                         "U_telefon2" VARCHAR,
                         "U_telefon3" VARCHAR,
                         "U_telefon4" VARCHAR,
                         "U_judet"  VARCHAR,
                         "U_localitate"  VARCHAR,
                         "U_cod_postal" VARCHAR,
                         "U_adresa" VARCHAR,
                         "U_parola" VARCHAR,
                         "U_userid" VARCHAR  NOT NULL  UNIQUE)
                         */
                        
                        
                        if(DATEUSER[@"U_userid"] && ![self MyStringisEmpty:[NSString stringWithFormat:@"%@",DATEUSER[@"U_userid"]]]) { //acest user exista deja asa ca ii vom actualiza date
                            [DATEUSER setValue:AUTH_TOKEN forKey:@"U_authtoken"];
                            if(!DATEUSER[@"U_lastupdate"]) {
                                [DATEUSER setValue:@"0" forKey:@"U_lastupdate"];
                            }
                            if(!DATEUSER[@"U_username"]) {
                                [DATEUSER setValue:USERNAME forKey:@"U_username"];
                            }
                            [DATEUSER setValue:@"1" forKey:@"U_logat"];
                            [DATEUSER setValue:emailuser forKey:@"U_email"];
                            [DATEUSER setValue:passworduser forKey:@"U_parola"];
                            
                        }else {
                            //user nou prima data
                            [DATEUSER setValue:AUTH_TOKEN forKey:@"U_authtoken"];
                            [DATEUSER setValue:@"0" forKey:@"U_lastupdate"];
                            [DATEUSER setValue:USERNAME forKey:@"U_username"];
                            [DATEUSER setValue:@"1" forKey:@"U_logat"];
                            [DATEUSER setValue:@"" forKey:@"U_preferinte_notificari"];
                            [DATEUSER setValue:@"" forKey:@"U_prenume"];
                            [DATEUSER setValue:@"" forKey:@"U_nume"];
                            [DATEUSER setValue:@"" forKey:@"U_telefon"];
                            [DATEUSER setValue:@"" forKey:@"U_telefon2"];
                            [DATEUSER setValue:@"" forKey:@"U_telefon3"];
                            [DATEUSER setValue:@"" forKey:@"U_telefon4"];
                            [DATEUSER setValue:@"" forKey:@"U_judet"];
                            [DATEUSER setValue:@"" forKey:@"U_localitate"];
                            [DATEUSER setValue:@"" forKey:@"U_cod_postal"];
                            [DATEUSER setValue:@"" forKey:@"U_adresa"];
                            [DATEUSER setValue:USERID forKey:@"U_userid"];
                            // [DATEUSER setValue:@"" forKey:@"U_email"];
                            // [DATEUSER setValue:@"" forKey:@"U_parola"];
                            [DATEUSER setValue:emailuser forKey:@"U_email"];
                            [DATEUSER setValue:passworduser forKey:@"U_parola"];
                        }
                      
                        NSLog(@"dateuser pentru login %@", DATEUSER);
                        [DataMasterProcessor insertUsers:DATEUSER];
                      
                        [prefs setValue:@"1" forKey:@"E_LOGAT"];
                        [prefs synchronize];
                     
                         NSString *authtoken=@"";
                        BOOL elogat = NO;
                        elogat = [self eLogat];
                        AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                        if(elogat) {
                            authtoken = [self AUTHTOKEN];
                          //  [del preia_notify_count];
                          [self getProfile:authtoken];
                          [self getnotify_count:authtoken];
                          [self set_push_token:authtoken];
                          [self cerere_autocomplete:authtoken];
                               if(del.vinedincerere ==YES) {
                                //inapoi la cerere cu send
                                del.inapoilacereredinlogin =YES;
                                [self  mergiLaCerereNouaViewVC];
                            } else {
                                del.inapoilacereredinlogin =NO;
                                [self mergiLaMainViewVC];
                            }
                            NSLog(@"bravo login %@",authtoken);
                        } else {
                            NSLog(@"nelogat %@",authtoken);
                            del.NOTIFY_COUNT = [[NSDictionary alloc]init];
                        }
                        
                    }
                }
                
            } else
                if([tipmetoda isEqualToString:@"Register"]) {
                    NSMutableDictionary *RASPUNS_REGISTER = [[NSMutableDictionary alloc]init];
                    NSMutableDictionary *DictionarErori= [[NSMutableDictionary alloc]init];
                    RASPUNS_REGISTER = responseObject;
                    NSMutableArray *erori = [[NSMutableArray alloc]init];
                    if(RASPUNS_REGISTER[@"errors"]) {
                        DictionarErori = RASPUNS_REGISTER[@"errors"];
                        for(id cheie in [DictionarErori allKeys]) {
                            NSLog(@"dds %@",[DictionarErori valueForKey:cheie]);
                            [erori addObject:[NSString stringWithFormat:@"%@",[DictionarErori valueForKey:cheie]]];
                        }
                    }
                    NSLog(@"ERORS %@",erori);
                    if(erori.count >0) {
                        [prefs setValue:@"0" forKey:@"E_LOGAT"];
                        [prefs synchronize];
                        eroare =   [erori componentsJoinedByString:@" "];
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                            message:eroare
                                                                           delegate:nil
                                                                  cancelButtonTitle:@"Ok"
                                                                  otherButtonTitles:nil];
                        [alertView show];
                    } else {
                        /*   data =     {
                         authtoken = "1248f7g56f1661dgQjLCI41nTdioxQ0S7F4ZsGJL6_Tb9-vvDVcdphM7Onw";
                         username = ioanungureanu;
                         };
                         errors =     {
                         };
                         */
                        NSMutableDictionary *DictionarDate= [[NSMutableDictionary alloc]init];
                        if(RASPUNS_REGISTER[@"data"])  DictionarDate = RASPUNS_REGISTER[@"data"];
                        
                        if([DictionarDate objectForKey:@"authtoken"] && [DictionarDate objectForKey:@"username"]) {
                            NSString *AUTH_TOKEN = [NSString stringWithFormat:@"%@",[DictionarDate objectForKey:@"authtoken"]];
                            NSString *USERNAME = [NSString stringWithFormat:@"%@",[DictionarDate objectForKey:@"username"]];
                            NSString *USERID = [NSString stringWithFormat:@"%@",[DictionarDate objectForKey:@"user_id"]];
                             NSLog(@"autohtoken %@",AUTH_TOKEN );
                            NSMutableDictionary *DATEUSER = [[NSMutableDictionary alloc]init];
                            DATEUSER = [NSMutableDictionary dictionaryWithDictionary:[DataMasterProcessor getUSERACCOUNT:USERID]];
                             if(DATEUSER[@"U_userid"] && ![self MyStringisEmpty:[NSString stringWithFormat:@"%@",DATEUSER[@"U_userid"]]])  { //acest user exista deja asa ca ii vom actualiza date
                                [DATEUSER setValue:AUTH_TOKEN forKey:@"U_authtoken"];
                                if(!DATEUSER[@"U_lastupdate"]) {
                                    [DATEUSER setValue:@"0" forKey:@"U_lastupdate"];
                                }
                                if(!DATEUSER[@"U_username"]) {
                                    [DATEUSER setValue:USERNAME forKey:@"U_username"];
                                }
                                [DATEUSER setValue:@"1" forKey:@"U_logat"];
                                [DATEUSER setValue:emailuser forKey:@"U_email"];
                            } else {
                                //user nou prima data
                                [DATEUSER setValue:AUTH_TOKEN forKey:@"U_authtoken"];
                                [DATEUSER setValue:@"0" forKey:@"U_lastupdate"];
                                [DATEUSER setValue:USERNAME forKey:@"U_username"];
                                [DATEUSER setValue:@"1" forKey:@"U_logat"];
                                [DATEUSER setValue:@"" forKey:@"U_preferinte_notificari"];
                                [DATEUSER setValue:@"" forKey:@"U_prenume"];
                                [DATEUSER setValue:@"" forKey:@"U_nume"];
                                // [DATEUSER setValue:@"" forKey:@"U_email"];
                                [DATEUSER setValue:emailuser forKey:@"U_email"];
                                // [DATEUSER setValue:@"" forKey:@"U_telefon"];
                                [DATEUSER setValue:telefonuser forKey:@"U_telefon"];
                                [DATEUSER setValue:@"" forKey:@"U_telefon2"];
                                [DATEUSER setValue:@"" forKey:@"U_telefon3"];
                                [DATEUSER setValue:@"" forKey:@"U_telefon4"];
                                [DATEUSER setValue:@"" forKey:@"U_judet"];
                                [DATEUSER setValue:@"" forKey:@"U_localitate"];
                                [DATEUSER setValue:@"" forKey:@"U_cod_postal"];
                                [DATEUSER setValue:@"" forKey:@"U_adresa"];
                                [DATEUSER setValue:@"" forKey:@"U_parola"];
                                [DATEUSER setValue:USERID forKey:@"U_userid"];
                            }
                           
                            [DataMasterProcessor insertUsers:DATEUSER];
                            [prefs setValue:@"1" forKey:@"E_LOGAT"];
                            [prefs synchronize];
                            NSString *authtoken=@"";
                            BOOL elogat = NO;
                            elogat = [self eLogat];
                            if(elogat) {
                                NSLog(@"bravo login %@",authtoken);
                                authtoken = [self AUTHTOKEN];
                                [self getProfile:authtoken];
                               //  [del preia_notify_count];
                                [self getnotify_count:authtoken];
                                [self set_push_token:authtoken];
                                 [self cerere_autocomplete:authtoken];
                                if(del.vinedincerere ==YES) {
                                    //inapoi la cerere cu send
                                    del.inapoilacereredinlogin =YES;
                                    [self  mergiLaCerereNouaViewVC];
                                    
                                } else {
                                    //inapoi la main
                                 //    [del preia_notify_count];
                                    [self getnotify_count:authtoken];
                                    [self mergiLaMainViewVC];
                                }
                                
                            } else {
                                  del.NOTIFY_COUNT = [[NSDictionary alloc]init];
                                NSLog(@"nelogat %@",authtoken);
                            }
                        }
                    }
                }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            
        }];
        [[NSOperationQueue mainQueue] addOperation:op];
    }
    //   sau  ->  [op start];
}
    //METODA_CERERE_AUTOCOMPLETE -> la intrare in app daca e logat sau la login si dupa ce modifica datele
-(void)cerere_autocomplete :(NSString *)AUTHTOKEN {
       Reachability *internetReach = [Reachability reachabilityForInternetConnection];
        [internetReach startNotifier];
        NetworkStatus netStatus = [internetReach currentReachabilityStatus];
        //ComNSLog(@"netstatus %u", netStatus);
        BOOL maideparte =NO;
        switch (netStatus)
        {
            case NotReachable:
            {
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Eroare" message:@"Telefonul tău nu este conectat la internet. Te rugăm să încerci mai târziu" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alertView show];
                break;
            }
                
            case ReachableViaWWAN:  case ReachableViaWiFi:
            {
                maideparte =YES;
                break;
            }
        }
        if(maideparte ==YES ) {
            NSMutableDictionary *dic2= [[NSMutableDictionary alloc]init];
            NSString *compus =@"";
            __block NSString *eroare = @"";
            //////////
            NSError * err;
            // __block BOOL logatcusucces =NO;
            NSString *currentSysVer = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] systemVersion]];
            [dic2 setObject:@"iOS" forKey:@"os"];
            [dic2 setObject:currentSysVer forKey:@"version"]; //  vers iOS
            [dic2 setObject:@"ro" forKey:@"lang"];
            [dic2 setObject:AUTHTOKEN forKey:@"authtoken"];
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic2 options:0 error:&err];
            NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            compus =[NSString stringWithFormat:@"%@%@",METODA_CERERE_AUTOCOMPLETE, myString];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://%@",base_url]]];
            [request setHTTPMethod:@"POST"];
            NSMutableData *postBody = [NSMutableData data];
            [postBody appendData:[compus dataUsingEncoding:NSUTF8StringEncoding]];
            [request setHTTPBody:postBody];
            NSLog(@"my strin %@", compus);
            AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
            op.securityPolicy = [self customSecurityPolicy];
            op.responseSerializer = [AFJSONResponseSerializer serializer];
            [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
                NSMutableDictionary *DictionarErori= [[NSMutableDictionary alloc]init];
                NSDictionary *REZULTAT_NOTIFY_COUNT = responseObject;
                if(REZULTAT_NOTIFY_COUNT[@"errors"]) {
                    NSMutableArray *erori = [[NSMutableArray alloc]init];
                    if(REZULTAT_NOTIFY_COUNT[@"errors"]) {
                        DictionarErori = REZULTAT_NOTIFY_COUNT[@"errors"];
                        for(id cheie in [DictionarErori allKeys]) {
                            NSLog(@"dds %@",[DictionarErori valueForKey:cheie]);
                            [erori addObject:[NSString stringWithFormat:@"%@",[DictionarErori valueForKey:cheie]]];
                        }
                    }
                    
                    NSLog(@"ERORS %@",erori);
                    if(erori.count >0) {
                        eroare=    [erori componentsJoinedByString:@" "];
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                            message:eroare
                                                                           delegate:nil
                                                                  cancelButtonTitle:@"Ok"
                                                                  otherButtonTitles:nil];
                        [alertView show];
                    }   else  if(  REZULTAT_NOTIFY_COUNT[@"data"]) {
                        NSArray *multedate = REZULTAT_NOTIFY_COUNT[@"data"];
                    /////JJNSLog(@"date METODA_CERERE_AUTOCOMPLETE raspuns %@",multedate);
                        dispatch_async(dispatch_get_main_queue(), ^{
                            //get userid
                            NSDictionary *userlogat = [DataMasterProcessor getLOGEDACCOUNT];
                            NSString *userid =[NSString stringWithFormat:@"%@",userlogat[@"U_userid"]];
                            [DataMasterProcessor updateUsers_cars:multedate :userid];
                           // [self updateprofile:multedate:AUTHTOKEN];
                        });
                    }
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                    message:[error localizedDescription]
                                                                   delegate:nil
                                                          cancelButtonTitle:@"Ok"
                                                          otherButtonTitles:nil];
                [alertView show];
                
            }];
            [[NSOperationQueue mainQueue] addOperation:op];
        }
        
}

    


-(void)primaconectare {
    //prima data cand intra in app si face sync -> dupa doar compara timestamp daca e dif. de last face iar sync
    AppDelegate * del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    ///// AFHTTPSessionManager *manager = [self SESSIONMANAGER];
    NSUserDefaults* prefs=[NSUserDefaults standardUserDefaults];
    NSString *compus =@""; //e string compus pentru metoda (login sau register si json)
    __block  NSString *OLDTIMESTAMP;
    __block  BOOL faupdate=NO;
    __block  BOOL primadata=NO;
    __block id WeakSelf = self;
    NSError * err;
    
    if(![self getObjectForKey:@"last_update"]){
        [prefs setValue:@"0" forKey:@"last_update"];
        primadata =YES;
        NSMutableArray *producatori = [[NSMutableArray alloc]init];
        NSMutableArray *marci = [[NSMutableArray alloc]init];
        NSMutableArray *judete = [[NSMutableArray alloc]init];
        NSMutableArray *localitati = [[NSMutableArray alloc]init];
        [prefs setObject:producatori forKey:@"PRODUCATORIAUTO"];
        [prefs setObject:marci forKey:@"MARCIAUTO"];
        [prefs setObject:judete forKey:@"JUDETE"];
        [prefs setObject:localitati forKey:@"LOCALITATI"];
        [prefs synchronize];
        OLDTIMESTAMP = [NSString stringWithFormat:@"%@", [prefs objectForKey:@"last_update"]];
    } else {
        primadata =NO;
        OLDTIMESTAMP = [NSString stringWithFormat:@"%@", [prefs objectForKey:@"last_update"]];
    }
    
    NSMutableDictionary *dic2= [[NSMutableDictionary alloc]init];
    [dic2 setValue:OLDTIMESTAMP forKey:@"last_update"];
    [dic2 setObject:@"iOS" forKey:@"os"];
    NSString *currentSysVer = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] systemVersion]];
    [dic2 setObject:currentSysVer forKey:@"version"]; //  vers iOS
    
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic2 options:0 error:&err];
    NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    compus =[NSString stringWithFormat:@"%@%@",METODA_INIT, myString];
    NSLog(@"compus %@", compus);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://%@",base_url]]];
    [request setHTTPMethod:@"POST"];
    NSMutableData *postBody = [NSMutableData data];
    [postBody appendData:[compus dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:postBody];
    
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.securityPolicy = [self customSecurityPolicy];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *REZULTATPRIMACONECTARE = responseObject;
        NSString *eroare = @"";
        /// NSLog(@"prima conectare %@", REZULTATPRIMACONECTARE);
        if(  REZULTATPRIMACONECTARE[@"last_update"]) {
            //citeste din nsuserdef
            NSString *NEWTIMESTAMP = [NSString stringWithFormat:@"%@", REZULTATPRIMACONECTARE[@"last_update"]];
            if(![OLDTIMESTAMP isEqualToString:NEWTIMESTAMP]){
                NSLog(@"e mai veche");
                faupdate =YES;
            }
        }
        //test sa vezi cat ii ia sa faca insert prima data
        //primadata =YES;
        //test update daca vrei sa vezi ca face update la cele deja existente in baza
        //// faupdate =YES;
        NSMutableDictionary *DictionarErori= [[NSMutableDictionary alloc]init];
        if( primadata ==YES) {
            //only once
            if(REZULTATPRIMACONECTARE[@"errors"]) {
                NSMutableArray *erori = [[NSMutableArray alloc]init];
                if(REZULTATPRIMACONECTARE[@"errors"]) {
                    DictionarErori = REZULTATPRIMACONECTARE[@"errors"];
                    for(id cheie in [DictionarErori allKeys]) {
                        NSLog(@"ccs %@",[DictionarErori valueForKey:cheie]);
                        [erori addObject:[NSString stringWithFormat:@"%@",[DictionarErori valueForKey:cheie]]];
                    }
                }
                NSLog(@"ERORS %@",erori);
                if(erori.count >0) {
                    eroare=    [erori componentsJoinedByString:@" "];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                        message:eroare
                                                                       delegate:nil
                                                              cancelButtonTitle:@"Ok"
                                                              otherButtonTitles:nil];
                    [alertView show];
                }   else  if(  REZULTATPRIMACONECTARE[@"data"]) {
                    NSDictionary *multedate = REZULTATPRIMACONECTARE[@"data"];
                    if(multedate[@"carmakers"] && [multedate[@"carmakers"] isKindOfClass:[NSArray class]] ) {
                        NSMutableArray *producatori = [NSMutableArray arrayWithArray:multedate[@"carmakers"]];
                        [prefs setObject:producatori forKey:@"PRODUCATORIAUTO"];
                        del.PRODUCATORIAUTO =producatori;
                        //   NSLog(@"producatori %@", del.PRODUCATORIAUTO);
                        BOOL ok = [DataMasterProcessor insertProducatori:del.PRODUCATORIAUTO :@"insert"];
                        if(ok) {
                            NSLog(@"ok prod");
                        }else {
                            NSLog(@"bad prod");
                        }
                    }
                    //currencies
                    if(multedate[@"currencies"] && [multedate[@"currencies"] isKindOfClass:[NSArray class]] ) {
                        NSMutableArray *currencies = [NSMutableArray arrayWithArray:multedate[@"currencies"]];
                        del.CURRENCIES =currencies;
                        BOOL ok = [DataMasterProcessor insertCurrencies:del.CURRENCIES :@"insert"];
                        if(ok) {
                            NSLog(@"ok CURRENCIES");
                        }else {
                            NSLog(@"bad CURRENCIES");
                        }
                    }
                    //img_max_width":1024,"img_max_height":768,"cerere_max_images
                    
                    if(multedate[@"img_max_width"]) {
                        NSString *img_max_width = [NSString stringWithFormat:@"%@",multedate[@"img_max_width"]];
                        [prefs setObject:img_max_width forKey:@"IMG_max_width"];
                        [prefs synchronize];
                        del.IMG_max_width = img_max_width;
                    }
                    if(multedate[@"img_max_height"]) {
                        NSString *img_max_height = [NSString stringWithFormat:@"%@",multedate[@"img_max_height"]];
                        [prefs setObject:img_max_height forKey:@"IMG_max_height"];
                        [prefs synchronize];
                        del.IMG_max_height =img_max_height;
                    }
                    if(multedate[@"cerere_max_images"]) {
                        
                        NSString *cerere_max_images = [NSString stringWithFormat:@"%@",multedate[@"cerere_max_images"]];
                        NSLog(@"cerere_max_images %@", cerere_max_images);
                        [prefs setObject:cerere_max_images forKey:@"CERERE_max_images"];
                        [prefs synchronize];
                        del.CERERE_max_images =cerere_max_images;
                    }
                    if(multedate[@"comment_max_images"]) {
                        NSString *comment_max_images = [NSString stringWithFormat:@"%@",multedate[@"comment_max_images"]];
                        [prefs setObject:comment_max_images forKey:@"COMMENT_max_images"];
                        [prefs synchronize];
                        del.COMMENT_max_images =comment_max_images;
                    }
                    
                    if(multedate[@"carmodels"] && [multedate[@"carmodels"] isKindOfClass:[NSArray class]] ) {
                        NSMutableArray *marci = [NSMutableArray arrayWithArray:multedate[@"carmodels"]];
                        del.MARCIAUTO =marci;
                        BOOL ok = [DataMasterProcessor insertCarModels:del.MARCIAUTO :@"insert"];
                        if(ok) {
                            NSLog(@"ok MARCIAUTO");
                        }else {
                            NSLog(@"bad MARCIAUTO");
                        }
                    }
                    
                    if(multedate[@"counties"] && [multedate[@"counties"] isKindOfClass:[NSArray class]] ) {
                        NSMutableArray *judete = [NSMutableArray arrayWithArray:multedate[@"counties"]];
                        del.JUDETE =judete;
                        BOOL ok = [DataMasterProcessor insertJudete:del.JUDETE :@"insert"];
                        if(ok) {
                            NSLog(@"ok jud");
                        }else {
                            NSLog(@"bad jud");
                        }
                    }
                    
                    if(multedate[@"locations"] && [multedate[@"locations"] isKindOfClass:[NSArray class]] ) {
                        NSMutableArray *localitati = [NSMutableArray arrayWithArray:multedate[@"locations"]];
                        del.LOCALITATI =localitati;
                        BOOL ok = [DataMasterProcessor insertLocalitati:del.LOCALITATI :@"insert"];
                        if(ok) {
                            NSLog(@"ok LOCALITATI");
                        }else {
                            NSLog(@"bad LOCALITATI");
                        }
                    }
                    //la final stocheaza si last_update
                    [prefs setObject:REZULTATPRIMACONECTARE[@"last_update"]  forKey:@"last_update"];
                    [prefs synchronize];
                } else {
                    NSLog(@"nu sunt date");
                }
            }
            
        }
        
        else
            if(faupdate ==YES ) {
                if(REZULTATPRIMACONECTARE[@"errors"]) {
                    NSMutableArray *erori = [[NSMutableArray alloc]init];
                    if(REZULTATPRIMACONECTARE[@"errors"]) {
                        DictionarErori = REZULTATPRIMACONECTARE[@"errors"];
                        for(id cheie in [DictionarErori allKeys]) {
                            NSLog(@"ccs %@",[DictionarErori valueForKey:cheie]);
                            [erori addObject:[NSString stringWithFormat:@"%@",[DictionarErori valueForKey:cheie]]];
                        }
                    }
                    NSLog(@"ERORS %@",erori);
                    if(erori.count >0) {
                        eroare=     [erori componentsJoinedByString:@" "];
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                            message:eroare
                                                                           delegate:nil
                                                                  cancelButtonTitle:@"Ok"
                                                                  otherButtonTitles:nil];
                        [alertView show];
                    }
                    else    if(  REZULTATPRIMACONECTARE[@"data"]) {
                        NSDictionary *multedate = REZULTATPRIMACONECTARE[@"data"];
                        if(multedate[@"carmakers"] && [multedate[@"carmakers"] isKindOfClass:[NSArray class]] ) {
                            NSMutableArray *producatori = [NSMutableArray arrayWithArray:multedate[@"carmakers"]];
                            BOOL ok = [DataMasterProcessor insertProducatori:producatori :@"update"];
                            if(ok) {
                                NSLog(@"ok prod");
                            }else {
                                NSLog(@"bad prod");
                            }
                            
                        }
                        if(multedate[@"carmodels"] && [multedate[@"carmodels"] isKindOfClass:[NSArray class]] ) {
                            NSMutableArray *marci = [NSMutableArray arrayWithArray:multedate[@"carmodels"]];
                            BOOL ok = [DataMasterProcessor insertCarModels:marci  :@"update"];
                            if(ok) {
                                NSLog(@"ok MARCIAUTO");
                            }else {
                                NSLog(@"bad MARCIAUTO");
                            }
                        }
                        
                        if(multedate[@"currencies"] && [multedate[@"currencies"] isKindOfClass:[NSArray class]] ) {
                            NSMutableArray *currencies = [NSMutableArray arrayWithArray:multedate[@"currencies"]];
                            del.CURRENCIES =currencies;
                            BOOL ok = [DataMasterProcessor insertCurrencies:del.CURRENCIES :@"update"];
                            if(ok) {
                                NSLog(@"ok CURRENCIES");
                            }else {
                                NSLog(@"bad CURRENCIES");
                            }
                        }
                        if(multedate[@"img_max_width"]) {
                            NSString *img_max_width = [NSString stringWithFormat:@"%@",multedate[@"img_max_width"]];
                            [prefs setObject:img_max_width forKey:@"IMG_max_width"];
                            [prefs synchronize];
                            del.IMG_max_width = img_max_width;
                        }
                        if(multedate[@"img_max_height"]) {
                            NSString *img_max_height = [NSString stringWithFormat:@"%@",multedate[@"img_max_height"]];
                            [prefs setObject:img_max_height forKey:@"IMG_max_height"];
                            [prefs synchronize];
                            del.IMG_max_height =img_max_height;
                        }
                        if(multedate[@"cerere_max_images"]) {
                            NSString *cerere_max_images = [NSString stringWithFormat:@"%@",multedate[@"cerere_max_images"]];
                            [prefs setObject:cerere_max_images forKey:@"CERERE_max_images"];
                            [prefs synchronize];
                            del.CERERE_max_images =cerere_max_images;
                        }
                        if(multedate[@"comment_max_images"]) {
                            NSString *comment_max_images = [NSString stringWithFormat:@"%@",multedate[@"comment_max_images"]];
                            [prefs setObject:comment_max_images forKey:@"COMMENT_max_images"];
                            [prefs synchronize];
                            del.COMMENT_max_images =comment_max_images;
                        }
                        
                        if(multedate[@"counties"] && [multedate[@"counties"] isKindOfClass:[NSArray class]] ) {
                            NSMutableArray *judete = [NSMutableArray arrayWithArray:multedate[@"counties"]];
                            BOOL ok = [DataMasterProcessor insertJudete:judete  :@"update"];
                            if(ok) {
                                NSLog(@"ok jud");
                            }else {
                                NSLog(@"bad jud");
                            }
                            
                        }
                        if(multedate[@"locations"] && [multedate[@"locations"] isKindOfClass:[NSArray class]] ) {
                            NSMutableArray *localitati = [NSMutableArray arrayWithArray:multedate[@"locations"]];
                            BOOL ok = [DataMasterProcessor insertLocalitati:localitati  :@"update"];
                            if(ok) {
                                NSLog(@"ok LOCALITATI");
                            }else {
                                NSLog(@"bad LOCALITATI");
                            }
                            
                        }
                        //la final stocheaza si last_update
                        [prefs setObject:REZULTATPRIMACONECTARE[@"last_update"]  forKey:@"last_update"];
                        [prefs synchronize];
                        
                    } else {
                        NSLog(@"nu sunt date");
                    }
                }
                
            }
            else {
                //init la arii cu datele vechi
                AppDelegate * del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                NSString *img_max_width = [NSString stringWithFormat:@"%@",[prefs objectForKey:@"IMG_max_width"]];
                NSString *img_max_height = [NSString stringWithFormat:@"%@",[prefs objectForKey:@"IMG_max_height"]];
                NSString *cerere_max_images = [NSString stringWithFormat:@"%@",[prefs objectForKey:@"CERERE_max_images"]];
                del.IMG_max_height = img_max_height;
                del.IMG_max_width = img_max_width;
                del.CERERE_max_images = cerere_max_images;
                // cred ca renunt la astea spre final ...au ramas aici ca referinta sa se vada cum se cheama :D
                del.PRODUCATORIAUTO =[DataMasterProcessor getProducatori];
                del.MARCIAUTO =[DataMasterProcessor getMarciAuto:@""];
                del.JUDETE =[DataMasterProcessor getJudete];
                del.LOCALITATI =[DataMasterProcessor getLocalitati:@""];
                del.CURRENCIES =[DataMasterProcessor getCURRENCIES];
                //   NSLog(@"nu e update foloseste vechi %@", del.PRODUCATORIAUTO);
                NSLog(@"nu e update foloseste vechi");
                [WeakSelf sendNotification];
                
            }   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                    message:[error localizedDescription]
                                                                   delegate:nil
                                                          cancelButtonTitle:@"Ok"
                                                          otherButtonTitles:nil];
                [alertView show];
            }];
    
    [[NSOperationQueue mainQueue] addOperation:op];
    
    //  [MBProgressHUD hideAllHUDsForView:[AppDelegate getReference].navigationController.topViewController.view animated:YES];
    [self sendNotification]; // anunta main ca a terminat de luat datele si sa faca push mai departe
    
    /* model get AF 3.0
     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     [manager GET:@"http://example.com/resources.json" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
     NSLog(@"JSON: %@", responseObject);
     } failure:^(NSURLSessionTask *operation, NSError *error) {
     NSLog(@"Error: %@", error);
     }];
     
     
     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     NSSet *certificates = [AFSecurityPolicy certificatesInBundle:[NSBundle mainBundle]];
     AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:certificates];
     [policy setValidatesDomainName:NO];
     [policy setAllowInvalidCertificates:YES]; // e self signed deci tehnic 'invalid' -> ii dam allow dev
     manager.securityPolicy = policy;
     
     NSMutableDictionary *dic= [[NSMutableDictionary alloc]init];
     NSMutableDictionary *dic2= [[NSMutableDictionary alloc]init];
     [dic setValue:@"init" forKey:@"m"];
     [dic2 setValue:@"0" forKey:@"last_update"];
     [dic setObject:dic2  forKey:@"p"];
     //m=init&p={"last_update":0}'
     NSLog(@"this is dic : %@", dic);
     [manager POST:[NSString stringWithFormat:@"https://%@",base_url]
     parameters:[dic copy]
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     NSLog(@"AFSSLPinningModeCertificate succ");
     NSLog(@"rez priam conectare %@",responseObject);
     }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     NSLog(@"AFSSLPinningModeCertificate error: %@",error);
     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
     message:[error localizedDescription]
     delegate:nil
     cancelButtonTitle:@"Ok"
     otherButtonTitles:nil];
     [alertView show];
     
     }];
     }
     */
}

-(NSArray *)ialistaJudete {
    NSArray *CEVA= [DataMasterProcessor getJudete];
    ///////NSLog(@"my jud %@", CEVA);
    return CEVA;
}
-(NSArray *)ialistaLocalitatipeJudet{
    NSArray *CEVA= [DataMasterProcessor getLocalitati:@"1"];
    ///////NSLog(@"my loca %@", CEVA);
    return CEVA;
    
}
-(NSArray *)ialistaProducatori{
    NSArray *CEVA= [DataMasterProcessor getProducatori];
    ///////NSLog(@"my Producatori %@", CEVA);
    return CEVA;
    
}
-(NSArray *)ialistaMarciAutopeProducator{
    NSArray *CEVA= [DataMasterProcessor getMarciAuto:@""];
    ///////NSLog(@"my marci  %@", CEVA);
    return CEVA;
    
}
-(BOOL)primaDatainApp {
    NSUserDefaults* prefs=[NSUserDefaults standardUserDefaults];
    if(![prefs objectForKey:@"E_LOGAT"]){
        [prefs setValue:@"0" forKey:@"E_LOGAT"];
        [prefs synchronize];
    }
    BOOL eprimadata =NO;
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = @"splash_firstb.c0d";
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileAtPath]) {
        eprimadata =YES;
        NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString* fileName = @"splash_firstb.c0d";
        NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
        if (![[NSFileManager defaultManager] fileExistsAtPath:fileAtPath]) {
            [[NSFileManager defaultManager] createFileAtPath:fileAtPath contents:nil attributes:nil];
            NSString *aString = @"1";
            [[aString dataUsingEncoding:NSUTF8StringEncoding] writeToFile:fileAtPath atomically:NO];
        } else {
            NSString *aString = @"1";
            [[aString dataUsingEncoding:NSUTF8StringEncoding] writeToFile:fileAtPath atomically:NO];
        }
        
        //prezinta SelectieLimba
        
    } else {
        eprimadata =NO;
        //prezinta loader
    }
    NSLog(@"ddd %i", eprimadata);
    return eprimadata;
}
- (void)sendNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"aluatdateprima"
                                                        object:nil];
}

// METODA_SET_PUSH_TOKEN @"m=set_push_token&p=" //se trimite vendor token
-(void)set_push_token :(NSString *)AUTHTOKEN {
    Reachability *internetReach = [Reachability reachabilityForInternetConnection];
    [internetReach startNotifier];
    NetworkStatus netStatus = [internetReach currentReachabilityStatus];
    //ComNSLog(@"netstatus %u", netStatus);
    BOOL maideparte =NO;
    switch (netStatus)
    {
        case NotReachable:
        {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Eroare" message:@"Telefonul tău nu este conectat la internet. Te rugăm să încerci mai târziu" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertView show];
            break;
        }
            
        case ReachableViaWWAN:  case ReachableViaWiFi:
        {
            maideparte =YES;
            break;
        }
    }
    if(maideparte ==YES ) {
         NSMutableDictionary *dic2= [[NSMutableDictionary alloc]init];
        NSString *compus =@"";
        __block NSString *eroare = @"";
        //////////
        NSError * err;
        //if ([prefs objectForKey:@"vendorTokenpieseauto"])  [prefs objectForKey:@"phoneIdpieseauto"] [prefs objectForKey:@"AppVersionpieseauto"] [prefs objectForKey:@"ApptimeZonepieseauto"]
        /*
         "set_push_token"
         Permite maxim 20 de token-uri per user, sterge token-urile mai vechi din baza noastra de date si apeleaza deleteSubscriber.
         ex. parametrii: {
             "vendorToken": "dummy-token", // OK
             "appInfo": {"appVersion" : "123"},
             "phoneId": "dummy-phoneid", //OK
             "osType": "android", //OK
             "osInfo": {"osVersion": "5.1.1", "timeZone": "GMT+3"} //OK
         }
         curl -k -H "Content-Type: application/json" -d '{ "jsonrpc": "2.0", "method": "sendMessageVendor","params":
         {"vendorToken": "bcaba79857874ad4d22965bdcb8a46c74329073d6f71c1282e0cbaad448feece","notificationTypesId": "5033230aaba79b1d28000005",
         "titleNotification": "Titlu notificare","payloadNotification": "Corpul notificarii","notificationLocalId": 1}, "id":1 }' http://mobilepn.t1.ro:16100/notification
         
         
         curl -k -H "Content-Type: application/json" -d '{"jsonrpc": "2.0", "method": "updateSubscriber",
         "params":
         {"applicationId": "50321804e353d40838000005",
         "phoneId": "ZombiePhone",
         "osType": "ios",
         "notificationTypesIds": [{"_id":"5033230aaba79b1d28000005", "params":{"category":1}},{"_id":"503611d83865afe310000005", "params":{}}],
         "params": {"vendorToken": "bcaba79857874ad4d22965bdcb8a46c74329073d6f71c1282e0cbaad448feece","notificationMethod": "push","appInfo": {"appVersion": "1.1.5"},"osInfo": {"osVersion": "iOS 10.0","timeZone": "GMT+2"}}
         },
         "id":1}' http://mobilepn.t1.ro:16100/subscription
         */
        // __block BOOL logatcusucces =NO;
        BOOL egata=NO;
        //{"appInfo":{"appVersion":"1.1.6"},"osType":"iOS","osInfo":{"osVersion":"7.1.2","timeZone":"GMT+3"},"os":"iOS","phoneId":"092C61D0-486A-4872-B994-EBC530A7B714","lang":"ro","vendorToken":"945f4e5259099c778e26e6f9c8ceb8326badddb818ec2d09f5e320cf3f221ee5","version":"7.1.2","authtoken":"1248f7g57bda0dbgDXwSlVEDSmY8Z8l8HXEqK_FDlDaKfzHUsb1pTlwukh0"}
        
//        params = Communications.addParamString(params, "vendorToken", token); //ok
//        params = Communications.addParamString(params, "phoneId", getPhoneId()); //ok
//        JSONObject appInfo = new JSONObject();
//        try {
//            appInfo.put("appVersion", getAppVersionName());
//        } catch (JSONException e) {
//            //                e.printStackTrace();
//        }
//        params = Communications.addParamObject(params, "appInfo", appInfo);
//        params = Communications.addParamString(params, "osType", "android");
//        JSONObject osInfo = new JSONObject();
//        try {
//            osInfo.put("osVersion", getOsVersion());
//            osInfo.put("timeZone", getTimeZone());
//        } catch (JSONException e) {
//            //                e.printStackTrace();
//        }
//        params = Communications.addParamObject(params, "osInfo", osInfo);
//        
//        //daca avem user logat
//        if( ((PieseAuto) context).getUser() != null && ((PieseAuto) context).getUser().getToken() != "" )
//        {
//            jsonObject.put("authtoken", ((PieseAuto) context).getUser().getToken());
//        }
//        //daca a fost selectata limba o trimitem si pe ea
//        if( UtilsPreferences.getLangChange( context ) )
//        {
//            jsonObject.put("lang", UtilsPreferences.getLang( context ));
//        }
//        jsonObject.put("os", "android");
//        jsonObject.put("version", version);
        
        NSUserDefaults* prefs=[NSUserDefaults standardUserDefaults];
      
        if ([prefs objectForKey:@"vendorTokenpieseauto"]) {
            NSString *vendorTokenpieseauto = [NSString stringWithFormat:@"%@",[prefs objectForKey:@"vendorTokenpieseauto"]];
            [dic2 setObject:vendorTokenpieseauto forKey:@"vendorToken"];
            egata=YES;
        } else {
            egata=NO;
        }
        
        if ([prefs objectForKey:@"phoneIdpieseauto"]) {
            NSString *phoneIdpieseauto = [NSString stringWithFormat:@"%@",[prefs objectForKey:@"phoneIdpieseauto"]];
            //50e6b46e6746c40e
            //   NSString *phoneIdpieseauto =@"54e4b41e6946c42e";
            [dic2 setObject:phoneIdpieseauto forKey:@"phoneId"];
            egata=YES;
        }else {
            egata=NO;
        }

               if ([prefs objectForKey:@"AppVersionpieseauto"]) {
           NSMutableDictionary *appInfo = [[NSMutableDictionary alloc]init];
           NSString *AppVersionpieseauto = [NSString stringWithFormat:@"%@",[prefs objectForKey:@"AppVersionpieseauto"]];
           [appInfo setObject:AppVersionpieseauto forKey:@"appVersion"];
           [dic2 setObject:appInfo forKey:@"appInfo"];
            egata=YES;
        }else {
            egata=NO;
        }

        
       [dic2 setObject:@"ios" forKey:@"osType"];
        
        NSMutableDictionary *osInfo = [[NSMutableDictionary alloc]init];
        NSString *currentSysVer = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] systemVersion]];
        [osInfo setObject:currentSysVer forKey:@"osVersion"]; //  vers iOS
        if ([prefs objectForKey:@"ApptimeZonepieseauto"]) {
            NSString *timeZone = [NSString stringWithFormat:@"%@",[prefs objectForKey:@"ApptimeZonepieseauto"]];
            [osInfo setObject:timeZone forKey:@"timeZone"];
            egata=YES;
        }else {
            egata=NO;
        }
        [dic2 setObject:osInfo forKey:@"osInfo"];
        [dic2 setObject:@"ro" forKey:@"lang"];
        [dic2 setObject:@"ios" forKey:@"os"];
        [dic2 setObject:currentSysVer forKey:@"version"]; //  vers iOS
        [dic2 setObject:AUTHTOKEN forKey:@"authtoken"];
        NSLog(@"SETTOKENPUSH %@",dic2);
        if(egata ==YES) {
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic2 options:0 error:&err];
        NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        compus =[NSString stringWithFormat:@"%@%@",METODA_SET_PUSH_TOKEN, myString];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://%@",base_url]]];
        [request setHTTPMethod:@"POST"];
        NSMutableData *postBody = [NSMutableData data];
        [postBody appendData:[compus dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:postBody];
        NSLog(@"my strin %@", compus);
        AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        op.securityPolicy = [self customSecurityPolicy];
        op.responseSerializer = [AFJSONResponseSerializer serializer];
        [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
            NSMutableDictionary *DictionarErori= [[NSMutableDictionary alloc]init];
            NSDictionary *REZULTAT_NOTIFY_COUNT = responseObject;
           NSLog(@"date METODA_SET_PUSH_TOKEN raspuns %@",REZULTAT_NOTIFY_COUNT);
            if(REZULTAT_NOTIFY_COUNT[@"errors"]) {
                NSMutableArray *erori = [[NSMutableArray alloc]init];
                if(REZULTAT_NOTIFY_COUNT[@"errors"]) {
                    DictionarErori = REZULTAT_NOTIFY_COUNT[@"errors"];
                    for(id cheie in [DictionarErori allKeys]) {
                        NSLog(@"dds %@",[DictionarErori valueForKey:cheie]);
                        [erori addObject:[NSString stringWithFormat:@"%@",[DictionarErori valueForKey:cheie]]];
                    }
                }
                
             
                if(erori.count >0) {
                    eroare=    [erori componentsJoinedByString:@" "];
//                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
//                                                                        message:eroare
//                                                                       delegate:nil
//                                                              cancelButtonTitle:@"Ok"
//                                                              otherButtonTitles:nil];
//                    [alertView show];
                     NSLog(@"ERORSpsuhtoken %@",eroare);
                  
                    //*Daca este vreo eroare se mai incearca retrimiterea token-ului.
                    //not safe here at all  [self set_push_token :AUTHTOKEN];
                }
                   else  if(  REZULTAT_NOTIFY_COUNT[@"data"]) {
                  NSLog(@"date METODA_SET_PUSH_TOKEN raspuns %@",REZULTAT_NOTIFY_COUNT);
                }
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                message:[error localizedDescription]
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
            
        }];
        [[NSOperationQueue mainQueue] addOperation:op];
    }
    } else {
        NSLog(@"nu sunt toate datele necesare");
    }
}

/*
 "comment_viewed" tb. apelat pe https://marvelapp.com/2511ee4#11557872 ( messageid-ul este ultimul comentariu din "comments" cu is_viewed=0 )
 respectiv pe https://marvelapp.com/2511ee4#11251891 ( messageid-ul este ultimul comentariu dintr-o discutie cu is_viewed=0 )
 */



@end

