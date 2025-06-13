//
//  EcranMesajeViewController.m
//  Pieseauto
//
//  Created by Ioan Ungureanu on 13/04/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//
#import "utile.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"
#import "Reachability.h"
#import "EcranMesajeViewController.h"
#import "CellDetaliuMesaj.h"
#import "TutorialHomeViewController.h"
#import <CoreText/CoreText.h>
#import "SetariViewController.h"
#import "UIImageView+WebCache.h" //sdwebimagefapozaac
#import "SDWebImagePrefetcher.h"

#import <QuartzCore/QuartzCore.h>
#import <CoreText/CTStringAttributes.h>
#import <CoreText/CoreText.h>
#import "EcranFormularComanda.h"
#import "CustomBadge.h"
#import "CustomBadge1.h"
#import "pozemesajeviewVC.h"
#import "TabelPozeMesajeVC.h"
#import "DetaliuProfil.h"
#import "Galerieslide.h"
#import "TTTAttributedLabel.h"
#import "CerereExistentaViewController.h"
#import "butoncustomback.h"



#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
static NSString *PE_PAGINA = @"20";
double cellheightmodificatmesaj =45;
@interface ClockFace1 ()

@end

@implementation ClockFace1

- (id)init
{
    if ((self = [super init]))
    {
        
    }
    return self;
}

@end

//@interface SpecialText: UILabel
@interface SpecialText1 ()

@end

@implementation SpecialText1

- (id)init
{
    if ((self = [super init]))
    {
        
    }
    return self;
}

@end

@interface IMAGINESERVER1 ()

@end

@implementation IMAGINESERVER1

- (id)init
{
    if ((self = [super init]))
    {
        
    }
    return self;
}

@end

@interface EcranMesajeViewController(){
    CGFloat textViewHeight;
    CGRect previousRect;
    BOOL shouldScrollToLastRow;
}
@property (nonatomic, strong) ClockFace1 *clockFace;
@end

@implementation EcranMesajeViewController
@synthesize  LISTASELECT,titluriCAMPURI,TOATE,RANDURIOFERTA,RANDOFERTANT,RANDURIEXPANDABILE,TEXTMESAJTEMPORAR;
@synthesize IDCERERE,CORPDATE,DETALIUCERERE,ladreapta,lastanga,pieseselectate,lastmessageid,stareexpand,pozele,pozetemporare,pozeprocesate,MESAJEFULL,PRIMULMESAJ;
@synthesize CE_TIP_E,titluecran,backbuton,labeltitluecran,NUMEUSERDISCUTIE; //dincerere sau dinnotificari
@synthesize  baradesus, titludesus,butondebackdesus; //apare tot timpul

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets;
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize.height), 0.0);
    } else {
        contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize.width), 0.0);
    }
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    CGRect aRect = self.view.frame;
    aRect.size.height -= keyboardSize.height;
    
    if (!CGRectContainsPoint(aRect, self.compuneView.frame.origin)) {
        [self.scrollView scrollRectToVisible:self.compuneView.frame animated:YES];
    }
    
}
- (void)keyboardWillHide:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}
-(void)addhud{
    [MBProgressHUD showHUDAddedTo:self.navigationController.visibleViewController.view animated:YES];
}
-(void)removehud{
    [MBProgressHUD hideAllHUDsForView:self.navigationController.visibleViewController.view animated:YES];
}
-(void)perfecttimeforback {
    utilitar = [[Utile alloc]init];
    NSString *authtoken=@"";
    BOOL elogat = NO;
    elogat = [utilitar eLogat];
    if(elogat) {
        authtoken = [utilitar AUTHTOKEN];
        [self get_comments_CERERE :[NSString stringWithFormat:@"%@",IDCERERE] :@"cerereid" :authtoken];
    }
}

-(void)get_comments_CERERE :(NSString*)CERERESAUOFERTAID :(NSString*)TIP :(NSString*)authtoken {
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
        
        if([TIP isEqualToString:@"cerereid"]) {
            [dic2 setObject:CERERESAUOFERTAID forKey:@"cerere_id"];
        } else  if([TIP isEqualToString:@"ofertaid"]) {
            [dic2 setObject:CERERESAUOFERTAID forKey:@"offer_id"];
        }
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic2 options:0 error:&err];
        NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        compus =[NSString stringWithFormat:@"%@%@",METODA_GET_COMMENTS, myString];
        
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
                    [self removehud];
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
                    NSMutableDictionary *multedate = [NSMutableDictionary dictionaryWithDictionary:REZULTAT_NOTIFY_COUNT[@"data"]];
                    [self removehud];
                    // ia coments si mergi la cerere existenta
                    NSLog(@"vezi cerere");
                    CerereExistentaViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CerereExistentaViewVC"];
                    vc.intrebaridelaaltii = [[NSMutableDictionary alloc]init];
                    vc.intrebaridelaaltii = multedate;
                    vc.CE_TIP_E=@"dinmesaje";
                    
                    
                    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                    del.POZECERERE=[[NSMutableArray alloc]init];
                    del.ARRAYASSETURI=[[NSMutableArray alloc]init];
                    del.ARRAYASSETURIEXTERNE=[[NSMutableArray alloc]init];
                    del.cererepiesa =[[NSMutableDictionary alloc]init];
                    
                    NSMutableDictionary *cererepiesa=[[NSMutableDictionary alloc]init];
                    NSString *TITLUCERERE =@"";
                    NSString *PRODUCATORAUTODEF =@"";
                    NSString *MARCAAUTODEF =@"";
                    NSString *ANMASINA = @"";
                    NSString *VARIANTA = @"";
                    NSString *MOTORIZARE =@"";
                    NSString *SERIESASIU =@"";
                    //  NSString *IDCERERE =@"";
                    NSString *LOCALITATEID =@"";
                    NSString *JUDETID =@"";
                    NSString *IS_NEW =@"";
                    NSString *IS_SECOND =@"";
                    NSString *REMAKE_ID =@"0"; //este  id-ul cererii noi, relistate.     In cazul in care o cerere are remake_id > 0, nu mai poate fi relistat.
                    NSMutableDictionary *CORP = [[NSMutableDictionary alloc]init];
                    if(DETALIUCERERE[@"CEREREFULLINFO"][@"cerere"]) {
                        CORP = DETALIUCERERE[@"CEREREFULLINFO"][@"cerere"];
                        if(CORP[@"title"])    TITLUCERERE = [NSString stringWithFormat:@"%@",CORP[@"title"]];
                        if(CORP[@"marca_id"]) PRODUCATORAUTODEF = [NSString stringWithFormat:@"%@",CORP[@"marca_id"]];
                        if(CORP[@"model_id"]) MARCAAUTODEF = [NSString stringWithFormat:@"%@",CORP[@"model_id"]];
                        if(CORP[@"talon_an_fabricatie"]) ANMASINA = [NSString stringWithFormat:@"%@",CORP[@"talon_an_fabricatie"]];
                        if(CORP[@"motorizare"]) MOTORIZARE = [NSString stringWithFormat:@"%@",CORP[@"motorizare"]];
                        if(CORP[@"talon_tip_varianta"]) VARIANTA=[NSString stringWithFormat:@"%@",CORP[@"talon_tip_varianta"]];
                        if(CORP[@"talon_nr_identificare"]) SERIESASIU = [NSString stringWithFormat:@"%@",CORP[@"talon_nr_identificare"]];
                        //  if(DETALIUCERERE[@"id"]) idcerere =[NSString stringWithFormat:@"%@", DETALIUCERERE[@"id"]];
                        if(CORP[@"localitate_id"]) LOCALITATEID =[NSString stringWithFormat:@"%@", CORP[@"localitate_id"]];
                        if(CORP[@"judet_id"]) JUDETID =[NSString stringWithFormat:@"%@", CORP[@"judet_id"]];
                        if(CORP[@"want_new"]) IS_NEW =[NSString stringWithFormat:@"%@", CORP[@"want_new"]];
                        if(CORP[@"want_second"]) IS_SECOND =[NSString stringWithFormat:@"%@", CORP[@"want_second"]];
                        if(CORP[@"remake_id"]) REMAKE_ID =[NSString stringWithFormat:@"%@", CORP[@"remake_id"]];
                        
                        [cererepiesa setObject:TITLUCERERE forKey:@"TEXTCERERE"];
                        [cererepiesa setObject:PRODUCATORAUTODEF forKey:@"PRODUCATORAUTO"];
                        [cererepiesa setObject:MARCAAUTODEF forKey:@"MARCAAUTO"];
                        [cererepiesa setObject:ANMASINA forKey:@"ANMASINA"];
                        [cererepiesa setObject:MOTORIZARE forKey:@"MOTORIZARE"];
                        [cererepiesa setObject:VARIANTA forKey:@"VARIANTA"];
                        [cererepiesa setObject:SERIESASIU forKey:@"SERIESASIU"];
                        [cererepiesa setObject:LOCALITATEID forKey:@"LOCALITATE"];
                        [cererepiesa setObject:JUDETID forKey:@"JUDET"];
                        [cererepiesa setObject:IS_NEW forKey:@"IS_NEW"];
                        [cererepiesa setObject:IS_SECOND forKey:@"IS_SECOND"];
                        [cererepiesa setObject:REMAKE_ID forKey:@"REMAKE_ID"];
                        [cererepiesa setObject:self.IDCERERE forKey:@"IDCERERE"];
                        
                        //   [DETALIUCERERE[@"CEREREFULLINFO"][@"cerere"]
                        [cererepiesa setObject:DETALIUCERERE[@"CEREREFULLINFO"] forKey:@"CEREREFULLINFO"]; //avem nevoie si de corpul cererii
                        del.reposteazacerere =NO;
                        if(CORP[@"images"]) {
                            del.ARRAYASSETURI = [[NSMutableArray alloc]init];
                            del.ARRAYASSETURI = [NSMutableArray arrayWithArray:CORP[@"images"]];
                            NSLog(@"del.pozecer %@", del.ARRAYASSETURI);
                            del.POZECERERE = del.ARRAYASSETURI;
                        }
                        del.cererepiesa =cererepiesa;
                        //  self.title = @"Înapoi"; //pt btn back
                        //                        for(UIButton *view in  self.navigationController.navigationBar.subviews) {
                        //                            if([view isKindOfClass:[butoncustomback class]]){
                        //                                [view removeFromSuperview];
                        //                            }
                        //                        }
                        
                        [self.navigationController pushViewController:vc animated:YES ];
                    }
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
    [self removehud];
}

-(butoncustomback *) backbtncustom {
    butoncustomback *backcustombutton =[butoncustomback  buttonWithType:UIButtonTypeCustom];
    [backcustombutton setFrame:CGRectMake(0.0f, 14.0f, 80.0f, 25.0f)];
    [backcustombutton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    UIImage *image3 = [UIImage imageNamed:@"Back-96.png"];
    UIImageView *btnimg= [[UIImageView alloc]init];
    CGRect frameimg = CGRectMake(-15, 2, 16, 16);
    btnimg.frame = frameimg;
    btnimg.image = image3;
    btnimg.contentMode =UIViewContentModeScaleAspectFit;
    [backcustombutton addSubview:btnimg];
    UILabel *titlubuton =[[UILabel alloc]init];
    titlubuton.textColor =[UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1];
    titlubuton.font =[UIFont systemFontOfSize:16];
    [titlubuton setFrame:CGRectMake(4.0f,2.0f, 60.0f, 20.0f)];
    titlubuton.textAlignment = NSTextAlignmentLeft;
    titlubuton.text=@"Înapoi";
    [backcustombutton addSubview:titlubuton];
    [backcustombutton setShowsTouchWhenHighlighted:NO];
    [backcustombutton bringSubviewToFront:btnimg];
    return backcustombutton;
}

-(void)mergiback {
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)viewWillAppear:(BOOL)animated {
    

    
    MESAJEFULL = [[NSMutableDictionary alloc]init];
    NSLog(@"detaliu MESAJE");
    /// sunt randuri selectate sau nu la tap pe rows se schimba val in 1 // revine la 0 sectiunile 2-5
    textViewHeight = 61;
    previousRect = CGRectZero;
    [self addhud];
    self.CORPDATE =CORPDATE;
    NUMEUSERDISCUTIE=@"";
    DETALIUCERERE = [NSMutableDictionary dictionaryWithDictionary:CORPDATE];
    self.CE_TIP_E = CE_TIP_E;
    [self.navigationController setNavigationBarHidden:NO]; self.navigationItem.leftBarButtonItem=nil;
    self.navigationController.navigationItem.hidesBackButton = YES;
    //clean other left
    for(UIButton *view in  self.navigationController.navigationBar.subviews) {
        if([view isKindOfClass:[butoncustomback class]]){
            [view removeFromSuperview];
        }
    }
   
    if([CE_TIP_E isEqualToString:@"dinnotificari"]) {
        //add new left
        UIButton *ceva = [self backbtncustom];
        [ceva addTarget:self action:@selector(perfecttimeforback) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *inapoibtn =[[UIBarButtonItem alloc] initWithCustomView:ceva];
        self.navigationItem.leftBarButtonItem = inapoibtn;
        
        
    } else {
        //back normal
        UIButton *ceva = [self backbtncustom];
        [ceva addTarget:self action:@selector(mergiback) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *inapoibtn =[[UIBarButtonItem alloc] initWithCustomView:ceva];
        self.navigationItem.leftBarButtonItem = inapoibtn;
    }
    
    
    
    TOATE= [[NSMutableArray alloc]init];
    LISTASELECT.delegate =self;
    LISTASELECT.dataSource =self;
    LISTASELECT.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    LISTASELECT.separatorColor = [UIColor darkGrayColor];
    
    NSLog(@"DETALIUCERERE mesaje FULL %@",DETALIUCERERE);
    
    
    //la mesaje avem Arii cu Dictionare [pentru un mai usor row count si insert la expand]
    
    NSMutableArray *MESAJEREXP = [[NSMutableArray alloc]init];
    NSMutableArray *MESAJELEALTORA = [[NSMutableArray alloc]init];
    PRIMULMESAJ =[[NSDictionary alloc]init];
    NSMutableArray *itemuriexpandabile =[[NSMutableArray alloc]init];
    
    if([self.CE_TIP_E isEqualToString:@"dincerere"]) {
        if([self checkDictionary:DETALIUCERERE[@"CEREREFULLINFO"][@"cerere"]]) {
            //dictionar detaliu oferta
            if(DETALIUCERERE[@"CEREREFULLINFO"][@"cerere"][@"id"]) {
                IDCERERE =[NSString stringWithFormat:@"%@",DETALIUCERERE[@"CEREREFULLINFO"][@"cerere"][@"id"]];
                lastmessageid=@"";
                lastmessageid =  [NSString stringWithFormat:@"%@",DETALIUCERERE[@"CEREREFULLINFO"][@"cerere"][@"id"]];
            }
        }
        
        if(DETALIUCERERE[@"discussions"]) {
            itemuriexpandabile = [NSMutableArray arrayWithArray: [DETALIUCERERE[@"discussions"]mutableCopy]];
            
            NSLog(@"itemuriexpandabile %@",itemuriexpandabile);
            if( itemuriexpandabile.count>0) {
                //acum parcurge aria si  stabileste lastmessageid
                 if([itemuriexpandabile objectAtIndex:0]) {
                 PRIMULMESAJ=[NSDictionary dictionaryWithDictionary:[itemuriexpandabile objectAtIndex:0]];
                 }
              for(int i=0;i< itemuriexpandabile.count;i++) {
                       NSDictionary *dictmesaj = [NSDictionary dictionaryWithDictionary:[itemuriexpandabile objectAtIndex:i]];
                       NSMutableDictionary *perfectsense =[NSMutableDictionary dictionaryWithDictionary:dictmesaj];
                        if(dictmesaj[@"is_myself"]) {
                            NSString *eusender =[NSString stringWithFormat:@"%@",dictmesaj[@"is_myself"]];
                            NSInteger z=[eusender integerValue];
                            if(z==0) {
                                //ADD IN ARRAY
                                [MESAJELEALTORA addObject:dictmesaj];
                            }
                        }
                        if(dictmesaj[@"images"]) {
                            NSArray *imagini = [NSArray arrayWithArray:dictmesaj[@"images"]];
                            if(imagini.count >0) {
                                NSDictionary *imagine = [imagini objectAtIndex:0];
                                if(imagine[@"original"]) {
                                    UIImage *IHAVEIMAGE = [[UIImage alloc]init];
                                    NSString *stringurlthumbnail = [NSString stringWithFormat:@"%@", imagine[@"original"]];
                                    IHAVEIMAGE = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: stringurlthumbnail]]];
                                    if(IHAVEIMAGE && IHAVEIMAGE.size.height >0) {
                                        [perfectsense setObject:IHAVEIMAGE forKey:@"imaginea0"];
                                        [itemuriexpandabile replaceObjectAtIndex:i withObject:perfectsense];
                                    }
                                }
                            }
                        }
              }
            }
            
         
            //ATENTIE ! aici se insereaza intotdeauna 2 randuri goale text mesaj + buton de trimite mesaj
//            NSDictionary *trimitemesaj =@{@"special" : @"1"};
//            NSDictionary *trimitemesajaltul =@{@"specialrand" : @"2"};
//            [itemuriexpandabile addObject:trimitemesaj];
//            [itemuriexpandabile addObject:trimitemesajaltul];
            NSMutableDictionary *CORPEXPANDABIL = [[NSMutableDictionary alloc]init];
            [CORPEXPANDABIL setObject:itemuriexpandabile forKey:@"SubItems"];
            
            MESAJEFULL =CORPEXPANDABIL;
            MESAJEREXP =[NSMutableArray arrayWithArray:[NSArray arrayWithObjects:CORPEXPANDABIL, nil]];
            NSLog(@"MESAJEFULL %@",MESAJEFULL);
            
            
            ////different one
            
            NSLog(@"MESAJELEALTORA %@",MESAJELEALTORA);
            if(MESAJELEALTORA.count >0) {
                NSDictionary *ULTIMULMESAJDELAALTII = [NSDictionary dictionaryWithDictionary:[MESAJELEALTORA lastObject]];
                if(ULTIMULMESAJDELAALTII[@"messageid"]) {
                    NSString *lastmesajid =[NSString stringWithFormat:@"%@",ULTIMULMESAJDELAALTII[@"messageid"]];
                    lastmessageid =lastmesajid;
                }
                if(ULTIMULMESAJDELAALTII[@"username"]) {
                    NUMEUSERDISCUTIE =[NSString stringWithFormat:@"%@",ULTIMULMESAJDELAALTII[@"username"]];
                }
            }
        }
    }
    ////////////////////////////////
    if([CE_TIP_E isEqualToString:@"dinnotificari"]) {
        int amgasitid=0; // este id-ul arrayului in care se afla mesajul userului din notificare
        if(DETALIUCERERE[@"CEREREFULLINFO"][@"cerere"][@"id"]) {
            IDCERERE =[NSString stringWithFormat:@"%@",DETALIUCERERE[@"CEREREFULLINFO"][@"cerere"][@"id"]];
        }
        self.lastmessageid = lastmessageid;
        NSMutableArray *prelucrate = [[NSMutableArray alloc]init];
        if(DETALIUCERERE[@"discussions"]) {
            
            itemuriexpandabile = [NSMutableArray arrayWithArray: [DETALIUCERERE[@"discussions"]mutableCopy]];
            
            NSLog(@"itemuriexpandabile %@",itemuriexpandabile);
            if( itemuriexpandabile.count>0) {
                for(int i=0;i< itemuriexpandabile.count;i++) {
                    NSMutableArray *deprelucrat =[NSMutableArray arrayWithArray: [itemuriexpandabile objectAtIndex:i]];
                    for (int y=0; y< deprelucrat.count;y++) {
                        NSDictionary *cevadegasit = [NSDictionary dictionaryWithDictionary:[deprelucrat objectAtIndex:y]];
                        NSMutableDictionary *perfectsense =[NSMutableDictionary dictionaryWithDictionary:cevadegasit];
                        if(cevadegasit[@"messageid"]) {
                            NSString *decomparat =[NSString stringWithFormat:@"%@",cevadegasit[@"messageid"]];
                            if([decomparat isEqualToString:lastmessageid]) {
                             
                                PRIMULMESAJ=[NSDictionary dictionaryWithDictionary:cevadegasit];
                                if(cevadegasit[@"username"]) {
                                    NUMEUSERDISCUTIE =[NSString stringWithFormat:@"%@",cevadegasit[@"username"]];
                                }
                                if(cevadegasit[@"images"]) {
                                    NSArray *imagini = [NSArray arrayWithArray:cevadegasit[@"images"]];
                                    if(imagini.count >0) {
                                        NSDictionary *imagine = [imagini objectAtIndex:0];
                                        if(imagine[@"original"]) {
                                            UIImage *IHAVEIMAGE = [[UIImage alloc]init];
                                            NSString *stringurlthumbnail = [NSString stringWithFormat:@"%@", imagine[@"original"]];
                                            IHAVEIMAGE = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: stringurlthumbnail]]];
                                            if(IHAVEIMAGE && IHAVEIMAGE.size.height >0) {
                                                [perfectsense setObject:IHAVEIMAGE forKey:@"imaginea0"];
                                            /// [deprelucrat replaceObjectAtIndex:y withObject:perfectsense];
                                            /// [itemuriexpandabile replaceObjectAtIndex:i withObject:deprelucrat];
                                            }
                                        }
                                    }
                                }
                                if(![prelucrate containsObject:perfectsense]) {
                                    [prelucrate addObject:perfectsense];
                                }
                                amgasitid =i;
                                NSLog(@"am gasit id");
                                break;
                            }
                            
                        }
                    }
                }
            }
        }
        //********************************** II
        if([itemuriexpandabile objectAtIndex:amgasitid]) {
                NSMutableArray *deprelucrat =[NSMutableArray arrayWithArray: [itemuriexpandabile objectAtIndex:amgasitid]];
                for (int y=0; y< deprelucrat.count;y++) {
                    NSDictionary *cevadegasit = [NSDictionary dictionaryWithDictionary:[deprelucrat objectAtIndex:y]];
                        if(cevadegasit[@"is_myself"]) {
                        NSString *eusender =[NSString stringWithFormat:@"%@",cevadegasit[@"is_myself"]];
                        NSInteger z=[eusender integerValue];
                        if(z==1) {
                            NSMutableDictionary *perfectsense =[NSMutableDictionary dictionaryWithDictionary:cevadegasit];
                            if(cevadegasit[@"images"]) {
                                NSArray *imagini = [NSArray arrayWithArray:cevadegasit[@"images"]];
                                if(imagini.count >0) {
                                    NSDictionary *imagine = [imagini objectAtIndex:0];
                                    if(imagine[@"original"]) {
                                        UIImage *IHAVEIMAGE = [[UIImage alloc]init];
                                        NSString *stringurlthumbnail = [NSString stringWithFormat:@"%@", imagine[@"original"]];
                                        IHAVEIMAGE = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: stringurlthumbnail]]];
                                        if(IHAVEIMAGE && IHAVEIMAGE.size.height >0) {
                                            [perfectsense setObject:IHAVEIMAGE forKey:@"imaginea0"];
                                          ////  [deprelucrat replaceObjectAtIndex:y withObject:perfectsense];
                                          ///  [itemuriexpandabile replaceObjectAtIndex:i withObject:deprelucrat];
                                        }
                                    }
                                }
                            }
                            if(![prelucrate containsObject:perfectsense]) {
                                [prelucrate addObject:perfectsense];
                            }
                        }
                    }
                }
        }
        
        
        //ATENTIE ! aici se insereaza intotdeauna 2 randuri goale text mesaj + buton de trimite mesaj
//        NSDictionary *trimitemesaj =@{@"special" : @"1"};
//        NSDictionary *trimitemesajaltul =@{@"specialrand" : @"2"};
//        [prelucrate addObject:trimitemesaj];
//        [prelucrate addObject:trimitemesajaltul];
        NSMutableDictionary *CORPEXPANDABIL = [[NSMutableDictionary alloc]init];
        [CORPEXPANDABIL setObject:prelucrate forKey:@"SubItems"];
        
        MESAJEFULL =CORPEXPANDABIL;
        MESAJEREXP =[NSMutableArray arrayWithArray:[NSArray arrayWithObjects:CORPEXPANDABIL, nil]];
        NSLog(@"MESAJEFULL %@",MESAJEFULL);
        
    }
    
    [self removehud];
    pozetemporare = [[NSArray alloc]init];
    self.pozeprocesate =[[NSMutableArray alloc]init];
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(del.ARRAYASSETURIMESAJ.count >0) {
        pozele= [[NSMutableArray alloc]init];
        pozele = del.ARRAYASSETURIMESAJ;
        if (pozele.count > 0) {
            if ([[del.ARRAYASSETURIMESAJ objectAtIndex:0]isKindOfClass:[UIImage class]]) {
                ////////  NSLog(@"ce avem pe aici %@",del.ARRAYASSETURIMESAJ);
            UIImage *thumbpoza1 = [del.ARRAYASSETURIMESAJ objectAtIndex:0];
                               //[self.faPozaButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
                             [self.faPozaImageView setImage:thumbpoza1];
                                //[self.faPozaButton setImage:thumbpoza1 forState:UIControlStateNormal];
        }else {
            [self.faPozaImageView setImage:[UIImage imageNamed:@"Icon_Camera_LightGrey_144x144.png"]];
          }
        }
        [self.LISTASELECT reloadData];
//        long noofrows = [self.LISTASELECT numberOfRowsInSection:0];
//        NSIndexPath * lastIndexPath = [NSIndexPath indexPathForRow:noofrows-1 inSection:0];
//    [self.LISTASELECT scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
       // [self scrollToBottom];
        
    } else {
        pozele = [[NSMutableArray alloc]init];
        del.POZEMESAJ= [[NSMutableArray alloc]init];
        del.ARRAYASSETURIMESAJ= [[NSMutableArray alloc]init];
        del.ARRAYASSETURIMESAJEXTERNE= [[NSMutableArray alloc]init];
        [self.LISTASELECT reloadData];
//        long noofrows = [self.LISTASELECT numberOfRowsInSection:0];
//        NSIndexPath * lastIndexPath = [NSIndexPath indexPathForRow:noofrows-1 inSection:0];
//    [self.LISTASELECT scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        //[self scrollToBottom];
    }
    
    //trebuie bara custom cu back
    NSLog(@"alterego %@",CE_TIP_E);
    self.title = [NSString stringWithFormat:@"Discuție cu %@", NUMEUSERDISCUTIE];
    
    CGRect fr = self.separatorView.frame;
    fr.size.height = 0.5f;
    self.separatorView.frame = fr;
    self.separatorView.backgroundColor = [UIColor lightGrayColor];
    [self.trimiteView setNeedsLayout];
    [self.trimiteView setNeedsDisplay];
    
    
    
}
//-(void) scrollTolastRow
//{
//    if (self.LISTASELECT.contentSize.height > self.LISTASELECT.frame.size.height)
//    {
//        CGPoint offset = CGPointMake(0, self.LISTASELECT.contentSize.height - self.LISTASELECT.frame.size.height);
//        [self.LISTASELECT setContentOffset:offset animated:YES];
//    }
//}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
-(AFHTTPSessionManager*)SESSIONMANAGER {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy =[self customSecurityPolicy];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
    return manager;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"compune frame : %@", NSStringFromCGRect(self.compuneView.frame));
    NSLog(@"trimite frame : %@", NSStringFromCGRect(self.trimiteView.frame));
    NSLog(@"tabel frame : %@", NSStringFromCGRect(self.LISTASELECT.frame));
   // [self scrollToBottom];
    
}

-(void)viewDidLayoutSubviews
{
    
    if ([self.scrollView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.scrollView setLayoutMargins:UIEdgeInsetsZero];
    }
    [self scrollToBottom];
}



-(void)scrollToBottom {
    
    if(shouldScrollToLastRow){
        CGPoint bottomOffset = CGPointMake(0, self.LISTASELECT.contentSize.height - self.LISTASELECT.bounds.size.height + self.LISTASELECT.contentInset.bottom);
        if (bottomOffset.y >= 0.0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.LISTASELECT setContentOffset:bottomOffset animated:NO];
                
            });
        }
    }
    
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    shouldScrollToLastRow = true;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    self.compuneTextView.delegate = self;
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    self.compuneTextView.inputAccessoryView = numberToolbar;
    [self.faPozaImageView setImage:[UIImage imageNamed:@"Icon_Camera_LightGrey_144x144.png"]];
    UITapGestureRecognizer * recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(trimitemesaj)];
    recognizer.numberOfTapsRequired = 1;
    [self.trimiteView addGestureRecognizer:recognizer];
    
    self.compuneTextView.textColor = [UIColor lightGrayColor];
    self.compuneTextView.text =@"Mesaj către vânzător";
    
    [self.LISTASELECT reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows =0;
    if(MESAJEFULL) {
        NSDictionary *MAJORDICT = [NSDictionary dictionaryWithDictionary:MESAJEFULL];
        NSArray *minorrarray = [[NSArray alloc]init];
        if(MAJORDICT[@"SubItems"] )  {
            minorrarray =MAJORDICT[@"SubItems"];
            rows = minorrarray.count;
        }
    }
    NSLog(@"rowsrowsrowsrows %li",(long)rows);
    return rows;
    //return 1;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    double inaltimerand =0;
    //    if(SYSTEM_VERSION_LESS_THAN(@"8.0")){
    //        if ([indexPath section]== 0) {
    //            inaltimerand = 120;
    //        }
    //
    //        if([indexPath section]== 1){
    //            inaltimerand = 110;
    //        }
    //        if(indexPath.section ==2 ) {
    //            if(indexPath.row == 0){
    //                inaltimerand = 40;
    //            } else {
    //                //              inaltimerand = 90; //NU UITA DINAMIC height
    //                NSDictionary *MAJORDICT = [[self.TOATE objectAtIndex:2] objectAtIndex:0];
    //                 if(MAJORDICT[@"SubItems"] ) {
    //                    NSArray *minorrarray =MAJORDICT[@"SubItems"];
    //                    NSDictionary *MINORDICT = [minorrarray objectAtIndex:indexPath.row-1]; //pentru ca 0 e nume, si subitems incep pe 0
    //                    if(MINORDICT[@"nume"]) {
    //                        NSString *descrierelunga = [NSString stringWithFormat:@"%@",MINORDICT[@"nume"]];
    //                       // NSStringDrawingContext *ctx = [NSStringDrawingContext new];
    //                        NSAttributedString *aString = [[NSAttributedString alloc] initWithString:descrierelunga];
    //                        UITextView *calculationView = [[UITextView alloc] init];
    //                        [calculationView setAttributedText:aString];
    //                        static NSString *CellIdentifier = @"CellDetaliuOferta";
    //                        CellDetaliuOferta *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //                        [cell layoutIfNeeded];
    //                        CGFloat widthWithInsetsApplied = self.view.frame.size.width;
    //                        if(SYSTEM_VERSION_LESS_THAN(@"8.0")){
    //                            widthWithInsetsApplied = self.view.frame.size.width - 30;
    //                        } else {
    //                            widthWithInsetsApplied = self.view.frame.size.width - 30;
    //                        }
    //                        double inaltimerand=0;
    //                        CGSize textSize = [calculationView.text  boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
    //                        inaltimerand= textSize.height +90;
    //                       // cell.dynamictableheightJ.constant = inaltimerand;
    ////
    ////                        CGRect textRect = [calculationView.text boundingRectWithSize:self.view.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:calculationView.font} context:ctx];
    ////                        NSLog(@"textRect.size.height %f maybe cell is better in autolay%f",textRect.size.height,[cell.contentView systemLayoutSizeFittingSize: UILayoutFittingCompressedSize].height); //    return textRect.size.height;
    ////                        inaltimerand =textRect.size.height;
    //                    }
    //                }
    //                // inaltimerand = 175;
    //            }
    //        }
    //
    //        if(indexPath.section ==3 ) {
    //            if(indexPath.row == 0){
    //                inaltimerand = 75;
    //            }  else {
    //                inaltimerand = 90; //NU UITA DINAMIC height
    //            }
    //        }
    //        if(indexPath.section ==4 ) {
    //            if(indexPath.row == 0){
    //                inaltimerand = 75;
    //            }  else {
    //                inaltimerand = 90; //NU UITA DINAMIC height
    //            }
    //        }
    //        if(indexPath.section ==5 ) {
    //            if(indexPath.row == 0){
    //                inaltimerand = 75;
    //            }  else {
    //                NSDictionary *MAJORDICT = [[self.TOATE objectAtIndex:5] objectAtIndex:0];
    //                if(MAJORDICT[@"SubItems"] ) {
    //                    NSArray *minorrarray =MAJORDICT[@"SubItems"];
    //                    NSDictionary *MINORDICT = [minorrarray objectAtIndex:indexPath.row-1]; //pentru ca 0 e nume, si subitems incep pe 0
    //                    if(MINORDICT[@"nume"]) {
    //                        NSString *descrierelunga = [NSString stringWithFormat:@"%@",MINORDICT[@"nume"]];
    //                        static NSString *CellIdentifier = @"CellDetaliuOferta";
    //                        CellDetaliuOferta *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //
    //                        CGFloat widthWithInsetsApplied = self.view.frame.size.width - 20;
    //
    //                        CGSize textSize = [descrierelunga boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    //                        NSLog(@"vsss %f %f",self.view.frame.size.width,cell.textmesaj.frame.size.height);
    //                        double NECESARHeight =textSize.height+60; //20 +
    //                        inaltimerand =NECESARHeight;
    //                        // inaltimerand = 120; //NU UITA DINAMIC height
    //                    }
    //                }
    //            }
    //        }
    //
    //        //butoane
    //        if(indexPath.section ==6) {
    //            inaltimerand = 74;
    //        }
    //
    //    } else { //ios 8
//    NSLog(@" dddddd %@", MESAJEFULL);

    NSDictionary *MAJORDICT = [NSDictionary dictionaryWithDictionary:MESAJEFULL];
    NSArray *minorrarray = [[NSArray alloc]init];
    if(MAJORDICT[@"SubItems"] ) minorrarray =MAJORDICT[@"SubItems"];
//    NSInteger totalRow = minorrarray.count;
//    if(indexPath.row == totalRow -2 ) {
//        //  inaltimerand = 78; //  ar trebui sa faca height automat
//        return  textViewHeight ;
//    } else if(indexPath.row == totalRow-1 ) {
//        return  47; //e buton trimite mesaj
//    }
//    else {
        double NECESARHeight =0;
        double NECESARHeightIMAGINE = 0;
        NSDictionary *MINORDICT = [minorrarray objectAtIndex:indexPath.row]; //pentru ca 0
        NSString *continutmesaj=@"";
        NSString *datafromatatamesaj=@"";
        if(MINORDICT[@"message"]) continutmesaj =[NSString stringWithFormat:@"%@",MINORDICT[@"message"]];
        if(MINORDICT[@"date_formatted"]) datafromatatamesaj =[NSString stringWithFormat:@"%@",MINORDICT[@"date_formatted"]];
        NSString *compus_mesaj= [NSString stringWithFormat:@"%@\n %@",continutmesaj,datafromatatamesaj];
        CGFloat widthWithInsetsApplied = self.view.frame.size.width;
        if(SYSTEM_VERSION_LESS_THAN(@"8.0")){
            widthWithInsetsApplied = self.view.frame.size.width - 30;
        } else {
            widthWithInsetsApplied = self.view.frame.size.width - 30;
        }
        CGSize textSize = [compus_mesaj boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
        NECESARHeight =textSize.height+20; //20 +
        NSArray *pozeatasatemesajdelaserver = [[NSArray alloc]init];
        if(MINORDICT[@"images"])  pozeatasatemesajdelaserver =[NSArray arrayWithArray:MINORDICT[@"images"]];
        if(pozeatasatemesajdelaserver.count >0) {
            if( [[pozeatasatemesajdelaserver objectAtIndex:0]isKindOfClass:[NSDictionary class]] && [[pozeatasatemesajdelaserver objectAtIndex:0]respondsToSelector:@selector(allKeys)]) {
                NSDictionary *detaliupoza =[pozeatasatemesajdelaserver objectAtIndex:0];
                if(detaliupoza[@"tb"]) {
                    NECESARHeightIMAGINE = 200;
                }
            }
        }
        inaltimerand = NECESARHeight +NECESARHeightIMAGINE +60 ;
    //}
    
    return inaltimerand;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"";
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Background color
    view.tintColor = [UIColor darkGrayColor];
}

-(void)doneWithNumberPad {
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([self.compuneTextView.text isEqualToString:@""]) {
        self.compuneTextView.text =  @"Mesaj către vânzător";
        self.compuneTextView.textColor = [UIColor lightGrayColor]; //optional
    } else {
        self.compuneTextView.textColor = [UIColor blackColor];
    }
    del.TEXTMESAJTEMPORAR = self.compuneTextView.text;
    [self.compuneTextView resignFirstResponder];
    [self.view endEditing:YES];
}
//-(void)textViewDidChange:(UITextView *)textView
//{
////    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
////    NSDictionary *CORPEXPANDABIL = [NSDictionary dictionaryWithDictionary:MESAJEFULL];
////    NSMutableArray *RANDURI = [[NSMutableArray alloc]init];
////    if( CORPEXPANDABIL[@"SubItems"]) {
////        RANDURI=[NSMutableArray arrayWithArray:CORPEXPANDABIL[@"SubItems"]];
////        
////    }
////    NSInteger totalRow = RANDURI.count;
////    NSInteger ipx=0;
////    ipx = totalRow-2;    NSIndexPath *indexPathreload = [NSIndexPath indexPathForRow:ipx inSection:0];
////    CellDetaliuMesaj *updateCell = (CellDetaliuMesaj *)[self.LISTASELECT cellForRowAtIndexPath:indexPathreload];
////    if ([updateCell.compunetextmesaj.text isEqualToString:@""]) {
////        updateCell.compunetextmesaj.text =  @"Mesaj către vânzător";
////        updateCell.compunetextmesaj.textColor = [UIColor lightGrayColor];
////        [updateCell.compunetextmesaj resignFirstResponder];
////    } else {
////        updateCell.compunetextmesaj.textColor = [UIColor blackColor];
////    }
////    
////    NSLog(@"Dilip : %@",textView.text);
////    CGFloat widthWithInsetsApplied = self.view.frame.size.width-45;
////    CGSize textSize = [textView.text boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
////    double heightrow= textSize.height+25;
////    NSLog(@"heightrow specx %f",heightrow);
////    
////    if(heightrow < 48) {
////        updateCell.dynamicTEXTVIEWHEIGHT.constant =48;
////    } else {
////        updateCell.dynamicTEXTVIEWHEIGHT.constant =heightrow;
////    }
////    [self.LISTASELECT beginUpdates];
////    updateCell.dynamicTEXTVIEWHEIGHT.constant =heightrow;
////    updateCell.dynamicCOMPUNEROWHEIGHT.constant =heightrow+30;
////    updateCell.dynamicLINIEGRIHEIGHT.constant =heightrow+30;
////    cellheightmodificatmesaj = heightrow+30;
////    [updateCell setNeedsLayout];
////    [updateCell layoutIfNeeded];
////    [self.LISTASELECT endUpdates];
////    del.TEXTMESAJTEMPORAR =updateCell.compunetextmesaj.text;
//    
//    
//}

- (void) textViewDidChange:(UITextView *)textView
{
    AppDelegate * del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    del.TEXTMESAJTEMPORAR = textView.text;
    UITextPosition* pos = textView.endOfDocument;
    CGRect currentRect = [textView caretRectForPosition:pos];
    
    NSLog(@"current y : %f", currentRect.origin.y);
    NSLog(@"prev y : %f", previousRect.origin.y);
    NSLog(@"text : %@",textView.text);
    if (currentRect.origin.y != previousRect.origin.y){
        CGFloat fixedWidth = textView.frame.size.width;
        CGSize newSize = [textView sizeThatFits:(CGSizeMake(fixedWidth, MAXFLOAT))];
        [self heightOfTextView:textView Withwheight:newSize.height];
    }
    previousRect = currentRect;
    
}



-(void)heightOfTextView:(UITextView *)textView Withwheight:(CGFloat)height{
    textViewHeight = height +16;
    CGRect textviewFrame = self.compuneTextView.frame;
    textviewFrame.size.height = textViewHeight;
    self.compuneTextView.frame = textviewFrame;
    [self.compuneView setNeedsLayout];
    [self.compuneView setNeedsDisplay];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
    if ([self.compuneTextView.text isEqualToString: @"Mesaj către vânzător"]) {
        self.compuneTextView.text = @"";
        self.compuneTextView.textColor = [UIColor blackColor];
    }

}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return UITableViewAutomaticDimension;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    //  NSArray *ofertaROW =[[NSArray alloc]init];
    static NSString *CellIdentifier = @"CellDetaliuMesaj";
    CellDetaliuMesaj *cell = [self.LISTASELECT dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (CellDetaliuMesaj*)[self.LISTASELECT dequeueReusableCellWithIdentifier:@"CellDetaliuMesaj"];
    }
    for (UIView *subview in [cell.contentView subviews]) {
        
        if([subview isKindOfClass:[CustomBadge class]]){
            [subview removeFromSuperview];
        }
    }
    for (UIView *subview in [cell.contentView subviews]) {
        
        if([subview isKindOfClass:[CustomBadge1 class]]){
            [subview removeFromSuperview];
        }
    }
    for (UIImageView *sublayer in cell.contentView.subviews) {
        if([sublayer isKindOfClass:[IMAGINESERVER1 class]]){
            [sublayer removeFromSuperview];
        }
    }
    for (UILabel *specialtext in cell.contentView.subviews) {
        if([specialtext isKindOfClass:[SpecialText1 class]]){
            [specialtext removeFromSuperview];
        }
    }
    
    for (CAShapeLayer *sublayer in cell.fundalmesaj.layer.sublayers) {
        if([sublayer isKindOfClass:[ClockFace1 class]]){
            [sublayer removeFromSuperlayer];
        }
    }
    
    NSInteger ipx = indexPath.row;
    NSLog(@"ipx ofer %li", (long)ipx);
    
    cell.toptitlurand.constant =-22;
    
    cell.badgeRow.hidden=YES;
    cell.bifablue.hidden=YES;
    cell.elpozaalbastra.hidden=YES;
    cell.eupozagri.hidden=YES;
    cell.fundalmesaj.hidden=YES;
    cell.textmesaj.hidden=YES;
    cell.compunetextmesaj.delegate =self;
    cell.compunetextmesaj.userInteractionEnabled=NO;
    cell.compunetextmesaj.hidden=YES;
    cell.sageatatrimite.hidden=YES;
    cell.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1];
    cell.cercalbastru.hidden=YES;
    
    cell.COMPUNE.hidden=YES;
    cell.TRIMITE.hidden=YES;
    cell.trimitetextmesaj.userInteractionEnabled=NO;
    cell.TRIMITE.userInteractionEnabled=YES;
    cell.contentView.frame = cell.bounds;
    cell.pozamesajdejatrimis.hidden=YES;
    /////  NSLog(@"sectionContents %@", ofertaROW);
    
    cell.continutmesaj.hidden=YES;
    NSDictionary *CORPEXPANDABIL = [NSDictionary dictionaryWithDictionary:MESAJEFULL];
    
    cell.contentView.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1] ;
    cell.bifablue.hidden=YES;
    NSMutableArray *RANDURI = [[NSMutableArray alloc]init];
    if( CORPEXPANDABIL[@"SubItems"]) {
        RANDURI=[NSMutableArray arrayWithArray:CORPEXPANDABIL[@"SubItems"]];
        
    }
    ///      NSLog(@" RANDURI zzz %i",RANDURI.count);
    NSInteger totalRow = RANDURI.count; // sunt toate comentariile + 1 [text mesaj]  +1 rand pentru trimite mesaj
    
//    if(ipx == totalRow-2){ //TEXT TRIMITE MESAJ ->incarca view mesaj
//        
//        cell.COMPUNE.hidden=NO;
//        cell.TRIMITE.hidden=YES;
//        cell.toptitlurand.constant =20;
//        cell.compunetextmesaj.userInteractionEnabled=YES;
//        cell.compunetextmesaj.hidden=NO;
//        [cell.compunetextmesaj setScrollEnabled:NO];
//        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
//        numberToolbar.barStyle = UIBarStyleBlackTranslucent;
//        numberToolbar.items = [NSArray arrayWithObjects:
//                               [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
//                               nil];
//        [numberToolbar sizeToFit];
//        cell.compunetextmesaj.inputAccessoryView = numberToolbar;
//        AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        
//        if( ![self MyStringisEmpty:[NSString stringWithFormat:@"%@",del.TEXTMESAJTEMPORAR]] && ![del.TEXTMESAJTEMPORAR isEqualToString:@"Mesaj către vânzător"]) {
//            cell.compunetextmesaj.textColor = [UIColor blackColor];
//            cell.compunetextmesaj.text =del.TEXTMESAJTEMPORAR;
//        } else {
//            cell.compunetextmesaj.textColor = [UIColor lightGrayColor];
//            cell.compunetextmesaj.text =@"Mesaj către vânzător";
//            
//        }
//        
//        CGFloat widthWithInsetsApplied = self.view.frame.size.width-45;
//        
//        CGSize textSize = [cell.compunetextmesaj.text boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
//        double heightrow= textSize.height +25;
//        
//        NSLog(@"heightrow spec %f",heightrow);
//        if(textSize.height < 48) {
//            heightrow =48;
//        }
//        cellheightmodificatmesaj = heightrow+30;
//        cell.dynamicTEXTVIEWHEIGHT.constant =heightrow;
//        cell.dynamicCOMPUNEROWHEIGHT.constant =heightrow+30;
//        cell.dynamicLINIEGRIHEIGHT.constant =heightrow+30;
//        [cell setNeedsLayout];
//        [cell layoutIfNeeded];
//        
//        
//        if(pozele.count >0) {
//            if( [[del.ARRAYASSETURIMESAJ objectAtIndex:0]isKindOfClass:[NSDictionary class]] && [[del.ARRAYASSETURIMESAJ objectAtIndex:0]respondsToSelector:@selector(allKeys)]) {
//                NSDictionary *detaliupoza =[del.ARRAYASSETURIMESAJ objectAtIndex:0];
//                if(detaliupoza[@"tb"]) {
//                    
//                    
//                    NSString *stringurlthumbnail = [NSString stringWithFormat:@"%@", detaliupoza[@"tb"]];
//                    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
//                        [cell.fapoza.imageView sd_setImageWithURL:[NSURL URLWithString:stringurlthumbnail]
//                                                 placeholderImage:nil
//                                                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                                                            //  ... completion code here ...
//                                                            if(image && image.size.height !=0) {  cell.fapoza.imageView.image = image;  }
//                                                        }];
//                    });
//                    [cell.fapoza.imageView setContentMode:UIViewContentModeScaleAspectFit];
//                }
//            } else if ([[del.ARRAYASSETURIMESAJ objectAtIndex:0]isKindOfClass:[UIImage class]]) {
//                ////////  NSLog(@"ce avem pe aici %@",del.ARRAYASSETURIMESAJ);
//                UIImage *thumbpoza1 = [del.ARRAYASSETURIMESAJ objectAtIndex:0];
//                [cell.fapoza.imageView setContentMode:UIViewContentModeScaleAspectFit];
//                [cell.fapoza setImage:thumbpoza1 forState:UIControlStateNormal];
//                [cell.fapoza setImage:thumbpoza1 forState:UIControlStateSelected];
//            }else {
//                [cell.fapoza setImage:[UIImage imageNamed:@"Icon_Camera_LightGrey_144x144.png"] forState:UIControlStateNormal];
//                [cell.fapoza setImage:[UIImage imageNamed:@"Icon_Camera_BlueJ_144x144.png"] forState:UIControlStateSelected];
//            }
//        }else {
//            [cell.fapoza setImage:[UIImage imageNamed:@"Icon_Camera_LightGrey_144x144.png"] forState:UIControlStateNormal];
//            [cell.fapoza setImage:[UIImage imageNamed:@"Icon_Camera_BlueJ_144x144.png"] forState:UIControlStateSelected];
//        }
//        
//        cell.fapoza.imageView.contentMode =UIViewContentModeScaleAspectFit;
//        cell.fapoza.userInteractionEnabled =TRUE;
//        cell.compunetextmesaj.userInteractionEnabled =TRUE;
//        [cell.contentView bringSubviewToFront:cell.COMPUNE];
//        [cell.COMPUNE bringSubviewToFront:cell.fapoza];
//    }
    //else
//        if(ipx == totalRow-1){ //ULTIMUL RAND BUTON TRIMITE MESAJ
//        cell.COMPUNE.hidden=YES;
//        cell.TRIMITE.hidden=NO;
//        [cell.COMPUNE bringSubviewToFront:cell.trimitetextmesaj];
//        [cell.trimitetextmesaj  setUserInteractionEnabled:NO];
//        cell.sageatatrimite.hidden=NO;
//    }
   // else  {
        cell.continutmesaj.hidden=NO;
        cell.toptitlurand.constant =20;
        cell.fundalmesaj.hidden=NO;
        cell.elpozaalbastra.hidden=NO;
        cell.eupozagri.hidden=NO;
        
        NSDictionary *specialitem= [[NSDictionary alloc]init];
        specialitem =[RANDURI objectAtIndex:ipx]; //make it rain
        NSLog(@"je myself %@", specialitem);
        NSString *continutmesaj =[NSString stringWithFormat:@"%@",specialitem[@"message"]];
        NSString *datafromatatamesaj =[NSString stringWithFormat:@"%@",specialitem[@"date_formatted"]];
        NSString *compus_mesaj= [NSString stringWithFormat:@"%@\n %@",continutmesaj,datafromatatamesaj];
        NSRange bigRange = [compus_mesaj rangeOfString:continutmesaj];
        NSRange mediumRange = [compus_mesaj rangeOfString:datafromatatamesaj];
        NSMutableAttributedString * attributedString= [[NSMutableAttributedString alloc] initWithString:compus_mesaj];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize: 18] range:bigRange];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:mediumRange];
        cell.contentView.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1] ;
        
        
        
        ////////// nu uita sa incerci  [aPath setFrame:CGRectZero]; la final
        cell.contentView.backgroundColor = [UIColor colorWithRed:(232/255.0) green:(232/255.0) blue:(232/255.0) alpha:1] ;
        NSLog(@"ce..funda %f %f %f %f", cell.fundalmesaj.frame.origin.x,cell.fundalmesaj.frame.origin.y,cell.fundalmesaj.frame.size.width,cell.fundalmesaj.frame.size.height);
        
        NSInteger x =0;
        NSString *eusender =[[NSString alloc]init];
        //"nume":@"mesaj1",@"descriere":@"textmesaj1", @"eusender":@"0"
        eusender =[NSString stringWithFormat:@"%@",specialitem[@"is_myself"]];
        x=[eusender integerValue];
        
        NSLog(@"ipxxxxxxxxxx %li si x %li", (long)ipx,(long)x);
        
        CGFloat widthWithInsetsApplied = self.view.frame.size.width;
        if(SYSTEM_VERSION_LESS_THAN(@"8.0")){
            widthWithInsetsApplied = self.view.frame.size.width - 50;
        } else {
            widthWithInsetsApplied = self.view.frame.size.width - 30;
        }
        cell.textmesaj.hidden=YES;
        cell.textmesaj.attributedText=attributedString;
        cell.textmesaj.numberOfLines =0;
        ////jjjjj de testat pe 4 ->
        [cell.textmesaj sizeToFit];
        
        CGSize textSize = [cell.textmesaj.text boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
        NSLog(@"vsss %f %f",self.view.frame.size.width,cell.textmesaj.frame.size.height);
        double NECESARHeight =textSize.height+20;
        CGRect FUNDALMSG = cell.fundalmesaj.frame;
        if(SYSTEM_VERSION_LESS_THAN(@"8.0")){
            FUNDALMSG.size.width = self.view.frame.size.width - 20;
            cell.fundalmesaj.clipsToBounds =NO;
        } else {
            FUNDALMSG.size.width = self.view.frame.size.width - 30;
            cell.fundalmesaj.clipsToBounds =YES;
        }
        double NECESARHeightIMAGINE = 0;
        UIImageView *pozamesajserver = [[IMAGINESERVER1 alloc]init];
        NSArray *pozeatasatemesajdelaserver = [[NSArray alloc]init];
        pozeatasatemesajdelaserver =[NSArray arrayWithArray:specialitem[@"images"]];
        if(specialitem[@"imaginea0"] && [specialitem[@"imaginea0"] isKindOfClass:[UIImage class]]) {
            //inseamna ca a tras imaginea la load cu NSData dataWithContentsOfURL: am preferat sa fac asta sus la load///
            UIImage *FLUXCONTINUU = [[UIImage alloc]init];
            FLUXCONTINUU =specialitem[@"imaginea0"];
            pozamesajserver.image = FLUXCONTINUU;
            pozamesajserver.frame =cell.pozamesajdejatrimis.frame;
            [pozamesajserver setContentMode:UIViewContentModeScaleAspectFit];
            [pozamesajserver clipsToBounds];
            NECESARHeightIMAGINE = pozamesajserver.frame.size.height;
            NSLog(@" NECESARHeightIMAGINE PRELOADED %f", NECESARHeightIMAGINE);
            if(pozeatasatemesajdelaserver.count >0) {
                UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mergilapoze)];
                self.pozeprocesate =[[NSMutableArray alloc]init];
                pozetemporare =[[NSArray alloc]init];
                pozetemporare= pozeatasatemesajdelaserver;
                [singleTap setNumberOfTapsRequired:1];
                [cell.pozamesajdejatrimis  setUserInteractionEnabled:YES];
                [cell.pozamesajdejatrimis  addGestureRecognizer:singleTap];
            }
            
            
        } else if(specialitem[@"images"]) {
            //se poate sa nu fi luat poza atunci reincearca aici
            
            if(pozeatasatemesajdelaserver.count >0) {
                if( [[pozeatasatemesajdelaserver objectAtIndex:0]isKindOfClass:[NSDictionary class]] && [[pozeatasatemesajdelaserver objectAtIndex:0]respondsToSelector:@selector(allKeys)]) {
                    NSDictionary *detaliupoza =[pozeatasatemesajdelaserver objectAtIndex:0];
                    if(detaliupoza[@"tb"]) {
                        NSString *calepozaserver = [NSString stringWithFormat:@"%@",detaliupoza[@"tb"]];
                        [pozamesajserver sd_setImageWithURL:[NSURL URLWithString:calepozaserver]
                                           placeholderImage:nil
                                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                      //  ... completion code here ...
                                                      if(image && image.size.height !=0) {  pozamesajserver.image = image;  }
                                                  }];
                        pozamesajserver.frame =cell.pozamesajdejatrimis.frame;
                        [pozamesajserver setContentMode:UIViewContentModeScaleAspectFit];
                       // [pozamesajserver clipsToBounds];
                        
                        NECESARHeightIMAGINE = pozamesajserver.frame.size.height;
                        NSLog(@" NECESARHeightIMAGINE %f", NECESARHeightIMAGINE);
                        UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mergilapoze)];
                        self.pozeprocesate =[[NSMutableArray alloc]init];
                        pozetemporare =[[NSArray alloc]init];
                        pozetemporare= pozeatasatemesajdelaserver;
                        [singleTap setNumberOfTapsRequired:1];
                        [cell.pozamesajdejatrimis setContentMode:UIViewContentModeScaleAspectFit];
                        [cell.pozamesajdejatrimis  setUserInteractionEnabled:YES];
                        [cell.pozamesajdejatrimis  addGestureRecognizer:singleTap];
                        
                    }
                }
            }
        }
        
        
        
        
        ////jjjj vezi 40
        FUNDALMSG.size.height = NECESARHeight +NECESARHeightIMAGINE+40;
        
        NECESARHeight =FUNDALMSG.size.height;
        cell.fundalmesaj.frame= FUNDALMSG;
        NSLog(@"  FUNDALMSG.size.height %f", FUNDALMSG.size.height);
        
        CAShapeLayer *shapeLayer = [[ClockFace1 alloc] init]; //nu uita iOS7 needs fix.
        UIBezierPath *aPath = [UIBezierPath bezierPath];
        NSInteger radius = 5.0;
        
        [aPath moveToPoint:CGPointMake(10.0, 10.0)];
        // Draw the lines.
        //top right
        [aPath addArcWithCenter:CGPointMake(cell.fundalmesaj.frame.size.width -15 -radius,10+radius)
                         radius:radius
                     startAngle:- (M_PI / 2)
                       endAngle:0
                      clockwise:YES];
        [aPath addLineToPoint:CGPointMake(cell.fundalmesaj.frame.size.width -15, 10.0+radius)];
        //bottom right
        [aPath addArcWithCenter:CGPointMake(cell.fundalmesaj.frame.size.width -15 - radius, NECESARHeight -radius)
                         radius:radius
                     startAngle:0
                       endAngle:- ((M_PI * 3) / 2)
                      clockwise:YES];
        [aPath addLineToPoint:CGPointMake(cell.fundalmesaj.frame.size.width -15-radius, NECESARHeight)];
        //bottom left
        [aPath addArcWithCenter:CGPointMake(25, NECESARHeight -radius)
                         radius:radius
                     startAngle:- ((M_PI * 3) / 2)
                       endAngle:- M_PI
                      clockwise:YES];
        [aPath addLineToPoint:CGPointMake(20.0,NECESARHeight-radius)];
        //finish line
        //top left
        //    [aPath addArcWithCenter:CGPointMake(10, 10)
        //                    radius:radius
        //                startAngle:- M_PI
        //                  endAngle:- (M_PI / 2)
        //                 clockwise:YES];
        [aPath addLineToPoint:CGPointMake(20.0,20)];
        [aPath closePath];
        shapeLayer.path = aPath.CGPath;
        shapeLayer.opacity = 1;
        //
        
        // shapeLayer.bounds = CGPathGetBoundingBox(aPath.CGPath);
        
        //                 shapeLayer.bounds =CGRectMake(0, 0, cell.fundalmesaj.frame.size.width -30, 55);
        //                  shapeLayer.anchorPoint= CGPointMake(10.0,10.0);
        //                  shapeLayer.position=CGPointMake(0,0);
        //  }
        
        
        switch (x) {
                
            case 0: { //ramane apath default+
                cell.textmesaj.textColor =[UIColor darkGrayColor];
                cell.elpozaalbastra.hidden=YES;
                if(![specialitem[@"is_viewed"] boolValue] || [specialitem[@"is_myself"] boolValue])
                cell.cercalbastru.hidden=NO;
                [cell.contentView bringSubviewToFront:cell.cercalbastru];
                shapeLayer.strokeColor = [[UIColor colorWithRed:(199/255.0) green:(199/255.0) blue:(199/255.0) alpha:1] CGColor];
                shapeLayer.fillColor = [[UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1] CGColor];
                shapeLayer.lineWidth = 2;
                CGRect framedorit = CGRectNull;
                
                if(SYSTEM_VERSION_LESS_THAN(@"8.0")){
                    framedorit = shapeLayer.frame;
                    shapeLayer.bounds = CGPathGetPathBoundingBox(aPath.CGPath);
                    framedorit.origin.x = 2;
                    framedorit.origin.y = 0;
                    framedorit.size.height =NECESARHeight;
                    shapeLayer.frame =framedorit;
                }else {
                    framedorit = shapeLayer.frame;
                    framedorit.origin.x = -6;
                    framedorit.origin.y =0;
                    framedorit.size.height =NECESARHeight;
                    shapeLayer.frame =framedorit;
                }
                [cell.fundalmesaj.layer insertSublayer:shapeLayer above:[cell.fundalmesaj.layer.sublayers firstObject]];
                if(NECESARHeightIMAGINE>0) {
                    cell.textmesaj.hidden=YES;
                    cell.pozamesajdejatrimis.hidden=NO;
                    cell.pozamesajdejatrimis.image =pozamesajserver.image;
                    [cell.pozamesajdejatrimis setContentMode:UIViewContentModeScaleAspectFit];
                    UILabel *SPECIALTEXTMESAJ =[[SpecialText1 alloc]init];
                    SPECIALTEXTMESAJ.attributedText = cell.textmesaj.attributedText;
                    CGRect framedorititext = cell.textmesaj.frame;
                    framedorititext.origin.x=40;
                    framedorititext.origin.y = NECESARHeightIMAGINE+30;
                    framedorititext.size.width =NECESARHeightIMAGINE +100;
                    SPECIALTEXTMESAJ.frame =framedorititext;
                    SPECIALTEXTMESAJ.font = cell.textmesaj.font;
                    SPECIALTEXTMESAJ.textColor= cell.textmesaj.textColor;
                    SPECIALTEXTMESAJ.numberOfLines =0;
                    [SPECIALTEXTMESAJ sizeToFit];
                    [cell.contentView addSubview:SPECIALTEXTMESAJ];
                    [cell.contentView bringSubviewToFront:SPECIALTEXTMESAJ];
                    [cell.contentView bringSubviewToFront:cell.cercalbastru];
                    NSLog(@"My view frame: %@", NSStringFromCGRect(SPECIALTEXTMESAJ.frame));
                    NSLog(@"donde esta la bulinas : %@", NSStringFromCGRect(cell.cercalbastru.frame));
                } else {
                    cell.textmesaj.hidden=NO;
                    [cell.contentView bringSubviewToFront:cell.textmesaj];
                }
                
                
            } break;
            case 1: {
                cell.eupozagri.hidden=YES;
                cell.cercalbastru.hidden=YES;
                cell.textmesaj.textColor =[UIColor whiteColor];
                shapeLayer.affineTransform =  CGAffineTransformMakeScale(-1, 1);
                shapeLayer.strokeColor = [[UIColor whiteColor] CGColor];
                shapeLayer.fillColor = [[UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] CGColor];
                CGRect framedorit = CGRectNull;
                if(SYSTEM_VERSION_LESS_THAN(@"8.0")){
                    framedorit = shapeLayer.frame;
                    shapeLayer.bounds = CGPathGetPathBoundingBox(aPath.CGPath);
                    //  framedorit.origin.x = cell.elpozaalbastra.frame.origin.x;
                    framedorit.origin.x = self.view.frame.size.width-50;
                    // framedorit.origin.x = -6;
                    framedorit.origin.y =0;
                    framedorit.size.height =NECESARHeight;
                    // framedorit.size.width = self.view.frame.size.width-20;
                    shapeLayer.frame =framedorit;
                }else {
                    framedorit = shapeLayer.frame;
                    framedorit.origin.x = cell.eupozagri.frame.origin.x +cell.fundalmesaj.frame.size.width -cell.eupozagri.frame.size.width;
                    framedorit.size.height =NECESARHeight;
                    framedorit.origin.y =0;
                    //  framedorit.size.width = self.view.frame.size.width-20;
                    shapeLayer.frame =framedorit;
                }
                [cell.fundalmesaj.layer insertSublayer:shapeLayer above:[cell.fundalmesaj.layer.sublayers firstObject]];
                if(NECESARHeightIMAGINE>0) {
                    cell.textmesaj.hidden=YES;
                    cell.pozamesajdejatrimis.hidden=NO;
                    cell.pozamesajdejatrimis.image =pozamesajserver.image;
                    [cell.pozamesajdejatrimis setContentMode:UIViewContentModeScaleAspectFit];
                    UILabel *SPECIALTEXTMESAJ =[[SpecialText1 alloc]init];
                    SPECIALTEXTMESAJ.attributedText = cell.textmesaj.attributedText;
                    CGRect framedorititext = cell.textmesaj.frame;
                    framedorititext.origin.x=35;
                    framedorititext.origin.y = NECESARHeightIMAGINE+30;
                    framedorititext.size.width =NECESARHeightIMAGINE;
                    SPECIALTEXTMESAJ.frame =framedorititext;
                    SPECIALTEXTMESAJ.font = cell.textmesaj.font;
                    SPECIALTEXTMESAJ.textColor= cell.textmesaj.textColor;
                    SPECIALTEXTMESAJ.numberOfLines =0;
                    
                    [SPECIALTEXTMESAJ sizeToFit];
                    [cell.contentView addSubview:SPECIALTEXTMESAJ];
                    [cell.contentView bringSubviewToFront:SPECIALTEXTMESAJ];
                    NSLog(@"My view frame: %@", NSStringFromCGRect(SPECIALTEXTMESAJ.frame));
                } else {
                    cell.textmesaj.hidden=NO;
                    [cell.contentView bringSubviewToFront:cell.textmesaj];
                    
                }
                //  cell.fundalmesaj.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0); //flip orizontal
                
            } break;
            default:
                break;
        }
        
    //}
    
    /////// ULTIMULRANDBUTOANE
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(void)mergilapoze{
    if(pozetemporare.count>0) {
        NSLog(@"pozetemporare %@", pozetemporare);
        //
        /*
         pozetemporare (
         {
         original = "http://dev5.activesoft.ro/~csaba/4tilance/attachment.php?id=e4fd70d2944ea691dcaa8e4e1dcb3aa1";
         tb = "http://dev5.activesoft.ro/~csaba/4tilance/attachment.php?id=e4fd70d2944ea691dcaa8e4e1dcb3aa1&cmd=thumb&w=300&h=300";
         },
         {
         original = "http://dev5.activesoft.ro/~csaba/4tilance/attachment.php?id=65ccc5c7c12c46ad7c0f3717a8faa9a2";
         tb = "http://dev5.activesoft.ro/~csaba/4tilance/attachment.php?id=65ccc5c7c12c46ad7c0f3717a8faa9a2&cmd=thumb&w=300&h=300";
         }
         )
         */
        self.pozeprocesate =[[NSMutableArray alloc]init];
        
        for(int i=0;i<pozetemporare.count;i++) {
            NSDictionary *pozamea = [NSDictionary dictionaryWithDictionary:[pozetemporare objectAtIndex:i]];
            if(pozamea[@"original"]) {
                [self addhud];
                NSString *stringurlthumbnail = [NSString stringWithFormat:@"%@", pozamea[@"original"]];
                UIImage *IHAVEIMAGE = [[UIImage alloc]init];
                IHAVEIMAGE = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: stringurlthumbnail]]];
                if(IHAVEIMAGE && IHAVEIMAGE.size.height >0) {
                    if(![self.pozeprocesate containsObject:IHAVEIMAGE]) {
                        [self.pozeprocesate addObject:IHAVEIMAGE];
                        [self removehud];
                    }
                }
            }
        }
        //just in case something goes wrong
        [self removehud];
        NSLog(@"self.pozeprocesate %@",self.pozeprocesate);
        Galerieslide *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"GalerieslideVC"];
        vc.imagini =[[NSArray alloc]init];
        vc.imagini = self.pozeprocesate;
        [self.navigationController pushViewController:vc animated:NO ];
        
    }
    
    
}
-(void)verificaPERMISIIDOI {
    //see
    [self addhud];
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")){
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusAuthorized) {
            // Access has been granted.
            dispatch_async(dispatch_get_main_queue(), ^{
                //Your main thread code goes in here
                NSLog(@"Im on the main thread");
                if(pozele.count >0) {
                    //tabel poze mesaj
                    TabelPozeMesajeVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TabelPozeMesajeVC"];
                    [self.navigationController pushViewController:vc animated:NO ];
                } else {
                    NSLog(@"mergi la fa poze mesaj");
                    pozemesajeviewVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"pozemesajeVC"];
                    [self.navigationController pushViewController:vc animated:NO ];
                }
            });
        }
        else if (status == PHAuthorizationStatusDenied) {
            // Access has been denied.
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                message:@"Verificați setările aplicației și permiteți utilizarea camerei și a galeriei foto"
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
        else if (status == PHAuthorizationStatusNotDetermined) {
            // Access has not been determined.
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) {
                    // Access has been granted.
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //Your main thread code goes in here
                        NSLog(@"Im on the main thread");
                        if(pozele.count >0) {
                            //tabel poze mesaj
                            TabelPozeMesajeVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TabelPozeMesajeVC"];
                            [self.navigationController pushViewController:vc animated:NO ];
                        } else {
                            NSLog(@"mergi la fa poze mesaj");
                            pozemesajeviewVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"pozemesajeVC"];
                            [self.navigationController pushViewController:vc animated:NO ];
                        }
                    });
                }
                else {
                    // Access has been denied.
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                        message:@"Verificați setările aplicației și permiteți utilizarea camerei și a galeriei foto"
                                                                       delegate:nil
                                                              cancelButtonTitle:@"Ok"
                                                              otherButtonTitles:nil];
                    [alertView show];
                }
            }];
        }
        
        else if (status == PHAuthorizationStatusRestricted) {
            // Restricted access - normally won't happen.
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                message:@"Verificați setările aplicației și permiteți utilizarea camerei și a galeriei foto"
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
    } else {
        // sub iOS8
        
        ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
        NSLog(@"status auth %ld",(long)status);
        
        if (status == AVAuthorizationStatusAuthorized || status == AVAuthorizationStatusNotDetermined) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //Your main thread code goes in here
                NSLog(@"Im on the main thread");
                
                if(pozele.count >0) {
                    //tabel poze mesaj
                    TabelPozeMesajeVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TabelPozeMesajeVC"];
                    [self.navigationController pushViewController:vc animated:NO ];
                } else {
                    NSLog(@"mergi la fa poze mesaj");
                    pozemesajeviewVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"pozemesajeVC"];
                    [self.navigationController pushViewController:vc animated:NO ];
                }
            });
        }
        
        if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                message:@"Verificați setările aplicației și permiteți utilizarea camerei și a galeriei foto"
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
    }
    
}
-(void)MERGILAECRANGALERIE{
    
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")){
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
          if (status == PHAuthorizationStatusAuthorized) {
            // Access has been granted.
            dispatch_async(dispatch_get_main_queue(), ^{
                //Your main thread code goes in here
                [self verificaPERMISIIDOI];
            });
            
        }
        
        else if (status == PHAuthorizationStatusDenied) {
            // Access has been denied.
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                message:@"Verificați setările aplicației și permiteți utilizarea camerei și a galeriei foto"
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
        
        else if (status == PHAuthorizationStatusNotDetermined) {
            
            // Access has not been determined.
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                
                if (status == PHAuthorizationStatusAuthorized) {
                    // Access has been granted.
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self verificaPERMISIIDOI];
                    });
                }
                
                
                else {
                    // Access has been denied.
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                        message:@"Verificați setările aplicației și permiteți utilizarea camerei și a galeriei foto"
                                                                       delegate:nil
                                                              cancelButtonTitle:@"Ok"
                                                              otherButtonTitles:nil];
                    [alertView show];
                }
            }];
        }
        
        else if (status == PHAuthorizationStatusRestricted) {
            // Restricted access - normally won't happen.
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                message:@"Verificați setările aplicației și permiteți utilizarea camerei și a galeriei foto"
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
        
        
    } else {
        // sub iOS8
        
        ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
        NSLog(@"status auth %ld",(long)status);
        
        if (status == AVAuthorizationStatusAuthorized || status == AVAuthorizationStatusNotDetermined) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //Your main thread code goes in here
                NSLog(@"Im on the main thread");
                
                if(pozele.count >0) {
                    //tabel poze mesaj
                    TabelPozeMesajeVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TabelPozeMesajeVC"];
                    [self.navigationController pushViewController:vc animated:NO ];
                } else {
                    NSLog(@"mergi la fa poze mesaj");
                    pozemesajeviewVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"pozemesajeVC"];
                    [self.navigationController pushViewController:vc animated:NO ];
                }

            });
        }
        
        if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                message:@"Verificați setările aplicației și permiteți utilizarea camerei și a galeriei foto"
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
    }
    
}
-(IBAction)fapozaaction:(id)sender {
  [self  MERGILAECRANGALERIE]; //pentru ca pe iOS9 alerta de permisii face return imediat am facut o a doua verificare
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"indexpath row sel %i %i",(int)indexPath.section, (int)indexPath.row);
    NSInteger sectiune = indexPath.section;
    NSInteger randselectat = indexPath.row;
    if(sectiune ==0 ) {
        NSDictionary *CORPEXPANDABIL = [NSDictionary dictionaryWithDictionary:MESAJEFULL];
        NSMutableArray *RANDURI = [[NSMutableArray alloc]init];
        if( CORPEXPANDABIL[@"SubItems"])  {
            RANDURI=CORPEXPANDABIL[@"SubItems"];
            ////  NSLog(@"randuri speciale %@", RANDURI);
            NSInteger totalRow = RANDURI.count;
//            if(randselectat ==totalRow-1) {
//                [self trimitemesaj];
//            } else {
//                NSLog(@"no action 1");
//                
//            }
        }
    } else {
        NSLog(@"no action 0");
    }
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



-(void)viewWillLayoutSubviews{
}

-(BOOL)MyStringisEmpty:(NSString *)str
{
    if(str.length==0 || [str isKindOfClass:[NSNull class]] || [str isEqualToString:@""]||[str  isEqualToString:@"NULL"]||[str isEqualToString:@"(null)"]|| [str isEqualToString:@"<null>"] || [str isEqualToString:@"null"] ||str==nil){
        return YES;
    }
    return NO;
}

-(bool)checkDictionary:(NSDictionary *)dict{
    if(dict == nil || [dict class] == [NSNull class] || ![dict isKindOfClass:[NSDictionary class]]){
        return NO;
    }
    return  YES;
}


-(void)trimitemesaj{
    NSLog(@"verifica mesaj");
    
    BOOL ok=NO;
    NSString *textmesajdetrimis =@"";

            ///     [tf resignFirstResponder];
            if( ![self MyStringisEmpty:[NSString stringWithFormat:@"%@",self.compuneTextView.text]] || ![self.compuneTextView.text isEqualToString:@"Mesaj către vânzător"]) {
                textmesajdetrimis =[NSString stringWithFormat:@"%@",self.compuneTextView.text];
                ok=YES;
            }
    

    if(ok ==YES) {
        NSMutableDictionary *DICTIONAR_MESAJ_ADD = [[NSMutableDictionary alloc]init];
        NSString *replyid =@"";
        replyid =  lastmessageid;
        [DICTIONAR_MESAJ_ADD setObject:replyid forKey:@"replyid"];
        [DICTIONAR_MESAJ_ADD setObject:textmesajdetrimis forKey:@"message"];
        utilitar = [[Utile alloc]init];
        NSString *authtoken=@"";
        BOOL elogat = NO;
        elogat = [utilitar eLogat];
        if(elogat) {
            authtoken = [utilitar AUTHTOKEN];
            NSMutableArray *images= [[NSMutableArray alloc]init];
            images = self.pozele;
            AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            if(del.ARRAYASSETURIMESAJ.count >0) {
                images = del.ARRAYASSETURIMESAJ;
            }
            del.amscrismesajboss = YES;
            NSLog(@"poze ver %@",pozele );
            [self comment_add:DICTIONAR_MESAJ_ADD :images :authtoken];
        }
        
        
        
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                            message:@"Completați mesajul"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
    
}
/*
 "comment_add"
 PARAMETRII:
 - validate_only: dry-run daca este thruthy (la fel ca la cerere_add)
 - cerere_id SAU replyid
 - message: continut comentariu
 replyid tb. sa fie ultimul id de comentariu intr-o discutie care nu a fost postat de user-ul logat
 ...sau replyid este id-ul ofertei, oferta fiind un caz particular de comentariu (cererea ofertei tb. sa apartina user-ului logat)
 fisierele uploadate prin post multipart/form-data sunt adaugete la comentariu (optional) la fel ca la cerere_add
 in cazul in care nu sunt trimise poze, "comment_add" poate fi apelat direct fara dry-run (la fel ca la cerere_add)
 am adaugat comment_max_images=8 la metoda "init"
 */
//////METODA_COMMENT_ADD jjjj cerere_id
-(BOOL)sendMesajcuPOZE:DICTIONAR_CERERE_ADD :(NSMutableArray*) POZEMESAJ :(NSString*)AUTHTOKEN {
    __block BOOL ATRIMIS = NO;
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
            [MBProgressHUD hideAllHUDsForView:self.navigationController.visibleViewController.view animated:YES];
            
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
        NSString *currentSysVer = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] systemVersion]];
        dic2= DICTIONAR_CERERE_ADD;
        [dic2 setObject:@"iOS" forKey:@"os"];
        [dic2 setObject:currentSysVer forKey:@"version"]; //  vers iOS
        [dic2 setObject:@"ro" forKey:@"lang"];
        [dic2 setObject:AUTHTOKEN forKey:@"authtoken"];
        
        NSMutableArray *images=[[NSMutableArray alloc]init];
        NSMutableArray *idspoze=[[NSMutableArray alloc]init]; //iduri poze la repostare
        
        for(int i=0;i<POZEMESAJ.count;i++) {
            if( [[POZEMESAJ objectAtIndex:i]isKindOfClass:[NSDictionary class]] && [[POZEMESAJ objectAtIndex:i]respondsToSelector:@selector(allKeys)]) {
                NSDictionary *pozeexistente = [POZEMESAJ objectAtIndex:i];
                if(pozeexistente[@"id"]) {
                    NSString *idpozaexistenta = [NSString stringWithFormat:@"%@", pozeexistente[@"id"]];
                    [idspoze addObject:idpozaexistenta];
                }
            }
        }
        for(int i=0;i<POZEMESAJ.count;i++) {
            if( [[POZEMESAJ objectAtIndex:i]isKindOfClass:[UIImage class]]) {
                UIImage *POZANOUA = [POZEMESAJ objectAtIndex:i];
                [images addObject:POZANOUA];
            }
        }
        
        NSLog(@"pozele  mesaj %@", images);
        ///no need for ids
        if(idspoze.count>0) {
            [dic2 setValue:idspoze forKey:@"image_ids"];
        }
        [dic2 setValue:@"0" forKey:@"validate_only"];
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic2 options:0 error:&err];
        NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        compus =[NSString stringWithFormat:@"%@", myString];
        
        NSString *lineEnd=@"\r\n";
        NSString *twoHyphens=@"--";
        NSString *boundary=@"*****";
        NSMutableData *postBody = [NSMutableData data];
        
        NSLog(@"DICTIONAR CERERE %@",dic2);
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://%@",base_url]]];
        [request setHTTPMethod:@"POST"];
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
        
        [postBody appendData:[[NSString stringWithFormat:@"%@%@%@", twoHyphens,boundary,lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"m\"%@",  lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@",  lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"comment_add"] dataUsingEncoding:NSUTF8StringEncoding]]; //metoda e comment_add
        [postBody appendData:[[NSString stringWithFormat:@"%@",  lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@%@%@", twoHyphens,boundary,lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [postBody appendData:[[NSString stringWithFormat:@"%@%@%@", twoHyphens,boundary,lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"p\"%@",  lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@",  lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[compus dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@",  lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@%@%@", twoHyphens,boundary,lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
        
        //images
        for(int i=0; i<images.count; i++) {
            long NUMEFISIERTIMESTAMP = (long)NSDate.date.timeIntervalSince1970;
            NSString *userfile = [NSString stringWithFormat:@"%lu.jpg",NUMEFISIERTIMESTAMP];
            UIImage *eachImage  = [images objectAtIndex:i];
            NSData *imageData = UIImageJPEGRepresentation(eachImage,0.8);
            if(imageData ) {
                [postBody appendData:[[NSString stringWithFormat:@"%@%@%@", twoHyphens,boundary,lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
                [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"images[%i]\"; filename=\"%@\"%@",i,userfile, lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
                [postBody appendData:[[NSString stringWithFormat:@"Content-Type: image/jpeg%@",lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
                [postBody appendData:[[NSString stringWithFormat:@"Content-Transfer-Encoding: binary%@",lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
                [postBody appendData:[[NSString stringWithFormat:@"%@",  lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
                [postBody appendData:[NSData dataWithData:imageData]];
                [postBody appendData:[[NSString stringWithFormat:@"%@",  lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
                [postBody appendData:[[NSString stringWithFormat:@"%@%@%@", twoHyphens,boundary,lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
                
            } else {
                NSLog(@"no image");
            }
        }
        
        //last line close bound.
        [postBody appendData:[[NSString stringWithFormat:@"%@%@%@", twoHyphens,boundary,lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"postBody=%@", [[NSString alloc] initWithData:postBody encoding:NSASCIIStringEncoding]);
        
        [request setHTTPBody:postBody];
        NSLog(@"my strin %@", compus);
        AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        op.securityPolicy = [self customSecurityPolicy];
       // op.responseSerializer = [AFJSONResponseSerializer serializer];
        [self addhud];
        
        [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSMutableDictionary *DictionarErori= [[NSMutableDictionary alloc]init];
            NSError *error = nil;
            id jsonArray = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
            
            if (error != nil) {
                NSLog(@"Error parsing JSON.");
                [self removehud];
            }
            else {
                NSLog(@"Array: %@", jsonArray);
                NSDictionary *REZULTAT_CERERE_ADD = jsonArray;
                if(REZULTAT_CERERE_ADD[@"errors"]) {
                    [self removehud];
                    NSMutableArray *erori = [[NSMutableArray alloc]init];
                    if(REZULTAT_CERERE_ADD[@"errors"]) {
                        DictionarErori = REZULTAT_CERERE_ADD[@"errors"];
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
                    }   else  if(  REZULTAT_CERERE_ADD[@"data"]) {
                        [self removehud];
                        NSDictionary *multedate = REZULTAT_CERERE_ADD[@"data"];
                        NSLog(@"date ADD MESAJ %@",multedate);
                        AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                        pozele = [[NSMutableArray alloc]init];
                        del.POZEMESAJ = [[NSMutableArray alloc]init];
                        del.ARRAYASSETURIMESAJ = [[NSMutableArray alloc]init];
                        del.TEXTMESAJTEMPORAR=@"Mesaj către vânzător";
                        self.compuneTextView.text = @"Mesaj către vânzător";
                        self.compuneTextView.textColor = [UIColor lightGrayColor];
                        [self.compuneTextView resignFirstResponder];
                         [self.faPozaImageView setImage:[UIImage imageNamed:@"Icon_Camera_LightGrey_144x144.png"]];
//                        NSArray *cells = [self.LISTASELECT visibleCells];
//                        for(UIView *view in cells){
//                            if([view isMemberOfClass:[CellDetaliuMesaj class]]){
//                                CellDetaliuMesaj *cell = (CellDetaliuMesaj *) view;
//                                UITextView *tf = (UITextView *)[cell compunetextmesaj];
//                                [tf resignFirstResponder];
//                                //  [self.LISTASELECT reloadData];
//                                /////JJJJJJ
//                            }
//                        }
                        [self get_comments : [NSString stringWithFormat:@"%@",IDCERERE] :@"cerereid" :AUTHTOKEN];
                        
                    }

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
            AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            pozele = [[NSMutableArray alloc]init];
            del.POZEMESAJ = [[NSMutableArray alloc]init];
            del.ARRAYASSETURIMESAJ = [[NSMutableArray alloc]init];
            del.TEXTMESAJTEMPORAR=@"Mesaj către vânzător";
            NSArray *cells = [self.LISTASELECT visibleCells];
            for(UIView *view in cells){
                if([view isMemberOfClass:[CellDetaliuMesaj class]]){
                    CellDetaliuMesaj *cell = (CellDetaliuMesaj *) view;
                    UITextView *tf = (UITextView *)[cell compunetextmesaj];
                    [tf resignFirstResponder];
                    //  [self.LISTASELECT reloadData];
                    /////JJJJJJ
                }
            }
            
            [self get_comments : [NSString stringWithFormat:@"%@",IDCERERE] :@"cerereid" :AUTHTOKEN];
        }];
        [self removehud];
        
        [[NSOperationQueue mainQueue] addOperation:op];
    }
    return ATRIMIS;
    
    
}

//jjjj cerere_id
-(BOOL)comment_add :(NSMutableDictionary *) DICTIONAR_MESAJ_ADD :(NSMutableArray*) POZEMESAJ :(NSString*)AUTHTOKEN {
    __block BOOL ATRIMIS = NO;
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
            [MBProgressHUD hideAllHUDsForView:self.navigationController.visibleViewController.view animated:YES];
            
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
        NSString *currentSysVer = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] systemVersion]];
        dic2= DICTIONAR_MESAJ_ADD;
        [dic2 setObject:@"iOS" forKey:@"os"];
        [dic2 setObject:currentSysVer forKey:@"version"]; //  vers iOS
        [dic2 setObject:@"ro" forKey:@"lang"];
        [dic2 setObject:AUTHTOKEN forKey:@"authtoken"];
        if(DICTIONAR_MESAJ_ADD[@"replyid"]) {
            NSString *oldcerereid = [NSString stringWithFormat:@"%@",DICTIONAR_MESAJ_ADD[@"replyid"]];
            [dic2 setValue:oldcerereid forKey:@"replyid"];
        }
        if(DICTIONAR_MESAJ_ADD[@"message"]) {
            NSString *message = [NSString stringWithFormat:@"%@",DICTIONAR_MESAJ_ADD[@"message"]];
            [dic2 setValue:message forKey:@"message"];
        }
        NSMutableArray *images=[[NSMutableArray alloc]init];
        images = pozele;
        //FOR IMAGES just end empty
        
        /*
         Metoda "cerere_add" are un parametru nou "validate_only" (0 sau 1) pt. dry run.
         Daca user-ul nu are poze, aplicatia poate sa trimita "cerere_add" cu validate_only = 0
         Daca are poze, trimite "cerere_add" fara poze cu validate_only = 1 dupa care, daca nu sunt "errors", trimite "cerere_add" cu "images[]" (multipart/form-data) si cu validate_only = 0
         am modificat, cerere_add returneaza:
         "images": [
         { "original":"http://...", "tb": "http://..." },
         ...
         ]
         */
        if(images.count>0) {
            // validate_only"
            [dic2 setValue:@"1" forKey:@"validate_only"];
        } else {
            [dic2 setValue:@"0" forKey:@"validate_only"];
        }
        NSLog(@"DICTIONAR CERERE %@",dic2);
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic2 options:0 error:&err];
        NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        compus =[NSString stringWithFormat:@"%@%@",METODA_COMMENT_ADD, myString];
        
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
            NSMutableDictionary *DictionarErori= [[NSMutableDictionary alloc]init];
            NSDictionary *REZULTAT_MESAJ_ADD = responseObject;
            if(REZULTAT_MESAJ_ADD[@"errors"]) {
                NSMutableArray *erori = [[NSMutableArray alloc]init];
                if(REZULTAT_MESAJ_ADD[@"errors"]) {
                    [self removehud];
                    DictionarErori = REZULTAT_MESAJ_ADD[@"errors"];
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
                }   else  if(  REZULTAT_MESAJ_ADD[@"data"]) {
                    [self removehud];
                    NSDictionary *multedate = REZULTAT_MESAJ_ADD[@"data"];
                    NSLog(@"date mesaj raspuns %@",multedate);
                    if(images.count>0) {
                        [self  sendMesajcuPOZE:dic2 :images :AUTHTOKEN];
                        
                    } else {
                        [self removehud];
                        NSLog(@"gata si mesaj fara poze jjjj");
                        AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                        pozele = [[NSMutableArray alloc]init];
                        del.POZEMESAJ = [[NSMutableArray alloc]init];
                        del.ARRAYASSETURIMESAJ = [[NSMutableArray alloc]init];
                        del.TEXTMESAJTEMPORAR=@"Mesaj către vânzător";
//                        NSArray *cells = [self.LISTASELECT visibleCells];
//                        for(UIView *view in cells){
//                            if([view isMemberOfClass:[CellDetaliuMesaj class]]){
//                                CellDetaliuMesaj *cell = (CellDetaliuMesaj *) view;
//                                UITextView *tf = (UITextView *)[cell compunetextmesaj];
//                                [tf resignFirstResponder];
//                                //  [self.LISTASELECT reloadData];
//                                /////JJJJJJ
//                            }
//                        }
                        self.compuneTextView.text = @"Mesaj către vânzător";
                        self.compuneTextView.textColor = [UIColor lightGrayColor];
                        [self.compuneTextView resignFirstResponder];
//                        long noofrows = [self.LISTASELECT numberOfRowsInSection:0];
//                        NSIndexPath * lastIndexPath = [NSIndexPath indexPathForRow:noofrows inSection:0];
//                        [self.LISTASELECT scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                        
                        [self get_comments : [NSString stringWithFormat:@"%@",IDCERERE] :@"cerereid" :AUTHTOKEN];
                        //// [self.LISTASELECT reloadData];
                    }
                    ATRIMIS =YES;
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
            //JJJ cerere_id
            AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            pozele = [[NSMutableArray alloc]init];
            del.POZEMESAJ = [[NSMutableArray alloc]init];
            del.ARRAYASSETURIMESAJ = [[NSMutableArray alloc]init];
            del.TEXTMESAJTEMPORAR=@"Mesaj către vânzător";
            NSArray *cells = [self.LISTASELECT visibleCells];
            for(UIView *view in cells){
                if([view isMemberOfClass:[CellDetaliuMesaj class]]){
                    CellDetaliuMesaj *cell = (CellDetaliuMesaj *) view;
                    UITextView *tf = (UITextView *)[cell compunetextmesaj];
                    [tf resignFirstResponder];
                    //  [self.LISTASELECT reloadData];
                    /////JJJJJJ
                }
            }
            
            [self get_comments : [NSString stringWithFormat:@"%@",IDCERERE] :@"cerereid" :AUTHTOKEN];
        }];
        [[NSOperationQueue mainQueue] addOperation:op];
    }
    return ATRIMIS;
}

-(void)get_comments :(NSString*)CERERESAUOFERTAID :(NSString*)TIP :(NSString*)authtoken {
    // __block  NSMutableDictionary *comentarii = [[NSMutableDictionary alloc]init];
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
        [dic2 setObject:authtoken forKey:@"authtoken"];
        
        if([TIP isEqualToString:@"cerereid"]) {
            [dic2 setObject:CERERESAUOFERTAID forKey:@"cerere_id"];
        } else  if([TIP isEqualToString:@"ofertaid"]) {
            [dic2 setObject:CERERESAUOFERTAID forKey:@"offer_id"];
        }
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic2 options:0 error:&err];
        NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        compus =[NSString stringWithFormat:@"%@%@",METODA_GET_COMMENTS, myString];
        
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
            NSLog(@"rezultat coment : %@", REZULTAT_NOTIFY_COUNT);
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
                    eroare=    [erori componentsJoinedByString:@" "];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                        message:eroare
                                                                       delegate:nil
                                                              cancelButtonTitle:@"Ok"
                                                              otherButtonTitles:nil];
                    [alertView show];
                }   else  if(  REZULTAT_NOTIFY_COUNT[@"data"]) {
                    NSMutableDictionary *multedate = [NSMutableDictionary dictionaryWithDictionary:REZULTAT_NOTIFY_COUNT[@"data"]];
                    [self removehud];
                    NSLog(@"date comentarii %@",multedate);
                    if([TIP isEqualToString:@"cerereid"]) {
                        [self REFRESH_MESAJE:multedate :@"cerereid"];
                    } else  if([TIP isEqualToString:@"ofertaid"]) {
                        [self REFRESH_MESAJE:multedate :@"ofertaid"];
                    }
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
    [self removehud];
}
-(void)reloadALLMESSAGES :(NSArray *) ariegasita {
    NSMutableArray *MESAJEREXP = [[NSMutableArray alloc]init];
    NSMutableArray *MESAJELEALTORA = [[NSMutableArray alloc]init];
    
    NSMutableArray *itemuriexpandabile =[[NSMutableArray alloc]init];
    itemuriexpandabile = [NSMutableArray arrayWithArray: ariegasita];
    NSLog(@"itemuriexpandabile last %@",itemuriexpandabile);
    if( itemuriexpandabile.count>0) {
        //acum parcurge aria si  stabileste lastmessageid
        for(int i=0;i< itemuriexpandabile.count;i++) {
            NSDictionary *dictmesaj = [itemuriexpandabile objectAtIndex:i];
            NSMutableDictionary *perfectsense =[NSMutableDictionary dictionaryWithDictionary:dictmesaj];
            if(dictmesaj[@"is_myself"]) {
                NSString *eusender =[NSString stringWithFormat:@"%@",dictmesaj[@"is_myself"]];
                NSInteger z=[eusender integerValue];
                if(z==0) {
                    //ADD IN ARRAY
                    [MESAJELEALTORA addObject:dictmesaj];
                }
            }
            if(dictmesaj[@"images"]) {
                NSArray *imagini = [NSArray arrayWithArray:dictmesaj[@"images"]];
                if(imagini.count >0) {
                    NSDictionary *imagine = [imagini objectAtIndex:0];
                    if(imagine[@"tb"]) {
                        
                        UIImage *IHAVEIMAGE = [[UIImage alloc]init];
                        NSString *stringurlthumbnail = [NSString stringWithFormat:@"%@", imagine[@"tb"]];
                        
                        IHAVEIMAGE = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: stringurlthumbnail]]];
                        NSLog(@"i have image size height : %f",IHAVEIMAGE.size.height);
                        if(IHAVEIMAGE && IHAVEIMAGE.size.height >0) {
                            [perfectsense setObject:IHAVEIMAGE forKey:@"imaginea0"];
                            [itemuriexpandabile replaceObjectAtIndex:i withObject:perfectsense];
                            
                        }
                    }
                }
            }
        }
    }
    //ATENTIE ! aici se insereaza intotdeauna 2 randuri goale text mesaj + buton de trimite mesaj
  
    //vasile
    // NSDictionary *trimitemesaj =@{@"special" : @"1"};
  //  NSDictionary *trimitemesajaltul =@{@"specialrand" : @"2"};
//    [itemuriexpandabile addObject:trimitemesaj];
//    [itemuriexpandabile addObject:trimitemesajaltul];
    //end vasile
    
    NSMutableDictionary *CORPEXPANDABIL = [[NSMutableDictionary alloc]init];
    [CORPEXPANDABIL setObject:itemuriexpandabile forKey:@"SubItems"];
    MESAJEFULL = [[NSMutableDictionary alloc]init];
    MESAJEFULL =CORPEXPANDABIL;
    MESAJEREXP =[NSMutableArray arrayWithArray:[NSArray arrayWithObjects:CORPEXPANDABIL, nil]];
    NSLog(@"MESAJEFULL xx %@",MESAJEFULL);
    
    NSLog(@"MESAJELEALTORA zzzzzzz %@",MESAJELEALTORA);
    if(MESAJELEALTORA.count >0) {
        NSDictionary *ULTIMULMESAJDELAALTII = [NSDictionary dictionaryWithDictionary:[MESAJELEALTORA lastObject]];
        if(ULTIMULMESAJDELAALTII[@"messageid"]) {
            NSString *lastmesajid =[NSString stringWithFormat:@"%@",ULTIMULMESAJDELAALTII[@"messageid"]];
            lastmessageid =lastmesajid;
        }
    }
    
    [self.LISTASELECT reloadData];
    
//    long noofrows = [self.LISTASELECT numberOfRowsInSection:0];
//    NSIndexPath * lastIndexPath = [NSIndexPath indexPathForRow:noofrows-1 inSection:0];
//    [self.LISTASELECT scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
   // [self scrollToBottom];
    
}
-(void)REFRESH_MESAJE :(NSMutableDictionary *) comentarii :(NSString *)tip {
    
    NSLog(@"comen %@",comentarii);
    
    NSArray *toatemesajele =[[NSArray alloc]init];
    if(comentarii[@"discussions"]) {
        toatemesajele =comentarii[@"discussions"];
        for(int i=0;i< toatemesajele.count;i++) {
            NSArray *deprelucrat = [toatemesajele objectAtIndex:i];
            if([deprelucrat containsObject:PRIMULMESAJ]) {
                NSLog(@"am gasit array mare %@", deprelucrat);
                [self reloadALLMESSAGES:deprelucrat];
                break;
            }
        }
    }
}


@end
