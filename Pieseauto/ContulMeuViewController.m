//
//  ContulMeuViewController.m
//  Pieseauto
//
//  Created by Ioan Ungureanu on 25/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//
#import "utile.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"
#import "ContulMeuViewController.h"
#import "CellContulMeuRow.h"
#import "TutorialHomeViewController.h"
#import <CoreText/CoreText.h>
#import "SetariViewController.h"
#import "CustomBadge.h"
#import "ListaNotificari.h"
#import "DetaliuProfil.h"
#import "Reachability.h"
#import "EcranCalificative.h"
#import "WebViewController.h"
#import "butoncustomback.h"
#import "ListaMasiniUserViewController.h"
#import "CererileMeleViewController.h"
#import "choseLoginview.h"
@interface ContulMeuViewController(){
    NSMutableArray* Cells_Array;
}
@end

@implementation ContulMeuViewController
@synthesize  LISTASELECT,titluriCAMPURI,pozeCAMPURI,barajos;
-(void)addhud{
    [MBProgressHUD showHUDAddedTo:self.navigationController.visibleViewController.view animated:YES];
}
-(void)removehud{
    [MBProgressHUD hideAllHUDsForView:self.navigationController.visibleViewController.view animated:YES];
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
-(void)viewWillAppear:(BOOL)animated {
    utilitar = [[Utile alloc]init];
    NSString *authtoken=@"";
    BOOL elogat = NO;
    elogat = [utilitar eLogat];
    if(elogat) {
        authtoken = [utilitar AUTHTOKEN];
        //  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       [self getnotify_count:authtoken];
        
        // });
    }
    NSLog(@"contul meu 4");
    self.titluriCAMPURI =[[NSMutableArray alloc]init];
    self.pozeCAMPURI =[[NSMutableArray alloc]init];
    self.pozeCAMPURI =@[@"",@"Icon_Profil_Line_144x144.png",@"Icon_Setari_Line_144x144.png",@"Icon_Notificari_Line_Blue_144x144.png", @"Icon_Acorda_Calificativ_Star_Line_144x144.png",@"Icon_Ajutor_Line_144x144.png",@"",@"Icon_Log_Out_Line_144x144.png"];
    
    self.titluriCAMPURI =@[@"",@"Detalii profil",@"Setări",@"Notificări", @"Calificative",@"Ajutor",@"",@"Log Out"];
    LISTASELECT.delegate =self;
    LISTASELECT.dataSource =self;
    LISTASELECT.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
   
       [self.navigationController setNavigationBarHidden:NO]; self.navigationItem.leftBarButtonItem=nil;
     self.title = @"Contul meu";
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
    self.view.backgroundColor =[UIColor lightGrayColor];
    [self barajosmadeit];
    [self removehud];
}

-(void) perfecttimeforback{
    for(UIButton *view in  self.navigationController.navigationBar.subviews) {
        if([view isKindOfClass:[butoncustomback class]]){
            [view removeFromSuperview];
        }
    }
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.LISTASELECT reloadData];
    
//    self.navigationItem.backBarButtonItem =
//    [[UIBarButtonItem alloc] initWithTitle:@"Înapoi"
//                                     style:UIBarButtonItemStylePlain
//                                    target:nil
//                                    action:nil];
//    
    // Do any additional setup after loading the view, typically from a nib.
  
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titluriCAMPURI.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger ipx = indexPath.row;
    double inaltimerand =44;
    if(ipx ==0) {
        inaltimerand =38;
    } else if(ipx ==6) {
    inaltimerand = 14;
    }
    return  inaltimerand;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//    }
}
-(void)viewDidLayoutSubviews
{
    if ([self.LISTASELECT respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.LISTASELECT setSeparatorInset:UIEdgeInsetsZero];
    }
    
//    if ([self.LISTASELECT respondsToSelector:@selector(setLayoutMargins:)]) {
//        [self.LISTASELECT setLayoutMargins:UIEdgeInsetsZero];
//    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger ipx = indexPath.row;
    
    static NSString *CellIdentifier = @"CellContulMeuRow";
    CellContulMeuRow *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (CellContulMeuRow*)[tableView dequeueReusableCellWithIdentifier:@"CellContulMeuRow"];
    }
    if ([cell.contentView subviews]){
        for (UIView *subview in [cell.contentView subviews]) {
            if([subview isKindOfClass:[CustomBadge class]]){
                [subview removeFromSuperview];
            }
        }
    }

    cell.TitluRand.hidden =NO;
    cell.TitluRandUNU.hidden =YES;
    cell.sageatablue.hidden =NO;
    cell.labelModifica.hidden=YES;
    cell.imgModifica.hidden =YES;
    cell.CONTINUTRand.hidden=YES;
    if(ipx ==7) {
        cell.TitluRand.textColor =[UIColor redColor];
        cell.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1];
        cell.pozaRow.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [pozeCAMPURI objectAtIndex:ipx]]];
        cell.pozaRow.hidden =NO;
        cell.pozaRow.contentMode =UIViewContentModeScaleAspectFit;
        cell.TitluRand.text =[NSString stringWithFormat:@"%@",[titluriCAMPURI objectAtIndex:ipx]];
       // [cell.TitluRand sizeToFit];
    } else if(ipx ==0 ) {
       cell.backgroundColor = [UIColor colorWithRed:(240/255.0f) green:(240/255.0f) blue:(240/255.0f) alpha:1];
       cell.pozaRow.hidden =YES;
       cell.TitluRand.textColor = [UIColor blackColor];
       cell.sageatablue.hidden =YES;
       utilitar= [[Utile alloc]init];
       NSDictionary *userd = [DataMasterProcessor getLOGEDACCOUNT];
       NSString *U_prenume=  [NSString stringWithFormat:@"%@",userd[@"U_prenume"]];
       NSString *U_nume=  [NSString stringWithFormat:@"%@",userd[@"U_nume"]];
       NSString *usernamesaunumeprenume =@"";
       if(![self MyStringisEmpty:U_prenume] || ![self MyStringisEmpty:U_nume]) {
           usernamesaunumeprenume =  [NSString stringWithFormat:@"%@ %@", U_prenume, U_nume];
       }
       else if (userd[@"U_username"]) {
           usernamesaunumeprenume = [NSString stringWithFormat:@"%@",userd[@"U_username"]];
       }
       cell.pozaRow.image = nil;
       cell.pozaRow.hidden =YES;
       cell.TitluRand.hidden =YES;
       cell.TitluRandUNU.text =usernamesaunumeprenume;
       cell.TitluRandUNU.hidden=NO;
   } else if(ipx==6 ) {
       cell.backgroundColor = [UIColor colorWithRed:(240/255.0f) green:(240/255.0f) blue:(240/255.0f) alpha:1];
       cell.pozaRow.hidden =YES;
       cell.pozaRow.image = nil;
       cell.sageatablue.hidden =YES;
       cell.TitluRand.hidden =YES;
   }
   else {
       cell.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1];
       cell.pozaRow.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [pozeCAMPURI objectAtIndex:ipx]]];
       cell.pozaRow.hidden =NO;
       cell.pozaRow.contentMode =UIViewContentModeScaleAspectFit;
       cell.TitluRand.textColor =  [UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] ;
       cell.TitluRand.text =[NSString stringWithFormat:@"%@",[titluriCAMPURI objectAtIndex:ipx]];
     //  [cell.TitluRand sizeToFit];
     

       CGRect titluframe = cell.TitluRand.frame;
       //valori pt badge -> done
       
       //  CGRect framenecesar = CGRectMake(titluframe.origin.x+ titluframe.size.width +12, cell.contentView.frame.size.height/2 -12  , 40, 40);
       CGRect framenecesar = cell.customBAADGE.frame;
       //       framenecesar.origin.x=titluframe.origin.x+ titluframe.size.width +12;
       framenecesar.origin.y= 9.5; //e fixa.. 44 /2  - 25/2 ...
       
       AppDelegate * del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
       if(del.NOTIFY_COUNT) {
           NSDictionary *notifs= [[NSDictionary alloc]init];
           notifs =del.NOTIFY_COUNT;
           if(ipx == 3) {
               if(notifs[@"unread_notifications_count"]) {
                   NSString *mybadgenr =@"";
                   mybadgenr  = [NSString stringWithFormat:@"%@",notifs[@"unread_notifications_count"]];
                   NSLog(@"my notif %li", (long)mybadgenr.integerValue);
                  if(mybadgenr.integerValue >0) {
                  CustomBadge *badge1 = [CustomBadge customBadgeWithString:mybadgenr:framenecesar];
                   CGRect badgeframe = badge1.frame;
                   badgeframe.origin.x = framenecesar.origin.x;
                   badgeframe.origin.y = framenecesar.origin.y;
                   [cell.contentView addSubview:badge1];
                   }
               }
           }
           if(ipx == 4) {
               if(notifs[@"feedback_needed_count"]) {
                   NSString *mybadgenr =@"";
                   mybadgenr  = [NSString stringWithFormat:@"%@",notifs[@"feedback_needed_count"]];
                   NSLog(@"my feedb %li", (long)mybadgenr.integerValue);
                   if(mybadgenr.integerValue >0) {
                   CustomBadge *badge1 = [CustomBadge customBadgeWithString:mybadgenr:framenecesar];
                   CGRect badgeframe = badge1.frame;
                   badgeframe.origin.x = framenecesar.origin.x;
                   badgeframe.origin.y = framenecesar.origin.y;
                   [cell.contentView addSubview:badge1];
                   }
               }
           }
        }
   }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // [LISTASELECT cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}
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
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    return manager;
}
-(void)gotodetaliuProfil :(NSMutableDictionary*) multedate {
   [self removehud];
    DetaliuProfil *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetaliuProfilVC"];
    vc.PROFILULMEU =YES;
    vc._currentPage_toate=1;
    vc.DATEPROFIL =[[NSMutableDictionary alloc]init];
    vc.DATEPROFIL =multedate;
    [self.navigationController pushViewController:vc animated:YES ];
    
}
//METODA_LIST_NOTIFICATIONS

/*echo 'm=list_notifications&p={"authtoken":"1248f7g57598af9gY-rG3EWf2J6BWvmnTb-E9YfV2dzIwu0ucBsehvaL7KY","os":"iOS","lang":"ro","version":"9.2.1","page":"1","per_page":"20"}' | curl --tlsv1 --cacert ./dev5.activesoft.crt --data @- -- https://dev5.activesoft.ro:277/*/
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
                    ListaNotificari *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ListaNotificariVC"];
                    vc.listaNOTIFICARI =multedate;
                   [self.navigationController pushViewController:vc animated:YES ];
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



//METODA_GET_MEMBER_PROFILE @"m=get_member_profile&p=" user_id username
-(void)get_member_profile :(NSString *)userid :(NSString *)AUTHTOKEN :(NSString *)tipuserid { //user_id sau username
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
        NSString *TIP_userid= tipuserid;
        if([TIP_userid isEqualToString:@"user_id"]) {
            [dic2 setObject:userid forKey:@"user_id"];
        }
        if([TIP_userid isEqualToString:@"username"]) {
            [dic2 setObject:userid forKey:@"username"];
        }
        
       // "per_page":"20","page":"1"
         [dic2 setObject:@"20" forKey:@"per_page"];
         [dic2 setObject:@"1" forKey:@"page"];
        
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic2 options:0 error:&err];
        NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        compus =[NSString stringWithFormat:@"%@%@",METODA_GET_MEMBER_PROFILE, myString];
        
        
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
                    NSMutableDictionary *multedate = REZULTAT_NOTIFY_COUNT[@"data"];
                    //   NSLog(@"date get_member_profile %@",multedate);
                    [self gotodetaliuProfil:multedate];
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger ipx = indexPath.row;
    //   CellChooseLogin *CELL = (CellChooseLogin *)[LISTASELECT cellForRowAtIndexPath:indexPath];
    switch (ipx) {
        case 0: case 6: {
            NSLog(@"nothing to do");
            break;
        }
        case 1: {
            //Detalii profil
            
            NSLog(@"detalii profil");
            utilitar = [[Utile alloc]init];
            NSString *authtoken=@"";
            BOOL elogat = NO;
            elogat = [utilitar eLogat];
            if(elogat) {
                NSString *usernamesauid=@"";
                NSDictionary *userlogat = [DataMasterProcessor getLOGEDACCOUNT];
                authtoken = [utilitar AUTHTOKEN];
                //(void)get_member_profile :(NSString *)userid :(NSString *)AUTHTOKEN :(NSString *)tipuserid{ //user_id sau username
                if(userlogat[@"U_userid"]) {
                    usernamesauid =[NSString stringWithFormat:@"%@",userlogat[@"U_userid"]];
                    [self get_member_profile:usernamesauid :authtoken :@"user_id"];
                } else if(userlogat[@"U_username"]) {
                    usernamesauid =[NSString stringWithFormat:@"%@",userlogat[@"U_username"]];
                    [self get_member_profile:usernamesauid :authtoken :@"username"];
                }
            }
                break;
            
        }
        case 2: {
            SetariViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SetariVC"];
            [self.navigationController pushViewController:vc animated:YES ];
            break;
        }
        case 3: {
           //list_not
            utilitar = [[Utile alloc]init];
            NSString *authtoken=@"";
            BOOL elogat = NO;
            elogat = [utilitar eLogat];
            if(elogat) {
                authtoken = [utilitar AUTHTOKEN];
                [self list_notifications:authtoken];
            }
            break;
        }
        case 4: {
            EcranCalificative *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"EcranCalificativeVC"];
            [self.navigationController pushViewController:vc animated:YES ];
            break;
        }
        case 5: {
            //link  afla mai multe
            NSUserDefaults* prefs=[NSUserDefaults standardUserDefaults];
            if([prefs objectForKey:@"url_tutorial"]) {
                NSString *url_tutorial = [NSString stringWithFormat:@"%@",[prefs objectForKey:@"url_tutorial"]];
                if(![self MyStringisEmpty:url_tutorial])
                {
                    [self addhud];
                    NSString *usertutorialspecialios = [NSString stringWithFormat:@"%@&os=ios",url_tutorial];
                    WebViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewVC"];
                    vc.dinhelp=YES;
                    vc.urlPiesesimilare = usertutorialspecialios;
                    vc.mWebView.scalesPageToFit = YES;
                    vc.title=@"Află mai multe";
                    [self.navigationController pushViewController:vc animated:YES ];
                }
            }

            
            break;
        }
        case 7: {
            utilitar= [[Utile alloc]init];
            [utilitar doLogout];
         //   dispatch_async(dispatch_get_main_queue(), ^{
                [utilitar mergiLaMainViewVC];
         //   });
           
            break;
        }
            
        default:
            break;
    }
}


/*- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
 NSArray *cells = [self.LISTASELECT visibleCells];
 for(UIView *view in cells){
 if([view isMemberOfClass:[CellChoose4 class]]){
 CellChoose4 *cell = (CellChoose4 *) view;
 UITextField *tf = (UITextField *)[cell texteditabil];
 if(tf.tag == textField.tag) {
 if([tf.text isEqualToString:@"\n"]) {
 [self inchideTastatura];
 return NO;
 }
 }
 }
 }
 
 
 
 return YES;
 
 }*/


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    switch ((int)textField.tag) {
        case 10:
        {
            NSLog(@"nothing");
         }
            break;
        case 11:
        {
            NSLog(@"email");
        }
            break;
        case 12:
        {
            NSLog(@"parola");
            break;
        }
         default:
            break;
    }
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            /// else contul meu nu face nimic - esti deja aici
            ///    ContulMeuViewController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"ContulMeuViewVC"];
            ///    [self.navigationController pushViewController:vc animated:NO];
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
-(NSDictionary*)updatenotify_count :(NSDictionary*)getnotify_count {
    NSDictionary *notify_count = getnotify_count;
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    del.NOTIFY_COUNT = [[NSDictionary alloc]init]; //se goleste mereu la login si logout
    del.NOTIFY_COUNT = notify_count;
    NSLog(@"del.NOTIFY_COUNT %@",del.NOTIFY_COUNT);
    //"feedback_needed_count":0,"unread_offers_count":0}}
    [self.LISTASELECT reloadData];
    [self barajosmadeit];
    return notify_count;
}

@end


