//
// choseLoginview.m -> un view cu 3 optiuni de login
//  Pieseauto
//
//  Created by Ioan Ungureanu on 21/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
#import "utile.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"
#import "choseLoginview.h"
#import "CellChooseLogin.h"
#import "TutorialHomeViewController.h"
#import <CoreText/CoreText.h>
#import "LoginView.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "Reachability.h"
#import "butoncustomback.h"

@interface choseLoginview(){
    NSMutableArray* Cells_Array;
}
@end

@implementation choseLoginview
@synthesize  Continua,LISTASELECT,titluriCAMPURI,sageatablue,pozeCAMPURI,isFBRegister,introdunrtelefon,textetelefon,butonOK,butonRENUNTA,labeltelefon,FACEBOOKTOKENTEMPORAR;
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
-(void)perfecttimeforback{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)viewWillAppear:(BOOL)animated {
    NSLog(@"Choose Login");
    self.title = @"Login";
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
    self.titluriCAMPURI =@[@"",@"Login cu Facebook",@"Creează cont",@"Ai deja cont?",@"Login"];
 //jmod   self.pozeCAMPURI =@[@"",@"Icon_Login_Facebook_144x144.png",@"Icon_Creeaza_Cont_Line_144x144.png",@"",@"Icon_Login_Line_144x144.png"];
     self.pozeCAMPURI =@[@"",@"Icon_Login_Facebook_144x144.png",@"Icon_Creeaza_Cont_144x144.png",@"",@"Icon_Login_144x144.png"];
    self.Continua.hidden =YES;
    self.Continua.userInteractionEnabled =NO;
    self.sageatablue.hidden =YES;
    introdunrtelefon.hidden=YES;
    FACEBOOKTOKENTEMPORAR=@"";
    labeltelefon.numberOfLines=0;
}

-(IBAction)ContinuaAction:(id)sender {
    utilitar=[[Utile alloc] init];
    dispatch_async(dispatch_get_main_queue(), ^{
        [utilitar mergiLaCerereNouaViewVC];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    LISTASELECT.delegate =self;
    LISTASELECT.dataSource =self;
    LISTASELECT.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
  
    // Do any additional setup after loading the view, typically from a nib.
    butonRENUNTA.layer.borderWidth=1.0f;
    butonRENUNTA.layer.cornerRadius = 5.0f;
    butonRENUNTA.layer.borderColor=[[UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] CGColor];
    butonOK.layer.borderWidth=1.0f;
    butonOK.layer.cornerRadius = 5.0f;
    butonOK.layer.borderColor=[[UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1] CGColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int ceva =(int)indexPath.row;
    int cellHeightcustom =14;
    if(ceva ==0) {
        cellHeightcustom =14;
    } else if(ceva ==3 ) {
        cellHeightcustom =50;
    } else {
        cellHeightcustom =60;
    }
    return cellHeightcustom;
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
    
    static NSString *CellIdentifier = @"CellChooseLogin";
    
    CellChooseLogin *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (CellChooseLogin*)[tableView dequeueReusableCellWithIdentifier:@"CellChooseLogin"];
    }
    cell.TitluRandaidejacont.hidden=YES;
    if(ipx ==0 || ipx ==3) {
        cell.backgroundColor = [UIColor colorWithRed:(240/255.0f) green:(240/255.0f) blue:(240/255.0f) alpha:1];
        cell.pozaRow.hidden =YES;
        cell.TitluRand.hidden=NO;
        cell.TitluRandaidejacont.textColor = [UIColor darkGrayColor];
        cell.TitluRandaidejacont.text =[NSString stringWithFormat:@"%@",[self.titluriCAMPURI objectAtIndex:ipx]];
        cell.pozaSageataRow.hidden =YES;
        cell.TitluRandaidejacont.hidden=NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else {
        cell.backgroundColor = [UIColor whiteColor];
        cell.TitluRand.text =[NSString stringWithFormat:@"%@",[self.titluriCAMPURI objectAtIndex:ipx]];
        cell.pozaRow.contentMode = UIViewContentModeScaleAspectFit;
        cell.pozaSageataRow.contentMode = UIViewContentModeScaleAspectFit;
        cell.pozaRow.image =[UIImage imageNamed:[NSString stringWithFormat:@"%@",[self.pozeCAMPURI objectAtIndex:ipx]]];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // [LISTASELECT cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int ipx = (int)indexPath.row;
    //   CellChooseLogin *CELL = (CellChooseLogin *)[LISTASELECT cellForRowAtIndexPath:indexPath];
    switch (ipx) {
        case 0: case 3: {
            NSLog(@"nothing to do");
            break;
        }
        case 1: {
            //fb login+
            [self executa:@"facebook_login"];
            break;
        }
        case 2: {
            //register
            dispatch_async(dispatch_get_main_queue(), ^{
                LoginView *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
                vc.CE_TIP_E =@"Register";
                [self.navigationController pushViewController:vc animated:YES ];
            });
            break;
        }
        case 4: {
            //LoginVC -> nu e logat
            dispatch_async(dispatch_get_main_queue(), ^{
                LoginView *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
                vc.CE_TIP_E =@"Login";
                [self.navigationController pushViewController:vc animated:YES ];
            });
            break;
        }
            
        default:
            break;
    }
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
-(void)executa :(NSString *) command  {
    if([command isEqualToString:@"facebook_login"]){
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
            
            isFBRegister=NO;
            ///login stuff
            [self registerFacebook];
        }
    }
    
}

-(BOOL)registerFacebook{
    
    NSUserDefaults* prefs=[NSUserDefaults standardUserDefaults];
    [prefs setBool:YES forKey:@"isConnecting"];
    [prefs setBool:YES forKey:@"fbRequest"];
    if(FBSession.activeSession){
        
        FBSession *session = FBSession.activeSession;
        if(session.isOpen){
            NSString* ftoken=nil;
            ftoken=[NSString stringWithFormat:@"%@",session.accessTokenData];
            [[FBRequest requestForMe] startWithCompletionHandler:
             ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
                 if (!error) {
                     //   SNSLog(@"accesstoken %@",[NSString stringWithFormat:@"%@",session.accessTokenData]);
                     //   SNSLog(@"user id %@",user.id);
                     //   SNSLog(@"Email %@",[user objectForKey:@"email"]);
                     //   SNSLog(@"User Name %@",user.username);
                 }}];
            if(ftoken&&[ftoken length]>5) {
                NSLog(@"fbtoken %@", ftoken);
                FACEBOOKTOKENTEMPORAR =ftoken;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self doFacebookLogin:ftoken:@""];
                });
            } else if([prefs boolForKey:@"fbRequest"]){//check if the block started from real request if true show alert on error
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Eroare" message:@"A intervenit o eroare la conectarea cu Facebook. Te rugăm să încerci mai târziu" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [alertView show];
                });
            } else{//after the fb connect if you pause and resume the application the block reexecutes, temporary fix
                //            NSLog(@"%s double request bug happened",__func__);
            }
            
            [prefs setBool:NO forKey:@"isConnecting"];
            [prefs setBool:NO forKey:@"fbRequest"];
            [prefs synchronize];
        }
        
        
        else{
            NSLog(@"deschide sesiune noua1");
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *fbToken = [NSString stringWithFormat:@"%@",[defaults objectForKey:@"FBACCESSTOKENKEY"]];
            if(fbToken && fbToken.length >5 && ![self MyStringisEmpty:fbToken]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    FACEBOOKTOKENTEMPORAR =fbToken;
                    [self doFacebookLogin:fbToken:@""];
                });
            }
            else {
                FBSession *session = [[FBSession alloc] initWithPermissions:@[@"email"]]; //@"basic_info", @"public_profile",
                [FBSession setActiveSession:session];
                NSLog(@"deschide sesiune noua2ß");
                [session openWithBehavior:FBSessionLoginBehaviorForcingWebView
                        completionHandler:^(FBSession *session,
                                            FBSessionState status,
                                            NSError *error) {
                            if (FBSession.activeSession.isOpen) {
                                [[FBRequest requestForMe] startWithCompletionHandler:
                                 ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
                                     if (!error) {
                                         //   SNSLog(@"accesstoken %@",[NSString stringWithFormat:@"%@",session.accessTokenData]);
                                         //   SNSLog(@"user id %@",user.id);
                                         //   SNSLog(@"Email %@",[user objectForKey:@"email"]);
                                         //   SNSLog(@"User Name %@",user.username);
                                         //   NSUserDefaults* prefs=[NSUserDefaults standardUserDefaults];
                                         NSString* ftoken=nil;
                                         ftoken=[NSString stringWithFormat:@"%@",session.accessTokenData];
                                         NSLog(@"%s fbtocken %@",__func__,ftoken);
                                         if(ftoken&&[ftoken length]>5) {
                                             NSLog(@"fbtoken  jai %@", ftoken);
                                             FACEBOOKTOKENTEMPORAR =ftoken;
                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                 [self doFacebookLogin:ftoken :@""];
                                             });
                                         }
                                     }}];
                            }
                        }];
            }
        }
    }
    return YES;
}
-(IBAction)renuntaAction:(id)sender{
    introdunrtelefon.hidden=YES;
}
-(IBAction)trimiteAction:(id)sender{
    if(![self MyStringisEmpty:textetelefon.text]) {
        NSString *telefonnecesar = [NSString stringWithFormat:@"%@",textetelefon.text];
        if(![self MyStringisEmpty:FACEBOOKTOKENTEMPORAR]) {
            
            [self doFacebookLogin: FACEBOOKTOKENTEMPORAR : telefonnecesar];
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
-(void)addhud{
    [MBProgressHUD showHUDAddedTo:self.navigationController.visibleViewController.view animated:YES];
}
-(void)removehud{
    [MBProgressHUD hideAllHUDsForView:self.navigationController.visibleViewController.view animated:YES];
}
-(void)doFacebookLogin: (NSString*) FBTOKEN :(NSString *) telefon {
    /*
     elenaciobanu1
     lambina
     ioan.ungureanu@activesoft.ro
     ioanungureanu
     wHdspd4DVAc
     {"os":"android","lang":"ro","access_token":"EAACtlLk5PTsBAGV9l7ECFvyuEobYfck3NChCsXXY1OZBNE4xtwogLZBQ1p3EmkWohlhgRx5ZCbvu7ohVgnNJpt4xA8bvPb2qBnuXqILToTcpJ4HJa7cNfP2OK09sRqBFOZAUbxB1zy6bvqxjP6GDZCSdLNcmHMT8ZD","version":1}
     */
    
    
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
        NSString *compus =@""; //e string compus pentru metoda (login sau register si json)
        NSError * err;
        // __block BOOL logatcusucces =NO;
        
        
        NSUserDefaults* prefs=[NSUserDefaults standardUserDefaults];
        NSString *currentSysVer = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] systemVersion]];
        
        [dic2 setObject:FBTOKEN  forKey:@"access_token"];
        [dic2 setObject:@"iOS" forKey:@"os"];
        [dic2 setObject:currentSysVer forKey:@"version"]; //  vers iOS
        [dic2 setObject:@"ro" forKey:@"lang"];
        __block NSString *eroare = @"";
        if(![self MyStringisEmpty:telefon]) {
            [dic2 setObject:telefon forKey:@"tel"];
        }
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic2 options:0 error:&err];
        NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        compus =[NSString stringWithFormat:@"%@%@",METODA_LOGIN, myString];
        
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
            NSMutableDictionary *RASPUNS_LOGIN = [[NSMutableDictionary alloc]init];
            NSMutableDictionary *DictionarErori= [[NSMutableDictionary alloc]init];
            RASPUNS_LOGIN = responseObject;
            NSMutableArray *erori = [[NSMutableArray alloc]init];
            BOOL need_tel=NO;
            NSString *mesajptnrtelefon=@"";
            if(RASPUNS_LOGIN[@"errors"]) {
                DictionarErori = RASPUNS_LOGIN[@"errors"];
                for(id cheie in [DictionarErori allKeys]) {
                    NSLog(@"dds %@",[DictionarErori valueForKey:cheie]);
                    [erori addObject:[NSString stringWithFormat:@"%@",[DictionarErori valueForKey:cheie]]];
                    NSString *Stringcheie = [NSString stringWithFormat:@"%@",cheie];
                    if([Stringcheie isEqualToString:@"need_tel"]) {
                        need_tel=YES;
                        mesajptnrtelefon =[NSString stringWithFormat:@"%@",[DictionarErori valueForKey:Stringcheie]];
                    }
                }
            }
            NSLog(@"ERORS %@",erori);
            
            if(need_tel ==YES) {
                [self removehud];
                introdunrtelefon.hidden =NO;
                labeltelefon.text=mesajptnrtelefon;
                [prefs setValue:@"0" forKey:@"E_LOGAT"];
                [prefs synchronize];
            }
            else  if(erori.count >0) {
                [prefs setValue:@"0" forKey:@"E_LOGAT"];
                [prefs synchronize];
                [self removehud];
                eroare=     [erori componentsJoinedByString:@" "];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                    message:eroare
                                                                   delegate:nil
                                                          cancelButtonTitle:@"Ok"
                                                          otherButtonTitles:nil];
                [alertView show];
                
            } else {
                /*
                 
                 my strin m=login&p={"tel":"0726744222","os":"iOS","lang":"ro","access_token":"EAACtlLk5PTsBAMGXRIl4YaSJrC4uMQUIquTe6pJQ1ZAZAeNHwpr2aUx6dTpnZAvBurLNRbO3XRZB6dduWetl6gig0oR8etqH3DwrXfxNEx4KovNokLjxJdiZBf5JdI6q55YNVH9KHrGaUyVsXJabezt6YR0AYe5ZBO523EzTxtQAZDZD","version":"9.2.1"}
                 2016-06-17 14:21:33.676 Piese auto[13202:3266906] JSON: {
                 data =     {
                 authtoken = 124964g5763dc8cgJk0QuwZedhpG2tGtdfGtqEZxNUt95LibVygpwNmu7Z8;
                 "user_id" = 1198436;
                 username = demchog;
                 };
                 errors =     {
                 };
                 }
                 2016-06-17 14:21:33.676 Piese auto[13202:3266906] ERORS (
                 )
                 2016-06-17 14:21:33.677 Piese auto[13202:3266906] autohtoken 124964g5763dc8cgJk0QuwZedhpG2tGtdfGtqEZxNUt95LibVygpwNmu7Z8
                 2016-06-17 14:21:33.686 Piese auto[13202:3266906] dateuser but not in {
                 }
                 2016-06-17 14:21:33.686 Piese auto[13202:3266906] DictionarDate facebook {
                 authtoken = 124964g5763dc8cgJk0QuwZedhpG2tGtdfGtqEZxNUt95LibVygpwNmu7Z8;
                 "user_id" = 1198436;
                 username = demchog;
                 }
                 
                 */
                [self removehud];
                introdunrtelefon.hidden=YES;
                need_tel =NO;
                NSMutableDictionary *DictionarDate= [[NSMutableDictionary alloc]init];
                if(RASPUNS_LOGIN[@"data"])  DictionarDate = RASPUNS_LOGIN[@"data"];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSString *fbToken = [NSString stringWithFormat:@"%@",FBTOKEN];
                [defaults setObject:fbToken forKey:@"FBACCESSTOKENKEY"];
                [defaults synchronize];
                
                if([DictionarDate objectForKey:@"authtoken"] && [DictionarDate objectForKey:@"username"]) {
                    
                    NSString *AUTH_TOKEN = [NSString stringWithFormat:@"%@",[DictionarDate objectForKey:@"authtoken"]];
                    NSString *USERNAME = [NSString stringWithFormat:@"%@",[DictionarDate objectForKey:@"username"]];
                    NSString *USERID = [NSString stringWithFormat:@"%@",[DictionarDate objectForKey:@"user_id"]];
                    NSLog(@"autohtoken %@",AUTH_TOKEN );
                    NSMutableDictionary *DATEUSER = [[NSMutableDictionary alloc]init];
                    DATEUSER = [NSMutableDictionary dictionaryWithDictionary:[DataMasterProcessor getUSERACCOUNT:USERID]];
                    NSLog(@"dateuser but not in %@",DATEUSER);
                    NSLog(@"DictionarDate facebook %@",DictionarDate);
                    
                    
                    if(DATEUSER[@"U_userid"] && ![self MyStringisEmpty:[NSString stringWithFormat:@"%@",DATEUSER[@"U_userid"]]]) { //acest user exista deja asa ca ii vom actualiza date
                        [DATEUSER setValue:AUTH_TOKEN forKey:@"U_authtoken"];
                        if(!DATEUSER[@"U_lastupdate"]) {
                            [DATEUSER setValue:@"0" forKey:@"U_lastupdate"];
                        }
                        if(!DATEUSER[@"U_username"]) {
                            [DATEUSER setValue:USERNAME forKey:@"U_username"];
                        }
                        [DATEUSER setValue:@"1" forKey:@"U_logat"];
                        [DATEUSER setValue:@"" forKey:@"U_email"];
                        [DATEUSER setValue:@"" forKey:@"U_parola"];
                        
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
                        [DATEUSER setValue:@"" forKey:@"U_email"];
                        [DATEUSER setValue:@"" forKey:@"U_parola"];
                    }
                    
                    NSLog(@"dateuser pentru login %@", DATEUSER);
                    [DataMasterProcessor insertUsers:DATEUSER];
                    
                    [prefs setValue:@"1" forKey:@"E_LOGAT"];
                    [prefs synchronize];
                    
                    NSString *authtoken=@"";
                    BOOL elogat = NO;
                    utilitar=[[Utile alloc] init];
                    elogat = [utilitar eLogat];
                    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                    if(elogat) {
                        authtoken = [utilitar AUTHTOKEN];
                        //[del preia_notify_count];
                        [utilitar getProfile:authtoken];
                        [utilitar getnotify_count:authtoken];
                        if(del.vinedincerere ==YES) {
                            //inapoi la cerere cu send
                            del.inapoilacereredinlogin =YES;
                            [utilitar  mergiLaCerereNouaViewVC];
                        } else {
                            del.inapoilacereredinlogin =NO;
                            [utilitar mergiLaMainViewVC];
                        }
                        NSLog(@"bravo login %@",authtoken);
                    } else {
                        NSLog(@"nelogat %@",authtoken);
                        del.NOTIFY_COUNT = [[NSDictionary alloc]init];
                    }
                    
                }
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [self removehud];
            
        }];
        [[NSOperationQueue mainQueue] addOperation:op];
    }
  
}

/*
 Pentru metoda "login"
 
 Cu parametrii
 
 {"os":"android","lang":"ro","access_token":"EAACtlLk5PTsBAGV9l7ECFvyuEobYfck3NChCsXXY1OZBNE4xtwogLZBQ1p3EmkWohlhgRx5ZCbvu7ohVgnNJpt4xA8bvPb2qBnuXqILToTcpJ4HJa7cNfP2OK09sRqBFOZAUbxB1zy6bvqxjP6GDZCSdLNcmHMT8ZD","version":1}
 
 adica register cu facebook.
 
 Raspunsul primit este:
 
 {"errors":{"need_tel":"need_tel: This is where the app asks for the phone number and resends the fb. login request ..."},"data":{}}
 */


@end
