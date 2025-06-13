//
//  MainViewController.m
//  Pieseauto
//
//  Created by Ioan Ungureanu on 23/02/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//

#import "MainViewController.h"
#import "Appdelegate.h"
#import "Reachability.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize  splashscreen,FIRSTIME;

-(void)addhud{
     [MBProgressHUD showHUDAddedTo:self.navigationController.visibleViewController.view animated:YES];
}
-(void)removehud{
    [MBProgressHUD hideAllHUDsForView:self.navigationController.visibleViewController.view animated:YES];
}

-(void)viewWillAppear:(BOOL)animated {
 
    self.FIRSTIME =FIRSTIME;
    if(FIRSTIME ==YES) {
        [self preiadateculanguage];
    }
    FIRSTIME =NO;

}
-(void)aluatdateprima{
    [self removehud];
    TutorialHomeViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TutorialHomeVC"];
    [self.navigationController pushViewController:vc animated:NO ];
    
}
-(void)aluatdate{
    [self removehud];
    TutorialHomeViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TutorialHomeVC"];
    [self.navigationController pushViewController:vc animated:NO ];
}
//
-(void)preiadateculanguage{
    [self addhud];
    utilitarx=[[Utile alloc] init];
    Reachability *internetReach = [Reachability reachabilityForInternetConnection];
    [internetReach startNotifier];
    NetworkStatus netStatus = [internetReach currentReachabilityStatus];
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
      [self primaconectare];
//    [utilitarx ialistaJudete];
//    [utilitarx ialistaLocalitatipeJudet];
//    [utilitarx ialistaProducatori];
//    [utilitarx ialistaMarciAutopeProducator];
    }
}
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
  

}
- (void)viewDidLoad {
      [super viewDidLoad];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(aluatdate)
//                                                 name:@"aluatdateprima" object:nil];
    [self.navigationController setNavigationBarHidden:YES];
    BOOL eprimadata =NO;
     utilitarx=[[Utile alloc] init];
     eprimadata = [utilitarx primaDatainApp];
     NSLog(@"EPRIMA %i", eprimadata);
     if(eprimadata == YES) {
         NSString *LIMBA_USER = [NSString stringWithFormat:@"ro"];
         NSLog(@"limba aleasa %@", LIMBA_USER);
         NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
         [defaults setObject:LIMBA_USER forKey:@"limba_user"];
         [defaults synchronize];
         [self addhud];
         Reachability *internetReach = [Reachability reachabilityForInternetConnection];
         [internetReach startNotifier];
         NetworkStatus netStatus = [internetReach currentReachabilityStatus];
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
             [self primaconectare];
             //        [utilitarx ialistaMarciAutopeProducator];
             //        [utilitarx ialistaJudete];
             //        [utilitarx ialistaLocalitatipeJudet];
             //        [utilitarx ialistaProducatori];
         }

//        SelectieLimbaVC *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"SelectieLimbaVC"];
//        //     [[[[UIApplication sharedApplication] delegate] window] setRootViewController:vc];
//        [self.navigationController pushViewController:vc animated:NO ];
    } else {
        // Do any additional setup after loading the view, typically from a nib.
        [self addhud];
        Reachability *internetReach = [Reachability reachabilityForInternetConnection];
        [internetReach startNotifier];
        NetworkStatus netStatus = [internetReach currentReachabilityStatus];
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
        [self primaconectare];
//        [utilitarx ialistaMarciAutopeProducator];
//        [utilitarx ialistaJudete];
//        [utilitarx ialistaLocalitatipeJudet];
//        [utilitarx ialistaProducatori];
        }
    }

    //my strin   echo 'm=get_comments&p={"authtoken":"1248f7g572b58f1gqLdXZSYc_3HP2RrKT7elg0hpIoH10LnbS0PqkIxRw0M","cerere_id":"342682","os":"iOS","lang":"ro","version":"9.0"}'  | curl --tlsv1 --cacert ./dev5.activesoft.crt --data @- -- https://dev5.activesoft.ro:277/
    // echo 'm=list_offers&p={"per_page":"20","os":"iOS","lang":"ro","authtoken":"1248f7g572b58f1gqLdXZSYc_3HP2RrKT7elg0hpIoH10LnbS0PqkIxRw0M","cerere_id":"342682","version":"9.0","page":"1","cerere_details":"1","prefered_only":"0"}'  | curl --tlsv1 --cacert ./dev5.activesoft.crt --data @- -- https://dev5.activesoft.ro:277/
 
//    UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mergila2:)];
//    [singleTap setNumberOfTapsRequired:1];
//    splashscreen.userInteractionEnabled =YES;
//    [splashscreen addGestureRecognizer:singleTap];
    
    
    }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)mergila2:(id)sender {
   /* TutorialHomeVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TutorialHomeVC"];*/
   // UIImagePickerController *vc = [[UIImagePickerController alloc]init];
      SelectieLimbaVC *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"SelectieLimbaVC"];
 //  [self presentViewController:vc animated:YES completion:nil];
    [self.navigationController pushViewController:vc animated:NO];
    NSLog(@"ecran2");
}
- (void)viewDidUnload {
    [super viewDidUnload];
//    [[NSNotificationCenter defaultCenter] removeObserver:self
//                                                    name:@"aluatdateprima" object:nil];
 
}
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
-(id)getObjectForKey:(NSString*)key{
    NSUserDefaults* prefs=[NSUserDefaults standardUserDefaults];
    return [prefs objectForKey:key];
}
//- (void)sendNotification {
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"aluatdateprima"
//                                                        object:nil];
//}

-(void)primaconectare {
    //prima data cand intra in app si face sync -> dupa doar compara timestamp daca e dif. de last face iar sync
    AppDelegate * del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    ///// AFHTTPSessionManager *manager = [self SESSIONMANAGER];
    NSUserDefaults* prefs=[NSUserDefaults standardUserDefaults];
    NSString *compus =@""; //e string compus pentru metoda (login sau register si json)
    __block  NSString *OLDTIMESTAMP;
    __block  BOOL faupdate=NO;
    __block  BOOL primadata=NO;
    ///__block id WeakSelf = self;
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
                    [self removehud];
                    eroare=    [erori componentsJoinedByString:@" "];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                        message:eroare
                                                                       delegate:nil
                                                              cancelButtonTitle:@"Ok"
                                                              otherButtonTitles:nil];
                    [alertView show];
                }   else  if(  REZULTATPRIMACONECTARE[@"data"]) {
                    
                    NSDictionary *multedate = REZULTATPRIMACONECTARE[@"data"];
                   //////////       NSLog(@"multedate %@",multedate);
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
                    
                    //url_tutorial
                    if(multedate[@"url_tutorial"] ) {
                    NSString *URL_tutorial =@"";
                    NSLog(@"url_tutorial %@", multedate[@"url_tutorial"]);
                        URL_tutorial = [NSString stringWithFormat:@"%@",multedate[@"url_tutorial"]];
                        del.URL_tutorial =URL_tutorial;
                         [prefs setObject:URL_tutorial  forKey:@"url_tutorial"];
                         [prefs synchronize];
                    }
                    //url_terms
                    if(multedate[@"url_terms"] ) {
                        NSLog(@"url_terms %@", multedate[@"url_terms"]);
                        NSString *URL_terms =@"";
                        URL_terms = [NSString stringWithFormat:@"%@",multedate[@"url_terms"]];
                        del.URL_terms =URL_terms;
                        [prefs setObject:URL_terms  forKey:@"url_terms"];
                        [prefs synchronize];
                    }

                    
                    
                    //la final stocheaza si last_update
                    [prefs setObject:REZULTATPRIMACONECTARE[@"last_update"]  forKey:@"last_update"];
                    [prefs synchronize];
                    [self removehud];
                    TutorialHomeViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TutorialHomeVC"];
                    [self.navigationController pushViewController:vc animated:NO ];

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
                          [self removehud];
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
                       ///////   NSLog(@"multedate %@",multedate);
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
                        //url_tutorial
                        if(multedate[@"url_tutorial"] ) {
                            NSString *URL_tutorial =@"";
                            NSLog(@"url_tutorial %@", multedate[@"url_tutorial"]);
                            URL_tutorial = [NSString stringWithFormat:@"%@",multedate[@"url_tutorial"]];
                            del.URL_tutorial =URL_tutorial;
                            [prefs setObject:URL_tutorial  forKey:@"url_tutorial"];
                            [prefs synchronize];
                        }
                        //url_terms
                        if(multedate[@"url_terms"] ) {
                            NSLog(@"url_terms %@", multedate[@"url_terms"]);
                            NSString *URL_terms =@"";
                            URL_terms = [NSString stringWithFormat:@"%@",multedate[@"url_terms"]];
                            del.URL_terms =URL_terms;
                            [prefs setObject:URL_terms  forKey:@"url_terms"];
                            [prefs synchronize];
                        }

                        //la final stocheaza si last_update
                        [prefs setObject:REZULTATPRIMACONECTARE[@"last_update"]  forKey:@"last_update"];
                        [prefs synchronize];
                        [self removehud];
                        TutorialHomeViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TutorialHomeVC"];
                        [self.navigationController pushViewController:vc animated:NO ];
                        
                    } else {
                        NSLog(@"nu sunt date");
                    }
                }
                
            

            }
            else {
                //init la arii cu datele vechi
                AppDelegate * del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                 NSString *img_max_width = @"";
                 NSString *img_max_height= @"";
                 NSString *cerere_max_images =@"";
                 NSString *url_tutorial =@"";
                 NSString *url_terms =@"";
            if([prefs objectForKey:@"IMG_max_width"])     img_max_width = [NSString stringWithFormat:@"%@",[prefs objectForKey:@"IMG_max_width"]];
            if([prefs objectForKey:@"IMG_max_height"])    img_max_height = [NSString stringWithFormat:@"%@",[prefs objectForKey:@"IMG_max_height"]];
            if([prefs objectForKey:@"CERERE_max_images"]) cerere_max_images = [NSString stringWithFormat:@"%@",[prefs objectForKey:@"CERERE_max_images"]];
            if([prefs objectForKey:@"url_tutorial"]) url_tutorial =[NSString stringWithFormat:@"%@",[prefs objectForKey:@"url_tutorial"]];
            if([prefs objectForKey:@"url_terms"])    url_terms =[NSString stringWithFormat:@"%@",[prefs objectForKey:@"url_terms"]];
                
                del.IMG_max_height = img_max_height;
                del.IMG_max_width = img_max_width;
                del.CERERE_max_images = cerere_max_images;
                del.URL_tutorial = url_tutorial;
                del.URL_terms = url_terms;
                // cred ca renunt la astea spre final ...au ramas aici ca referinta sa se vada cum se cheama :D
                del.PRODUCATORIAUTO =[DataMasterProcessor getProducatori];
                del.MARCIAUTO =[DataMasterProcessor getMarciAuto:@""];
                del.JUDETE =[DataMasterProcessor getJudete];
                del.LOCALITATI =[DataMasterProcessor getLocalitati:@""];
                del.CURRENCIES =[DataMasterProcessor getCURRENCIES];
                //   NSLog(@"nu e update foloseste vechi %@", del.PRODUCATORIAUTO);
                NSLog(@"nu e update foloseste vechi");
                [self removehud];
                TutorialHomeViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TutorialHomeVC"];
                [self.navigationController pushViewController:vc animated:NO ];

                
            }   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                [self removehud];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                    message:[error localizedDescription]
                                                                   delegate:nil
                                                          cancelButtonTitle:@"Ok"
                                                          otherButtonTitles:nil];
                [alertView show];
            }];
    
    [[NSOperationQueue mainQueue] addOperation:op];
    
   }


@end
