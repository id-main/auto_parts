//
//  AppDelegate.m
//  Pieseauto
//
//  Created by Ioan Ungureanu on 23/02/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//

#import "AppDelegate.h"
#import "DB_template.h"
#import "AFNetworkActivityLogger.h"
#import "UIAlertView+Blocks.h"
#import "utile.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "DetaliuOfertaViewController.h"
#import "WebViewController.h"
#import "EcranMesajeViewController.h"
#import "ListaNotificari.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize  PRODUCATORIAUTO,MARCIAUTO,JUDETE,LOCALITATI,cererepiesa,IMG_max_height,IMG_max_width,CURRENCIES,CERERE_max_images,POZECERERE,ARRAYASSETURI, NOTIFY_COUNT,USER_LOGAT,ARRAYCERERI_ACTIVE,ARRAYCERERI_REZOLVATE,ARRAYCERERI_ANULATE,ARRAYASSETURIEXTERNE,COMMENT_max_images; //arii & dicts etc
@synthesize aafisatTutorial,vinedincerere,inapoilacereredinlogin,temporaraddress,reposteazacerere,MODPLATATEMPORAR,modificariDateComanda,CLONADATEUSER,MODLIVRARETEMPORAR,POZEMESAJ,ARRAYASSETURIMESAJ,ARRAYASSETURIMESAJEXTERNE,URL_terms,URL_tutorial,TEXTMESAJTEMPORAR,STRINGOBSERVATII,vendorToken,afostanulata,refreshdupaanulata;
static NSString *PE_PAGINA = @"20";


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
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    return manager;
}
-(BOOL)MyStringisEmpty:(NSString *)str
{
    if(str.length==0 || [str isKindOfClass:[NSNull class]] || [str isEqualToString:@""]||[str  isEqualToString:@"NULL"]||[str isEqualToString:@"(null)"]|| [str isEqualToString:@"<null>"] || [str isEqualToString:@"null"] ||str==nil){
        return YES;
    }
    return NO;
}
-(NSString*) getAppVersion{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSString *minorversion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *versiunefinala = [NSString stringWithFormat:@"%@.%@", version, minorversion];
 //   Bundle versions string, short
    return versiunefinala;
}
-(void)addhud{
      UINavigationController *nav=(UINavigationController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController;
      [MBProgressHUD showHUDAddedTo:nav.visibleViewController.view animated:YES];
}
-(void)removehud{
     UINavigationController *nav=(UINavigationController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController;
    [MBProgressHUD hideAllHUDsForView:nav.view animated:YES];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    /*
     curl -k -H "Content-Type: application/json" -d '{ "jsonrpc": "2.0", "method": "sendMessageVendor","params":
     {"vendorToken": "0b6b9351ab126cf65c0d3d6fae71c6304a103b9a265f3c588d3c563f29e68718","notificationTypesId": "5033230aaba79b1d28000005",
     "titleNotification": "Titlu notificare","payloadNotification": "Corpul notificarii","notificationLocalId": 1}, "id":1 }' http://mobilepn.t1.ro:16100/notification
     
     
     curl -k -H "Content-Type: application/json" -d '{ "jsonrpc": "2.0", "method": "sendMessageVendor","params":  {"notification":"57bad1cbf3c3990b1f00010f","notificationType":"572c7577c73459f77e87789d","subscriber":"573db65d2e0455813c00004c","alert":"Ai o întrebare nouă","payload":{"type":"msg_added.question.1827031","cerere_id":342828,"id":332,"user_id":1198319},"vendorToken":"94fe59875dc693a4dd12a8176a0e47fbdfb413d2d79fe3d9dc04788251177c5e","osType":"ios"}' http://mobilepn.t1.ro:16100/notification
     
     curl -k -H "Content-Type: application/json" -d '{ "jsonrpc": "2.0", "method": "sendMessageVendor","params": {"vendorToken": "0b6b9351ab126cf65c0d3d6fae71c6304a103b9a265f3c588d3c563f29e68718" ,"notificationTypesId": "572c7577c73459f77e87789d", "titleNotification": "Ai o întrebare nouă","payloadNotification": {"type":"msg_added.question.1826953","cerere_id":342784,"offer_id":1826948,"id":309,"user_id":1198319},"notificationLocalId": 1}, "id":1 }' http://mobilepn.t1.ro:16100/notification
     
     
     
     curl -k -H "Content-Type: application/json" -d '{ "jsonrpc": "2.0", "method": "sendMessageVendor","params": {"vendorToken": "94fe59875dc693a4dd12a8176a0e47fbdfb413d2d79fe3d9dc04788251177c5e" ,"notificationTypesId": "572c7577c73459f77e87789d", "titleNotification": "Ai o întrebare nouă","payloadNotification": {"type":"msg_added.question.1826953","cerere_id":342784,"offer_id":1826948,"id":309,"user_id":1198319},"notificationLocalId": 1}, "id":1 }' http://mobilepn.t1.ro:16100/notification
     */
    
 
    
   
    
    if (application.applicationState == UIApplicationStateActive ||application.applicationState == UIApplicationStateInactive || application.applicationState == UIApplicationStateBackground ||application.applicationState == UIApplicationStateInactive)
    {
          NSLog(@"active inactive etc %ld",(long)application.applicationState);
        utilitare = [[Utile alloc]init];
        NSString *authtoken=@"";
        BOOL elogat = NO;
        elogat = [utilitare eLogat];
        if(elogat) {
            authtoken = [utilitare AUTHTOKEN];
        }
        
        NSLog(@"userInfo %@",userInfo);
        
        /*
         userInfo {
         aps =     {
         alert = "Ai o \U00eentrebare nou\U0103";
         badge = 0;
         sound = "ping.aiff";
         };
         body =     {
         "cerere_id" = 342784;
         id = 309;
         "offer_id" = 1826948;
         type = "msg_added.question.1826953";
         "user_id" = 1198319;
         };
         notificationTypeId = 572c7577c73459f77e87789d;
         }
         
         
         */
        for (id key in userInfo) {
            NSLog(@"key: %@, value: %@", key, [userInfo objectForKey:key]);
        }
        NSString *alertMsg;
        if( [[userInfo objectForKey:@"aps"] objectForKey:@"alert"] != NULL)
        {
            alertMsg = [NSString stringWithFormat:@"%@", [[userInfo objectForKey:@"aps"] objectForKey:@"alert"]];
        }
        else
        {
            alertMsg = @"No alert";
        }
        NSLog(@"%@",userInfo);
        __block  NSString *mesageid = @"";
        __block   NSString *typeid = @"";
        __block  NSString *tipsend=@"";
        /*
         Pentru type = new_version in aux trebuie sa vina si versiunea aplicatiei. Nu am nevoie de link-ul din store, aplicatia stie ce sa deschida.
         
         Nu uita sa trimiti in payload-ul mesajului de push si "user_id" daca notificarea este doar pentru un user si nu de interes general.
         
         In payload am mai adaugat "id"-ul notificarii si "user_id"-ul.
         "user_id"-ul poate fi trimis in toate cazulile in payload. (pe langa token stocam si user_id-ul)
         
         Pentru type = new_version trimitem in aux si payload ex: version="1.1"
         
         */
        RIButtonItem *ok = [RIButtonItem item];
        ok.label = @"Vizualizare";
        ok.action = ^{
            
            
            
            /*
             userInfo {
             aps =     {
             alert = "Ai o \U00eentrebare nou\U0103";
             badge = 0;
             sound = "ping.aiff";
             };
             body =     {
             "cerere_id" = 588183;
             id = 385298;
             type = "msg_added.question.3261749";
             "user_id" = 1850865;
             };
             notificationTypeId = 572c7577c73459f77e87789d;
             }
             
             
             
             
             //          aps =     {
             alert = "Ai primit o ofert\U0103 nou\U0103";
             badge = 0;
             sound = "ping.aiff";
             };
             body =     {
             "cerere_id" = 588183;
             id = 385244;
             type = "msg_added.offer.3261690";
             "user_id" = 1850865;
             };
             notificationTypeId = 572c7577c73459f77e87789d;
             }
             */
            
            //        }
            if([userInfo objectForKey:@"body"]){
                NSDictionary *notificarerow = [NSDictionary dictionaryWithDictionary:[userInfo objectForKey:@"body"]];
                
                if(notificarerow[@"type"]) {
                    NSString *splitstring= [NSString stringWithFormat:@"%@",notificarerow[@"type"]];
                    // "type": "new_version.1.1.9"
                    if([splitstring isEqualToString:@"new_version" ]) {
                        tipsend =@"new_version";
                    } else if([splitstring isEqualToString:@"special_offer"]) {
                        tipsend =@"special_offer";
                    } else {

                    NSArray* splitarray = [splitstring componentsSeparatedByString: @"."];
                        if(splitarray.count >0) {
                        if(splitarray[1] && splitarray[2]) {
                        typeid =[NSString stringWithFormat:@"%@",splitarray[1]];
                        mesageid=[NSString stringWithFormat:@"%@",splitarray[2]];
                        if([typeid isEqualToString:@"offer"]) {
                            //mergi la detaliu oferta
                            tipsend =@"offer";
                            
                        }
                        if([typeid isEqualToString:@"question"]) {
                            //mergi la mesaje din cerere
                            tipsend =@"question";
                            
                        }
                        if([typeid isEqualToString:@"comment"]) {
                            //mergi la mesaje  de la o oferta
                            tipsend =@"comment";
                        }
                        }
                        }
                    }
                    NSLog(@"tipsend %@ mesageid %@",tipsend, mesageid);
                }
                /*
                 curl -k -H "Content-Type: application/json" -d '{ "jsonrpc": "2.0", "method": "sendMessageVendor","params": {"vendorToken": "94fe59875dc693a4dd12a8176a0e47fbdfb413d2d79fe3d9dc04788251177c5e" ,"notificationTypesId": "572c7577c73459f77e87789d", "titleNotification": "versiunenoua","payloadNotification": {"type":"new_version","aux":{"version":"1.1.9"}},"notificationLocalId": 1}, "id":1 }' http://mobilepn.t1.ro:16100/notification
                 
                 */
                //b7b7ab7d745e2292070d7374f6eeb2a852be2686a603f318da61d280f8d1ee3b
             /*   curl -k -H "Content-Type: application/json" -d '{ "jsonrpc": "2.0", "method": "sendMessageVendor","params": {"vendorToken": "26789dbfc2ed15df971d52b487e1d86116fa69f2635217106fcb7c680b7beb39" ,"notificationTypesId": "572c7577c73459f77e87789d", "titleNotification": "E disponibila o noua versiune a aplicatiei","payloadNotification": {"type":"new_version","aux":{"version":"1.1.9"}},"notificationLocalId": 1}, "id":1 }' http://mobilepn.t1.ro:16100/notification */
                if([tipsend isEqualToString:@"new_version" ]) {
                    BOOL sunt_nou=NO;
                    if(notificarerow[@"aux"]) {
                        NSDictionary *detaliunotificari= [[NSDictionary alloc]init];
                        detaliunotificari =notificarerow[@"aux"];
                        if(detaliunotificari[@"version"]) {
                            NSString *versiunenoua = [NSString stringWithFormat:@"%@",detaliunotificari[@"version"]];
                            NSString *appVersion =@"";
                            appVersion =[self getAppVersion];
                            NSArray *versiuneamea = [appVersion componentsSeparatedByString: @"."];
                            NSLog(@"versiuneamea %@",versiuneamea);
                            NSArray *versiune_de_comparat = [versiunenoua componentsSeparatedByString: @"."];
                            NSInteger x1=0; NSInteger x2=0;
                            NSInteger y1=0; NSInteger y2=0;
                            NSInteger z1=0; NSInteger z2=0;
                            if(versiuneamea[0]) {
                                x1 =[versiuneamea[0]integerValue];
                            }
                            if(versiune_de_comparat[0]) {
                                x2 =[versiune_de_comparat[0]integerValue];
                            }
                            if(versiuneamea[1]) {
                                y1 =[versiuneamea[1]integerValue];
                            }
                            if(versiune_de_comparat[1]) {
                                y2 =[versiune_de_comparat[1]integerValue];
                            }
                            if(versiuneamea[2]) {
                                z1 =[versiuneamea[2]integerValue];
                            }
                            if(versiune_de_comparat[2]) {
                                z2 =[versiune_de_comparat[2]integerValue];
                            }
                            
                            //now compare ...
                             if (x2> x1) {
                                sunt_nou=YES;
                             }else {
                                if (x2 == x1) {
                                    //versiunea majora e egala vezi build
                                    if (y2> y1) {
                                        sunt_nou=YES;
                                    } else {
                                      if (y2 == y1) {
                                       //versiunea majora build e egala vezi minor build
                                           if (z2> z1) {
                                                sunt_nou=YES;
                                           }else {
                                                if (z2 == z1) {
                                                    //nothing
                                                }
                                           }
                                      }
                                    }
                                }
                             }
                        }
                    }
                    if(sunt_nou ==YES) {
                        //mystring is appstorelink https://itunes.apple.com/app/dmpiese/id1116030452?mt=8
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms://itunes.apple.com/app/dmpiese/id1116030452?mt=8"]];
                    }
                }
                //    -msg_added.question.ID este o intrebare pe o cerere sau oferta
                //
                BOOL epentrumine =NO;
                
                if([tipsend isEqualToString:@"special_offer"]) {
                    if(notificarerow[@"aux"]) {
                        NSDictionary *detaliunotificari= [[NSDictionary alloc]init];
                        detaliunotificari =notificarerow[@"aux"];
                        if(detaliunotificari[@"external_url"]) {
                            [self addhud];
                            NSString *external_url = [NSString stringWithFormat:@"%@", detaliunotificari[@"external_url"]];
                            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                                     bundle: nil];
                            WebViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"WebViewVC"];
                            vc.urlPiesesimilare = external_url;
                            vc.mWebView.scalesPageToFit = YES;
                            vc.title=@"Află mai multe";
                            UINavigationController *nav=(UINavigationController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController;
                            [nav pushViewController:vc animated:YES ];
                        }
                    }
                }
                
                if(notificarerow[@"user_id"]) {
                    NSString *userid_denotificat =[NSString stringWithFormat:@"%@",notificarerow[@"user_id"]];
                    NSDictionary *userlogat = [DataMasterProcessor getLOGEDACCOUNT];
                    if(userlogat[@"U_userid"]) {
                        NSString *userid =[NSString stringWithFormat:@"%@",userlogat[@"U_userid"]];
                        if(![self MyStringisEmpty:userid]) {
                            if([userid_denotificat isEqualToString:userid]) {
                                epentrumine =YES;
                            }
                        }
                    }
                }
                if(epentrumine ==YES) {
                    if([tipsend  isEqualToString:@"offer"]){
                        [self getOffer :mesageid :authtoken :mesageid];
                    }
                    
                    if([tipsend  isEqualToString:@"question"]){
                        if(notificarerow[@"aux"]) {
                            NSDictionary *detaliunotificari= [[NSDictionary alloc]init];
                            detaliunotificari =notificarerow[@"aux"];
                            if(detaliunotificari[@"offer_id"]) {
                                NSString *offer_id = [NSString stringWithFormat:@"%@",detaliunotificari[@"offer_id"]];
                                NSLog(@"offer_idoffer_id %@",offer_id);
                                [self getOffer :offer_id :authtoken :mesageid];
                            } else  if(detaliunotificari[@"cerere_id"] ) {
                                NSString *cerere_id = [NSString stringWithFormat:@"%@",detaliunotificari[@"cerere_id"]];
                                NSLog(@"cerere_idcerere_id %@",cerere_id);
                                [self list_offers_per_cerere:authtoken :@"1" :PE_PAGINA :cerere_id  :@"0" :@"1" :mesageid];
                            }
                        } else    if(notificarerow[@"offer_id"]) {
                            NSString *offer_id = [NSString stringWithFormat:@"%@",notificarerow[@"offer_id"]];
                            NSLog(@"offer_idoffer_id %@",offer_id);
                            [self getOffer :offer_id :authtoken:mesageid];
                        } else  if(notificarerow[@"cerere_id"] ) {
                            NSString *cerere_id = [NSString stringWithFormat:@"%@",notificarerow[@"cerere_id"]];
                            NSLog(@"cerere_idcerere_id %@",cerere_id);
                            [self list_offers_per_cerere:authtoken :@"1" :PE_PAGINA :cerere_id  :@"0" :@"1" :mesageid];
                        }
                    }
                }
            }
            
            
        };
        RIButtonItem *cancelItem = [RIButtonItem item];
        cancelItem.label =@"Nu";
        cancelItem.action = ^{
            //no action ...
        };
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Piese Auto"
                                                            message:alertMsg
                                                   cancelButtonItem:cancelItem
                                                   otherButtonItems:ok,nil];
        [alertView show];
    } else { //fa la fel in cazul in care nu stie starea
        NSLog(@"active inactive etc %ld",(long)application.applicationState);
        utilitare = [[Utile alloc]init];
        NSString *authtoken=@"";
        BOOL elogat = NO;
        elogat = [utilitare eLogat];
        if(elogat) {
            authtoken = [utilitare AUTHTOKEN];
        }
        
        NSLog(@"userInfo %@",userInfo);
               for (id key in userInfo) {
            NSLog(@"key: %@, value: %@", key, [userInfo objectForKey:key]);
        }
        NSString *alertMsg;
        if( [[userInfo objectForKey:@"aps"] objectForKey:@"alert"] != NULL)
        {
            alertMsg = [NSString stringWithFormat:@"%@", [[userInfo objectForKey:@"aps"] objectForKey:@"alert"]];
        }
        else
        {
            alertMsg = @"No alert";
        }
        NSLog(@"%@",userInfo);
        __block  NSString *mesageid = @"";
        __block   NSString *typeid = @"";
        __block  NSString *tipsend=@"";
               RIButtonItem *ok = [RIButtonItem item];
        ok.label = @"Vizualizare";
        ok.action = ^{
            
 
            if([userInfo objectForKey:@"body"]){
                NSDictionary *notificarerow = [NSDictionary dictionaryWithDictionary:[userInfo objectForKey:@"body"]];
                
                if(notificarerow[@"type"]) {
                    NSString *splitstring= [NSString stringWithFormat:@"%@",notificarerow[@"type"]];
                    // "type": "new_version.1.1.9"
                    if([splitstring isEqualToString:@"new_version" ]) {
                        tipsend =@"new_version";
                    } else if([splitstring isEqualToString:@"special_offer"]) {
                        tipsend =@"special_offer";
                    } else {
                        
                        NSArray* splitarray = [splitstring componentsSeparatedByString: @"."];
                        if(splitarray.count >0) {
                            if(splitarray[1] && splitarray[2]) {
                                typeid =[NSString stringWithFormat:@"%@",splitarray[1]];
                                mesageid=[NSString stringWithFormat:@"%@",splitarray[2]];
                                if([typeid isEqualToString:@"offer"]) {
                                    //mergi la detaliu oferta
                                    tipsend =@"offer";
                                    
                                }
                                if([typeid isEqualToString:@"question"]) {
                                    //mergi la mesaje din cerere
                                    tipsend =@"question";
                                    
                                }
                                if([typeid isEqualToString:@"comment"]) {
                                    //mergi la mesaje  de la o oferta
                                    tipsend =@"comment";
                                }
                            }
                        }
                    }
                    NSLog(@"tipsend %@ mesageid %@",tipsend, mesageid);
                }
                /*
                 curl -k -H "Content-Type: application/json" -d '{ "jsonrpc": "2.0", "method": "sendMessageVendor","params": {"vendorToken": "94fe59875dc693a4dd12a8176a0e47fbdfb413d2d79fe3d9dc04788251177c5e" ,"notificationTypesId": "572c7577c73459f77e87789d", "titleNotification": "versiunenoua","payloadNotification": {"type":"new_version","aux":{"version":"1.1.9"}},"notificationLocalId": 1}, "id":1 }' http://mobilepn.t1.ro:16100/notification
                 
                 */
                //b7b7ab7d745e2292070d7374f6eeb2a852be2686a603f318da61d280f8d1ee3b
                /*   curl -k -H "Content-Type: application/json" -d '{ "jsonrpc": "2.0", "method": "sendMessageVendor","params": {"vendorToken": "26789dbfc2ed15df971d52b487e1d86116fa69f2635217106fcb7c680b7beb39" ,"notificationTypesId": "572c7577c73459f77e87789d", "titleNotification": "E disponibila o noua versiune a aplicatiei","payloadNotification": {"type":"new_version","aux":{"version":"1.1.9"}},"notificationLocalId": 1}, "id":1 }' http://mobilepn.t1.ro:16100/notification */
                if([tipsend isEqualToString:@"new_version" ]) {
                    BOOL sunt_nou=NO;
                    if(notificarerow[@"aux"]) {
                        NSDictionary *detaliunotificari= [[NSDictionary alloc]init];
                        detaliunotificari =notificarerow[@"aux"];
                        if(detaliunotificari[@"version"]) {
                            NSString *versiunenoua = [NSString stringWithFormat:@"%@",detaliunotificari[@"version"]];
                            NSString *appVersion =@"";
                            appVersion =[self getAppVersion];
                            NSArray *versiuneamea = [appVersion componentsSeparatedByString: @"."];
                            NSLog(@"versiuneamea %@",versiuneamea);
                            NSArray *versiune_de_comparat = [versiunenoua componentsSeparatedByString: @"."];
                            NSInteger x1=0; NSInteger x2=0;
                            NSInteger y1=0; NSInteger y2=0;
                            NSInteger z1=0; NSInteger z2=0;
                            if(versiuneamea[0]) {
                                x1 =[versiuneamea[0]integerValue];
                            }
                            if(versiune_de_comparat[0]) {
                                x2 =[versiune_de_comparat[0]integerValue];
                            }
                            if(versiuneamea[1]) {
                                y1 =[versiuneamea[1]integerValue];
                            }
                            if(versiune_de_comparat[1]) {
                                y2 =[versiune_de_comparat[1]integerValue];
                            }
                            if(versiuneamea[2]) {
                                z1 =[versiuneamea[2]integerValue];
                            }
                            if(versiune_de_comparat[2]) {
                                z2 =[versiune_de_comparat[2]integerValue];
                            }
                            
                            //now compare ...
                            if (x2> x1) {
                                sunt_nou=YES;
                            }else {
                                if (x2 == x1) {
                                    //versiunea majora e egala vezi build
                                    if (y2> y1) {
                                        sunt_nou=YES;
                                    } else {
                                        if (y2 == y1) {
                                            //versiunea majora build e egala vezi minor build
                                            if (z2> z1) {
                                                sunt_nou=YES;
                                            }else {
                                                if (z2 == z1) {
                                                    //nothing
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    if(sunt_nou ==YES) {
                        //mystring is appstorelink https://itunes.apple.com/app/dmpiese/id1116030452?mt=8
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms://itunes.apple.com/app/dmpiese/id1116030452?mt=8"]];
                    }
                }
                //    -msg_added.question.ID este o intrebare pe o cerere sau oferta
                //
                BOOL epentrumine =NO;
                
                if([tipsend isEqualToString:@"special_offer"]) {
                    if(notificarerow[@"aux"]) {
                        NSDictionary *detaliunotificari= [[NSDictionary alloc]init];
                        detaliunotificari =notificarerow[@"aux"];
                        if(detaliunotificari[@"external_url"]) {
                            [self addhud];
                            NSString *external_url = [NSString stringWithFormat:@"%@", detaliunotificari[@"external_url"]];
                            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                                     bundle: nil];
                            WebViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"WebViewVC"];
                            vc.urlPiesesimilare = external_url;
                            vc.mWebView.scalesPageToFit = YES;
                            vc.title=@"Află mai multe";
                            UINavigationController *nav=(UINavigationController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController;
                            [nav pushViewController:vc animated:YES ];
                        }
                    }
                }
                
                if(notificarerow[@"user_id"]) {
                    NSString *userid_denotificat =[NSString stringWithFormat:@"%@",notificarerow[@"user_id"]];
                    NSDictionary *userlogat = [DataMasterProcessor getLOGEDACCOUNT];
                    if(userlogat[@"U_userid"]) {
                        NSString *userid =[NSString stringWithFormat:@"%@",userlogat[@"U_userid"]];
                        if(![self MyStringisEmpty:userid]) {
                            if([userid_denotificat isEqualToString:userid]) {
                                epentrumine =YES;
                            }
                        }
                    }
                }
                if(epentrumine ==YES) {
                    if([tipsend  isEqualToString:@"offer"]){
                        [self getOffer :mesageid :authtoken :mesageid];
                    }
                    
                    if([tipsend  isEqualToString:@"question"]){
                        if(notificarerow[@"aux"]) {
                            NSDictionary *detaliunotificari= [[NSDictionary alloc]init];
                            detaliunotificari =notificarerow[@"aux"];
                            if(detaliunotificari[@"offer_id"]) {
                                NSString *offer_id = [NSString stringWithFormat:@"%@",detaliunotificari[@"offer_id"]];
                                NSLog(@"offer_idoffer_id %@",offer_id);
                                [self getOffer :offer_id :authtoken :mesageid];
                            } else  if(detaliunotificari[@"cerere_id"] ) {
                                NSString *cerere_id = [NSString stringWithFormat:@"%@",detaliunotificari[@"cerere_id"]];
                                NSLog(@"cerere_idcerere_id %@",cerere_id);
                                [self list_offers_per_cerere:authtoken :@"1" :PE_PAGINA :cerere_id  :@"0" :@"1" :mesageid];
                            }
                        } else    if(notificarerow[@"offer_id"]) {
                            NSString *offer_id = [NSString stringWithFormat:@"%@",notificarerow[@"offer_id"]];
                            NSLog(@"offer_idoffer_id %@",offer_id);
                            [self getOffer :offer_id :authtoken:mesageid];
                        } else  if(notificarerow[@"cerere_id"] ) {
                            NSString *cerere_id = [NSString stringWithFormat:@"%@",notificarerow[@"cerere_id"]];
                            NSLog(@"cerere_idcerere_id %@",cerere_id);
                            [self list_offers_per_cerere:authtoken :@"1" :PE_PAGINA :cerere_id  :@"0" :@"1" :mesageid];
                        }
                    }
                }
            }
            
            
        };
        RIButtonItem *cancelItem = [RIButtonItem item];
        cancelItem.label =@"Nu";
        cancelItem.action = ^{
            //no action ...
        };
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Piese Auto"
                                                            message:alertMsg
                                                   cancelButtonItem:cancelItem
                                                   otherButtonItems:ok,nil];
        [alertView show];
        
    }
    
        
//    } else  if(application.applicationState == UIApplicationStateInactive) {
//        for (id key in userInfo) {
//            NSLog(@"key: %@, value: %@", key, [userInfo objectForKey:key]);
//        }
//        NSLog(@"Inactive z");
////        //-(void)list_notifications :(NSString *)AUTHTOKEN
////        NSLog(@"active z");
////        utilitare = [[Utile alloc]init];
////        NSString *authtoken=@"";
////        BOOL elogat = NO;
////        elogat = [utilitare eLogat];
////        if(elogat) {
////            authtoken = [utilitare AUTHTOKEN];
////            [self list_notifications:authtoken];
////        }
//
//        completionHandler(UIBackgroundFetchResultNewData);
//        
//    } else if (application.applicationState == UIApplicationStateBackground) {
//        for (id key in userInfo) {
//            NSLog(@"key: %@, value: %@", key, [userInfo objectForKey:key]);
//        }
////        utilitare = [[Utile alloc]init];
////        NSString *authtoken=@"";
////        BOOL elogat = NO;
////        elogat = [utilitare eLogat];
////        if(elogat) {
////            authtoken = [utilitare AUTHTOKEN];
////            [self list_notifications:authtoken];
////        }
//        
//
//        NSLog(@"Background zz");
//        
//        //Refresh the local model
//       
//            completionHandler(UIBackgroundFetchResultNewData);
//        
//    } else {
//        
////        NSLog(@"Active z");
////        for (id key in userInfo) {
////            NSLog(@"key: %@, value: %@", key, [userInfo objectForKey:key]);
////        }
////        utilitare = [[Utile alloc]init];
////        NSString *authtoken=@"";
////        BOOL elogat = NO;
////        elogat = [utilitare eLogat];
////        if(elogat) {
////            authtoken = [utilitare AUTHTOKEN];
////            [self list_notifications:authtoken];
////        }
//       
//        //Show an in-app banner
//        
//        completionHandler(UIBackgroundFetchResultNewData);
//        
//    }
}


- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    self.vendorToken = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    self.vendorToken = [self.vendorToken stringByReplacingOccurrencesOfString:@" " withString:@""];
   
    CFUUIDRef udid = CFUUIDCreate(NULL);
    NSString *phoneId = (NSString *) CFBridgingRelease(CFUUIDCreateString(NULL, udid));

     NSLog(@"My token is: %@", self.vendorToken);
//    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Eroare" message:self.vendorToken delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//    [alertView show];
    NSUserDefaults* prefs=[NSUserDefaults standardUserDefaults];
    if(![prefs objectForKey:@"vendorTokenpieseauto"]) {
        [prefs setObject:self.vendorToken forKey:@"vendorTokenpieseauto"];
        [prefs synchronize];
    } else if ([prefs objectForKey:@"vendorTokenpieseauto"]) {
          [prefs setObject:self.vendorToken forKey:@"vendorTokenpieseauto"];
          [prefs synchronize];
         NSLog(@"vendorTokenpieseauto %@ ",  [prefs objectForKey:@"vendorTokenpieseauto"]);
     }
  
    if(![prefs objectForKey:@"phoneIdpieseauto"]) {
        [prefs setObject:phoneId forKey:@"phoneIdpieseauto"];
        [prefs synchronize];
    } else {
        if ([prefs objectForKey:@"phoneIdpieseauto"]) {
            NSString *uidsalvat =[NSString stringWithFormat:@"%@",[prefs objectForKey:@"phoneIdpieseauto"]];
            if([self MyStringisEmpty:uidsalvat]) {
                [prefs setObject:phoneId forKey:@"phoneIdpieseauto"];
                [prefs synchronize];
        } else
         NSLog(@"My saved phoneId %@ ",  [prefs objectForKey:@"phoneIdpieseauto"]);
        }
    }
    NSString *appVersion =@"";
    appVersion =[self getAppVersion];
    if(![prefs objectForKey:@"AppVersionpieseauto"]) {
        [prefs setObject:appVersion forKey:@"AppVersionpieseauto"];
        [prefs synchronize];
    } else if ([prefs objectForKey:@"AppVersionpieseauto"]) {
        [prefs setObject:appVersion forKey:@"AppVersionpieseauto"];
        [prefs synchronize];
    }
    
    NSLog(@"My appVersion: %@", appVersion);
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    NSLog(@"My timeZone : %@", [timeZone abbreviation]) ;
        NSString *apptimeZone = [NSString stringWithFormat:@"%@",[timeZone abbreviation]];
        
        if(![prefs objectForKey:@"ApptimeZonepieseauto"]) {
            [prefs setObject:apptimeZone forKey:@"ApptimeZonepieseauto"];
            [prefs synchronize];
        } else
            if ([prefs objectForKey:@"ApptimeZonepieseauto"]) {
                [prefs setObject:apptimeZone forKey:@"ApptimeZonepieseauto"];
                [prefs synchronize];
            }
    utilitare = [[Utile alloc]init];
    NSString *authtoken=@"";
    BOOL elogat = NO;
    elogat = [utilitare eLogat];
    if(elogat) {
        authtoken = [utilitare AUTHTOKEN];
        [utilitare set_push_token :authtoken];
    }   //save all in NSUserDefaults
    
  /*  ex. parametrii: {
            "vendorToken": "dummy-token",
            "appInfo": {"appVersion" : "123"},
            "phoneId": "dummy-phoneid",
            "osType": "android",
            "osInfo": {"osVersion": "5.1.1", "timeZone": "GMT+3"}
    } */
/*
 curl -k -H "Content-Type: application/json" -d '{ "jsonrpc": "2.0", "method": "sendMessageVendor","params":
 {"vendorToken": "eMfJHqalHug:APA91bFf2yzBau5P_uUIaKdgU6ySPl5u37HCQJE0Ml0_1TkP-F1a4roG0KUI-FuMxwBwxt_zAe5Ad213GUqzVoX5Mj1xxCXgiHBik0UqYLRTuae8kYyBhiO6QAd11GR-mBM7Z_qDA_ae"
 ,"notificationTypesId": "572c7577c73459f77e87789d",
 "titleNotification": "Titlu notificare","payloadNotification": "Corpul notificarii","notificationLocalId": 1}, "id":1 }' http://mobilepn.t1.ro:16100/notification
 */
    
}


- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
   NSLog(@"\n\n\n Failed to register to server for push \n\n %@ \n\n %@ \n\n %ld \n\n",error,[error localizedDescription],(long)error.code);
    
}

-(void)setdbname{
    [DB_template setDataBaseName:@"pieselocal.sqlite"];
    
}
-(void)preia_notify_count {
    utilitare = [[Utile alloc]init];
    NSString *authtoken=@"";
    BOOL elogat = NO;
    elogat = [utilitare eLogat];
    if(elogat) {
        authtoken = [utilitare AUTHTOKEN];
        //  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
      
        [utilitare cerere_autocomplete:authtoken];
        [utilitare getProfile:authtoken];
          [utilitare getnotify_count:authtoken];
      
       // });
    }
}

-(void)initbaze{
    PRODUCATORIAUTO= [[NSArray alloc]init];
    MARCIAUTO=[[NSArray alloc]init];
    JUDETE=[[NSArray alloc]init];
    LOCALITATI=[[NSArray alloc]init];
    CURRENCIES=[[NSArray alloc]init];
    POZECERERE=[[NSMutableArray alloc]init];
    cererepiesa = [[NSMutableDictionary alloc]init];
    ARRAYASSETURI=[[NSMutableArray alloc]init];
    ARRAYASSETURIEXTERNE=[[NSMutableArray alloc]init];
    ARRAYCERERI_ACTIVE=[[NSMutableArray alloc]init];
    ARRAYCERERI_REZOLVATE=[[NSMutableArray alloc]init];
    ARRAYCERERI_ANULATE=[[NSMutableArray alloc]init];
    NOTIFY_COUNT =[[NSDictionary alloc]init];
    USER_LOGAT =[[NSDictionary alloc]init];
    temporaraddress =[[NSMutableDictionary alloc]init];
    MODPLATATEMPORAR =[[NSMutableDictionary alloc]init];
    MODLIVRARETEMPORAR =[[NSMutableDictionary alloc]init];
    CLONADATEUSER=[[NSMutableDictionary alloc]init];
    POZEMESAJ=[[NSMutableArray alloc]init];
    ARRAYASSETURIMESAJ=[[NSMutableArray alloc]init];
    ARRAYASSETURIMESAJEXTERNE=[[NSMutableArray alloc]init];
    TEXTMESAJTEMPORAR=[[NSString alloc]init];
    TEXTMESAJTEMPORAR=@"Mesaj către vânzător";
    STRINGOBSERVATII=@"Poți adăuga informații suplimentare";
    vinedincerere =NO;
    inapoilacereredinlogin=NO;
    reposteazacerere=NO;
    modificariDateComanda=NO;
    afostanulata=NO;
  
    /*  [cererepiesa setObject:@"lala" forKey:@"TEXTCERERE"];
     [cererepiesa setObject:@"2" forKey:@"PRODUCATORAUTO"];
     //[cererepiesa setObject:@"a10" forKey:@"MARCAAUTO"];
     [cererepiesa setObject:@"" forKey:@"MARCAAUTO"];
     [cererepiesa setObject:@"1" forKey:@"JUDET"];
     [cererepiesa setObject:@"11" forKey:@"LOCALITATE"];
     [cererepiesa setObject:@"2016" forKey:@"ANMASINA"];
     [cererepiesa setObject:@"motorina" forKey:@"VARIANTA"];
     [cererepiesa setObject:@"diesel" forKey:@"MOTORIZARE"];
     [cererepiesa setObject:@"KWXNNNSNNSS KWXNNNSNNSS KWXNNNSNNSS KWXNNNSNNSS KWXNNNSNNSS KWXNNNSNNSS KWXNNNSNNSS KWXNNNSNNSS KWXNNNSNNSS KWXNNNSNNSS KWXNNNSNNSS KWXNNNSNNSS KWXNNNSNNSS KWXNNNSNNSS KWXNNNSNNSS KWXNNNSNNSS" forKey:@"SERIESASIU"];
     [cererepiesa setObject:@"1" forKey:@"IS_NEW"]; // 0 SI 1 NOI
     [cererepiesa setObject:@"1" forKey:@"IS_SECOND"]; // 0 SI 1 SECOND*/
    
    
}
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    NSLog(@"NotificationSettings: %@", notificationSettings);
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // dictionar icons la start
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
          NSLog(@"registerUserNotificationSettings: ");
        UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    }
    else
    {
           NSLog(@"22registerUserNotificationSettings: ");
        // Register for Push Notifications, if running iOS version < 8
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
    }
 
    [Fabric with:@[[Crashlytics class]]];
    utilitare=[[Utile alloc] init];
    aafisatTutorial =NO;
    //  [[AFNetworkActivityLogger sharedLogger] startLogging];
    //  [[AFNetworkActivityLogger sharedLogger] setLevel:AFLoggerLevelDebug];
    //  [utilitare primaconectare];
    
    //  AppDelegate * del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //  del.DICTIONARICONS = [[NSMutableDictionary alloc] init];
    //  del.DICTIONARICONS = utilitare.DictionarmareIcons;
    [self setdbname];
    [self initbaze];
    [self preia_notify_count];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)getOffer :(NSString*)ID_OFERTA :(NSString*)authtoken :(NSString *)mesajid {
    
    Reachability *internetReach = [Reachability reachabilityForInternetConnection];
    [internetReach startNotifier];
    NetworkStatus netStatus = [internetReach currentReachabilityStatus];
    //ComNSLog(@"netstatus %u", netStatus);
    BOOL maideparte =NO;
    switch (netStatus)
    {
        case NotReachable:
        {
            [self removehud];
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
        [self addhud];
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
        [dic2 setObject:authtoken forKey:@"authtoken"];
        [dic2 setObject:ID_OFERTA forKey:@"offer_id"];
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic2 options:0 error:&err];
        NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        compus =[NSString stringWithFormat:@"%@%@",METODA_GET_OFFER, myString];
        
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
                    [self removehud];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                        message:eroare
                                                                       delegate:nil
                                                              cancelButtonTitle:@"Ok"
                                                              otherButtonTitles:nil];
                    [alertView show];
                }   else  if(  REZULTAT_NOTIFY_COUNT[@"data"]) {
                    NSMutableDictionary *multedate = REZULTAT_NOTIFY_COUNT[@"data"];
                    NSLog(@"date DETALIU OFERTA %@",multedate);
                    //dispatch_async(dispatch_get_main_queue(), ^{
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                             bundle: nil];
                    
                    DetaliuOfertaViewController *vc =[mainStoryboard instantiateViewControllerWithIdentifier:@"DetaliuOfertaVC"];
                    if( ![self MyStringisEmpty:mesajid] ) {
                        vc.idmesaj = mesajid;
                        NSLog(@"idmesaj %@", mesajid);
                    }
                    vc.dinpush=YES;
                    vc.CORPDATE = multedate;
                    UINavigationController *nav=(UINavigationController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController;
                    [nav pushViewController:vc animated:YES ];
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
            [self removehud];
        }];
        [[NSOperationQueue mainQueue] addOperation:op];
    }
    
    
}
-(void) list_offers_per_cerere :(NSString *)AUTHTOKEN :(NSString *)PAGE :(NSString *)PER_PAGE :(NSString *)cerere_id :(NSString *)prefered_only :(NSString*)cerere_details :(NSString *)messageid {
    Reachability *internetReach = [Reachability reachabilityForInternetConnection];
    [internetReach startNotifier];
    NetworkStatus netStatus = [internetReach currentReachabilityStatus];
    BOOL maideparte =NO;
    switch (netStatus)
    {
        case NotReachable:
        {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Eroare" message:@"Telefonul tău nu este conectat la internet. Te rugăm să încerci mai târziu" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertView show];
             UINavigationController *nav=(UINavigationController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController;
            [MBProgressHUD hideAllHUDsForView:nav.visibleViewController.view animated:YES];
            
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
        NSString *currentSysVer = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] systemVersion]];
        [dic2 setObject:@"iOS" forKey:@"os"];
        [dic2 setObject:currentSysVer forKey:@"version"]; //  vers iOS
        [dic2 setObject:@"ro" forKey:@"lang"];
        [dic2 setObject:AUTHTOKEN forKey:@"authtoken"];
        [dic2 setObject:PAGE forKey:@"page"];
        [dic2 setObject:PER_PAGE forKey:@"per_page"];
        [dic2 setObject:cerere_id forKey:@"cerere_id"];  // obligatoriu
        [dic2 setObject:prefered_only forKey:@"prefered_only"];
        [dic2 setObject:cerere_details forKey:@"cerere_details"];
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic2 options:0 error:&err];
        NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        compus =[NSString stringWithFormat:@"%@%@",METODA_LIST_OFFERS, myString];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://%@",base_url]]];
        [request setHTTPMethod:@"POST"];
        NSMutableData *postBody = [NSMutableData data];
        [postBody appendData:[compus dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:postBody];
        NSLog(@"my strin %@", compus);
        [self addhud];
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
                    [self removehud];
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
                    NSLog(@"date cerere raspuns %@",multedate);
                    NSMutableDictionary *DETALIUCERERE = [[NSMutableDictionary alloc]init];
                    NSLog(@"CEREREFULLINFO %@", multedate);
                    if(multedate[@"cerere"]) {
                        DETALIUCERERE =multedate[@"cerere"];
                        
                        
                        NSMutableDictionary *cererepiesax=[[NSMutableDictionary alloc]init];
                        NSString *TITLUCERERE =@"";
                        NSString *PRODUCATORAUTODEF =@"";
                        NSString *MARCAAUTODEF =@"";
                        NSString *ANMASINA = @"";
                        NSString *VARIANTA = @"";
                        NSString *MOTORIZARE =@"";
                        NSString *SERIESASIU =@"";
                        NSString *IDCERERE =@"";
                        NSString *LOCALITATEID =@"";
                        NSString *JUDETID =@"";
                        NSString *IS_NEW =@"";
                        NSString *IS_SECOND =@"";
                        NSString *REMAKE_ID =@"0"; //este  id-ul cererii noi, relistate.     In cazul in care o cerere are remake_id > 0, nu mai poate fi relistat.
                        
                        if(DETALIUCERERE[@"title"])    TITLUCERERE = [NSString stringWithFormat:@"%@",DETALIUCERERE[@"title"]];
                        if(DETALIUCERERE[@"marca_id"]) PRODUCATORAUTODEF = [NSString stringWithFormat:@"%@",DETALIUCERERE[@"marca_id"]];
                        if(DETALIUCERERE[@"model_id"]) MARCAAUTODEF = [NSString stringWithFormat:@"%@",DETALIUCERERE[@"model_id"]];
                        if(DETALIUCERERE[@"talon_an_fabricatie"]) ANMASINA = [NSString stringWithFormat:@"%@",DETALIUCERERE[@"talon_an_fabricatie"]];
                        if(DETALIUCERERE[@"motorizare"]) MOTORIZARE = [NSString stringWithFormat:@"%@",DETALIUCERERE[@"motorizare"]];
                        if(DETALIUCERERE[@"talon_tip_varianta"]) VARIANTA=[NSString stringWithFormat:@"%@",DETALIUCERERE[@"talon_tip_varianta"]];
                        if(DETALIUCERERE[@"talon_nr_identificare"]) SERIESASIU = [NSString stringWithFormat:@"%@",DETALIUCERERE[@"talon_nr_identificare"]];
                        if(DETALIUCERERE[@"localitate_id"]) LOCALITATEID =[NSString stringWithFormat:@"%@", DETALIUCERERE[@"localitate_id"]];
                        if(DETALIUCERERE[@"judet_id"]) JUDETID =[NSString stringWithFormat:@"%@", DETALIUCERERE[@"judet_id"]];
                        if(DETALIUCERERE[@"want_new"]) IS_NEW =[NSString stringWithFormat:@"%@", DETALIUCERERE[@"want_new"]];
                        if(DETALIUCERERE[@"want_second"]) IS_SECOND =[NSString stringWithFormat:@"%@", DETALIUCERERE[@"want_second"]];
                        if(DETALIUCERERE[@"remake_id"]) REMAKE_ID =[NSString stringWithFormat:@"%@", DETALIUCERERE[@"remake_id"]];
                        IDCERERE = cerere_id;
                        [cererepiesax setObject:TITLUCERERE forKey:@"TEXTCERERE"];
                        [cererepiesax setObject:PRODUCATORAUTODEF forKey:@"PRODUCATORAUTO"];
                        [cererepiesax setObject:MARCAAUTODEF forKey:@"MARCAAUTO"];
                        [cererepiesax setObject:ANMASINA forKey:@"ANMASINA"];
                        [cererepiesax setObject:MOTORIZARE forKey:@"MOTORIZARE"];
                        [cererepiesax setObject:VARIANTA forKey:@"VARIANTA"];
                        [cererepiesax setObject:SERIESASIU forKey:@"SERIESASIU"];
                        [cererepiesax setObject:LOCALITATEID forKey:@"LOCALITATE"];
                        [cererepiesax setObject:JUDETID forKey:@"JUDET"];
                        [cererepiesax setObject:IS_NEW forKey:@"IS_NEW"];
                        [cererepiesax setObject:IS_SECOND forKey:@"IS_SECOND"];
                        [cererepiesax setObject:REMAKE_ID forKey:@"REMAKE_ID"];
                        [cererepiesax setObject:IDCERERE forKey:@"IDCERERE"];
                        [cererepiesax setObject:multedate forKey:@"CEREREFULLINFO"];
                        if(DETALIUCERERE[@"discussions"]) {
                            [cererepiesax setObject:DETALIUCERERE[@"discussions"] forKey:@"discussions"];
                        }
                                   
                        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                                 bundle: nil];
                        EcranMesajeViewController *vc =[mainStoryboard instantiateViewControllerWithIdentifier:@"EcranMesajeViewControllerVC"];
                        vc.CE_TIP_E=@"dinnotificari";
                        vc.lastmessageid = messageid;
                        NSLog(@"cererepiesax %@",cererepiesax);
                        vc.CORPDATE =cererepiesax;

                                             UINavigationController *nav=(UINavigationController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController;
                        [nav pushViewController:vc animated:YES ];
                        
                    }
                }
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //            NSLog(@"Error: %@", error);
            //            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
            //                                                                message:[error localizedDescription]
            //                                                               delegate:nil
            //                                                      cancelButtonTitle:@"Ok"
            //                                                      otherButtonTitles:nil];
            //            [alertView show];
            [self removehud];
            
        }];
        [[NSOperationQueue mainQueue] addOperation:op];
    }
}
-(void)list_notifications :(NSString *)AUTHTOKEN {
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
        [self addhud];
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
        // "per_page":"20","page":"1"
        [dic2 setObject:@"20" forKey:@"per_page"];
        [dic2 setObject:@"1" forKey:@"page"];
        
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic2 options:0 error:&err];
        NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        compus =[NSString stringWithFormat:@"%@%@",METODA_LIST_NOTIFICATIONS, myString];
        
        
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
                    [self removehud];
                    eroare =    [erori componentsJoinedByString:@" "];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                        message:eroare
                                                                       delegate:nil
                                                              cancelButtonTitle:@"Ok"
                                                              otherButtonTitles:nil];
                    [alertView show];
                }   else  if(  REZULTAT_NOTIFY_COUNT[@"data"]) {
                    NSDictionary *multedate = REZULTAT_NOTIFY_COUNT[@"data"];
                    [self removehud];
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                             bundle: nil];
                    
                    UINavigationController *nav=(UINavigationController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController;
                  

                    ListaNotificari *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"ListaNotificariVC"];
                    vc.listaNOTIFICARI =multedate;
                    [nav pushViewController:vc animated:YES ];
                }
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [self removehud];
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

@end
