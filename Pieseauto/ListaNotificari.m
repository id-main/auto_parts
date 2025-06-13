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
#import "ListaNotificari.h"
#import "CellListaNotificari.h"
#import "TutorialHomeViewController.h"
#import <CoreText/CoreText.h>
#import "SetariViewController.h"
#import "OferteLaCerereViewController.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "EcranMesajeViewController.h"
#import "butoncustomback.h"
#import "DetaliuOfertaViewController.h"
#import "WebViewController.h"

static NSString *PE_PAGINA = @"20";
@interface ListaNotificari(){
    NSMutableArray* Cells_Array;
}
@end

@implementation ListaNotificari
@synthesize  LISTASELECT,titluriCAMPURI,listaNOTIFICARI,catepagininotificari,_currentPage_notificari,nusuntnotificari,edinback,refreshControl,xrays;
//// pentru ca avem nevoie de un custom back in unele cazuri
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
                    DetaliuOfertaViewController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"DetaliuOfertaVC"];
                    if( ![self MyStringisEmpty:mesajid] ) {
                        vc.idmesaj = mesajid;
                        NSLog(@"idmesaj %@", mesajid);
                    }
                    vc.CORPDATE = multedate;
                    [self.navigationController pushViewController:vc animated:NO];
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

-(void)viewWillAppear:(BOOL)animated {
    NSLog(@"NOTIFICARILE mele");

    self.title = @"Notificări";
       [self.navigationController setNavigationBarHidden:NO]; self.navigationItem.leftBarButtonItem=nil;
    
    self.navigationController.navigationItem.hidesBackButton = YES;
    //clean other left
    for(UIButton *view in  self.navigationController.navigationBar.subviews) {
        if([view isKindOfClass:[butoncustomback class]]){
            [view removeFromSuperview];
        }
    }
    //add new left
    UIButton *ceva = [self backbtncustom];
    [ceva addTarget:self action:@selector(perfecttimeforback) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *inapoibtn =[[UIBarButtonItem alloc] initWithCustomView:ceva];
    self.navigationItem.leftBarButtonItem = inapoibtn;
    [self removehud];
    if( edinback==YES) {
    //reload all notifs list
    //list_notifications :(NSString *)AUTHTOKEN
         _currentPage_notificari=1;
        utilitar = [[Utile alloc]init];
        NSString *authtoken=@"";
        BOOL elogat = NO;
        elogat = [utilitar eLogat];
        if(elogat) {
            authtoken = [utilitar AUTHTOKEN];
             edinback=NO;
            [self  list_notifications_refresh :authtoken];
        }
    }
     else {
       edinback=NO;
    }
    
    
}
-(void)perfecttimeforback{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
   
    LISTASELECT.delegate =self;
    LISTASELECT.dataSource =self;
    LISTASELECT.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _currentPage_notificari=1;
    titluriCAMPURI=[[NSMutableArray alloc]init];
    self.listaNOTIFICARI= listaNOTIFICARI;
    
    int  round =0;
    if( listaNOTIFICARI[@"total_count"]) {
        int  cateintotalrezolvate =[listaNOTIFICARI[@"total_count"] intValue];
        double originalFloat =(double)cateintotalrezolvate/ PE_PAGINA.intValue;
        NSLog(@"originalFloat %f / %i ** %i %f", originalFloat,PE_PAGINA.intValue,[listaNOTIFICARI[@"total_count"] intValue],(double)cateintotalrezolvate/ PE_PAGINA.intValue );
        if(originalFloat - (int)originalFloat > 0) {
            originalFloat += 1;
            round = (int)originalFloat;
            
        } else {
            round = (int)originalFloat;
        }
    }
    catepagininotificari =round;
    /*"items":[{"id":2,"type":"msg_added.question.1826901","title":"Ai o \u00eentrebare nou\u0103","date_added":1463770784,"is_viewed":0,"date_added_formatted":"20 mai 2016, 21:59","aux":{"cerere_id":342741}},{"id":1,"type":"msg_added.question.1826900","title":"Ai o \u00eentrebare nou\u0103","date_added":1463769980,"is_viewed":1,"date_added_formatted":"20 mai 2016, 21:46","aux":{"cerere_id":342741}}]}}
     if(listaNOTIFICARI[@"items"]) {*/
    
    if(listaNOTIFICARI[@"items"]) {
        
        titluriCAMPURI =[NSMutableArray arrayWithArray: listaNOTIFICARI[@"items"]];
    }
    
    NSLog(@"notificari %@", titluriCAMPURI);
    if(titluriCAMPURI.count ==0) {
        nusuntnotificari.text =@"Momentan nu sunt notificări";
        nusuntnotificari.hidden=NO;
    } else {
         nusuntnotificari.text =@"";
        nusuntnotificari.hidden=YES;
    }
        
    utilitar = [[Utile alloc]init];
       // Do any additional setup after loading the view, typically from a nib.
    xrays= [[UITableViewController alloc] init];
    xrays.tableView = self.LISTASELECT;
   
    refreshControl = [[UIRefreshControl alloc]init];
  //  [LISTASELECT addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
     xrays.refreshControl = self.refreshControl;
}
-(void)refreshTable {
    //RELOADDATA
    _currentPage_notificari=1;
    utilitar = [[Utile alloc]init];
    NSString *authtoken=@"";
    BOOL elogat = NO;
    elogat = [utilitar eLogat];
    if(elogat) {
        authtoken = [utilitar AUTHTOKEN];
        edinback=NO;
        [self  list_notifications_refresh :authtoken];
    }
   
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int numarranduri =0;
    return self.titluriCAMPURI.count;
    return numarranduri;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int ipx = (int)indexPath.row;
    static NSString *CellIdentifier = @"CellListaNotificari";
    CellListaNotificari *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (CellListaNotificari*)[tableView dequeueReusableCellWithIdentifier:@"CellListaNotificari"];
    }
    /*
     roundblue,sageatagri,TitluRand,datasiora
     @"title": @"Bara spate cu intaritura Bmw 320 facelift 1999 - 2005",
     @"data_ora": @"13 martie ora 15:30",
     @"citita": @"0",
     },
     */
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *cerererow =[[NSDictionary alloc]init];
    cerererow = [self.titluriCAMPURI objectAtIndex:ipx];
    cell.TitluRand.text = [NSString stringWithFormat:@"%@",cerererow[@"title"]];
    cell.datasiora.text = [NSString stringWithFormat:@"%@",cerererow[@"date_added_formatted"]];
    if(cerererow[@"is_viewed"]) {
        NSString *citita=  [NSString stringWithFormat:@"%@",cerererow[@"is_viewed"]];
        if([citita integerValue]==0) {
            cell.roundblue.hidden=NO;
        } else {
            cell.roundblue.hidden=YES;
        }
    }
    cell.sageatagri.hidden=NO;
    cell.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1];
    cell.TitluRand.textColor =  [UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] ;
    if (indexPath.row == [titluriCAMPURI count] - 1)
    {
        [self launchReload];
    }
    
    return cell;
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
        NSString *pagina = [NSString stringWithFormat:@"%i", _currentPage_notificari];
        [dic2 setObject:pagina forKey:@"page"];
        
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
                    eroare =    [erori componentsJoinedByString:@" "];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                        message:eroare
                                                                       delegate:nil
                                                              cancelButtonTitle:@"Ok"
                                                              otherButtonTitles:nil];
                    [alertView show];
                }   else  if(  REZULTAT_NOTIFY_COUNT[@"data"]) {
                    NSDictionary *multedate = REZULTAT_NOTIFY_COUNT[@"data"];
                    if(multedate[@"items"]) {
                        NSArray *notifs = multedate[@"items"];
                        [self update_list_notificari:notifs];
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
            
        }];
        [[NSOperationQueue mainQueue] addOperation:op];
    }
    
}
-(void)doarupdatetabel {
    [refreshControl endRefreshing];
    NSIndexSet *section =  [NSIndexSet indexSetWithIndex:0];
    [self.LISTASELECT beginUpdates];
    [self.LISTASELECT reloadSections:section withRowAnimation:UITableViewRowAnimationNone];
    [self.LISTASELECT endUpdates];
    
}
-(void)reloadsectiunea12 {
    
      if(self.titluriCAMPURI.count>0) {
        nusuntnotificari.text =@"";
        nusuntnotificari.hidden=YES;
        [self doarupdatetabel];
    } else {
        [refreshControl endRefreshing];
        nusuntnotificari.text =@"Momentan nu sunt notificări";
        nusuntnotificari.hidden=NO;
        [self.LISTASELECT reloadData];
    }
    
}
-(NSMutableArray*)update_list_notificari :(NSArray *)notifcari  {
    NSArray *lista_notifs = notifcari;
    NSMutableArray *copie = [self.titluriCAMPURI mutableCopy];
    for(NSDictionary *itemnou in lista_notifs) {
        if(![copie containsObject:itemnou]) {
            [copie addObject:itemnou];
        }
    }
    self.titluriCAMPURI = copie;
    [self reloadsectiunea12];
    return titluriCAMPURI;
}


-(void)launchReload {
    NSLog(@"lreload");
    utilitar = [[Utile alloc]init];
    NSString *authtoken=@"";
    BOOL elogat = NO;
    elogat = [utilitar eLogat];
    if(elogat) {
        authtoken = [utilitar AUTHTOKEN];
        if(_currentPage_notificari ==1) {
            _currentPage_notificari ++;
            [self  list_notifications:authtoken];
        } else  if(_currentPage_notificari < catepagininotificari)  {
            _currentPage_notificari ++;
            [self  list_notifications:authtoken];
        }
    }
}



-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // [LISTASELECT cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}
-(NSString*) getAppVersion{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSString *minorversion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *versiunefinala = [NSString stringWithFormat:@"%@.%@", version, minorversion];
    //   Bundle versions string, short
    return versiunefinala;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    edinback =YES;
    NSInteger ipx = indexPath.row;
    NSMutableDictionary *notificarerow =[[NSMutableDictionary alloc]init];
    notificarerow = [NSMutableDictionary dictionaryWithDictionary:[self.titluriCAMPURI objectAtIndex:ipx]];
    
    utilitar = [[Utile alloc]init];
    NSString *authtoken=@"";
    BOOL elogat = NO;
    elogat = [utilitar eLogat];
    if(elogat) {
        authtoken = [utilitar AUTHTOKEN];
    }
 
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSLog(@"notificarerow %@",notificarerow);
    [notificarerow setValue:@"1" forKey:@"is_viewed"];
    NSMutableArray *copie = [self.titluriCAMPURI mutableCopy];
    [copie replaceObjectAtIndex:ipx withObject:notificarerow];
    self.titluriCAMPURI = copie;
    [self.LISTASELECT reloadData];
    });
   BOOL evazuta=NO;
   if(notificarerow[@"is_viewed"])  {
        NSString *setrimitecavazutlaserver = [NSString stringWithFormat:@"%@",notificarerow[@"is_viewed"]];
       if(setrimitecavazutlaserver.integerValue==0 ) {
           evazuta =YES;
       }
   }
    if(notificarerow[@"id"] && evazuta ==YES) {
        NSString *setrimitecavazutlaserver = [NSString stringWithFormat:@"%@",notificarerow[@"id"]];
        [self notification_viewed:authtoken:setrimitecavazutlaserver];
    }
  /*
  type = "msg_added.question.1826900";
  */
    NSString *mesageid = @"";
    NSString *typeid = @"";
    NSString *tipsend=@"";
    
    if(notificarerow[@"type"]) {
        NSString *splitstring= [NSString stringWithFormat:@"%@",notificarerow[@"type"]];
        NSArray* splitarray = [splitstring componentsSeparatedByString: @"."];
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
            if([tipsend isEqualToString:@"new_version" ]) {
                tipsend =@"new_version";
            }
            if([tipsend isEqualToString:@"special_offer"]) {
                 tipsend =@"special_offer";
            }
           
        }
          NSLog(@" tipsend %@ mesageid %@",tipsend, mesageid);
    }
  
   //    -msg_added.question.ID este o intrebare pe o cerere sau oferta
//
    if([tipsend  isEqualToString:@"offer"]){
        [self getOffer :mesageid :authtoken :mesageid];
            }
    
    if([tipsend isEqualToString:@"new_version" ]) {
 //       tipsend =@"new_version"; du-l in store
        BOOL sunt_nou=NO;
        if(notificarerow[@"aux"]) {
            NSDictionary *detaliunotificari= [[NSDictionary alloc]init];
            detaliunotificari =notificarerow[@"aux"];
            if(detaliunotificari[@"version"]) {
                NSString *versiunenoua = [NSString stringWithFormat:@"%@",detaliunotificari[@"version"]];
                NSString *appVersion =@"";
                appVersion =[self getAppVersion];
                NSArray *versiuneamea = [appVersion componentsSeparatedByString: @"."];
                NSArray *versiune_de_comparat = [versiunenoua componentsSeparatedByString: @"."];
                int x1=0; int x2=0;
                int y1=0; int y2=0;
                int z1=0; int z2=0;
                if([versiuneamea[0]intValue]) {
                    x1 =[versiuneamea[0]intValue];
                }
                if([versiune_de_comparat[0]intValue]) {
                    x2 =[versiune_de_comparat[0]intValue];
                }
                if([versiuneamea[1]intValue]) {
                    y1 =[versiuneamea[1]intValue];
                }
                if([versiune_de_comparat[1]intValue]) {
                    y2 =[versiune_de_comparat[1]intValue];
                }
                if([versiuneamea[2]integerValue]) {
                    z1 =[versiuneamea[2]intValue];
                }
                if([versiune_de_comparat[2]integerValue]) {
                    z2 =[versiune_de_comparat[2]intValue];
                }
                
                //now compare ...
                if(x1 && x2) {  if (x2> x1) {
                    sunt_nou=YES;
                } else {
                    if (x2 == x1) {
                        //versiunea majora e egala vezi build
                        if(y1 && y2) { if (y2> y1) {
                            sunt_nou=YES;
                        } else {
                            if (y2 == y1) {
                                //versiunea majora build e egala vezi minor build
                                if(z1 && z2) { if (z2> z1) {
                                    sunt_nou=YES;
                                } else {
                                    if (z2 == z1) {
                                        //nothing
                                    }}}}}}}}}}}
        if(sunt_nou ==YES) {
            //mystring is appstorelink https://itunes.apple.com/app/dmpiese/id1116030452?mt=8
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms://itunes.apple.com/app/dmpiese/id1116030452?mt=8"]];
        }
    }
    if([tipsend isEqualToString:@"special_offer"]) {
     if(notificarerow[@"aux"]) {
         NSDictionary *detaliunotificari= [[NSDictionary alloc]init];
         detaliunotificari =notificarerow[@"aux"];
         if(detaliunotificari[@"external_url"]) {
             [self addhud];
             NSString *external_url = [NSString stringWithFormat:@"%@", detaliunotificari[@"external_url"]];
             WebViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewVC"];
             vc.urlPiesesimilare = external_url;
             vc.mWebView.scalesPageToFit = YES;
             vc.title=@"Află mai multe";
             [self.navigationController pushViewController:vc animated:YES ];
         }
    }
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
/*
 
 //        - type: string, are forma: tip.subtip.etc... deocamdata avem doar: msg_added.offer.ID, msg_added.question.ID, msg_added.comment.ID unde ID este id-ul comentariului/ofertei
 //        Payload-ul mesajului push contine tot ce este in aux + type-ul intr-un json
 //        Pt. type in viitor am putea avea "new_version", "special_offer", etc. iar in aux si payload vom adauga "external_url" care va fi deschis in browser pt. valorile de type care nu sunt recunoscute de aplicatie.    // if([tipsend isEqualToString:@"external_url" ]) {
 // tipsend =@"external_url";
 
 //type = "msg_added.question.1826900";
 // msg_added.offer.ID, msg_added.question.ID, msg_added.comment.ID unde ID
 //  este id-ul comentariului/ofertei
 
 

 Metode noi:
 "list_notifications"
 - page
 - per_page
 Raspunde cu total_count, items
 La items:
 - type: string, are forma: tip.subtip.etc... deocamdata avem doar: msg_added.offer.ID, msg_added.question.ID, msg_added.comment.ID unde ID este id-ul comentariului/ofertei
 Payload-ul mesajului push contine tot ce este in aux + type-ul intr-un json
 Pt. type in viitor am putea avea "new_version", "special_offer", etc. iar in aux si payload vom adauga "external_url" care va fi deschis in browser pt. valorile de type care nu sunt recunoscute de aplicatie.
 
 
 "notification_viewed"
 - notification_id - id-ul din "list_notifications"
 In metoda "list_notifications" am adugat in aux "offer_id" pentru comentariile care sunt in legatura cu o oferta.
 ( valabil pt. type=msg_added.question.ID si type=msg_added.offer.ID )
 In acest caz click-ul pe o notificare din https://marvelapp.com/2511ee4#11187635 ar tb. sa duca pe comentariile ofertei.
 De asemenea, "offer_id" este trimis si in payload-ul mesajului push. ( care nu pare sa functioneze, mobilepn.t1.ro trimite mai departe mesajul? )
 */

//METODA_NOTIFICATION_VIEWED
-(void) notification_viewed :(NSString *)AUTHTOKEN :(NSString *)notification_id {
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
       ///     [MBProgressHUD hideAllHUDsForView:self.navigationController.visibleViewController.view animated:YES];
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
        [dic2 setObject:notification_id forKey:@"notification_id"];
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic2 options:0 error:&err];
        NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        compus =[NSString stringWithFormat:@"%@%@",METODA_NOTIFICATION_VIEWED, myString];
        
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
                    NSDictionary *multedate = REZULTAT_NOTIFY_COUNT[@"data"];
                    NSLog(@"date motificare citita %@",multedate);
                    
                   // [self.LISTASELECT reloadData];
                    [self removehud];
                    
                    }
                }
        }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
                [self removehud];
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


-(bool)checkDictionary:(NSDictionary *)dict{
    if(dict == nil || [dict class] == [NSNull class] || ![dict isKindOfClass:[NSDictionary class]]){
        return NO;
    }
    return  YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)addhud{
    [MBProgressHUD showHUDAddedTo:self.navigationController.visibleViewController.view animated:YES];
}
-(void)removehud{
    [MBProgressHUD hideAllHUDsForView:self.navigationController.visibleViewController.view animated:YES];
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
             [self removehud];
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Eroare" message:@"Telefonul tău nu este conectat la internet. Te rugăm să încerci mai târziu" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertView show];
        ////    [MBProgressHUD hideAllHUDsForView:self.navigationController.visibleViewController.view animated:YES];
           
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
                        
                        
                        NSMutableDictionary *cererepiesa=[[NSMutableDictionary alloc]init];
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
                        [cererepiesa setObject:IDCERERE forKey:@"IDCERERE"];
                        [cererepiesa setObject:multedate forKey:@"CEREREFULLINFO"];
                        //   if(DETALIUCERERE[@"CEREREFULLINFO"][@"cerere"][@"id"]) {
                        //  if(DETALIUCERERE[@"discussions"]) {
                        if(DETALIUCERERE[@"discussions"]) {
                            [cererepiesa setObject:DETALIUCERERE[@"discussions"] forKey:@"discussions"];
                        }
             
                        EcranMesajeViewController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"EcranMesajeViewControllerVC"];
                        vc.CE_TIP_E=@"dinnotificari";
                        vc.lastmessageid = messageid;
                        vc.CORPDATE =cererepiesa;
                        [self.navigationController pushViewController:vc animated:YES];
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
-(void)list_notifications_refresh :(NSString *)AUTHTOKEN {
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
              self.listaNOTIFICARI = multedate;
                    _currentPage_notificari=1;
                    titluriCAMPURI=[[NSMutableArray alloc]init];
                    self.listaNOTIFICARI= listaNOTIFICARI;
                    int  round =0;
                    if( listaNOTIFICARI[@"total_count"]) {
                        int  cateintotalrezolvate =[listaNOTIFICARI[@"total_count"] intValue];
                        double originalFloat =(double)cateintotalrezolvate/ PE_PAGINA.intValue;
                        NSLog(@"originalFloat %f / %i ** %i %f", originalFloat,PE_PAGINA.intValue,[listaNOTIFICARI[@"total_count"] intValue],(double)cateintotalrezolvate/ PE_PAGINA.intValue );
                        if(originalFloat - (int)originalFloat > 0) {
                            originalFloat += 1;
                            round = (int)originalFloat;
                            
                        } else {
                            round = (int)originalFloat;
                        }
                    }
                    catepagininotificari =round;
                    /*"items":[{"id":2,"type":"msg_added.question.1826901","title":"Ai o \u00eentrebare nou\u0103","date_added":1463770784,"is_viewed":0,"date_added_formatted":"20 mai 2016, 21:59","aux":{"cerere_id":342741}},{"id":1,"type":"msg_added.question.1826900","title":"Ai o \u00eentrebare nou\u0103","date_added":1463769980,"is_viewed":1,"date_added_formatted":"20 mai 2016, 21:46","aux":{"cerere_id":342741}}]}}
                     if(listaNOTIFICARI[@"items"]) {*/
                    
                    if(listaNOTIFICARI[@"items"]) {
                        
                        titluriCAMPURI =[NSMutableArray arrayWithArray: listaNOTIFICARI[@"items"]];
                    }
                    
                    NSLog(@"notificari %@", titluriCAMPURI);
                    if(titluriCAMPURI.count ==0) {
                        nusuntnotificari.text =@"Momentan nu sunt notificări";
                        nusuntnotificari.hidden=NO;
                    } else {
                        nusuntnotificari.text =@"";
                        nusuntnotificari.hidden=YES;
                    }
                    [self reloadsectiunea12];
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


