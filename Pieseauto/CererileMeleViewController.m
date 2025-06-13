//
//  ContulMeuViewController.m
//  Pieseauto
//
//  Created by Ioan Ungureanu on 31/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//
#import "utile.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"
#import "CererileMeleViewController.h"
#import "CellListaCereriRow.h"
#import "TutorialHomeViewController.h"
#import <CoreText/CoreText.h>
#import "SetariViewController.h"
#import "OferteLaCerereViewController.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "CereriAnulateViewController.h"
#import "butoncustomback.h"
#import "ListaMasiniUserViewController.h"
#import "CererileMeleViewController.h"
#import "choseLoginview.h"
#import "ContulMeuViewController.h"
#import "CerereExistentaViewController.h"

static NSString *PE_PAGINA = @"20";
@interface CererileMeleViewController(){
    NSMutableArray* Cells_Array;
}
@end

@implementation CererileMeleViewController
@synthesize  LISTASELECT,SEGCNTRL,CERERIACTIVE,REZOLVATE,_currentPage,_currentPageRezolvate,numarpagini,numarpaginirezolvate,totalcererianulate,ANULATE,_currentPageAnulate,numarpaginianulate,MOMENTANNUSUNTCERERI,barajos,REINCARCALISTA;

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
    titlubuton.text=@"Home";
    [backcustombutton addSubview:titlubuton];
    [backcustombutton setShowsTouchWhenHighlighted:NO];
    [backcustombutton bringSubviewToFront:btnimg];
    return backcustombutton;
}
-(void)addhud{
    [MBProgressHUD showHUDAddedTo:self.navigationController.visibleViewController.view animated:YES];
}
-(void)removehud{
    [MBProgressHUD hideAllHUDsForView:self.navigationController.visibleViewController.view animated:YES];
}

-(void)perfecttimeforback{
    //[self.navigationController popViewControllerAnimated:NO];
    utilitar=[[Utile alloc] init];
    [utilitar mergiLaMainViewVC];
}
-(void)madeinit {
    _currentPageRezolvate =1;
    _currentPage = 1;
    _currentPageAnulate = 1;
    
    NSString *paginacurentastring =[NSString stringWithFormat:@"%i", _currentPage];
    NSString *paginacurentarezolvatestring =[NSString stringWithFormat:@"%i", _currentPageRezolvate];
    NSString *paginacurentaanulatestring =[NSString stringWithFormat:@"%i", _currentPageAnulate];
    utilitar = [[Utile alloc]init];
    NSString *authtoken=@"";
    BOOL elogat = NO;
    CERERIACTIVE= [[NSMutableArray alloc]init];
    REZOLVATE= [[NSMutableArray alloc]init];
    ANULATE= [[NSMutableArray alloc]init];
    elogat = [utilitar eLogat];
    if(elogat) {
        authtoken = [utilitar AUTHTOKEN];
        [self list_cereri:authtoken :paginacurentastring :PE_PAGINA :@"active"];
        [self list_cereri:authtoken :paginacurentarezolvatestring :PE_PAGINA :@"solved"];
        [self list_cereri:authtoken :paginacurentaanulatestring :PE_PAGINA :@"cancelled"];
    }
    

}
-(void)viewWillAppear:(BOOL)animated {
    
     self.title = @"Cererile mele";
    [self.navigationController setNavigationBarHidden:NO]; self.navigationItem.leftBarButtonItem=nil;
    
    self.navigationController.navigationItem.hidesBackButton = YES;
    //clean other left
    for(UIButton *view in  self.navigationController.navigationBar.subviews) {
        if([view isKindOfClass:[butoncustomback class]]){
            [view removeFromSuperview];
        }
    }
    if( REINCARCALISTA ==YES) {
        REINCARCALISTA =NO;
        [self madeinit];
    }
    //add new left
    UIButton *ceva = [self backbtncustom];
    [ceva addTarget:self action:@selector(perfecttimeforback) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *inapoibtn =[[UIBarButtonItem alloc] initWithCustomView:ceva];
    self.navigationItem.leftBarButtonItem = inapoibtn;

    MOMENTANNUSUNTCERERI.hidden=YES;
    
   
    [SEGCNTRL addTarget:self action:@selector(schimbaSegment) forControlEvents:UIControlEventValueChanged];
    [self barajosmadeit];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    REINCARCALISTA =NO;
  //  MOMENTANNUSUNTCERERI.hidden=YES;

    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    NSLog(@"cererile mele si pagina %i si pag rezolvate %i", _currentPage,_currentPageRezolvate);
    LISTASELECT.delegate =self;
    LISTASELECT.dataSource =self;
    LISTASELECT.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self madeinit];
    // self.navigationController.navigationBar.clipsToBounds = YES;
    
    // Do any additional setup after loading the view, typically from a nib.
    
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
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    return manager;
}
-(void)doarupdatetabel {
    NSIndexSet *section =  [NSIndexSet indexSetWithIndex:0];
    [self.LISTASELECT beginUpdates];
    [self.LISTASELECT reloadSections:section withRowAnimation:UITableViewRowAnimationNone];
    [self.LISTASELECT endUpdates];
    
}
-(void)reloadsectiunea0 {
    if(self.SEGCNTRL.selectedSegmentIndex ==0 && self.CERERIACTIVE.count>0) {
        [self doarupdatetabel];
    } else {
        [self.LISTASELECT reloadData];
    }
    
   if(self.SEGCNTRL.selectedSegmentIndex ==1 && self.REZOLVATE.count>0) {
        [self doarupdatetabel];
    } else {
        [self.LISTASELECT reloadData];
    }
    
    
    
}

-(NSMutableArray*)update_list_cereri :(NSMutableArray *)get_list_cereri :(NSString *)status {
    [self removehud];
    NSMutableArray *lista_cereri = get_list_cereri;
    //active', 'solved' sau 'cancelled
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //   ARRAYCERERI_ACTIVE,ARRAYCERERI_REZOLVATE,ARRAYCERERI_ANULATE
    del.ARRAYCERERI_ACTIVE = [[NSMutableArray alloc]init]; //se goleste mereu la login si logout
    del.ARRAYCERERI_REZOLVATE =[[NSMutableArray alloc]init];
    del.ARRAYCERERI_ANULATE =[[NSMutableArray alloc]init];
   
    if([status isEqualToString:@"active"]) {
        for(NSDictionary *itemnou in lista_cereri) {
            if(![CERERIACTIVE containsObject:itemnou]) {
                [CERERIACTIVE addObject:itemnou];
            }
        }
        del.ARRAYCERERI_ACTIVE =  CERERIACTIVE;
         [self reloadsectiunea0];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.LISTASELECT reloadData];
//        });
        
        
        //  NSLog(@"ARRAYCERERI_ACTIVE %@",del.ARRAYCERERI_ACTIVE);
    }
    if([status isEqualToString:@"solved"]) {
        for(NSDictionary *itemnou in lista_cereri) {
            if(![REZOLVATE containsObject:itemnou]) {
                [REZOLVATE addObject:itemnou];
            }
        }
        del.ARRAYCERERI_REZOLVATE = REZOLVATE;
        [self reloadsectiunea0];
        //    NSLog(@"ARRAYCERERI_REZOLVATE %@",del.ARRAYCERERI_REZOLVATE);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.LISTASELECT reloadData];
//        });
    }
  
   
    //pt referinta nu e chemat am preferat sa-l duc la anulate direct
    if([status isEqualToString:@"cancelled"]) {
        for(NSDictionary *itemnou in lista_cereri) {
            if(![self.ANULATE containsObject:itemnou]) {
                [self.ANULATE addObject:itemnou];
            }
        }
        del.ARRAYCERERI_ANULATE = self.ANULATE;
        NSLog(@"anulate %@", self.ANULATE);
        [self reloadsectiunea0];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.LISTASELECT reloadData];
//        });
    }
  /*  dispatch_async(dispatch_get_main_queue(), ^{
        [self schimbaSegment];
    });*/

   
    [self removehud];
    //"feedback_needed_count":0,"unread_offers_count":0}}
    return lista_cereri;
}

-(void) mergi_la_oferte :(NSDictionary*) corpraspuns {
    NSLog(@"spiders %@",corpraspuns);
    [self removehud];
    NSMutableDictionary *DETALIICERERE = [NSMutableDictionary dictionaryWithDictionary:corpraspuns];
    [DETALIICERERE setObject:@"1" forKey:@"pagina_curenta_trimisa"];
    [DETALIICERERE setObject:@"0" forKey:@"pagina_curenta_preferate"];
    OferteLaCerereViewController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"OferteLaCerereVC"];
    vc.CORPDATE = DETALIICERERE;
    vc.E_DIN_DETALIU_CERERE =NO;
    [self.navigationController pushViewController:vc animated:NO];
}
/*
 echo 'm=list_offers&p={"per_page":"20","os":"iOS","lang":"ro","authtoken":"1248f7g57051f23gqf9ZSL2qTKiEbDmhgjYVLfFmbc8cm6UBR0ekyW-HP28","version":"9.0","page":"1","cerere_id":"342629","prefered_only":"0", "cerere_details":"1"}'  | curl --tlsv1 --cacert ./dev5.activesoft.crt --data @- -- https://dev5.activesoft.ro:277/
 
 echo 'm=cerere_autocomplete&p={"os":"iOS","lang":"ro","authtoken":"1248f7g57051f23gqf9ZSL2qTKiEbDmhgjYVLfFmbc8cm6UBR0ekyW-HP28","version":"9.0"}'  | curl --tlsv1 --cacert ./dev5.activesoft.crt --data @- -- https://dev5.activesoft.ro:277/
 
 
 echo 'm=cerere_cancel&p{"authtoken":"1248f7g5721f694g5fT1mW7btr9QI7QXHnoXwD2VdUQ5OKgkuR8zvWh7DjY","cerere_id":"342553","os":"android","lang":"ro","version":1}' | curl --tlsv1 --cacert ./dev5.activesoft.crt --data @- -- https://dev5.activesoft.ro:277/
 echo 'm=cerere_cancel&p{"authtoken":"1248f7g5721f694g5fT1mW7btr9QI7QXHnoXwD2VdUQ5OKgkuR8zvWh7DjY","cerere_id":"342553","os":"iOS","lang":"ro","version":"9.3.1"}' | curl --tlsv1 --cacert ./dev5.activesoft.crt --data @- -- https://dev5.activesoft.ro:277/
  {"errors":{},"data":{}}
 */

-(void) list_offers_per_cerere :(NSString *)AUTHTOKEN :(NSString *)PAGE :(NSString *)PER_PAGE :(NSString *)cerere_id :(NSString *)prefered_only :(NSString*)cerere_details :(NSString*) castigatoare{
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
        ///    [MBProgressHUD hideAllHUDsForView:self.navigationController.visibleViewController.view animated:YES];
 
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
    [dic2 setObject:@"iOS" forKey:@"os"];
    [dic2 setObject:currentSysVer forKey:@"version"];   //  vers iOS
    [dic2 setObject:@"ro" forKey:@"lang"];
    [dic2 setObject:AUTHTOKEN forKey:@"authtoken"];
             NSString *ecasgigatoaresaunu= castigatoare;
        if([ecasgigatoaresaunu isEqualToString:@"nu"]) {
              [dic2 setObject:PAGE forKey:@"page"];
              [dic2 setObject:PER_PAGE forKey:@"per_page"];
        } else {
            [dic2 setObject:@"1" forKey:@"page"];
            [dic2 setObject:@"1" forKey:@"per_page"];
        }
  
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
                [self removehud];
                DictionarErori = REZULTAT_NOTIFY_COUNT[@"errors"];
                for(id cheie in [DictionarErori allKeys]) {
                    NSLog(@"dds %@",[DictionarErori valueForKey:cheie]);
                    [erori addObject:[NSString stringWithFormat:@"%@",[DictionarErori valueForKey:cheie]]];
                }
            }
            NSLog(@"ERORS %@",erori);
            if(erori.count >0) {
                  [self removehud];
                eroare = [erori componentsJoinedByString:@" "];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                    message:eroare
                                                                   delegate:nil
                                                          cancelButtonTitle:@"Ok"
                                                          otherButtonTitles:nil];
                [alertView show];
            }   else  if(  REZULTAT_NOTIFY_COUNT[@"data"]) {
              
                if([ecasgigatoaresaunu isEqualToString:@"nu"]) {
                //{"errors":{},"data":{"items":[{"id":342551,"title":"Test","nr_offers":0,"nr_unread_offers":0},{"id":342550,"title":"Test","nr_offers":0,"nr_unread_offers":0},{"id":342549,"title":"Test","nr_offers":0,"nr_unread_offers":0}],"total_count":3}}
                NSDictionary *multedate = REZULTAT_NOTIFY_COUNT[@"data"];
                NSLog(@"date cerere raspuns %@",multedate);
                [self removehud];
                [self mergi_la_oferte:multedate];
                }
                if([ecasgigatoaresaunu isEqualToString:@"da"]) {
                    //{"errors":{},"data":{"items":[{"id":342551,"title":"Test","nr_offers":0,"nr_unread_offers":0},{"id":342550,"title":"Test","nr_offers":0,"nr_unread_offers":0},{"id":342549,"title":"Test","nr_offers":0,"nr_unread_offers":0}],"total_count":3}}
                    
                    NSMutableDictionary *multedate = REZULTAT_NOTIFY_COUNT[@"data"];
                    NSLog(@"date speciale cerere raspuns %@",multedate);
                    NSLog(@"vezi cerere");
                    CerereExistentaViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CerereExistentaViewVC"];
                    vc.intrebaridelaaltii = [[NSMutableDictionary alloc]init];
                    vc.intrebaridelaaltii = multedate[@"cerere"];
                    vc.CE_TIP_E=@"dinwinner";
                    
                    
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
                    if(multedate[@"cerere"]) {
                        CORP = multedate[@"cerere"];
                        if(CORP[@"title"])    TITLUCERERE = [NSString stringWithFormat:@"%@",CORP[@"title"]];
                        if(CORP[@"marca_id"]) PRODUCATORAUTODEF = [NSString stringWithFormat:@"%@",CORP[@"marca_id"]];
                        if(CORP[@"model_id"]) MARCAAUTODEF = [NSString stringWithFormat:@"%@",CORP[@"model_id"]];
                        if(CORP[@"talon_an_fabricatie"]) ANMASINA = [NSString stringWithFormat:@"%@",CORP[@"talon_an_fabricatie"]];
                        if(CORP[@"motorizare"]) MOTORIZARE = [NSString stringWithFormat:@"%@",CORP[@"motorizare"]];
                        if(CORP[@"talon_tip_varianta"]) VARIANTA=[NSString stringWithFormat:@"%@",CORP[@"talon_tip_varianta"]];
                        if(CORP[@"talon_nr_identificare"]) SERIESASIU = [NSString stringWithFormat:@"%@",CORP[@"talon_nr_identificare"]];
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
                        [cererepiesa setObject:cerere_id forKey:@"IDCERERE"];
                        [cererepiesa setObject:multedate forKey:@"CEREREFULLINFO"]; //avem nevoie si de corpul cererii
                        del.reposteazacerere =NO;
                        if(CORP[@"images"]) {
                            del.ARRAYASSETURI = [[NSMutableArray alloc]init];
                            del.ARRAYASSETURI = [NSMutableArray arrayWithArray:CORP[@"images"]];
                            NSLog(@"del.pozecer %@", del.ARRAYASSETURI);
                            del.POZECERERE = del.ARRAYASSETURI;
                        }
                        del.cererepiesa =cererepiesa;
                      [self.navigationController pushViewController:vc animated:YES ];
                     [self removehud];
                    }
                 
                }
            }
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
//                                                            message:[error localizedDescription]
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"Ok"
//                                                  otherButtonTitles:nil];
//        [alertView show];
        [self removehud];
        
    }];
    [[NSOperationQueue mainQueue] addOperation:op];
    }
}
-(void) mergi_la_cerere_castigatoare :(NSString *)AUTHTOKEN :(NSString *)PAGE :(NSString *)PER_PAGE :(NSString *)STATUS {
}
-(void) list_cereri :(NSString *)AUTHTOKEN :(NSString *)PAGE :(NSString *)PER_PAGE :(NSString *)STATUS {
    /*
     list_cereri params
     - page
     - per_page
     - status: 'active', 'solved' sau 'cancelled'
     echo 'm=list_cereri&p={"os":"iOS","authtoken":"1248efg56f11eaagjJfKpR6LBVPXHlCHQwFNJiN7qwf6DJ8NHh6cnM4qHfs","version":"7.1.2","lang":"ro","status":"active","page":"1","per_page":20}' | curl --tlsv1 --cacert ./dev5.activesoft.crt --data @- -- https://dev5.activesoft.ro:277/
     */
    // AUTHTOKEN =@"1248efg56f11eaagjJfKpR6LBVPXHlCHQwFNJiN7qwf6DJ8NHh6cnM4qHfs";
   
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
        //    [MBProgressHUD hideAllHUDsForView:self.navigationController.visibleViewController.view animated:YES];
           

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
    [dic2 setObject:@"iOS" forKey:@"os"];
    [dic2 setObject:currentSysVer forKey:@"version"]; //  vers iOS
    [dic2 setObject:@"ro" forKey:@"lang"];
    [dic2 setObject:AUTHTOKEN forKey:@"authtoken"];
    [dic2 setObject:PAGE forKey:@"page"];
    [dic2 setObject:PER_PAGE forKey:@"per_page"];
    [dic2 setObject:STATUS forKey:@"status"];  // active', 'solved' sau 'cancelled
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic2 options:0 error:&err];
    NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    compus =[NSString stringWithFormat:@"%@%@",METODA_LIST_CERERI, myString];
    
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
                  [self removehud];
                DictionarErori = REZULTAT_NOTIFY_COUNT[@"errors"];
                for(id cheie in [DictionarErori allKeys]) {
                    NSLog(@"dds %@",[DictionarErori valueForKey:cheie]);
                    [erori addObject:[NSString stringWithFormat:@"%@",[DictionarErori valueForKey:cheie]]];
                }
            }
            
            NSLog(@"ERORS %@",erori);
            if(erori.count >0) {
                 [self removehud];
                eroare = [erori componentsJoinedByString:@" "];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                    message:eroare
                                                                   delegate:nil
                                                          cancelButtonTitle:@"Ok"
                                                          otherButtonTitles:nil];
                [alertView show];
            }   else  if(  REZULTAT_NOTIFY_COUNT[@"data"]) {
                 [self removehud];
                //{"errors":{},"data":{"items":[{"id":342551,"title":"Test","nr_offers":0,"nr_unread_offers":0},{"id":342550,"title":"Test","nr_offers":0,"nr_unread_offers":0},{"id":342549,"title":"Test","nr_offers":0,"nr_unread_offers":0}],"total_count":3}}
                NSDictionary *multedate = REZULTAT_NOTIFY_COUNT[@"data"];
                NSLog(@"date cerere raspuns %@",multedate);
                if([STATUS isEqualToString:@"active"]) {
                    if([PAGE isEqualToString:@"1"]) {
                        if( multedate[@"count_active"]) {
                            int  round =0;
                            int  cateintotal =[multedate[@"count_active"] intValue];
                            double originalFloat =(double)cateintotal/ PE_PAGINA.intValue;
                            NSLog(@"originalFloat %f / %i ** %i %f", originalFloat,PE_PAGINA.intValue,[multedate[@"count_active"] intValue],(double)cateintotal/ PE_PAGINA.intValue );
                            if(originalFloat - (int)originalFloat > 0) {
                                originalFloat += 1;
                                round = (int)originalFloat;
                                
                            } else {
                                round = (int)originalFloat;
                            }
                            NSLog(@"round dmc %i", round);
                            numarpagini =round;
                        }
                    }
                }
                 if( multedate[@"count_cancelled"]) {
                     int  cateintotalanulate =[multedate[@"count_cancelled"] intValue];
                       totalcererianulate = cateintotalanulate;
                 }
               if([STATUS isEqualToString:@"solved"]) {
                            if( multedate[@"count_solved"]) {
                                int  round =0;
                                int  cateintotalrezolvate =[multedate[@"count_solved"] intValue];
                                double originalFloat =(double)cateintotalrezolvate/ PE_PAGINA.intValue;
                                NSLog(@"originalFloat %f / %i ** %i %f", originalFloat,PE_PAGINA.intValue,[multedate[@"count_solved"] intValue],(double)cateintotalrezolvate/ PE_PAGINA.intValue );
                                if(originalFloat - (int)originalFloat > 0) {
                                    originalFloat += 1;
                                    round = (int)originalFloat;
                                    
                                } else {
                                    round = (int)originalFloat;
                                }
                                NSLog(@"round dmc %i", round);
                                numarpaginirezolvate =round;
                        }
               }
              if([STATUS isEqualToString:@"cancelled"]) {
                    if( multedate[@"count_cancelled"]) {
                        int  cateintotalanulate =[multedate[@"count_cancelled"] intValue];
                     //  totalcererianulate = cateintotalanulate;
                        int  round =0;
                        double originalFloat =(double)cateintotalanulate/ PE_PAGINA.intValue;
                        NSLog(@"originalFloat %f / %i ** %i %f", originalFloat,PE_PAGINA.intValue,[multedate[@"count_cancelled"] intValue],(double)cateintotalanulate/ PE_PAGINA.intValue );
                        if(originalFloat - (int)originalFloat > 0) {
                            originalFloat += 1;
                            round = (int)originalFloat;
                            
                        } else {
                            round = (int)originalFloat;
                        }
                        NSLog(@"round dmc %i", round);
                        numarpaginianulate =round;
                    }
               }
                
               if(multedate[@"items"]) {
                    NSMutableArray *multecereri =multedate[@"items"];
                    if(multecereri.count >0){
                           [self removehud];
                            [self update_list_cereri:multecereri:STATUS];
                        } else {
                            [self removehud];
                            [self reloadsectiunea0];
                        }
                        
                       /* dispatch_async(dispatch_get_main_queue(), ^{
                               [self update_list_cereri:multecereri:STATUS];
                                                   });*/

                     
               } else {
                      /*   dispatch_async(dispatch_get_main_queue(), ^{
                        [self schimbaSegment];
                              });*/
                      [self schimbaSegment];
                        [self removehud];
                    }
                }
        
            [self removehud];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
//                                                            message:[error localizedDescription]
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"Ok"
//                                                  otherButtonTitles:nil];
//        [alertView show];
        [self removehud];
    }];
    [[NSOperationQueue mainQueue] addOperation:op];
    }
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numarranduri =0;
    if(self.SEGCNTRL.selectedSegmentIndex ==0) {
        numarranduri = CERERIACTIVE.count;
    } else   if(self.SEGCNTRL.selectedSegmentIndex ==1) {
        numarranduri = REZOLVATE.count +1; // intotdeauna aici vom afisa nr cereri anulate chiar daca e 0
    } else if( self.SEGCNTRL.selectedSegmentIndex ==UISegmentedControlNoSegment) {
          numarranduri = ANULATE.count;
    }
    return numarranduri;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //iOS 9 10  -> 45
    //iOS 7 -> 55
    NSInteger ipx= indexPath.row;
    double inaltimerand =75;
    if(self.SEGCNTRL.selectedSegmentIndex ==0) {
         if(CERERIACTIVE.count>0) {
           
            if([CERERIACTIVE objectAtIndex:ipx] !=(NSDictionary*) [NSNull null]  ) {
                NSDictionary *cerererow = [[NSDictionary alloc]init];
                cerererow = [CERERIACTIVE objectAtIndex:ipx];
                NSString *C_titlu = [NSString stringWithFormat:@"%@",cerererow[@"title"]];
                CGFloat widthWithInsetsApplied = self.view.frame.size.width -24;
                CGSize textSize = [C_titlu boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
                UIFont *tester = [UIFont systemFontOfSize:18];
                inaltimerand= textSize.height;
                double numberOfLines = textSize.height /tester.pointSize;
                if(numberOfLines >2) {
                    inaltimerand = 90;
                } else  {

                if(textSize.height < 30) {
                    inaltimerand= textSize.height + 45;
                } else {
                inaltimerand= textSize.height + 25;
                }
                }
             ////   NSLog(@"inaltimerand %f",inaltimerand);
            }
         }
    }
        if(self.SEGCNTRL.selectedSegmentIndex ==1) {
               if(ipx != REZOLVATE.count) {
               if([REZOLVATE objectAtIndex:ipx] !=(NSDictionary*) [NSNull null]  ) {
                NSDictionary *cerererow = [[NSDictionary alloc]init];
                cerererow = [REZOLVATE objectAtIndex:ipx];
                 NSLog(@"cerererere %@",cerererow);
                NSString *C_titlu = [NSString stringWithFormat:@"%@",cerererow[@"title"]];
                CGFloat widthWithInsetsApplied = self.view.frame.size.width -24;
                CGSize textSize = [C_titlu boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
                   UIFont *tester = [UIFont systemFontOfSize:18];
                   inaltimerand= textSize.height;
                   double numberOfLines = textSize.height /tester.pointSize;
                   if(numberOfLines >2) {
                       inaltimerand = 90;
                   } else  {
                           if(textSize.height < 30) {
                           inaltimerand= textSize.height + 45;
                       } else {
                           inaltimerand= textSize.height + 25;
                       }
                   }

               }
               } else {
                   inaltimerand =55;
               }
        }
    if( self.SEGCNTRL.selectedSegmentIndex ==UISegmentedControlNoSegment) {
        if(ANULATE.count>0) {
            
            if([ANULATE objectAtIndex:ipx] !=(NSDictionary*) [NSNull null]  ) {
                NSDictionary *cerererow = [[NSDictionary alloc]init];
                cerererow = [ANULATE objectAtIndex:ipx];
                NSString *C_titlu = [NSString stringWithFormat:@"%@",cerererow[@"title"]];
                CGFloat widthWithInsetsApplied = self.view.frame.size.width -24;
                CGSize textSize = [C_titlu boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
                UIFont *tester = [UIFont systemFontOfSize:18];
                inaltimerand= textSize.height;
                double numberOfLines = textSize.height /tester.pointSize;
                if(numberOfLines >2) {
                    inaltimerand = 90;
                } else  {
                    
                    if(textSize.height < 30) {
                        inaltimerand= textSize.height + 45;
                    } else {
                        inaltimerand= textSize.height + 25;
                    }
                }
                ////   NSLog(@"inaltimerand %f",inaltimerand);
            }
        }
        
    }


    return inaltimerand;
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
-(void)viewDidLayoutSubviews
{
    if ([self.LISTASELECT respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.LISTASELECT setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.LISTASELECT respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.LISTASELECT setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(void)schimbaSegment{
    /*
     MOMENTANNUSUNTCERERI
    */
    MOMENTANNUSUNTCERERI.hidden=YES;
    NSArray *cells = [self.LISTASELECT visibleCells];
    for(UIView *view in cells){
        if([view isMemberOfClass:[CellListaCereriRow class]]){
            CellListaCereriRow *cell = (CellListaCereriRow *) view;
            if ([cell.contentView subviews]){
                for (UIView *subview in [cell.contentView subviews]) {
                    if([subview isKindOfClass:[CustomBadge class]]){
                        [subview removeFromSuperview];
                    }
                }
            }
        }
    }
    [self.LISTASELECT setContentOffset:CGPointZero animated:NO];
    [self.LISTASELECT reloadData];
   
    if(self.SEGCNTRL.selectedSegmentIndex ==0) {
       NSInteger cateactive = CERERIACTIVE.count;
        if(cateactive ==0) {
            MOMENTANNUSUNTCERERI.hidden=NO;
        } else {
            MOMENTANNUSUNTCERERI.hidden=YES;
        }
    } else   if(self.SEGCNTRL.selectedSegmentIndex ==1) {
       NSInteger  numarranduri = REZOLVATE.count;
        if(numarranduri ==0 && ANULATE.count>0) {
            MOMENTANNUSUNTCERERI.hidden=YES;
        } else  if(numarranduri ==0 && ANULATE.count==0) {
              MOMENTANNUSUNTCERERI.hidden=NO;
        }
    }
     else if(self.SEGCNTRL.selectedSegmentIndex ==UISegmentedControlNoSegment) {
        NSInteger  numarranduri = ANULATE.count;
        if(numarranduri ==0) {
            MOMENTANNUSUNTCERERI.hidden=NO;
        } else {
            MOMENTANNUSUNTCERERI.hidden=YES;
        }
    }
}
-(void)launchReload {
    //  pagina curenta _currentPage
    //  pagina curenta rezolvate  _currentPageRezolvate
    // increase page
    if(self.SEGCNTRL.selectedSegmentIndex ==0) {
        if(_currentPage < numarpagini) {
            _currentPage ++;
            NSString *pagina = [NSString stringWithFormat:@"%i", _currentPage];
            
            utilitar = [[Utile alloc]init];
            NSString *authtoken=@"";
            BOOL elogat = NO;
            elogat = [utilitar eLogat];
            if(elogat) {
                authtoken = [utilitar AUTHTOKEN];
                [self list_cereri:authtoken :pagina :PE_PAGINA :@"active"];
                // list_cereri :(NSString *)AUTHTOKEN :(NSString *)PAGE :(NSString *)PER_PAGE :(NSString *)STATUS{
            }
        }
    }
    else  if(self.SEGCNTRL.selectedSegmentIndex ==1) {
        if(_currentPageRezolvate < numarpaginirezolvate) {
            _currentPageRezolvate ++;
            NSString *pagina = [NSString stringWithFormat:@"%i", _currentPageRezolvate];
            
            utilitar = [[Utile alloc]init];
            NSString *authtoken=@"";
            BOOL elogat = NO;
            elogat = [utilitar eLogat];
            if(elogat) {
                authtoken = [utilitar AUTHTOKEN];
                
                [self list_cereri:authtoken :pagina :PE_PAGINA :@"solved"];
                // list_cereri :(NSString *)AUTHTOKEN :(NSString *)PAGE :(NSString *)PER_PAGE :(NSString *)STATUS{
            }
        }
        
    }
    else if( self.SEGCNTRL.selectedSegmentIndex ==UISegmentedControlNoSegment) {
        NSLog(@" never ever do this piece of ...");
        if(_currentPageAnulate < numarpaginianulate) {
            _currentPageAnulate ++;
            NSString *pagina = [NSString stringWithFormat:@"%i", _currentPageAnulate];
            utilitar = [[Utile alloc]init];
            NSString *authtoken=@"";
            BOOL elogat = NO;
            elogat = [utilitar eLogat];
            if(elogat) {
                authtoken = [utilitar AUTHTOKEN];
                [self list_cereri:authtoken :pagina :PE_PAGINA :@"cancelled"];
                // list_cereri :(NSString *)AUTHTOKEN :(NSString *)PAGE :(NSString *)PER_PAGE :(NSString *)STATUS{
            }
        }

    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int ipx = (int)indexPath.row;
    static NSString *CellIdentifier = @"CellListaCereriRow";
    CellListaCereriRow *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (CellListaCereriRow*)[tableView dequeueReusableCellWithIdentifier:@"CellListaCereriRow"];
    }
    for (UIView *subview in [cell.contentView subviews]) {
        if([subview isKindOfClass:[CustomBadge class]]){
            [subview removeFromSuperview];
        }
    }
    cell.TitluRand.hidden =YES;
    cell.TitluRand.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
    cell.numaroferteRand.verticalAlignment=TTTAttributedLabelVerticalAlignmentTop;
    cell.sageatablue.hidden =NO;
    cell.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1];
    cell.pozaRow.hidden =YES;
   
    cell.TitluRand.textColor =  [UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] ;
    cell.numaroferteRand.hidden =YES;
    //dynamictitluheight calculeaza row height
    NSDictionary *cerererow =[[NSDictionary alloc]init];
    
    if(self.SEGCNTRL.selectedSegmentIndex ==0) {
        cell.sageatagri.hidden=YES;
        cell.labelanulate.hidden=YES;
        if(CERERIACTIVE.count >0) {
            cerererow = [CERERIACTIVE objectAtIndex:ipx];
            if(cerererow !=(NSDictionary*) [NSNull null] ) {
                NSString *C_titlu = [NSString stringWithFormat:@"%@",cerererow[@"title"]];
                 CGFloat widthWithInsetsApplied = self.view.frame.size.width;
                 widthWithInsetsApplied = self.view.frame.size.width - 24;
                 double inaltimerand=0;
                 CGSize textSize = [C_titlu boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
                UIFont *tester = [UIFont systemFontOfSize:18];
                inaltimerand= textSize.height;
                double numberOfLines = textSize.height /tester.pointSize;
                if(numberOfLines >2) {
                    inaltimerand = 50;
                }
               cell.dynamictitluheight.constant = inaltimerand +22;
         
                NSString *C_numaroferte = [NSString stringWithFormat:@"%@",cerererow[@"nr_offers"]];
                NSString *compus_nr_oferte = [NSString stringWithFormat:@"%@ Oferte", C_numaroferte];
                NSString *C_ofertenevazute = [NSString stringWithFormat:@"%@",cerererow[@"nr_unread_offers"]];
                cell.TitluRand.text = C_titlu;
                cell.numaroferteRand.text = compus_nr_oferte;
                cell.TitluRand.hidden=NO;
                cell.numaroferteRand.hidden=NO;
                [cell.numaroferteRand sizeToFit];
                if(self.SEGCNTRL.selectedSegmentIndex ==0) {
                    CGRect nroferteframe =cell.numaroferteRand.frame;
                    if(C_ofertenevazute.integerValue >0) { //add badge and keep working
                        CGRect framenecesar = CGRectMake(nroferteframe.origin.x+ nroferteframe.size.width +12,cell.numaroferteRand.frame.origin.y-1, 25, 25);
                        NSString *mybadgenr =C_ofertenevazute;
                        CustomBadge *badge1 = [CustomBadge customBadgeWithString:mybadgenr:framenecesar];
                        badge1.hidden =NO;
                        [cell.contentView addSubview:badge1];
                    }
                }
            }
        }
    }
       if(self.SEGCNTRL.selectedSegmentIndex ==1) {
        cell.sageatagri.hidden=YES;
        cell.labelanulate.hidden=YES;
        NSInteger rezcount =REZOLVATE.count;
        if(rezcount==0  && ANULATE.count ==0){
            cell.TitluRand.hidden=YES;
            cell.pozaRow.hidden=YES;
            cell.numaroferteRand.hidden =YES;
            cell.sageatablue.hidden =YES;
            cell.sageatagri.hidden=YES;
            cell.labelanulate.hidden=YES;
            cell.labelanulate.text = @"";
            [self schimbaSegment];
        } else {
        NSInteger totalRow = REZOLVATE.count+1;//first get total rows +1 label   //
        NSLog(@"totalRow %li",(long)totalRow);
        if(indexPath.row == totalRow -1   ){ //numar cereri anulate
            MOMENTANNUSUNTCERERI.hidden=YES;
            //this is the last row in section.
            NSString *nrtotalanulate = [NSString stringWithFormat:@"%i Cereri anulate",totalcererianulate];
            cell.TitluRand.hidden=YES;
            cell.pozaRow.hidden=YES;
            cell.numaroferteRand.hidden =YES;
            cell.sageatablue.hidden =YES;
            cell.sageatagri.hidden=NO;
            cell.labelanulate.hidden=NO;
            cell.labelanulate.textColor =  [UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] ;
            cell.labelanulate.text = nrtotalanulate;
        } else if(REZOLVATE.count >0) {
            cerererow = [REZOLVATE objectAtIndex:ipx];
            if(cerererow !=(NSDictionary*) [NSNull null] ) {
                NSLog(@"Are winner? Daca da text e Vezi oferta câștigătoare %@",cerererow);
                NSString *C_titlu = [NSString stringWithFormat:@"%@",cerererow[@"title"]];
//                NSString *C_numaroferte = [NSString stringWithFormat:@"%@",cerererow[@"nr_offers"]];
//                NSString *compus_nr_oferte = [NSString stringWithFormat:@"%@ Oferte", C_numaroferte];
//                NSString *C_ofertenevazute = [NSString stringWithFormat:@"%@",cerererow[@"nr_unread_offers"]];
                CGFloat widthWithInsetsApplied = self.view.frame.size.width;
                widthWithInsetsApplied = self.view.frame.size.width - 24;
                double inaltimerand=0;
                CGSize textSize = [C_titlu boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
                inaltimerand= textSize.height;
                UIFont *tester = [UIFont systemFontOfSize:18];
                inaltimerand= textSize.height;
                double numberOfLines = textSize.height /tester.pointSize;
                if(numberOfLines >2) {
                    inaltimerand = 40;
                }
                cell.dynamictitluheight.constant = inaltimerand +22;
                cell.TitluRand.text = C_titlu;
                cell.numaroferteRand.text = @"Vezi oferta câștigătoare";
                cell.TitluRand.hidden=NO;
                cell.numaroferteRand.hidden=NO;
                [cell.numaroferteRand sizeToFit];
           }
        }
        }
    }
    if( self.SEGCNTRL.selectedSegmentIndex ==UISegmentedControlNoSegment) {
        cell.sageatagri.hidden=YES;
        cell.labelanulate.hidden=YES;
        if(ANULATE.count >0) {
            cerererow = [ANULATE objectAtIndex:ipx];
            if(cerererow !=(NSDictionary*) [NSNull null] ) {
                NSString *C_titlu = [NSString stringWithFormat:@"%@",cerererow[@"title"]];
                CGFloat widthWithInsetsApplied = self.view.frame.size.width;
                widthWithInsetsApplied = self.view.frame.size.width - 24;
                double inaltimerand=0;
                CGSize textSize = [C_titlu boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
                UIFont *tester = [UIFont systemFontOfSize:18];
                inaltimerand= textSize.height;
                double numberOfLines = textSize.height /tester.pointSize;
                if(numberOfLines >2) {
                    inaltimerand = 50;
                }
                cell.dynamictitluheight.constant = inaltimerand +22;
                
                NSString *C_numaroferte = [NSString stringWithFormat:@"%@",cerererow[@"nr_offers"]];
                NSString *compus_nr_oferte = [NSString stringWithFormat:@"%@ Oferte", C_numaroferte];
                NSString *C_ofertenevazute = [NSString stringWithFormat:@"%@",cerererow[@"nr_unread_offers"]];
                cell.TitluRand.text = C_titlu;
                cell.numaroferteRand.text = compus_nr_oferte;
                cell.TitluRand.hidden=NO;
                cell.numaroferteRand.hidden=NO;
                [cell.numaroferteRand sizeToFit];
                if(self.SEGCNTRL.selectedSegmentIndex ==UISegmentedControlNoSegment) {
                    CGRect nroferteframe =cell.numaroferteRand.frame;
                    if(C_ofertenevazute.integerValue >0) { //add badge and keep working
                        CGRect framenecesar = CGRectMake(nroferteframe.origin.x+ nroferteframe.size.width +12,cell.numaroferteRand.frame.origin.y-1, 25, 25);
                        NSString *mybadgenr =C_ofertenevazute;
                        CustomBadge *badge1 = [CustomBadge customBadgeWithString:mybadgenr:framenecesar];
                        badge1.hidden =NO;
                        [cell.contentView addSubview:badge1];
                    }
                }
            }
        }
        
    }

    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    if(self.SEGCNTRL.selectedSegmentIndex ==0) {
        if (indexPath.row == [CERERIACTIVE count] - 1)
        {
            [self launchReload];
        }
    }
    if(self.SEGCNTRL.selectedSegmentIndex ==1) {
        if (indexPath.row == [REZOLVATE count] - 1)
        {
            [self launchReload];
        }
    }
    if( self.SEGCNTRL.selectedSegmentIndex ==UISegmentedControlNoSegment) {
        if (indexPath.row == [ANULATE count] - 1)
        {
            [self launchReload];
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // [LISTASELECT cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int ipx = (int)indexPath.row;
    NSDictionary *cerererow =[[NSDictionary alloc]init];
    if(self.SEGCNTRL.selectedSegmentIndex ==0) {
        cerererow = [CERERIACTIVE objectAtIndex:ipx];
        
    }else  if(self.SEGCNTRL.selectedSegmentIndex ==1) {
        NSInteger totalRow = REZOLVATE.count+1;//first get total rows +1 label   //doar aici
        if(indexPath.row == totalRow -1   ){ //numar cereri anulate
            NSLog(@"caz special anulate");
            if(totalcererianulate >0) {
              //  jNSLog(@"toate anulate %@", ANULATE);
                //   //arata-i anulate
            }
        }else {
            cerererow = [REZOLVATE objectAtIndex:ipx];
        }
    } else if(self.SEGCNTRL.selectedSegmentIndex ==UISegmentedControlNoSegment){
         cerererow = [ANULATE objectAtIndex:ipx];
    }
    if([self checkDictionary:cerererow] && cerererow[@"id"]) {
         if(self.SEGCNTRL.selectedSegmentIndex ==0) {
        utilitar = [[Utile alloc]init];
        NSString *authtoken=@"";
        BOOL elogat = NO;
        elogat = [utilitar eLogat];
        if(elogat) {
            authtoken = [utilitar AUTHTOKEN];
            NSString *cerereID = [NSString stringWithFormat:@"%@", cerererow[@"id"]];
            // list_offers_per_cerere :(NSString *)AUTHTOKEN :(NSString *)PAGE :(NSString *)PER_PAGE :(NSString *)cerere_id :(NSString *)prefered_only  :(NSString*)cerere_details
            //prefered_only =0 sau 1 toate sau numai cele preferate
            REINCARCALISTA =YES;
            [self list_offers_per_cerere:authtoken :@"1" :PE_PAGINA :cerereID  :@"0" :@"1" :@"nu"];
        }
         }
  if(self.SEGCNTRL.selectedSegmentIndex ==1) {
               //mergi la detaliu cerere
                   utilitar = [[Utile alloc]init];
                   NSString *authtoken=@"";
                   BOOL elogat = NO;
                   elogat = [utilitar eLogat];
                   if(elogat) {
                       authtoken = [utilitar AUTHTOKEN];
                       NSString *cerereID = [NSString stringWithFormat:@"%@", cerererow[@"id"]];
                       // list_offers_per_cerere :(NSString *)AUTHTOKEN :(NSString *)PAGE :(NSString *)PER_PAGE :(NSString *)cerere_id :(NSString *)prefered_only  :(NSString*)cerere_details
                       //prefered_only =0 sau 1 toate sau numai cele preferate
                        REINCARCALISTA =YES;
                       [self list_offers_per_cerere:authtoken :@"1" :PE_PAGINA :cerereID  :@"0" :@"1" :@"da"];
               }
               }
if(self.SEGCNTRL.selectedSegmentIndex ==UISegmentedControlNoSegment) {
            //mergi la detaliu cerere
            utilitar = [[Utile alloc]init];
            NSString *authtoken=@"";
            BOOL elogat = NO;
            elogat = [utilitar eLogat];
            if(elogat) {
                authtoken = [utilitar AUTHTOKEN];
                NSString *cerereID = [NSString stringWithFormat:@"%@", cerererow[@"id"]];
                // list_offers_per_cerere :(NSString *)AUTHTOKEN :(NSString *)PAGE :(NSString *)PER_PAGE :(NSString *)cerere_id :(NSString *)prefered_only  :(NSString*)cerere_details
                //prefered_only =0 sau 1 toate sau numai cele preferate
                 REINCARCALISTA =YES;
                [self list_offers_per_cerere:authtoken :@"1" :PE_PAGINA :cerereID  :@"0" :@"1" :@"nu"];
            }
        }

   
   }  else {
       NSLog(@"caz special anulate stai pe aici");
        self.SEGCNTRL.selectedSegmentIndex =UISegmentedControlNoSegment;
        NSString *paginacurentastring = [NSString stringWithFormat:@"%i",_currentPageAnulate];
        utilitar = [[Utile alloc]init];
        NSString *authtoken=@"";
        BOOL elogat = NO;
        ANULATE= [[NSMutableArray alloc]init];
        elogat = [utilitar eLogat];
        if(elogat) {
            authtoken = [utilitar AUTHTOKEN];
             REINCARCALISTA =YES;
            [self list_cereri:authtoken :paginacurentastring :PE_PAGINA :@"cancelled"];
        }
        NSLog(@"_currentPageAnulate %i numarpaginianulate %i", _currentPageAnulate,numarpaginianulate);

//       CereriAnulateViewController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"CereriAnulateVC"];
//       [self.navigationController pushViewController:vc animated:NO];
    }
}

-(bool)checkDictionary:(NSDictionary *)dict{
    if(dict == nil || [dict class] == [NSNull class] || ![dict isKindOfClass:[NSDictionary class]]){
        return NO;
    }
    
    return  YES;
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
        
        if([TIP isEqualToString:@"cerereid"]) {
            [dic2 setObject:CERERESAUOFERTAID forKey:@"cerere_id"];
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
                     [self removehud];
                    NSLog(@"date comentarii %@",multedate);
                    if([TIP isEqualToString:@"cerereid"]) {
                        CerereExistentaViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CerereExistentaViewVC"];
                        vc.intrebaridelaaltii = [[NSMutableDictionary alloc]init];
                        vc.intrebaridelaaltii = multedate;
                      [self.navigationController pushViewController:vc animated:YES ];
                    }
                    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)cereofertaacumAction:(id)sender {
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    del.reposteazacerere =NO;
    del.ARRAYASSETURIEXTERNE = [[NSMutableArray alloc]init];
    del.ARRAYASSETURI = [[NSMutableArray alloc]init];
    
    NSString *authtoken=@"";
    BOOL elogat = NO;
    utilitar=[[Utile alloc] init];
    elogat = [utilitar eLogat];
    if(elogat) {
        authtoken = [utilitar AUTHTOKEN];
        NSDictionary *userulmeu= [DataMasterProcessor getLOGEDACCOUNT];
        NSString *userid = [NSString stringWithFormat:@"%@", userulmeu[@"U_userid"]];
        NSMutableArray *cars = [[NSMutableArray alloc]init];
        cars = [DataMasterProcessor getCars:userid];
        if(cars.count >0) {
            //du-l la tabel cu masini adaugate anterior
            ListaMasiniUserViewController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"ListaMasiniUserVC"];
            vc.titluriCAMPURI =cars;
            [self.navigationController pushViewController:vc animated:NO];
        } else {
            //adauga cerere noua
            CerereNouaViewController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"CerereNouaViewVC"];
            [self.navigationController pushViewController:vc animated:NO];
        }
        
    } else {
        // cerere noua
        CerereNouaViewController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"CerereNouaViewVC"];
        [self.navigationController pushViewController:vc animated:NO];
    }
    NSLog(@"ecran home select");
    NSLog(@"gata screen");
}




- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    utilitar = [[Utile alloc]init];
    switch (item.tag) {
        case 0:
        {
            NSLog(@"la 0"); // Adauga cerere noua
            //getCars
            
            [self cereofertaacumAction:nil];
            
        }
            break;
        case 1: //cererile mele
        {
            NSString *authtoken=@"";
            BOOL elogat = NO;
            elogat = [utilitar eLogat];
            if(elogat) {
                authtoken = [utilitar AUTHTOKEN];
                NSLog(@"la cereri %@",authtoken);
                CererileMeleViewController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"CererileMeleVC"];
                [self.navigationController pushViewController:vc animated:NO];
            } else {
                choseLoginview *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"ChooseLoginVC"];
                [self.navigationController pushViewController:vc animated:NO];
                
            }
            break;
        }
        case 2: {
            NSLog(@"la 2"); //contul meu
            // daca nu e logat il ducem
            BOOL eLogat = [utilitar eLogat];
            if(!eLogat) {
                choseLoginview *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"ChooseLoginVC"];
                [self.navigationController pushViewController:vc animated:NO];
            } else {
                 NSString *authtoken=@"";
                 authtoken = [utilitar AUTHTOKEN];
                [utilitar getnotify_count:authtoken];
                    
                   ContulMeuViewController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"ContulMeuViewVC"];
                    [self.navigationController pushViewController:vc animated:NO];
            }
            break;
        }
        default:
            break;
    }
}
-(void)barajosmadeit {
    NSArray *imagini = [[NSArray alloc]init];
    //ic_my_account_login.png
    
    imagini=@[@"Icon_Adauga_Cerere_144x144.png",@"Icon_Cereri_144x144@2x.png",@"Icon_Contul_Meu_144x144@2x.png"];
    
    
    self.barajos.delegate = self;
    for (int i=0;i< self.barajos.items.count;i++) {
        UITabBarItem *ITEM = self.barajos.items[i];
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowColor = [UIColor blackColor];
        shadow.shadowOffset = CGSizeMake(0, 0);
        if(i==1) {
            //feedback_needed_count":0,"unread_offers_count":0}}
            AppDelegate * del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            if(del.NOTIFY_COUNT) { // vezi daca e mai mare ca 0 afisam daca nu nu /deocamdata asa sa se vada
                NSDictionary *notifs= [[NSDictionary alloc]init];
                notifs =del.NOTIFY_COUNT;
                if(notifs[@"unread_offers_count"]) {
                    NSString *mybadgenr  = [NSString stringWithFormat:@"%@",notifs[@"unread_offers_count"]];
                    NSInteger unread_notif =mybadgenr.integerValue;
                    
                    if(unread_notif!=0) {
                        [ITEM setBadgeValue:mybadgenr];
                    }
                }
                else {
                    [ITEM setBadgeValue:nil];
                }
                
            }
        }        if(i==2) {
            utilitar = [[Utile alloc]init];
            BOOL Elogat = NO;
            Elogat =[utilitar eLogat];
            if(Elogat) {
                NSString *mybadgenr  =@"\u2713";
                [ITEM setBadgeValue:mybadgenr];
            }
            else {
                ITEM.badgeValue = nil;
            }
        }
        
        [ITEM setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                      [UIColor grayColor],NSForegroundColorAttributeName,
                                      shadow,NSShadowAttributeName,
                                      [NSValue valueWithUIOffset:UIOffsetMake(0,0)], NSShadowAttributeName,
                                      [UIFont fontWithName:@"Helvetica" size:15.0], NSFontAttributeName, nil]
                            forState:UIControlStateNormal];
        
        NSString *numeimagine = [NSString stringWithFormat:@"%@", imagini[i]];
        UIImage *imagine =[UIImage imageNamed:numeimagine];
        [ITEM setImageInsets: UIEdgeInsetsMake(0, 0, 0, 0)];
        ITEM.image = [[UIImage imageNamed:numeimagine] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        ITEM.image = [self imageWithImage:imagine scaledToSize:CGSizeMake(24, 24)]; //APPLE ZICE 30
        ITEM.selectedImage =[self imageWithImage:imagine scaledToSize:CGSizeMake(24, 24)];
        //     [ITEM setBadgeValue:@"2O"];
    }

}
-(void)viewDidAppear:(BOOL)animated {
    [self.barajos setNeedsLayout];
    [self.barajos layoutIfNeeded];
    [self removehud];
    
}
-(void)viewWillLayoutSubviews{
  }
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(BOOL)MyStringisEmpty:(NSString *)str
{
    if(str.length==0 || [str isKindOfClass:[NSNull class]] || [str isEqualToString:@""]||[str  isEqualToString:@"NULL"]||[str isEqualToString:@"(null)"]|| [str isEqualToString:@"<null>"] || [str isEqualToString:@"null"] ||str==nil){
        return YES;
    }
    return NO;
}



@end
