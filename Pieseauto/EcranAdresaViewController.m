//
//  EcranAdresaViewController.m
//  Pieseauto
//
//  Created by Ioan Ungureanu on 24/02/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//
#import "utile.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"
#import "EcranAdresaViewController.h"
#import "CellChoose4.h"
#import "TutorialHomeViewController.h"
#import <CoreText/CoreText.h>
#import <QuartzCore/QuartzCore.h>
#import "chooseview.h"
#import "choose4view.h"
#import "Reachability.h"
#import "butoncustomback.h"

@interface EcranAdresaViewController(){
    NSMutableArray* Cells_Array;
}
@end

@implementation EcranAdresaViewController
@synthesize  LISTASELECT,titluriCAMPURI,CE_TIP_E,dynamicHEIGHTTEXTVIEW;
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
   AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSDictionary *userd =[[NSDictionary alloc]init];
    if(  del.modificariDateComanda==YES) {
   userd =[NSDictionary dictionaryWithDictionary:del.CLONADATEUSER];
     } else {
    userd = [DataMasterProcessor getLOGEDACCOUNT];
   }
    NSString *localitateid =@"";
    NSString *judetid  =@"";
    NSString *codpostal =@"";
    NSString *adresa =@"";
    NSMutableDictionary *judbazafull =[[NSMutableDictionary alloc]init];
    [judbazafull setObject:@"" forKey:@"id"];
    [judbazafull setObject:@"" forKey:@"name"];
    NSMutableDictionary *localitatebazafull =[[NSMutableDictionary alloc]init];
    [localitatebazafull setObject:@"" forKey:@"id"];
    [localitatebazafull setObject:@"" forKey:@"name"];
    
    if(userd[@"U_judet"] && ![self MyStringisEmpty:[NSString stringWithFormat:@"%@",userd[@"U_judet"]]]) {
        NSLog(@"ios 9 %@", userd[@"U_judet"]);
        judetid = [NSString stringWithFormat:@"%@",userd[@"U_judet"]];
      
        NSDictionary *judbaza = [DataMasterProcessor getJudet:judetid];
        if(judbaza && judbaza[@"name"] && judbaza[@"id"]) {
            NSString *judid =[NSString stringWithFormat:@"%@", judbaza[@"id"]];
            NSString *judname =[NSString stringWithFormat:@"%@", judbaza[@"name"]];
            [judbazafull setObject:judid forKey:@"id"];
            [judbazafull setObject:judname forKey:@"name"];
        }
          NSLog(@"ola chica %@",judbaza );
    }
    
    if(userd[@"U_localitate"] && ![self MyStringisEmpty:[NSString stringWithFormat:@"%@",userd[@"U_localitate"]]]) {
        localitateid = [NSString stringWithFormat:@"%@",userd[@"U_localitate"]];
        NSDictionary * localitatebaza = [DataMasterProcessor getLocalitate:localitateid];
        if(localitatebaza && localitatebaza[@"name"] && localitatebaza[@"id"]) {
            NSString *locid =[NSString stringWithFormat:@"%@", localitatebaza[@"id"]];
            NSString *locname =[NSString stringWithFormat:@"%@", localitatebaza[@"name"]];
            [localitatebazafull setObject:locid forKey:@"id"];
            [localitatebazafull setObject:locname forKey:@"name"];
        }
    }
    
    if(userd[@"U_cod_postal"] && ![self MyStringisEmpty:[NSString stringWithFormat:@"%@",userd[@"U_cod_postal"]]])
        codpostal = [NSString stringWithFormat:@"%@",userd[@"U_cod_postal"]];
    
    if(userd[@"U_adresa"] && ![self MyStringisEmpty:[NSString stringWithFormat:@"%@",userd[@"U_adresa"]]])
        adresa = [NSString stringWithFormat:@"%@",userd[@"U_adresa"]];
    
    self.titluriCAMPURI =@[@"Județ",judbazafull,@"Localitate",localitatebazafull,@"Cod poștal",codpostal,@"Adresa",adresa];
    
    LISTASELECT.dataSource =self;
    LISTASELECT.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [LISTASELECT reloadData];
   }
-(BOOL)MyStringisEmpty:(NSString *)str
{
    if(str.length==0 || [str isKindOfClass:[NSNull class]] || [str isEqualToString:@""]||[str  isEqualToString:@"NULL"]||[str isEqualToString:@"(null)"]|| [str isEqualToString:@"<null>"] || [str isEqualToString:@"null"] ||str==nil){
        return YES;
    }
    return NO;
}

-(void)gata{
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //chestii finale -> send la server toate modificarile
    utilitar = [[Utile alloc]init];
    NSString *authtoken=@"";
    BOOL elogat = NO;
    elogat = [utilitar eLogat];
    if(elogat) {
        authtoken = [utilitar AUTHTOKEN];
    }
        if([CE_TIP_E isEqualToString:@"adresa"]) {
            NSLog(@"nu uita x %@", self.titluriCAMPURI);
          //   self.titluriCAMPURI =@[@"Județ",judbazafull,@"Localitate",localitatebazafull,@"Cod poștal",codpostal,@"Adresa",adresa];
            BOOL okey1 =NO;
            BOOL okey2 =NO;
            BOOL okey3 =NO;
            BOOL okey4 =NO;
            BOOL okey5 =NO;
            NSDictionary *judet= [self.titluriCAMPURI objectAtIndex:1];
            NSDictionary *localitate= [self.titluriCAMPURI objectAtIndex:3];
            NSString *codpostal = [self.titluriCAMPURI objectAtIndex:5];
            NSString *adresa = [self.titluriCAMPURI objectAtIndex:7];
            NSString *eroarejudet =@"- judetul";
            NSString *eroarelocalitate =@"- localitatea";
           // NSString *eroarecodpostal =@"- codul postal";
            NSString *eroareadresa =@"- adresa";
            NSString *judetid =@"";
            NSString *localitateid =@"";
            if(judet && judet[@"id"]) {
                judetid = [NSString stringWithFormat:@"%@",judet[@"id"]];
                if(![self MyStringisEmpty:judetid]) {
                    okey1=YES;
                    eroarejudet =@"";
                }
            }
            if(localitate && localitate[@"id"]) {
                 localitateid = [NSString stringWithFormat:@"%@",localitate[@"id"]];
                if(![self MyStringisEmpty:localitateid]) {
                    okey2=YES;
                     eroarelocalitate =@"";
                }
            }
            okey3=YES;
//           if(![self MyStringisEmpty:codpostal]) {
//              okey3=YES;
//               eroarecodpostal =@"";
//                }
            if(![self MyStringisEmpty:adresa]) {
                okey4=YES;
                eroareadresa =@"";
            }
            
            NSString *eroarecompus = [NSString stringWithFormat:@"Nu ai completat: %@ %@ %@", eroarejudet,eroarelocalitate,/*eroarecodpostal,*/eroareadresa];
            okey5 =okey1 && okey2 && okey3 && okey4;
            if(okey5 ==NO) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                    message:eroarecompus
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                [alertView show];

            } else {
                //do insert
                if(del.modificariDateComanda ==YES) {
                     NSMutableDictionary *modat = [NSMutableDictionary dictionaryWithDictionary:del.CLONADATEUSER];
                    [modat setObject:adresa forKey:@"U_adresa"];
                    [modat setObject:localitateid forKey:@"U_localitate"];
                    [modat setObject:judetid forKey:@"U_judet"];
                    [modat setObject:codpostal forKey:@"U_cod_postal"];
                    del.CLONADATEUSER =modat;
                    NSLog(@"clonda %@",del.CLONADATEUSER);
                } else {
                NSMutableDictionary *DATEUSER=[[NSMutableDictionary alloc]init];
                [DATEUSER setObject:adresa forKey:@"U_adresa"];
                [DATEUSER setObject:localitateid forKey:@"U_localitate"];
                [DATEUSER setObject:judetid forKey:@"U_judet"];
                [DATEUSER setObject:codpostal forKey:@"U_cod_postal"];
                [self editProfile:authtoken  :DATEUSER :@"adresacompleta"];
             }
            }
            
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
    //  manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    return manager;
}

//METODA_EDIT_PROFILE
-(void)editProfile :(NSString *)AUTHTOKEN :(NSMutableDictionary *)DATEUSER :(NSString *)tip_date{
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
        NSMutableDictionary *datedetrimis = [[NSMutableDictionary alloc]init];
        datedetrimis =DATEUSER;
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
         NSString *U_cod_postal =@"";
         NSString *U_localitate=@"";
         NSString *U_adresa=@"";
         NSString *U_judet=@"";
         if([tip_date isEqualToString:@"adresacompleta"]) {
            if(DATEUSER[@"U_cod_postal"]) {
                U_cod_postal=  [NSString stringWithFormat:@"%@",DATEUSER[@"U_cod_postal"]];
                [dic2 setObject:U_cod_postal forKey:@"zip_code"];
            }
            if(DATEUSER[@"U_localitate"]) {
                U_localitate=  [NSString stringWithFormat:@"%@",DATEUSER[@"U_localitate"]];
                [dic2 setObject:U_localitate forKey:@"localitate_id"];
            }
            if(DATEUSER[@"U_adresa"]) {
               U_adresa=  [NSString stringWithFormat:@"%@",DATEUSER[@"U_adresa"]];
                [dic2 setObject:U_adresa forKey:@"address"];
            }
            if(DATEUSER[@"U_judet"]) {
               U_judet=  [NSString stringWithFormat:@"%@",DATEUSER[@"U_judet"]];
            }
        
        NSDictionary *userd =[DataMasterProcessor getLOGEDACCOUNT];
 
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic2 options:0 error:&err];
        NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        compus =[NSString stringWithFormat:@"%@%@",METODA_EDIT_PROFILE, myString];
        
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
                    eroare =   [erori componentsJoinedByString:@" "];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                        message:eroare
                                                                       delegate:nil
                                                              cancelButtonTitle:@"Ok"
                                                              otherButtonTitles:nil];
                    [alertView show];
                }   else  if(  REZULTAT_NOTIFY_COUNT[@"data"]) {
                    NSDictionary *multedate = REZULTAT_NOTIFY_COUNT[@"data"];
                    NSLog(@"date EDIT  /SEND  PROFILE raspuns %@",multedate);
                    NSMutableArray *raspuns = [[NSMutableArray alloc]init];
                    for (NSString *key in multedate) {
                        [raspuns addObject:key];
                    }
                    if(raspuns.count ==0) {
                        NSLog(@"succes");
                        if([tip_date isEqualToString:@"adresacompleta"]) {
                            NSMutableDictionary *modat = [NSMutableDictionary dictionaryWithDictionary:userd];
                            NSString *U_codpostal_mod = [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"zip_code"]];
                            NSString *U_localitate_mod = [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"localitate_id"]];
                            NSString *U_adresa_mod = [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"address"]];
                             NSString *U_judet_mod = U_judet;
                            [modat setObject:U_codpostal_mod forKey:@"U_cod_postal"];
                            [modat setObject:U_localitate_mod forKey:@"U_localitate"];
                            [modat setObject:U_judet_mod forKey:@"U_judet"];
                            [modat setObject:U_adresa_mod forKey:@"U_adresa"];
                            [DataMasterProcessor updateUsers:modat];
                            [self.navigationController popViewControllerAnimated:YES];
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
            
        }];
        [[NSOperationQueue mainQueue] addOperation:op];
    }
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
 
        [self.navigationController setNavigationBarHidden:NO]; self.navigationItem.leftBarButtonItem=nil;
     if([CE_TIP_E isEqualToString:@"adresa"]) {
     self.title =@"Adresa";
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
      UIBarButtonItem *butonDreapta = [[UIBarButtonItem alloc] initWithTitle:@"Gata" style:UIBarButtonItemStylePlain target:self action:@selector(gata)];
      self.navigationItem.rightBarButtonItem = butonDreapta;
      
     
         
         NSLog(@"setari adresa");
         self.CE_TIP_E = CE_TIP_E; // a uitat pass sau varianta etc
               LISTASELECT.delegate =self;
        

  }


        // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int numarranduri =0;
   if([CE_TIP_E isEqualToString:@"adresa"]) {
         numarranduri =8;
    }
    return numarranduri;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int heightrow =0;
     if([CE_TIP_E isEqualToString:@"adresa"]){
         if (indexPath.row ==7) {
             NSString *textadresa = [NSString stringWithFormat:@"%@",[self.titluriCAMPURI objectAtIndex:7]];
             CGFloat widthWithInsetsApplied = self.view.frame.size.width-30;
             CGSize textSize = [textadresa boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
             heightrow = textSize.height +50;
             return heightrow;
         } else {
        if (indexPath.row % 2) {
            heightrow =50;
          }
        else {
            heightrow =40;
        }
         }
    }
    return  heightrow;
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
   static NSString *CellIdentifier = @"Cell4";
    CellChoose4 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (CellChoose4*)[tableView dequeueReusableCellWithIdentifier:@"Cell4"];
    }
         [cell.contentView bringSubviewToFront:cell.sageatablue];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
         cell.texteditabil.hidden=YES;
         cell.texteditabil.userInteractionEnabled =NO;
         cell.titluROW.numberOfLines =0;
   
          if(indexPath.row ==1) {
        NSDictionary *judet = [self.titluriCAMPURI  objectAtIndex:indexPath.row];
        NSLog(@"verifica jud %@",judet);
        NSString *judetname =@"";
        if(judet[@"name"]) {
            judetname = [NSString stringWithFormat:@"%@",judet[@"name"]];
            if([self MyStringisEmpty:judetname]) {
                 judetname =@"Județ";
                cell.titluROW.textColor =[UIColor lightGrayColor];
            }
        } else {
            judetname =@"Județ";
        }
        cell.titluROW.text =judetname;
        cell.sageatagri.hidden =NO;
     
    } else if (indexPath.row ==3) {
        NSDictionary *localitate = [self.titluriCAMPURI  objectAtIndex:indexPath.row];
              NSString *localitatename =@"";
              if(localitate[@"name"]) {
                  localitatename = [NSString stringWithFormat:@"%@",localitate[@"name"]];
                  if([self MyStringisEmpty:localitatename]) {
                      localitatename =@"Localitate";
                       cell.titluROW.textColor =[UIColor lightGrayColor];
                  }
              } else {
                  localitatename =@"Localitate";
              }
        cell.titluROW.text =localitatename;
        cell.sageatagri.hidden =NO;
        
    }
    
    else if (indexPath.row ==5) {
       NSString *codpostal = [self.titluriCAMPURI  objectAtIndex:indexPath.row];
       NSString *codulpostalstring =@"";
            if(![self MyStringisEmpty:codpostal]) {
                codulpostalstring = codpostal;
            } else {
                codulpostalstring =@"Cod poștal";
                cell.titluROW.textColor =[UIColor lightGrayColor];
            }
     
        cell.titluROW.text =codulpostalstring;
        cell.sageatagri.hidden =NO;
    }
    else {
         cell.titluROW.text =[NSString stringWithFormat:@"%@",[self.titluriCAMPURI  objectAtIndex:indexPath.row]];
         cell.sageatagri.hidden =YES;
    }
          cell.titluROW.hidden=NO;
         if (indexPath.row % 2) {
             cell.backgroundColor = [UIColor whiteColor];
             cell.titluROW.textColor =  [UIColor darkGrayColor];
            cell.titluROW.font = [UIFont systemFontOfSize: 17];
            
          }else {
            cell.backgroundColor = [UIColor colorWithRed:(240/255.0f) green:(240/255.0f) blue:(240/255.0f) alpha:1];
            cell.titluROW.textColor =  [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:1];
            cell.titluROW.font =[UIFont boldSystemFontOfSize:18];
          }
    if(indexPath.row ==7) {
        cell.sageatagri.hidden =NO;
        //just to set height the text is bellow anyway
        NSString *textadresa = [NSString stringWithFormat:@"%@",[self.titluriCAMPURI objectAtIndex:7]];
        CGFloat widthWithInsetsApplied = self.view.frame.size.width-30;
        cell.sageatagri.hidden =NO;
        CGSize textSize = [textadresa boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
        double heightrow = textSize.height +10;
        cell.dynamicTEXTVIEWHEIGHT.constant = heightrow;
    } else {
        cell.dynamicTEXTVIEWHEIGHT.constant =35; //that is default
    }

    [self focusfirstfieldDINTABEL];
    return cell;
}
// primul camp are focus.
-(void)focusfirstfieldDINTABEL{
    NSArray *cells = [self.LISTASELECT visibleCells];
    for(UIView *view in cells){
        if([view isMemberOfClass:[CellChoose4 class]] ){
            CellChoose4 *cell = (CellChoose4 *) view;
            UITextField *tf = (UITextField *)[cell texteditabil];
            if(tf.hidden ==NO) {
                [tf becomeFirstResponder];
                break;
            }
      }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   int ipx = (int)indexPath.row;
    
 //JUDET PUR SI SIMPLU
    if(ipx ==1) {
       chooseview *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Choose1VC"];
        vc.CE_TIP_E = @"Judetsimplu";
        vc.data =[[NSArray alloc]init];
        vc.data = [DataMasterProcessor getJudete];
        [self.navigationController pushViewController:vc animated:YES ];
    }
    if(ipx ==3) {
        NSString *judetselectatid = @"";
        NSDictionary *judet =  [self.titluriCAMPURI  objectAtIndex:1]; //cam asta e pentru ca acolo oricum trebuie sa stea un judet
        if(judet[@"name"] && ![self MyStringisEmpty:[NSString stringWithFormat:@"%@",judet[@"name"]]]) {
            judetselectatid =[NSString stringWithFormat:@"%@",judet[@"id"]];
            //si du-l la selectie localitati din judetul x
            chooseview *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Choose1VC"];
            vc.CE_TIP_E = @"Localitatisimplu";
            vc.data =[[NSArray alloc]init];
            vc.data = [DataMasterProcessor getLocalitati:judetselectatid];
            [self.navigationController pushViewController:vc animated:YES ];
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                message:@"Nu ați selectat județul"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
    }
        if(ipx ==5) {
            choose4view *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Choose4VC"];
            vc.CE_TIP_E = @"codpostal";
            [self.navigationController pushViewController:vc animated:YES ];
        }
        if(ipx ==7) {
        choose4view *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Choose4VC"];
        vc.CE_TIP_E = @"adresa";
        [self.navigationController pushViewController:vc animated:YES ];
    }
    
    
    
/*   CellChoose4 *CELL = (CellChoose4 *)[LISTASELECT cellForRowAtIndexPath:indexPath];
 
      if([CE_TIP_E isEqualToString:@"anfabricatie"]) {
    if(ipx==0 ||ipx==4) {
    CELL.texteditabil.hidden =NO;
  } else {
     CELL.texteditabil.hidden =YES;
  }
      }
    if([CE_TIP_E isEqualToString:@"amuitatparola"] ||[CE_TIP_E isEqualToString:@"prenumenume"]) {
        if(ipx==0 ||ipx==2) {
            CELL.texteditabil.hidden =YES;
        } else {
            CELL.texteditabil.hidden =NO;
        }
    }
    */
    NSLog(@"AAA");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)viewWillLayoutSubviews{
    
}


//-(void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    if (self.isMovingFromParentViewController) {
//        NSLog(@"verifica datele");
//        [self gata];
//        // Do your stuff here
//    }
//}
@end


