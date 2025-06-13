//
// EcranCalificativAcordatsauPrimit.m
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
#import "EcranCalificativAcordatsauPrimit.h"
#import "CellCalificativAcordatsauPrimit.h"
#import "TutorialHomeViewController.h"
#import <CoreText/CoreText.h>
#import <QuartzCore/QuartzCore.h>
#import "Reachability.h"
#import "UIImageView+WebCache.h" //sdwebimage
#import "DetaliuOfertaViewController.h"
#import "DetaliuVanzator.h"
#import "butoncustomback.h"

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@interface EcranCalificativAcordatsauPrimit(){
    NSMutableArray* Cells_Array;
}
@end

@implementation EcranCalificativAcordatsauPrimit
@synthesize  Continua,LISTASELECT,sageatablue,CE_TIP_E,CALIFICATIV;

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
    NSLog(@"EcranCalificativAcordatsauPrimit");
    self.CE_TIP_E = CE_TIP_E;
    self.CALIFICATIV = CALIFICATIV;
    NSLog(@"CALIFICATIV %@",CALIFICATIV);
    LISTASELECT.delegate =self;
    LISTASELECT.dataSource =self;
    LISTASELECT.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
       [self.navigationController setNavigationBarHidden:NO]; self.navigationItem.leftBarButtonItem=nil;
    if([CE_TIP_E isEqualToString:@"acordat"]) {
        self.title= @"Calificativ acordat";
    }
    if([CE_TIP_E isEqualToString:@"primit"]) {
        self.title= @"Calificativ primit";
    }
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
}
- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    [LISTASELECT reloadData];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
       // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int ipx = (int)indexPath.row;
    double heightrow=50;
        if(ipx==0 ||ipx==2||ipx==4) {
            heightrow =39;
        }
    if(ipx==1) {
             if(CALIFICATIV[@"title_detailed"]) {
                NSString *titluitem = [NSString stringWithFormat:@"%@", CALIFICATIV[@"title_detailed"]];
                CGFloat widthWithInsetsApplied = self.view.frame.size.width;
                if(SYSTEM_VERSION_LESS_THAN(@"8.0")){
                    widthWithInsetsApplied = self.view.frame.size.width - 30;
                } else {
                    widthWithInsetsApplied = self.view.frame.size.width - 30;
                }
                CGSize textSize = [titluitem boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
                heightrow= textSize.height +30;
                }
    }
   // if( ipx==5 && CALIFICATIV[@"comment"]) {
    if( ipx==5) {
                 NSString *comment =[NSString stringWithFormat:@"%@",CALIFICATIV[@"comment"]];
           //     NSString *comment =@" Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis interdum felis et efficitur posuere. Nunc vulputate lacus quis tellus eleifend, sit amet elementum mi fermentum. Cras dolor ligula, viverra sit amet faucibus non, sagittis rutrum magna. Vivamus viverra, ex id tempus pretium, orci tellus pellentesque ipsum, et pellentesque leo tortor et quam. Nullam suscipit eget est vel viverra. In scelerisque, magna id placerat suscipit, ex neque mollis odio, in porttitor nunc orci in purus. Curabitur vestibulum eget tortor ac finibus. Proin aliquet eu erat id bibendum. Nullam aliquet magna quis convallis congue.\n Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis interdum felis et efficitur posuere. Nunc vulputate lacus quis tellus eleifend, sit amet elementum mi fermentum. Cras dolor ligula, viverra sit amet faucibus non, sagittis rutrum magna. Vivamus viverra, ex id tempus pretium, orci tellus pellentesque ipsum, et pellentesque leo tortor et quam. Nullam suscipit eget est vel viverra. In scelerisque, magna id placerat suscipit, ex neque mollis odio, in porttitor nunc orci in purus. Curabitur vestibulum eget tortor ac finibus. Proin aliquet eu erat id bibendum. Nullam aliquet magna quis convallis congue.\n Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis interdum felis et efficitur posuere. Nunc vulputate lacus quis tellus eleifend, sit amet elementum mi fermentum. Cras dolor ligula, viverra sit amet faucibus non, sagittis rutrum magna. Vivamus viverra, ex id tempus pretium, orci tellus pellentesque ipsum, et pellentesque leo tortor et quam. Nullam suscipit eget est vel viverra. In scelerisque, magna id placerat suscipit, ex neque mollis odio, in porttitor nunc orci in purus. Curabitur vestibulum eget tortor ac finibus. Proin aliquet eu erat id bibendum. Nullam aliquet magna quis convallis congue.\n Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis interdum felis et efficitur posuere. Nunc vulputate lacus quis tellus eleifend, sit amet elementum mi fermentum. Cras dolor ligula, viverra sit amet faucibus non, sagittis rutrum magna. Vivamus viverra, ex id tempus pretium, orci tellus pellentesque ipsum, et pellentesque leo tortor et quam. Nullam suscipit eget est vel viverra. In scelerisque, magna id placerat suscipit, ex neque mollis odio, in porttitor nunc orci in purus. Curabitur vestibulum eget tortor ac finibus. Proin aliquet eu erat id bibendum. Nullam aliquet magna quis convallis congue.\n Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis interdum felis et efficitur posuere. Nunc vulputate lacus quis tellus eleifend, sit amet elementum mi fermentum. Cras dolor ligula, viverra sit amet faucibus non, sagittis rutrum magna. Vivamus viverra, ex id tempus pretium, orci tellus pellentesque ipsum, et pellentesque leo tortor et quam. Nullam suscipit eget est vel viverra. In scelerisque, magna id placerat suscipit, ex neque mollis odio, in porttitor nunc orci in purus. Curabitur vestibulum eget tortor ac finibus. Proin aliquet eu erat id bibendum. Nullam aliquet magna quis convallis congue. ";
                if(![self MyStringisEmpty:comment]) {
                  CGFloat widthWithInsetsApplied = self.view.frame.size.width;
                    if(SYSTEM_VERSION_LESS_THAN(@"8.0")){
                        widthWithInsetsApplied = self.view.frame.size.width - 10;
                    } else {
                        widthWithInsetsApplied = self.view.frame.size.width - 10;
                    }
                    
                    CGSize textSize = [comment boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
                     heightrow= textSize.height +90;
                    //hei row 601.906250
                    NSLog(@"hei row  2 %f", heightrow);

                }
    }
//     if( ipx==6) {
//     heightrow= 60;
//     }
    return heightrow;
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
-(void)gotodetaliuProfil :(NSMutableDictionary*) multedate {
    DetaliuVanzator *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetaliuVanzatorVC"];
    vc.PROFILULMEU =NO;
    vc.DATEPROFIL =[[NSMutableDictionary alloc]init];
    vc._currentPage_toate=1;
    vc.DATEPROFIL =multedate;
    [self.navigationController pushViewController:vc animated:YES ];
    
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
-(void)addhud{
    [MBProgressHUD showHUDAddedTo:self.navigationController.visibleViewController.view animated:YES];
}
-(void)removehud{
    [MBProgressHUD hideAllHUDsForView:self.navigationController.visibleViewController.view animated:YES];
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
                     [self removehud];
                    NSMutableDictionary *multedate = REZULTAT_NOTIFY_COUNT[@"data"];
                    //   NSLog(@"date get_member_profile %@",multedate);
                    [self gotodetaliuProfil:multedate];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    int ipx = (int)indexPath.row;
    static NSString *CellIdentifier = @"CellCalificativAcordatsauPrimit";
    CellCalificativAcordatsauPrimit *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (CellCalificativAcordatsauPrimit*)[tableView dequeueReusableCellWithIdentifier:@"CellCalificativAcordatsauPrimit"];
    }
    
    cell.sageatagri.hidden =YES;
    cell.titluROW.hidden=YES;
    cell.pozacerere.hidden=YES;
   // cell.detaliucomentariu.hidden=YES;
    cell.iconuser.hidden=YES;
    cell.iconcalificativ.hidden=YES;
    cell.titlucalificativ.hidden=YES;
    cell.textcalificativ.hidden=YES;
  
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
        if(ipx==0 ||ipx==2 ||ipx==4) {
           cell.backgroundColor = [UIColor colorWithRed:(240/255.0f) green:(240/255.0f) blue:(240/255.0f) alpha:1];
            
        } else {
            cell.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1];
        }


        switch (ipx) {
            case 0: {
                cell.titluROW.hidden=NO;
                cell.titluROW.font = [UIFont boldSystemFontOfSize:17.0f];
                cell.dynamictleftpoza.constant =-38;
                cell.titluROW.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
                if(CALIFICATIV[@"item_type"]) {
                    NSString *tipitem = [NSString stringWithFormat:@"%@", CALIFICATIV[@"item_type"]];
                    if([tipitem isEqualToString:@"cerere"]) {
                    cell.titluROW.text = @"Pentru cererea";
                    } else {
                    cell.titluROW.text = @"Pentru anunțul";
                    }
                }
           }  break;
        
            case 1: {
               
                if(CALIFICATIV[@"tb_url"]) {
                   
                    NSString *calepozaserver =[NSString stringWithFormat:@"%@", CALIFICATIV[@"tb_url"]];
                    [cell.pozacerere sd_setImageWithURL:[NSURL URLWithString:calepozaserver]
                                       placeholderImage:nil
                                              completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                  //  ... completion code here ...
                                                  if(image && image.size.height !=0) {   cell.pozacerere.hidden=NO; cell.pozacerere.image = image;  } else { cell.dynamictleftpoza.constant =-40;}
                                              }];
                    
                    [ cell.pozacerere setContentMode:UIViewContentModeScaleAspectFit];
                    [ cell.pozacerere clipsToBounds];
                    cell.titluROW.hidden=NO;
                }

                  cell.titluROW.hidden=NO;
                  cell.titluROW.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
                  cell.titluROW.numberOfLines =0;
                   NSString *titluitem =@"";
                   if(CALIFICATIV[@"title_detailed"]) {
                   titluitem = [NSString stringWithFormat:@"%@", CALIFICATIV[@"title_detailed"]];
                       CGFloat widthWithInsetsApplied = self.view.frame.size.width;
                       if(SYSTEM_VERSION_LESS_THAN(@"8.0")){
                           widthWithInsetsApplied = self.view.frame.size.width - 30;
                       } else {
                           widthWithInsetsApplied = self.view.frame.size.width - 30;
                       }
                       double inaltimerand=0;
                            CGSize textSize = [titluitem boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
                               inaltimerand= textSize.height +10;
                              cell.dynamictableheightJ.constant = inaltimerand;
                   }
                cell.titluROW.text =titluitem;
                cell.sageatagri.hidden=NO;
              
            }  break;
                
            case 2: {
                cell.titluROW.hidden=NO;
                cell.titluROW.font = [UIFont boldSystemFontOfSize:17.0f];
                cell.titluROW.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
                cell.titluROW.text = @"User";
                cell.dynamictleftpoza.constant =-38;
            } break;
                
            case 3: {
                //date user icon
                  cell.sageatagri.hidden=NO;
                  cell.iconuser.hidden=NO;
                  cell.titlucalificativ.hidden=NO;
                if(CALIFICATIV[@"user_profile"]) {
                    NSDictionary *ceva = [NSDictionary dictionaryWithDictionary:CALIFICATIV[@"user_profile"]];
                    if(ceva[@"username" ]){
                    NSString *titluitem = [NSString stringWithFormat:@"%@", ceva[@"username"]];
                        cell.titlucalificativ.text = titluitem;
                        cell.titlucalificativ.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
                    }
                
                }
            }break;
            case 4: {
                cell.sageatagri.hidden=YES;
                cell.titluROW.hidden=NO;
                cell.dynamictleftpoza.constant =-38;
                cell.titluROW.font = [UIFont boldSystemFontOfSize:17.0f];
                cell.titluROW.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
                if([CE_TIP_E isEqualToString:@"acordat"]) {
                  cell.titluROW.text = @"Ai acordat";
                }
                if([CE_TIP_E isEqualToString:@"primit"]) {
                  cell.titluROW.text = @"Ai primit";
                }
            }  break;
            case 5: {
            //    @synthesize pozacerere,iconuser,iconcalificativ,titlucalificativ,textcalificativ,detaliucomentariu
                cell.sageatagri.hidden=YES;
                cell.titluROW.hidden=YES;
                cell.iconcalificativ.hidden=NO;
                cell.titlucalificativ.hidden=NO;
                cell.titlucalificativ.font = [UIFont boldSystemFontOfSize:15.0f];
                cell.titlucalificativ.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
                cell.textcalificativ.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
                 if(CALIFICATIV[@"comment"]) {
                    NSString *comment =[NSString stringWithFormat:@"%@",CALIFICATIV[@"comment"]];
//NSString *comment =@" Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis interdum felis et efficitur posuere. Nunc vulputate lacus quis tellus eleifend, sit amet elementum mi fermentum. Cras dolor ligula, viverra sit amet faucibus non, sagittis rutrum magna. Vivamus viverra, ex id tempus pretium, orci tellus pellentesque ipsum, et pellentesque leo tortor et quam. Nullam suscipit eget est vel viverra. In scelerisque, magna id placerat suscipit, ex neque mollis odio, in porttitor nunc orci in purus. Curabitur vestibulum eget tortor ac finibus. Proin aliquet eu erat id bibendum. Nullam aliquet magna quis convallis congue.\n Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis interdum felis et efficitur posuere. Nunc vulputate lacus quis tellus eleifend, sit amet elementum mi fermentum. Cras dolor ligula, viverra sit amet faucibus non, sagittis rutrum magna. Vivamus viverra, ex id tempus pretium, orci tellus pellentesque ipsum, et pellentesque leo tortor et quam. Nullam suscipit eget est vel viverra. In scelerisque, magna id placerat suscipit, ex neque mollis odio, in porttitor nunc orci in purus. Curabitur vestibulum eget tortor ac finibus. Proin aliquet eu erat id bibendum. Nullam aliquet magna quis convallis congue.\n Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis interdum felis et efficitur posuere. Nunc vulputate lacus quis tellus eleifend, sit amet elementum mi fermentum. Cras dolor ligula, viverra sit amet faucibus non, sagittis rutrum magna. Vivamus viverra, ex id tempus pretium, orci tellus pellentesque ipsum, et pellentesque leo tortor et quam. Nullam suscipit eget est vel viverra. In scelerisque, magna id placerat suscipit, ex neque mollis odio, in porttitor nunc orci in purus. Curabitur vestibulum eget tortor ac finibus. Proin aliquet eu erat id bibendum. Nullam aliquet magna quis convallis congue.\n Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis interdum felis et efficitur posuere. Nunc vulputate lacus quis tellus eleifend, sit amet elementum mi fermentum. Cras dolor ligula, viverra sit amet faucibus non, sagittis rutrum magna. Vivamus viverra, ex id tempus pretium, orci tellus pellentesque ipsum, et pellentesque leo tortor et quam. Nullam suscipit eget est vel viverra. In scelerisque, magna id placerat suscipit, ex neque mollis odio, in porttitor nunc orci in purus. Curabitur vestibulum eget tortor ac finibus. Proin aliquet eu erat id bibendum. Nullam aliquet magna quis convallis congue.\n Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis interdum felis et efficitur posuere. Nunc vulputate lacus quis tellus eleifend, sit amet elementum mi fermentum. Cras dolor ligula, viverra sit amet faucibus non, sagittis rutrum magna. Vivamus viverra, ex id tempus pretium, orci tellus pellentesque ipsum, et pellentesque leo tortor et quam. Nullam suscipit eget est vel viverra. In scelerisque, magna id placerat suscipit, ex neque mollis odio, in porttitor nunc orci in purus. Curabitur vestibulum eget tortor ac finibus. Proin aliquet eu erat id bibendum. Nullam aliquet magna quis convallis congue. ";
                     if(![self MyStringisEmpty:comment]) {
                     
                        cell.textcalificativ.hidden=NO;
                             CGFloat widthWithInsetsApplied = self.view.frame.size.width;
                         if(SYSTEM_VERSION_LESS_THAN(@"8.0")){
                             widthWithInsetsApplied = self.view.frame.size.width - 30;
                         } else {
                             widthWithInsetsApplied = self.view.frame.size.width - 30;
                         }
                         double inaltimerand=0;
                         CGSize textSize = [comment boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
                         inaltimerand= textSize.height +30;
                         NSLog(@"hei row %f", inaltimerand);
                         cell.dynamictableheightJ2.constant = inaltimerand;
                         cell.textcalificativ.text =comment;
                     }
                 }
            
                if(CALIFICATIV[@"rating_type"]) {
                    NSString *rating_type =[NSString stringWithFormat:@"%@",CALIFICATIV[@"rating_type"]];
                    if([self MyStringisEmpty:rating_type]) {
                        cell.iconcalificativ.image =[UIImage imageNamed:@"Icon_Calificativ_Neacordat_144x144.png"];
                        cell.titlucalificativ.text =@"Userul încă nu a acordat calificativ";
                    }
                    /*
                     [UIImage imageNamed:@"Icon_Calificativ_Pozitiv_Face_144x144.png"];
                     [UIImage imageNamed:@"Icon_Calificativ_Neutru_Face_144x144.png"];
                     [UIImage imageNamed:@"Icon_Calificativ_Negativ_Face_144x144.png"];
                     */
                    if([rating_type isEqualToString:@"positive"]) {
                        cell.iconcalificativ.image = [UIImage imageNamed:@"Icon_Calificativ_Pozitiv_Face_144x144.png"];
                        cell.titlucalificativ.text =@"Calificativ pozitiv";
                    }
                    if([rating_type isEqualToString:@"neutral"]) {
                        cell.iconcalificativ.image = [UIImage imageNamed:@"Icon_Calificativ_Neutru_Face_144x144.png"];
                        cell.titlucalificativ.text =@"Calificativ neutru";
                    }
                    if([rating_type isEqualToString:@"negative"]) {
                        cell.iconcalificativ.image =[UIImage imageNamed:@"Icon_Calificativ_Negativ_Face_144x144.png"];
                        cell.titlucalificativ.text =@"Calificativ negativ";
                    }
                }
            } break;
//                 case 6:   case 7:{
//                     cell.sageatagri.hidden=YES;
//                     cell.titluROW.hidden=NO;
//                     cell.titluROW.font = [UIFont boldSystemFontOfSize:17.0f];
//                     cell.titluROW.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
//                     if([CE_TIP_E isEqualToString:@"acordat"]) {
//                         cell.titluROW.text = @"Ai primit";
//                     }
//                     if([CE_TIP_E isEqualToString:@"primit"]) {
//                         cell.titluROW.text = @"Ai acordat";
//                     }
//
//                 } break;
                
            default:
                break;
        }
     return cell;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
-(void)getOffer :(NSString*)ID_OFERTA :(NSString*)authtoken {
    
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
                     [self removehud];
                    eroare=    [erori componentsJoinedByString:@" "];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                        message:eroare
                                                                       delegate:nil
                                                              cancelButtonTitle:@"Ok"
                                                              otherButtonTitles:nil];
                    [alertView show];
                }   else  if(  REZULTAT_NOTIFY_COUNT[@"data"]) {
                       [self removehud];
                    NSMutableDictionary *multedate = REZULTAT_NOTIFY_COUNT[@"data"];
                    NSLog(@"date DETALIU OFERTA %@",multedate);
                    //dispatch_async(dispatch_get_main_queue(), ^{
                    DetaliuOfertaViewController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"DetaliuOfertaVC"];
                    vc.CORPDATE = multedate;
                    [self.navigationController pushViewController:vc animated:NO];
                    // });
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int ipx = (int)indexPath.row;
    utilitar=[[Utile alloc] init];
    //get_member_profile
//    Pe detaliu calificativ, la click pe "title detailed" avem situatiile:
//    - "item_type" = "product" -> duce la un URL din pieseauto.ro  "external_url"
//    - "item_type" = "cerere"
//    - userul logat este acelasi cu "main_item_owner_id" -> duce in aplicatie in ecranul cu detalii oferta ("item_id" este id de oferta, "main_item_id" este id de cerere)
//    - userul logat nu e acelasi cu "main_item_owner_id" -> duce la un URL din pieseauto.ro  "external_url"
    switch(ipx) {
        case 1: {
           NSString *tipitem = [NSString stringWithFormat:@"%@", CALIFICATIV[@"item_type"]];
            if([tipitem isEqualToString:@"cerere"]) {
                if(CALIFICATIV[@"main_item_owner_id"]) {
                    NSString *main_item_owner_id=@"";
                    NSString *user_id=@"";
                    NSString *item_id=@"";
                    
                    main_item_owner_id =[NSString stringWithFormat:@"%@", CALIFICATIV[@"main_item_owner_id"]];
                    NSDictionary *userlogat = [DataMasterProcessor getLOGEDACCOUNT];
                    NSLog(@"usercalif %@", userlogat);
                    if(userlogat[@"U_userid"]) {
                    user_id =[NSString stringWithFormat:@"%@",userlogat[@"U_userid"]];
                    }
                    if([user_id isEqualToString:main_item_owner_id]) {
                        //main_item_id
                        //item_id
                       if(CALIFICATIV[@"item_id"]) {
                              item_id =[NSString stringWithFormat:@"%@", CALIFICATIV[@"item_id"]];
                        }
                        NSString *authtoken=@"";
                        BOOL elogat = NO;
                        elogat = [utilitar eLogat];
                        if(elogat) {
                            authtoken = [utilitar AUTHTOKEN];
                            if(![self MyStringisEmpty:item_id]) {
                            [self getOffer:item_id :authtoken];
                            }
                        }
                    } else {
                        if(CALIFICATIV[@"external_url"]) {
                            NSString *titluitem = [NSString stringWithFormat:@"%@", CALIFICATIV[@"external_url"]];
                            if(![self MyStringisEmpty:titluitem]) {
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:titluitem]];
                            }
                        }
                    }
                }
                
              //du-l la cerere
            } else {
               //url extern
                if(CALIFICATIV[@"external_url"]) {
                     NSString *titluitem = [NSString stringWithFormat:@"%@", CALIFICATIV[@"external_url"]];
                    if(![self MyStringisEmpty:titluitem]) {
                   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:titluitem]];
                }
                }
            }
    }  break;
        case 3: {
            //user profile
            NSString *user_id =@"";
            NSString *authtoken=@"";
            if(CALIFICATIV[@"user_profile"]) {
                BOOL elogat = NO;
                elogat = [utilitar eLogat];
                if(elogat) {
                    authtoken = [utilitar AUTHTOKEN];
                    NSDictionary *COMENTATOR =  [NSDictionary dictionaryWithDictionary:CALIFICATIV[@"user_profile"]];
                    if(COMENTATOR[@"user_id"]) {
                        user_id =[NSString stringWithFormat:@"%@",COMENTATOR[@"user_id"]];
                        //  -(void)get_member_profile :(NSString *)userid :(NSString *)AUTHTOKEN :(NSString *)tipuserid
                        [self get_member_profile:user_id :authtoken :@"user_id"];
                    }
                }
            }
        } break;
            
        
   
    }
   
     NSLog(@"AAA");
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


@end


