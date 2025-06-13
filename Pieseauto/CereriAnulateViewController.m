//
//  CereriAnulateViewController.m
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
#import "CereriAnulateViewController.h"
#import "CellListaCereriRow.h"
#import "TutorialHomeViewController.h"
#import <CoreText/CoreText.h>
#import "SetariViewController.h"
#import "OferteLaCerereViewController.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "butoncustomback.h"
#import "ListaMasiniUserViewController.h"
#import "CererileMeleViewController.h"
#import "choseLoginview.h"
#import "ContulMeuViewController.h"

static NSString *PE_PAGINA = @"20";
@interface CereriAnulateViewController(){
    NSMutableArray* Cells_Array;
}
@end

@implementation CereriAnulateViewController
@synthesize  LISTASELECT,totalcererianulate,ANULATE,_currentPageAnulate,numarpaginianulate,barajos;

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

-(void)addhud{
    [MBProgressHUD showHUDAddedTo:self.navigationController.visibleViewController.view animated:YES];
}
-(void)removehud{
    [MBProgressHUD hideAllHUDsForView:self.navigationController.visibleViewController.view animated:YES];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    LISTASELECT.delegate =self;
    LISTASELECT.dataSource =self;
    LISTASELECT.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
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
-(void)perfecttimeforback{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)viewWillAppear:(BOOL)animated {
    self.title = @"Cereri anulate";
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

    _currentPageAnulate=1;
    NSString *paginacurentastring = [NSString stringWithFormat:@"%i",_currentPageAnulate];
    utilitar = [[Utile alloc]init];
    NSString *authtoken=@"";
    BOOL elogat = NO;
    ANULATE= [[NSMutableArray alloc]init];
    elogat = [utilitar eLogat];
    if(elogat) {
        authtoken = [utilitar AUTHTOKEN];
      [self list_cereri:authtoken :paginacurentastring :PE_PAGINA :@"cancelled"];
        
   }
   NSLog(@"_currentPageAnulate %i numarpaginianulate %i", _currentPageAnulate,numarpaginianulate);
   [self barajosmadeit];
}


-(void) list_cereri :(NSString *)AUTHTOKEN :(NSString *)PAGE :(NSString *)PER_PAGE :(NSString *)STATUS{
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
         ///   [MBProgressHUD hideAllHUDsForView:self.navigationController.visibleViewController.view animated:YES];
           
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
                    if([STATUS isEqualToString:@"cancelled"]) {
                        if( multedate[@"count_cancelled"]) {
                            int  cateintotalanulate =[multedate[@"count_cancelled"] intValue];
                            totalcererianulate = cateintotalanulate;
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
                            [self update_list_cereri:multecereri:STATUS];
                            
                        } else {
                             [self removehud];
                        }
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
            [self removehud];
        }];
        [[NSOperationQueue mainQueue] addOperation:op];
    }
}
-(NSMutableArray*)update_list_cereri :(NSMutableArray *)get_list_cereri :(NSString *)status {
     [self removehud];
    NSMutableArray *lista_cereri = get_list_cereri;
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    del.ARRAYCERERI_ANULATE =[[NSMutableArray alloc]init];
        if([status isEqualToString:@"cancelled"]) {
            for(NSDictionary *itemnou in lista_cereri) {
                if(![ANULATE containsObject:itemnou]) {
                    [ANULATE addObject:itemnou];
                }
            }
           
            del.ARRAYCERERI_ANULATE = ANULATE;
            NSLog(@"anulate %@", ANULATE);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.LISTASELECT reloadData];
            });
 }
    return lista_cereri;
}
-(void) mergi_la_oferte :(NSDictionary*) corpraspuns {
    [self removehud];
    NSMutableDictionary *DETALIICERERE = [NSMutableDictionary dictionaryWithDictionary:corpraspuns];
    [DETALIICERERE setObject:@"1" forKey:@"pagina_curenta_trimisa"];
    [DETALIICERERE setObject:@"0" forKey:@"pagina_curenta_preferate"];
    OferteLaCerereViewController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"OferteLaCerereVC"];
    vc.E_DIN_DETALIU_CERERE =NO;
    vc.CORPDATE = DETALIICERERE;
    [self.navigationController pushViewController:vc animated:NO];
}
-(void) list_offers_per_cerere :(NSString *)AUTHTOKEN :(NSString *)PAGE :(NSString *)PER_PAGE :(NSString *)cerere_id :(NSString *)prefered_only :(NSString*)cerere_details{
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
                //{"errors":{},"data":{"items":[{"id":342551,"title":"Test","nr_offers":0,"nr_unread_offers":0},{"id":342550,"title":"Test","nr_offers":0,"nr_unread_offers":0},{"id":342549,"title":"Test","nr_offers":0,"nr_unread_offers":0}],"total_count":3}}
                NSDictionary *multedate = REZULTAT_NOTIFY_COUNT[@"data"];
                NSLog(@"date cerere raspuns %@",multedate);
                [self mergi_la_oferte:multedate];
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
        [self removehud];
        
    }];
    [[NSOperationQueue mainQueue] addOperation:op];
    }
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numarranduri =0;
    numarranduri = ANULATE.count;
   return numarranduri;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger ipx= indexPath.row;
    double inaltimerand =75;
         if(ANULATE.count>0) {
               if([ANULATE objectAtIndex:ipx] !=(NSDictionary*) [NSNull null]  ) {
                NSDictionary *cerererow = [[NSDictionary alloc]init];
                cerererow = [ANULATE objectAtIndex:ipx];
                NSString *C_titlu = [NSString stringWithFormat:@"%@",cerererow[@"title"]];
                CGFloat widthWithInsetsApplied = self.view.frame.size.width -24;
                CGSize textSize = [C_titlu boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
                inaltimerand= textSize.height + 45; //pentru ca avem si nr oferte label
             ////   NSLog(@"inaltimerand %f",inaltimerand);
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
-(void)launchReload {
    //  pagina curenta anulate _currentPageAnulate
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
    cell.sageatablue.hidden =NO;
    cell.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1];
    cell.pozaRow.hidden =YES;
    cell.pozaRow.contentMode =UIViewContentModeScaleAspectFit;
    cell.TitluRand.textColor =  [UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] ;
    cell.numaroferteRand.hidden =YES;
    cell.labelanulate.hidden=YES;
    NSDictionary *cerererow =[[NSDictionary alloc]init];
        cell.sageatagri.hidden=YES;
        cell.labelanulate.hidden=YES;
        if(ANULATE.count !=0) {
            cerererow = [ANULATE objectAtIndex:ipx];
            if(cerererow !=(NSDictionary*) [NSNull null] ) {
                NSString *C_titlu = [NSString stringWithFormat:@"%@",cerererow[@"title"]];
                NSString *C_numaroferte = [NSString stringWithFormat:@"%@",cerererow[@"nr_offers"]];
                NSString *compus_nr_oferte = [NSString stringWithFormat:@"%@ Oferte", C_numaroferte];
                NSString *C_ofertenevazute = [NSString stringWithFormat:@"%@",cerererow[@"nr_unread_offers"]];
                
                CGFloat widthWithInsetsApplied = self.view.frame.size.width;
                widthWithInsetsApplied = self.view.frame.size.width - 24;
                double inaltimerand=0;
                CGSize textSize = [C_titlu boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
                inaltimerand= textSize.height;
                cell.dynamictitluheight.constant = inaltimerand +5;
                 cell.TitluRand.text = C_titlu;
                cell.numaroferteRand.text = compus_nr_oferte;
                cell.TitluRand.hidden=NO;
                cell.numaroferteRand.hidden=NO;
                [cell.numaroferteRand sizeToFit];
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
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
         if (indexPath.row == [ANULATE count] - 1)
        {
            [self launchReload];
        }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger ipx = indexPath.row;
    NSDictionary *cerererow =[[NSDictionary alloc]init];
    cerererow = [ANULATE objectAtIndex:ipx];
    NSLog(@"cerereeeee %@", cerererow);
    if([self checkDictionary:cerererow] && cerererow[@"id"]) {
        utilitar = [[Utile alloc]init];
        NSString *authtoken=@"";
        BOOL elogat = NO;
        elogat = [utilitar eLogat];
        if(elogat) {
            authtoken = [utilitar AUTHTOKEN];
            NSString *cerereID = [NSString stringWithFormat:@"%@", cerererow[@"id"]];
            // list_offers_per_cerere :(NSString *)AUTHTOKEN :(NSString *)PAGE :(NSString *)PER_PAGE :(NSString *)cerere_id :(NSString *)prefered_only  :(NSString*)cerere_details
            //prefered_only =0 sau 1 toate sau numai cele preferate
            [self list_offers_per_cerere:authtoken :@"1" :PE_PAGINA :cerereID  :@"0" :@"1"];
        }
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
        }
        if(i==2) {
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

@end

