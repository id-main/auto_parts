//
//  EcranAcorda.m
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
#import "EcranAcorda.h"
#import "CellAcorda.h"
#import "TutorialHomeViewController.h"
#import <CoreText/CoreText.h>
#import <QuartzCore/QuartzCore.h>
#import "Reachability.h"
#import "UIImageView+WebCache.h" //sdwebimage
#import "DetaliuOfertaViewController.h"
#import "DetaliuVanzator.h"

#import "EcranAiAcordat.h"
#import "butoncustomback.h"

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@interface EcranAcorda(){
    NSMutableArray* Cells_Array;
}
@end

@implementation EcranAcorda
@synthesize  LISTASELECT,CE_TIP_E,CALIFICATIV;
@synthesize rating1,rating2,rating3,rating4,tipuldecalificativdeacordat,comentariuAcorda,mystars;
double cellheightTEXTmodificat=45;
float _initialTVHeightx2 =0;
float _MYkeyboardheightx2 =0;

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
    NSLog(@"EcranAcorda");
    self.CE_TIP_E = CE_TIP_E;
    NSLog(@"cetipeacorda %@", CE_TIP_E);
    self.CALIFICATIV = CALIFICATIV;
    NSLog(@"CALIFICATIV %@",CALIFICATIV);
    LISTASELECT.delegate =self;
    LISTASELECT.dataSource =self;
    LISTASELECT.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    // gettextview inside cell se prea poate sa existe ceva scris  cellheightTEXTmodificat =45;
    
    if([CE_TIP_E isEqualToString:@"acorda"] || [CE_TIP_E isEqualToString:@"dincerere"]) {
        self.title= @"Acordare calificativ";
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
 //   [self.LISTASELECT reloadData];
}
-(void)viewDidAppear:(BOOL)animated {
    NSArray *cells = [self.LISTASELECT visibleCells];
    for(UITextView *view in cells){
        if(view.hidden==NO){
            NSLog(@"IA CALCUL");
            CGFloat widthWithInsetsApplied = self.view.frame.size.width-25;
            CGSize textSize = [view.text boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
            double heightrow= textSize.height+35;
            NSLog(@"heightrow spec %f",heightrow);
            if(textSize.height < 40) {
                heightrow =55;
            }
            cellheightTEXTmodificat = heightrow;
            break;
        }
    }
   [self.LISTASELECT reloadData];
//    [self.LISTASELECT beginUpdates];
////    [cell.contentView  setNeedsLayout];
////    [cell.contentView  layoutIfNeeded];
//    [self.LISTASELECT endUpdates];
 
    
}
-(void)addhud{
    [MBProgressHUD showHUDAddedTo:self.navigationController.visibleViewController.view animated:YES];
}
-(void)removehud{
    [MBProgressHUD hideAllHUDsForView:self.navigationController.visibleViewController.view animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    rating1 = 0;
    rating2 = 0;
    rating3 = 0;
    rating4 = 0;
    tipuldecalificativdeacordat=0;
    
    
    
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
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}



- (void)keyboardWillShow:(NSNotification *)notification
{
    
    _initialTVHeightx2 = self.LISTASELECT.frame.size.height;
    CGRect initialFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect convertedFrame = [self.view convertRect:initialFrame fromView:nil];
    CGRect tvFrame = self.LISTASELECT.frame;
    tvFrame.size.height = convertedFrame.origin.y;
    _MYkeyboardheightx2 = convertedFrame.origin.y;
    [self.LISTASELECT setFrame:tvFrame];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.LISTASELECT setNeedsDisplay];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:8 inSection:0]; // sa urce peste keyboard
        [self.LISTASELECT scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    });
    
    
    
}
- (void)keyboardWillHide:(NSNotification *)notification
{
    
    CGRect tvFrame = self.LISTASELECT.frame;
    tvFrame.size.height = _initialTVHeightx2;
    [UIView beginAnimations:@"TableViewDown" context:NULL];
    [UIView setAnimationDuration:0.3f];
    self.LISTASELECT.frame = tvFrame;
    _MYkeyboardheightx2 =0;
    [UIView commitAnimations];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.LISTASELECT setNeedsDisplay];
      });

    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 17;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int ipx = (int)indexPath.row;
    double heightrow=54;
    if(ipx==5) heightrow =0;
    if(ipx==0 ||ipx==2||ipx==4 || ipx==9 ) {
        heightrow =39;
    }
    if(ipx==16) {
        heightrow =59;
    }
    if(ipx==10) {
        //  heightrow =128;
        heightrow= cellheightTEXTmodificat;
    }
    
   // jmod stele dispar si alte texte randuri
   // if(ipx ==12 || ipx ==13 || ipx ==14 || ipx ==15) heightrow =105;
    if( ipx==11 ||ipx ==12 || ipx ==13 || ipx ==14 || ipx ==15) heightrow =0;
    if(ipx==1) {
        if([CE_TIP_E isEqualToString:@"acorda"] ) {
            
            if(CALIFICATIV[@"title_detailed"]) {
                NSString *titluitem = [NSString stringWithFormat:@"%@", CALIFICATIV[@"title_detailed"]];
                CGFloat widthWithInsetsApplied = self.view.frame.size.width-30;
                CGSize textSize = [titluitem boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
                heightrow= textSize.height +35;
                
            }
        } else
        
        if([CE_TIP_E isEqualToString:@"dincerere"]) {
            NSLog(@"do something %@", CALIFICATIV);
            if(CALIFICATIV[@"items"]) {
                NSArray *arieitemuri = [NSArray arrayWithArray:CALIFICATIV[@"items"]];
                if(arieitemuri.count >0) {
                NSDictionary *primulrand = [arieitemuri objectAtIndex:0];
                if(primulrand[@"description"]) {
                    NSString *titluitem = [NSString stringWithFormat:@"%@", primulrand[@"description"]];
                    CGFloat widthWithInsetsApplied = self.view.frame.size.width-30;
                    CGSize textSize = [titluitem boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
                    heightrow= textSize.height +35;
                }
                }
            }
        }
    }
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
    _initialTVHeightx2 = self.LISTASELECT.frame.size.height;
    CGRect tvFrame = self.LISTASELECT.frame;
    if(_MYkeyboardheightx2 >0) {
        tvFrame.size.height = _MYkeyboardheightx2;
        [self.LISTASELECT setFrame:tvFrame];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.LISTASELECT setNeedsDisplay];
            [self.view layoutIfNeeded];
        });
    }
    [self.LISTASELECT reloadData];
    
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
                    [self removehud];
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
-(HCSStarRatingView *)HCS :(double)RANDSELECT {
   NSIndexPath *indexPathreload = [NSIndexPath indexPathForRow:0 inSection:0];
    CellAcorda *CELL = (CellAcorda *)[LISTASELECT cellForRowAtIndexPath:indexPathreload];
    HCSStarRatingView *starRatingView = [[HCSStarRatingView alloc] initWithFrame:CELL.cadrustele.frame];
    starRatingView.maximumValue = 5;
    starRatingView.minimumValue = 0;
    starRatingView.allowsHalfStars = NO;
    starRatingView.tintColor = [UIColor lightGrayColor];
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        UIImage *image = [UIImage imageNamed:@"Icon_Steluta_Calificative_Detaliate_Gri_144x144.png"];
        starRatingView.emptyStarImage = [image imageWithRenderingMode:UIImageRenderingModeAutomatic];
        UIImage *image2 = [UIImage imageNamed:@"Icon_Steluta_Calificative_Detaliate_180x180.png"];
        starRatingView.filledStarImage = [image2 imageWithRenderingMode:UIImageRenderingModeAutomatic];
    } else {
        starRatingView.emptyStarImage = [UIImage imageNamed:@"Icon_Steluta_Calificative_Detaliate_Gri_144x144.png"]; // imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        starRatingView.filledStarImage = [UIImage imageNamed:@"Icon_Steluta_Calificative_Detaliate_180x180.png"];
    }

    if(RANDSELECT ==1) {
             starRatingView.value = rating1;
       indexPathreload= [NSIndexPath indexPathForRow:12 inSection:0];
       

            }
    if(RANDSELECT ==2) {
        starRatingView.value = rating2;
        indexPathreload = [NSIndexPath indexPathForRow:13 inSection:0];
       
    }
    if(RANDSELECT ==3) {
        starRatingView.value = rating3;
       indexPathreload = [NSIndexPath indexPathForRow:14 inSection:0];
           }
    if(RANDSELECT ==4) {
        starRatingView.value = rating4;
        indexPathreload = [NSIndexPath indexPathForRow:15 inSection:0];
     
    }
    // starRatingView.value = 0;
    CellAcorda *CELLOK = (CellAcorda *)[LISTASELECT cellForRowAtIndexPath:indexPathreload];
 //   [self.LISTASELECT beginUpdates];
  //  dispatch_async(dispatch_get_main_queue(), ^{
 
        [CELLOK setNeedsLayout];
        [CELLOK layoutIfNeeded];
   // });
  //  [self.LISTASELECT endUpdates];
    return starRatingView;
}
- (IBAction)stardidChangeValue1:(HCSStarRatingView *)sender {
    //  NSLog(@"Changed rating to %.1f", sender.value);
    rating1 =sender.value;
}
- (IBAction)stardidChangeValue2:(HCSStarRatingView *)sender {
    //  NSLog(@"Changed rating to %.1f", sender.value);
    rating2 =sender.value;
}
- (IBAction)stardidChangeValue3:(HCSStarRatingView *)sender {
    //   NSLog(@"Changed rating to %.1f", sender.value);
    rating3 =sender.value;
}
- (IBAction)stardidChangeValue4:(HCSStarRatingView *)sender {
    //   NSLog(@"Changed rating to %.1f", sender.value);
    rating4 =sender.value;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void) textViewDidChange:(UITextView *)textView
{
   // NSLog(@"did cha");
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"opțional";
        textView.textColor = [UIColor lightGrayColor]; //optional
        [textView resignFirstResponder];
    } else {
        textView.textColor = [UIColor blackColor];
    }
    
    NSIndexPath *indexPathreload = [NSIndexPath indexPathForRow:10 inSection:0];
    CellAcorda *updateCell = (CellAcorda *)[self.LISTASELECT cellForRowAtIndexPath:indexPathreload];
    //  UITextView *textViews = updateCell.maimulttext;
    
    CGFloat widthWithInsetsApplied = self.view.frame.size.width-25;
    CGSize textSize = [textView.text boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    double heightrow= textSize.height+35;
    NSString *textscrisdeuser= [NSString stringWithFormat:@"%@",textView.text];
    comentariuAcorda =textscrisdeuser;
   // NSLog(@"heightrow specx %f",heightrow);
    [self.LISTASELECT beginUpdates];
    if(heightrow < 40) {
        updateCell.dynamicHEIGHTCOMENTARIU .constant =50;
    } else {
        updateCell.dynamicHEIGHTCOMENTARIU.constant =heightrow;
    }
    [updateCell setNeedsLayout];
    [updateCell layoutIfNeeded];
    cellheightTEXTmodificat = heightrow;
    [self.LISTASELECT endUpdates];
    
    
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"opțional"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }  else {
        textView.textColor = [UIColor blackColor];
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text =@"opțional";
        textView.textColor = [UIColor lightGrayColor]; //optional
    } else {
        textView.textColor = [UIColor blackColor];
    }
    NSString *textscrisdeuser= [NSString stringWithFormat:@"%@",textView.text];
    comentariuAcorda =textscrisdeuser;
    [textView resignFirstResponder];
}
-(void)doneWithNumberPad {
    NSIndexPath *indexPathreload = [NSIndexPath indexPathForRow:10 inSection:0];
    CellAcorda *updateCell = (CellAcorda *)[self.LISTASELECT cellForRowAtIndexPath:indexPathreload];
    if ([updateCell.texteditabil.text isEqualToString:@""]) {
        updateCell.texteditabil.text = @"opțional";
        updateCell.texteditabil.textColor = [UIColor lightGrayColor]; //optional
    } else {
        updateCell.texteditabil.textColor = [UIColor blackColor];
    }
    NSString *textscrisdeuser= [NSString stringWithFormat:@"%@",updateCell.texteditabil.text];
    comentariuAcorda =textscrisdeuser;
    [updateCell.texteditabil resignFirstResponder];
   // [self.view endEditing:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    int ipx = (int)indexPath.row;
    static NSString *CellIdentifier = @"CellAcorda";
    CellAcorda *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (CellAcorda*)[tableView dequeueReusableCellWithIdentifier:@"CellAcorda"];
    }
    if ([cell.contentView subviews]){
        for (UIControl *subview in [cell.contentView subviews]) {
            if([subview isKindOfClass:[HCSStarRatingView class]]){
                [subview removeFromSuperview];
            }
        }
    }
    cell.bifablue.hidden=YES;
    cell.sageatagri.hidden =YES;
    cell.titluROW.hidden=YES;
    cell.pozacerere.hidden=YES;
    cell.iconuser.hidden=YES;
    cell.iconcalificativ.hidden=YES;
    cell.titlucalificativ.hidden=YES;
    cell.textcalificativ.hidden=YES;
    cell.titlucalificativcentrat.hidden=YES;
    cell.cadrustele.hidden=YES;
    cell.sageatablue.hidden=YES;
    cell.Continua.hidden=YES;
    cell.texteditabil.hidden=YES;
    cell.bifablue.hidden =YES;
    cell.texteditabil.delegate =self;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if(ipx==0 ||ipx==2 ||ipx==4 ||ipx==5 ||ipx==9 ||ipx==11) {
        cell.backgroundColor = [UIColor colorWithRed:(240/255.0f) green:(240/255.0f) blue:(240/255.0f) alpha:1];
    } else {
        cell.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1];
    }
    cell.dynamicHEIGHTCOMENTARIU.constant = 35;
    
    switch (ipx) {
        case 0: {
            cell.titluROW.hidden=NO;
            cell.titluROW.font = [UIFont boldSystemFontOfSize:17.0f];
            cell.dynamictleftpoza.constant =-38;
            cell.titluROW.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
            if([CE_TIP_E isEqualToString:@"acorda"] ) {
                if(CALIFICATIV[@"item_type"]) {
                    NSString *tipitem = [NSString stringWithFormat:@"%@", CALIFICATIV[@"item_type"]];
                    if([tipitem isEqualToString:@"cerere"]) {
                        cell.titluROW.text = @"Pentru oferta";
                    } else {
                        cell.titluROW.text = @"Pentru anunțul";
                    }
                }
            } else {
            if([CE_TIP_E isEqualToString:@"dincerere"]) {
                cell.titluROW.text = @"Pentru oferta";
            }
            }
        }  break;
            
        case 1: {
            cell.dynamictleftpoza.constant =-38;
            if([CE_TIP_E isEqualToString:@"acorda"] ) {
                if(CALIFICATIV[@"tb_url"]) {
                    
                    NSString *calepozaserver =[NSString stringWithFormat:@"%@", CALIFICATIV[@"tb_url"]];
                    [cell.pozacerere sd_setImageWithURL:[NSURL URLWithString:calepozaserver]
                                       placeholderImage:nil
                                              completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                  //  ... completion code here ...
                                                  if(image && image.size.height !=0) {   cell.pozacerere.hidden=NO; cell.pozacerere.image = image;  cell.dynamictleftpoza.constant =8; }
                                                  else { cell.dynamictleftpoza.constant =-38;}
                                              }];
                    
                    [cell.pozacerere setContentMode:UIViewContentModeScaleAspectFit];
                    [cell.pozacerere clipsToBounds];
                    cell.titluROW.hidden=NO;
                }
                
                cell.titluROW.hidden=NO;
                cell.titluROW.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
                cell.titluROW.numberOfLines =0;
                NSString *titluitem =@"";
                if(CALIFICATIV[@"title_detailed"]) {
                    titluitem = [NSString stringWithFormat:@"%@", CALIFICATIV[@"title_detailed"]];
                    CGFloat widthWithInsetsApplied = self.view.frame.size.width -30;
                    double inaltimerand=0;
                    CGSize textSize = [titluitem boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
                    inaltimerand= textSize.height +20;
                    cell.dynamictableheightJ.constant = inaltimerand;
                }
                cell.titluROW.text =titluitem;
                cell.sageatagri.hidden=NO;
                
            }
            
            if([CE_TIP_E isEqualToString:@"dincerere"]) {
                /*
                 buyerfeedback = 0;
                 images =     (
                 {
                 height = 101;
                 original = "http://dev5.activesoft.ro/~csaba/4tilance/attachment.php?id=5f036f3a5d5f2493a38c244ebd3c6ff9";
                 tb = "http://dev5.activesoft.ro/~csaba/4tilance/attachment.php?id=5f036f3a5d5f2493a38c244ebd3c6ff9&cmd=thumb&w=300&h=300";
                 width = 104;
                 }
                 );
                 */
                if(CALIFICATIV[@"images"]) {
                    NSArray *arieitemuri = [NSArray arrayWithArray:CALIFICATIV[@"images"]];
                    if(arieitemuri.count >0) {
                    NSDictionary *primulrand = [arieitemuri objectAtIndex:0];
                    if(primulrand[@"tb"]) {
                        
                        NSString *calepozaserver =[NSString stringWithFormat:@"%@", primulrand[@"tb"]];
                        [cell.pozacerere sd_setImageWithURL:[NSURL URLWithString:calepozaserver]
                                           placeholderImage:nil
                                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                      //  ... completion code here ...
                                                      if(image && image.size.height !=0) {   cell.pozacerere.hidden=NO; cell.pozacerere.image = image;  cell.dynamictleftpoza.constant =8; } else { cell.dynamictleftpoza.constant =-38;}
                                                  }];
                        
                        [cell.pozacerere setContentMode:UIViewContentModeScaleAspectFit];
                        [cell.pozacerere clipsToBounds];
                        cell.titluROW.hidden=NO;
                    }
                    }
                }
                if(CALIFICATIV[@"items"]) {
                    NSArray *arieitemuri = [NSArray arrayWithArray:CALIFICATIV[@"items"]];
                    if(arieitemuri.count >0) {
                        NSDictionary *primulrand = [arieitemuri objectAtIndex:0];
                    if(primulrand[@"description"]) {
                        NSString *titluitem = [NSString stringWithFormat:@"%@", primulrand[@"description"]];
                        CGFloat widthWithInsetsApplied = self.view.frame.size.width -30;
                        double inaltimerand=0;
                        CGSize textSize = [titluitem boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
                        inaltimerand= textSize.height +20;
                        cell.dynamictableheightJ.constant = inaltimerand;
                        cell.titluROW.text =titluitem;
                        cell.titluROW.hidden=NO;
                        cell.titluROW.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
                        cell.titluROW.numberOfLines =0;
                        cell.sageatagri.hidden=NO;
                    }
                    }
                }
             }
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
            cell.titlucalificativ.font = [UIFont systemFontOfSize:18];
            if([CE_TIP_E isEqualToString:@"acorda"] ) {
                
                if(CALIFICATIV[@"user_profile"]) {
                    NSDictionary *ceva = [NSDictionary dictionaryWithDictionary:CALIFICATIV[@"user_profile"]];
                    if(ceva[@"username" ]){
                        NSString *titluitem = [NSString stringWithFormat:@"%@", ceva[@"username"]];
                        cell.titlucalificativ.text = titluitem;
                        
                    }
                }
            } else
            if([CE_TIP_E isEqualToString:@"dincerere"] ) {
                
                if(CALIFICATIV[@"username"]) {
                    NSString *titluitem = [NSString stringWithFormat:@"%@", CALIFICATIV[@"username"]];
                    cell.titlucalificativ.text = titluitem;
                } else {
                if(CALIFICATIV[@"user"]) {
                        NSDictionary *dateuser = [NSDictionary dictionaryWithDictionary:CALIFICATIV[@"user"]];
                        if(dateuser[@"username"]) {
                        NSString *titluitem = [NSString stringWithFormat:@"%@", dateuser[@"username"]];
                        cell.titlucalificativ.text = titluitem;
                        }
                    }
                }
            }
        }
            
            break;
            
        case 4: {
            cell.sageatagri.hidden=YES;
            cell.titluROW.hidden=NO;
            cell.dynamictleftpoza.constant =-38;
            cell.titluROW.font = [UIFont boldSystemFontOfSize:17.0f];
            cell.titluROW.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
            if([CE_TIP_E isEqualToString:@"acorda"]) {
                cell.titluROW.text = @"Calificativul pe care îl acorzi";
            }
        }  break;
            
        case 5: {
//            cell.titlucalificativ.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
//            cell.textcalificativ.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
//            //    @synthesize pozacerere,iconuser,iconcalificativ,titlucalificativ,textcalificativ,detaliucomentariu
//            cell.sageatagri.hidden=YES;
//            cell.titluROW.hidden=YES;
//            cell.iconcalificativ.hidden=NO;
//            cell.iconcalificativ.image =[UIImage imageNamed:@"Icon_Info_144x144.png"];
//            cell.titlucalificativ.hidden=NO;
//            cell.titlucalificativ.font = [UIFont systemFontOfSize:14.0f];
//            cell.titlucalificativ.textColor=[UIColor blackColor];
//            cell.titlucalificativ.text =@"În caz de tranzacție nefinalizată, te rugăm să acorzi calificativ neutru";
//            cell.titlucalificativ.numberOfLines=0;
        } break;
            
        case 6: {
            cell.sageatagri.hidden=YES;
            cell.titlucalificativ.textColor =  [UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1];
            cell.titluROW.hidden=YES;
            cell.iconcalificativ.hidden=NO;
          // jmod  cell.iconcalificativ.image =[UIImage imageNamed:@"Icon_Calificativ_Pozitiv_180x180.png"];
            cell.iconcalificativ.image =[UIImage imageNamed:@"Icon_Calificativ_Pozitiv_Face_144x144.png"];
           //Icon_Calificativ_Pozitiv_Face_144x144.png
            cell.titlucalificativ.hidden=NO;
            cell.titlucalificativ.font = [UIFont boldSystemFontOfSize:17.0f];
            cell.titlucalificativ.text =@"Calificativ pozitiv";
            if(tipuldecalificativdeacordat==1) { cell.bifablue.hidden=NO; } else { cell.bifablue.hidden=YES; }
            //  cell.titlucalificativ.numberOfLines=1;
            
            
        } break;
            
        case 7: {
            cell.sageatagri.hidden=YES;
            cell.titlucalificativ.textColor =  [UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1];
            cell.titluROW.hidden=YES;
            cell.iconcalificativ.hidden=NO;
          // jmod  cell.iconcalificativ.image =[UIImage imageNamed:@"Icon_Calificativ_Neutru_180x180.png"];
            cell.iconcalificativ.image =[UIImage imageNamed:@"Icon_Calificativ_Neutru_Face_144x144.png"];
            cell.titlucalificativ.hidden=NO;
            cell.titlucalificativ.font = [UIFont boldSystemFontOfSize:17.0f];
            cell.titlucalificativ.text =@"Calificativ neutru";
            if(tipuldecalificativdeacordat==2) { cell.bifablue.hidden=NO; } else { cell.bifablue.hidden=YES; }
            //    cell.titlucalificativ.numberOfLines=1;
        } break;
            
        case 8: {
            cell.sageatagri.hidden=YES;
            cell.titlucalificativ.textColor =  [UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1];
            cell.titluROW.hidden=YES;
            cell.iconcalificativ.hidden=NO;
          //jmod  cell.iconcalificativ.image =[UIImage imageNamed:@"Icon_Calificativ_Negativ_180x180.png"];
            cell.iconcalificativ.image =[UIImage imageNamed:@"Icon_Calificativ_Negativ_Face_144x144.png"];
            cell.titlucalificativ.hidden=NO;
            cell.titlucalificativ.font = [UIFont boldSystemFontOfSize:17.0f];
            cell.titlucalificativ.text =@"Calificativ negativ";
            if(tipuldecalificativdeacordat==3) { cell.bifablue.hidden=NO; } else { cell.bifablue.hidden=YES; }
            //   cell.titlucalificativ.numberOfLines=1;
        } break;
            
        case 9: {
            cell.sageatagri.hidden=YES;
            cell.titluROW.hidden=NO;
            cell.dynamictleftpoza.constant =-38;
            cell.titluROW.font = [UIFont boldSystemFontOfSize:17.0f];
            cell.titluROW.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
            cell.titluROW.text = @"Descriere calificativ";
            
        } break;
        case 10: {
            cell.sageatagri.hidden=YES;
            cell.titluROW.hidden=YES;
            cell.texteditabil.hidden=NO;
            if([self MyStringisEmpty:comentariuAcorda]) {
                cell.texteditabil.text =@"opțional";
                cell.texteditabil.textColor = [UIColor lightGrayColor];
            } else {
                cell.texteditabil.text =comentariuAcorda;
                cell.texteditabil.textColor = [UIColor blackColor];
            }
            [cell.texteditabil setScrollEnabled:NO];
            UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
            numberToolbar.barStyle = UIBarStyleBlackTranslucent;
            numberToolbar.items = [NSArray arrayWithObjects:
                                   [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                                   nil];
            [numberToolbar sizeToFit];
            cell.texteditabil.inputAccessoryView = numberToolbar;
            
            //   [cell.texteditabil becomeFirstResponder];
            
        } break;
        case 11: {
//            cell.sageatagri.hidden=YES;
//            cell.titluROW.hidden=YES;
//            cell.titlucalificativcentrat.hidden=NO;
//            cell.titlucalificativcentrat.font = [UIFont boldSystemFontOfSize:16.0f];
//            cell.titlucalificativcentrat.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
//            //   cell.titluROW.textAlignment = NSTextAlignmentCenter;
//            cell.titlucalificativcentrat.text = @"Acordă note conform celor 4 criterii:";
        } break;
        case 12: {
//            cell.sageatagri.hidden=YES;
//            cell.titluROW.hidden=YES;
//            cell.titlucalificativcentrat.hidden=NO;
//            cell.titlucalificativcentrat.font = [UIFont boldSystemFontOfSize:17.0f];
//            cell.titlucalificativcentrat.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
//            cell.dynamictableheightJ.constant =45;
//            cell.titlucalificativcentrat.text = @"Produs conform cu descrierea";
//            HCSStarRatingView *NEWSTARS =[self HCS:1];
//              cell.cadrustele.clipsToBounds =YES;
//            [NEWSTARS  addTarget:self action:@selector(stardidChangeValue1:) forControlEvents:UIControlEventValueChanged];
//            CGRect framestele = cell.cadrustele.frame;
//            NEWSTARS.frame=framestele;
//             NEWSTARS.clipsToBounds =YES;
//            [cell.contentView addSubview:NEWSTARS];
//            [cell.contentView bringSubviewToFront:NEWSTARS];
//                [cell.contentView  setNeedsLayout];
//                [cell.contentView  layoutIfNeeded];
        } break;
        case 13: {
//            cell.sageatagri.hidden=YES;
//            cell.titluROW.hidden=YES;
//            cell.titlucalificativcentrat.hidden=NO;
//            cell.titlucalificativcentrat.font = [UIFont boldSystemFontOfSize:17.0f];
//            cell.titlucalificativcentrat.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
//              cell.dynamictableheightJ.constant =45;
//            cell.titlucalificativcentrat.text = @"Comunicarea cu vânzătorul";
//               cell.cadrustele.clipsToBounds =YES;
//            HCSStarRatingView *NEWSTARS =[self HCS:2];
//           
//            [NEWSTARS  addTarget:self action:@selector(stardidChangeValue2:) forControlEvents:UIControlEventValueChanged];
//            CGRect framestele = cell.cadrustele.frame;
//            NEWSTARS.frame=framestele;
//             NEWSTARS.clipsToBounds =YES;
//            [cell.contentView addSubview:NEWSTARS];
//            [cell.contentView bringSubviewToFront:NEWSTARS];
//                [cell.contentView  setNeedsLayout];
//                [cell.contentView  layoutIfNeeded];
//          
            
        } break;
        case 14: {
//            cell.sageatagri.hidden=YES;
//            cell.titluROW.hidden=YES;
//            cell.titlucalificativcentrat.hidden=NO;
//            cell.titlucalificativcentrat.font = [UIFont boldSystemFontOfSize:17.0f];
//            cell.titlucalificativcentrat.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
//            cell.dynamictableheightJ.constant =45;
//            cell.titlucalificativcentrat.text = @"Timpul de livrare";
//               cell.cadrustele.clipsToBounds =YES;
//            HCSStarRatingView *NEWSTARS =[self HCS:3];
//            [NEWSTARS  addTarget:self action:@selector(stardidChangeValue3:) forControlEvents:UIControlEventValueChanged];
//            CGRect framestele = cell.cadrustele.frame;
//            NEWSTARS.frame=framestele;
//            NEWSTARS.clipsToBounds =YES;
//            [cell.contentView addSubview:NEWSTARS];
//            [cell.contentView bringSubviewToFront:NEWSTARS];
//                [cell.contentView  setNeedsLayout];
//                [cell.contentView  layoutIfNeeded];
//           
//
          
        } break;
        case 15: {
//            cell.sageatagri.hidden=YES;
//            cell.titluROW.hidden=YES;
//            cell.titlucalificativcentrat.hidden=NO;
//            cell.titlucalificativcentrat.font = [UIFont boldSystemFontOfSize:17.0f];
//            cell.titlucalificativcentrat.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
//            cell.cadrustele.clipsToBounds =YES;
//            cell.dynamictableheightJ.constant =45;
//            cell.titlucalificativcentrat.text = @"Costul de transport";
//            HCSStarRatingView *NEWSTARS =[self HCS:4];
//            [NEWSTARS  addTarget:self action:@selector(stardidChangeValue4:) forControlEvents:UIControlEventValueChanged];
//            CGRect framestele = cell.cadrustele.frame;
//            NEWSTARS.frame=framestele;
//            NEWSTARS.clipsToBounds =YES;
//            [cell.contentView addSubview:NEWSTARS];
//            [cell.contentView bringSubviewToFront:NEWSTARS];
//                [cell.contentView  setNeedsLayout];
//                [cell.contentView  layoutIfNeeded];
//            
//
//           
        } break;
        case 16: {
            cell.sageatablue.hidden=NO;
            cell.Continua.hidden=NO;
        } break;
            
        default:
            break;
    }
    // [self.LISTASELECT reloadData];
    return cell;
}
-(IBAction)gata:(id)sender {
    //verifica toate selecturile inclusiv textul editabil | Motivează calificativul acordat ...
    NSString *item_type=@"";
    NSString *item_id=@"";
    NSString *rating_type=@"";
    NSString *comment=@"";
    NSString *description=@"";
    NSString *communication=@"";
    NSString *delivery=@"";
    NSString *transport=@"";
    
    NSMutableArray *erori = [[NSMutableArray alloc]init];
    NSString *eroarecalif = @"Nu ai selectat:";
    [erori addObject:eroarecalif];
    BOOL ok=YES;
    BOOL ok2=NO;
    BOOL ok3=NO;
    if( tipuldecalificativdeacordat==0) {
        NSString *er1 = @"tipul de calificativ (pozitiv / negativ / neutru) /";
        [erori addObject:er1];
        ok=NO;
    } else {
        if(tipuldecalificativdeacordat ==1) {
            rating_type =@"positive";
        }
        if(tipuldecalificativdeacordat ==2) {
            rating_type =@"neutral";
        }
        if(tipuldecalificativdeacordat ==3) {
            rating_type =@"negative";
        }
    }
//    if(rating1==0 || rating2 ==0 || rating3==0 || rating4 ==0) {
//        NSString *er2 = @"rating (stea) pentru fiecare din cele 4 criterii /";
//        [erori addObject:er2];
//        ok =NO;
//    } else {
//        description =[NSString stringWithFormat:@"%f", rating1];
//        communication=[NSString stringWithFormat:@"%f", rating2];
//        delivery=[NSString stringWithFormat:@"%f", rating3];
//        transport=[NSString stringWithFormat:@"%f", rating4];
//    }
//    NSIndexPath *indexPathreload = [NSIndexPath indexPathForRow:10 inSection:0];
//    CellAcorda *updateCell = (CellAcorda *)[self.LISTASELECT cellForRowAtIndexPath:indexPathreload];
//    UITextView *tf = [updateCell texteditabil];
//    NSLog(@" texteditabil texteditabil %@", tf.text);
      NSLog(@" texteditabil texteditabil %@",comentariuAcorda);
//            if([self MyStringisEmpty:[NSString stringWithFormat:@"%@", tf.text]] || [tf.text isEqualToString:@"| Motivează calificativul acordat ..."]) {
//             ok2=NO;
//                NSString *er3 = @"comentariu calificativ";
//                [erori addObject:er3];
//            } else {
//              comment = [NSString stringWithFormat:@"%@", tf.text];
//             ok2=YES;
//            }
    if([self MyStringisEmpty:comentariuAcorda] || [comentariuAcorda isEqualToString:@"opțional"]) {
        ok2=YES;
        comment = @"";
        NSString *er3 = @"";
        [erori addObject:er3];
    } else {
        comment = [NSString stringWithFormat:@"%@",comentariuAcorda];
        ok2=YES;
    }
   //jmod ok3= ok&&ok2;
    ok3= ok2;
    if(ok3==NO) {
        NSString *EROARE= [NSString stringWithFormat:@"%@", [erori componentsJoinedByString:@" "]];
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Eroare" message:EROARE delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    } else {
        NSMutableDictionary *DICTADD = [[NSMutableDictionary alloc]init];
        
        NSString *tipitem = [NSString stringWithFormat:@"%@", CALIFICATIV[@"item_type"]];
        if([tipitem isEqualToString:@"cerere"]) {
            item_type =@"cerere";
        } else {
            item_type =@"product";
        }
        
        if( CALIFICATIV[@"item_id"]) {
            item_id = [NSString stringWithFormat:@"%@", CALIFICATIV[@"item_id"]];
        }
        [DICTADD setObject:item_type forKey:@"item_type"];
        [DICTADD setObject:item_id forKey:@"item_id"];
        [DICTADD setObject:comment forKey:@"comment"];
        [DICTADD setObject:rating_type forKey:@"rating_type"];
        [DICTADD setObject:description forKey:@"description"];
        [DICTADD setObject:communication forKey:@"communication"];
        [DICTADD setObject:delivery forKey:@"delivery"];
        [DICTADD setObject:transport forKey:@"transport"];
        
        utilitar=[[Utile alloc] init];
        NSString *authtoken=@"";
        BOOL elogat = NO;
        elogat = [utilitar eLogat];
        if(elogat) {
            authtoken = [utilitar AUTHTOKEN];
            //-(void)add_rating :(NSString *)AUTHTOKEN :(NSMutableDictionary *)adaugaRating {
            [self add_rating:authtoken :DICTADD];
            
        }
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger ipx = indexPath.row;
    if(ipx ==6 || ipx==7 || ipx==8) {
        NSIndexPath *indexPathx = [NSIndexPath indexPathForRow:ipx inSection:0]; // sa urce peste keyboard
        CellAcorda *CELL = (CellAcorda *)[LISTASELECT cellForRowAtIndexPath:indexPathx];
        CELL.bifablue.hidden =YES;
        CELL.titlucalificativ.textColor =  [UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1];
        //    [self.LISTASELECT reloadData]; // metoda cea mai simpla pt bifa
    } else {
        
    }
}
//METODA_ADD_RATING
-(void)add_rating :(NSString *)AUTHTOKEN :(NSMutableDictionary *)adaugaRating { //user_id sau username
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
        if(adaugaRating[@"item_type"])  [dic2 setObject:adaugaRating[@"item_type"] forKey:@"item_type"];
        if(adaugaRating[@"item_id"])  [dic2 setObject:adaugaRating[@"item_id"] forKey:@"item_id"];
        if(adaugaRating[@"comment"])  [dic2 setObject:adaugaRating[@"comment"] forKey:@"comment"];
        if(adaugaRating[@"rating_type"])  [dic2 setObject:adaugaRating[@"rating_type"] forKey:@"rating_type"];
        if(adaugaRating[@"description"])  [dic2 setObject:adaugaRating[@"description"] forKey:@"description"];
        if(adaugaRating[@"communication"])  [dic2 setObject:adaugaRating[@"communication"] forKey:@"communication"];
        if(adaugaRating[@"delivery"])  [dic2 setObject:adaugaRating[@"delivery"] forKey:@"delivery"];
        if(adaugaRating[@"transport"])  [dic2 setObject:adaugaRating[@"transport"] forKey:@"transport"];
        
        
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic2 options:0 error:&err];
        NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        compus =[NSString stringWithFormat:@"%@%@",METODA_ADD_RATING, myString];
        
        
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
                    NSMutableDictionary *multedate = REZULTAT_NOTIFY_COUNT[@"data"];
                    NSLog(@"date addrating %@",multedate);
                    NSString *catemaiare = @"0";
                    if(multedate[@"ratings_todo"]) {
                        catemaiare = [NSString stringWithFormat:@"%@",multedate[@"ratings_todo"]];
                    }
                    /*
                     m=add_rating&p={"description":"4.000000","version":"9.2.1","rating_type":"positive","item_id":"1826878","transport":"3.000000","authtoken":"1248f7g5756e1e9gEQLfMQdHjj1nDXSv868DRYDL7Rw0_fxW50lK9RVZv64","comment":"Forte ok","os":"iOS","communication":"4.000000","item_type":"cerere","delivery":"4.000000","lang":"ro"}
                     2016-06-09 13:29:43.053 Piese auto[9600:2246868] ERORS (
                     )
                     2016-06-09 13:29:43.053 Piese auto[9600:2246868] date addrating {
                     "ratings_todo" = 4;
                     }
                     */
                    EcranAiAcordat *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"EcranAiAcordatVC"];
                    vc.catemaiare = (int)catemaiare.integerValue;
                    [self.navigationController pushViewController:vc animated:NO];
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
                    NSMutableDictionary *multedate = REZULTAT_NOTIFY_COUNT[@"data"];
                    NSLog(@"date DETALIU OFERTA %@",multedate);
                    [self removehud];
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
    NSInteger ipx = indexPath.row;
    utilitar=[[Utile alloc] init];
    //get_member_profile
    //    Pe detaliu calificativ, la click pe "title detailed" avem situatiile:
    //    - "item_type" = "product" -> duce la un URL din pieseauto.ro  "external_url"
    //    - "item_type" = "cerere"
    //    - userul logat este acelasi cu "main_item_owner_id" -> duce in aplicatie in ecranul cu detalii oferta ("item_id" este id de oferta, "main_item_id" este id de cerere)
    //    - userul logat nu e acelasi cu "main_item_owner_id" -> duce la un URL din pieseauto.ro  "external_url"
    switch(ipx) {
        case 1: {
            if([CE_TIP_E isEqualToString:@"acorda"] ) {
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
            } else
            if([CE_TIP_E isEqualToString:@"dincerere"]) {
                if(CALIFICATIV[@"messageid"]) {
                    NSString *messageitemid = [NSString stringWithFormat:@"%@", CALIFICATIV[@"messageid"]];
                    NSString *user_id=@"";
                    NSDictionary *userlogat = [DataMasterProcessor getLOGEDACCOUNT];
                    NSLog(@"usercalif %@", userlogat);
                    if(userlogat[@"U_userid"]) {
                        user_id =[NSString stringWithFormat:@"%@",userlogat[@"U_userid"]];
                    }
                    //main_item_id
                    
                    NSString *authtoken=@"";
                    BOOL elogat = NO;
                    elogat = [utilitar eLogat];
                    if(elogat) {
                        authtoken = [utilitar AUTHTOKEN];
                        if(![self MyStringisEmpty:messageitemid]) {
                            [self getOffer:messageitemid :authtoken];
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
        }
            break;
        case 3: {
            //user profile
            NSString *user_id =@"";
            NSString *authtoken=@"";
            if([CE_TIP_E isEqualToString:@"acorda"] ) {
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
            } else
            if([CE_TIP_E isEqualToString:@"dincerere"]) {
                if(CALIFICATIV[@"username"]) {
                    NSString *username =[NSString stringWithFormat:@"%@",CALIFICATIV[@"username"]];
                    BOOL elogat = NO;
                    elogat = [utilitar eLogat];
                    if(elogat) {
                        authtoken = [utilitar AUTHTOKEN];
                        //  -(void)get_member_profile :(NSString *)userid :(NSString *)AUTHTOKEN :(NSString *)tipuserid
                        [self get_member_profile:username :authtoken :@"username"];
                    }
                }
            }
        }
            break;
        case 6: {
            CellAcorda *CELL = (CellAcorda *)[LISTASELECT cellForRowAtIndexPath:indexPath];
            CELL.bifablue.hidden =NO;
            CELL.titlucalificativ.textColor =  [UIColor blackColor];
            CELL.titlucalificativ.font = [UIFont boldSystemFontOfSize:17.0f];
            tipuldecalificativdeacordat=1;
            [self.LISTASELECT reloadData];
            
        }break;
        case 7:{
            CellAcorda *CELL = (CellAcorda *)[LISTASELECT cellForRowAtIndexPath:indexPath];
            CELL.bifablue.hidden =NO;
            CELL.titlucalificativ.textColor =  [UIColor blackColor];
            CELL.titlucalificativ.font = [UIFont boldSystemFontOfSize:17.0f];
            
            tipuldecalificativdeacordat=2;
            [self.LISTASELECT reloadData];
        }break;
        case 8:{
            CellAcorda *CELL = (CellAcorda *)[LISTASELECT cellForRowAtIndexPath:indexPath];
            CELL.bifablue.hidden =NO;
            CELL.titlucalificativ.textColor =  [UIColor blackColor];
            CELL.titlucalificativ.font = [UIFont boldSystemFontOfSize:17.0f];
            tipuldecalificativdeacordat=3;
            [self.LISTASELECT reloadData];
            
        }break;
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
-(void)viewWillDisappear:(BOOL)animated{
    
}

@end


