//
//  DetaliuVanzator.m
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
#import "DetaliuProfil.h"
#import "CellCalificativ.h"
#import "TutorialHomeViewController.h"
#import <CoreText/CoreText.h>
#import "SetariViewController.h"
#import "OferteLaCerereViewController.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "UIImageView+WebCache.h" //sdwebimage
#import "WebViewController.h"
#import "EcranCalificative.h"
#import "DetaliuVanzator.h"
#import "EcranCalificativAcordatsauPrimit.h"
#import "EcranAcorda.h"
#import "butoncustomback.h"

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
static NSString *PE_PAGINA = @"20";

@interface DetaliuProfil(){
    NSMutableArray* Cells_Array;
}
@end

@implementation EcranCalificative
@synthesize  LISTASELECT,titluriCAMPURI,catedeacordat,cateacordate,cateprimite,_currentPage_deacordat,_currentPage_acordate,_currentPage_primite;
@synthesize TOATEDEACORDAT,TOATEACORDATE,TOATEPRIMITE,SEGMENTACTIV,SEGCNTRL,INCHIDEALERTA;

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
//  +(NSDictionary*) getuser_closealerta:(NSString*)USERID
-(void)viewWillAppear:(BOOL)animated {
    self.title = @"Calificative";
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
    [self addhud];
    SEGMENTACTIV =0;
    NSLog(@"ecran calificative");
    TOATEDEACORDAT =[[NSMutableArray alloc]init];
    TOATEACORDATE =[[NSMutableArray alloc]init];
    TOATEPRIMITE =[[NSMutableArray alloc]init];
    //se verifica daca a apasat nu  mai afisa alerta //sunt tinuti in baza pe userid si Nu
    NSDictionary *PREFERINTAUSERA = [[NSDictionary alloc]init];
    NSString *authtoken=@"";
    BOOL elogat = NO;
    NSString *user_id=@"";
    utilitar = [[Utile alloc]init];
    elogat = [utilitar eLogat];
    if(elogat) {
        authtoken = [utilitar AUTHTOKEN];
        NSDictionary *userlogat = [DataMasterProcessor getLOGEDACCOUNT];
        if(userlogat[@"U_userid"]) {
            user_id =[NSString stringWithFormat:@"%@",userlogat[@"U_userid"]];
            PREFERINTAUSERA = [DataMasterProcessor getuser_closealerta:user_id];
            NSLog(@"PREFERINTAUSERA %@",PREFERINTAUSERA);
            if(PREFERINTAUSERA[@"A_afisat"] ) {
                NSString *prefalertuser = [NSString stringWithFormat:@"%@",PREFERINTAUSERA[@"A_afisat"]];
                if([prefalertuser isEqualToString:@"Nu"]) {
                    INCHIDEALERTA=YES;
                }
            }
        }
    }
    SEGCNTRL.selectedSegmentIndex =SEGMENTACTIV;
    LISTASELECT.delegate =self;
    LISTASELECT.dataSource =self;
    LISTASELECT.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self._currentPage_acordate =_currentPage_acordate;
    _currentPage_deacordat=1;
    _currentPage_acordate=1;
    _currentPage_primite=1;
    catedeacordat=0;cateacordate=0;cateprimite=0;
    utilitar = [[Utile alloc]init];
    
    if(elogat) {
        authtoken = [utilitar AUTHTOKEN];
        
        //- type (todo, done, received, toreceive)
        NSDictionary *userlogat = [DataMasterProcessor getLOGEDACCOUNT];
        if(userlogat[@"U_userid"]) {
            user_id =[NSString stringWithFormat:@"%@",userlogat[@"U_userid"]];
        }
        else if(userlogat[@"U_username"]) {
            user_id =[NSString stringWithFormat:@"%@",userlogat[@"U_username"]];
        }
        NSString *pagina = [NSString stringWithFormat:@"%i", _currentPage_deacordat];
        if(_currentPage_deacordat ==1) {
            _currentPage_deacordat ++;
          
            [self  list_ratings:authtoken :pagina :PE_PAGINA :@"todo" :user_id];
        } else  if(_currentPage_deacordat < catedeacordat)  {
            _currentPage_deacordat ++;
          
            [self  list_ratings:authtoken :pagina :PE_PAGINA :@"todo" :user_id];
        }
        
    }
    
    
    [SEGCNTRL addTarget:self     action:@selector(valueChanged:)
       forControlEvents:UIControlEventValueChanged];
    SEGCNTRL.selectedSegmentIndex =SEGMENTACTIV;
    LISTASELECT.delegate =self;
    LISTASELECT.dataSource =self;
    LISTASELECT.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [LISTASELECT reloadData];
    
    
}
-(IBAction)closeAlerta:(id)sender {
    
    NSString *authtoken=@"";
    BOOL elogat = NO;
    NSString *user_id=@"";
    utilitar = [[Utile alloc]init];
    elogat = [utilitar eLogat];
    if(elogat) {
        authtoken = [utilitar AUTHTOKEN];
        NSDictionary *userlogat = [DataMasterProcessor getLOGEDACCOUNT];
        if(userlogat[@"U_userid"]) {
            user_id =[NSString stringWithFormat:@"%@",userlogat[@"U_userid"]];
        }
        NSMutableDictionary *preferinteuser =[[NSMutableDictionary alloc]init];
        [preferinteuser setObject:user_id forKey:@"U_userid"];
        [preferinteuser setObject:@"Nu" forKey:@"preferinta"];
        BOOL ok =NO;
        ok=[DataMasterProcessor updatePreferintaUsers:preferinteuser];
        NSLog(@"E OK UPDATE %i",ok );
        if(ok) {
            INCHIDEALERTA =YES;
            [self.LISTASELECT reloadData];
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
   
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int numarranduri =0;
    //+1 ->randul de alerta
    if(SEGMENTACTIV ==0) {
        numarranduri = (int)TOATEDEACORDAT.count +1;
    }
    if(SEGMENTACTIV ==1) {
        numarranduri = (int)TOATEACORDATE.count+1;
    }
    if(SEGMENTACTIV ==2) {
        numarranduri = (int)TOATEPRIMITE.count+1;
    }
    return numarranduri;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    double inaltimerand=0;
    NSInteger ipx = indexPath.row;
    if(ipx ==0) {
        if(SEGMENTACTIV ==0) {
            if(INCHIDEALERTA ==NO) {
                inaltimerand = 60;
            } else {
                inaltimerand=0;
            }
        } else {
            inaltimerand=0;
        }
    } else {
        NSDictionary *calculcomentariu = [[NSDictionary alloc]init];
        if(SEGMENTACTIV ==0  && TOATEDEACORDAT.count >0) {
            if([TOATEDEACORDAT objectAtIndex:indexPath.row-1] && [self checkDictionary:[TOATEDEACORDAT objectAtIndex:indexPath.row-1]]) {
                calculcomentariu = [NSDictionary dictionaryWithDictionary:[TOATEDEACORDAT objectAtIndex:indexPath.row-1]];
            }
        }
        if(SEGMENTACTIV ==1   && TOATEACORDATE.count >0) {
            if([TOATEACORDATE objectAtIndex:indexPath.row-1] &&[self checkDictionary:[TOATEACORDATE objectAtIndex:indexPath.row-1]]) {
                calculcomentariu = [NSDictionary dictionaryWithDictionary:[TOATEACORDATE objectAtIndex:indexPath.row-1]];
            }
        }
        if(SEGMENTACTIV ==2   && TOATEPRIMITE.count >0) {
            if([TOATEPRIMITE objectAtIndex:indexPath.row-1]&& [self checkDictionary:[TOATEPRIMITE objectAtIndex:indexPath.row-1]]) {
                calculcomentariu = [NSDictionary dictionaryWithDictionary:[TOATEPRIMITE objectAtIndex:indexPath.row-1]];
            }
        }
        
        
        if(calculcomentariu[@"title"]) {
            CGFloat widthWithInsetsApplied = self.view.frame.size.width -20;
            
            if(calculcomentariu[@"item_type"]) {
                NSString *tipitem = [NSString stringWithFormat:@"%@", calculcomentariu[@"item_type"]];
                if([tipitem isEqualToString:@"cerere"]) {
                    if(calculcomentariu[@"title"]) {
                        NSString *textcoment =[NSString stringWithFormat:@"Cerere: %@",calculcomentariu[@"title"]];
                        CGSize textSize = [textcoment boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19]} context:nil].size;
                        UIFont *tester = [UIFont systemFontOfSize:19];
                        inaltimerand= textSize.height;
                        double numberOfLines = textSize.height /tester.pointSize;
                        if(numberOfLines >2) {
                            inaltimerand = 90;
                        } else {
                              inaltimerand = 70;
                        }
                    }
                }else {
                    if(calculcomentariu[@"title"]) {
                        NSString *textcoment =[NSString stringWithFormat:@"Anunț: %@",calculcomentariu[@"title"]];
                        CGSize textSize = [textcoment boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19]} context:nil].size;
                        // inaltimerand= textSize.height +60;
                        inaltimerand= textSize.height;
                        UIFont *tester = [UIFont systemFontOfSize:19];
                        double numberOfLines = textSize.height /tester.pointSize;
                        if(numberOfLines >2) {
                            inaltimerand = 90;
                        } else {
                            inaltimerand = 70;
                        }

                    }
                }
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
-(void)tothetopoftable{
    NSIndexSet *section =  [NSIndexSet indexSetWithIndex:0];
    [self.LISTASELECT beginUpdates];
    [self.LISTASELECT reloadSections:section withRowAnimation:UITableViewRowAnimationNone];
    [self.LISTASELECT endUpdates];
    NSIndexPath *pathToLastRow = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.LISTASELECT scrollToRowAtIndexPath:pathToLastRow
                            atScrollPosition:UITableViewScrollPositionTop
                                    animated:NO];
}
- (IBAction)valueChanged:(id)sender {

    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    NSLog(@"uiseg %i",(int) segmentedControl.selectedSegmentIndex);
    SEGMENTACTIV =(int) segmentedControl.selectedSegmentIndex;
    [self launchReload];
    [self reloadsectiunea12];
    //verifica daca are rows
    if(SEGMENTACTIV ==0 && self.TOATEDEACORDAT.count>0) {
        [self tothetopoftable];
    }  else {
        [self.LISTASELECT reloadData];
    }
    
    if(SEGMENTACTIV ==1 && self.TOATEACORDATE.count>0) {
        [self tothetopoftable];
    } else {
        [self.LISTASELECT reloadData];
    }
    if(SEGMENTACTIV ==2 && self.TOATEPRIMITE.count>0) {
        [self tothetopoftable];
    } else {
        [self.LISTASELECT reloadData];
    }
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // self.titluriCAMPURI =@[@"numeuser",@"seller gold",array_tels, AREFIRMA ,@"membrudin",@"eticheta calif",@"pozit",@"neut",@"neg",@"eticheta calif detaliate",array_criterii,@"tabbar",@"arraytoate",@"vezimaimult"
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //// int ipx = (int)indexPath.section;
    int ROWWHOIS = (int)indexPath.row;
    static NSString *CellIdentifier = @"CellCalificativ";
    CellCalificativ *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (CellCalificativ*)[tableView dequeueReusableCellWithIdentifier:@"CellCalificativ"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeAlerta:)];
    [singleTap setNumberOfTapsRequired:1];
    
    cell.RowGalben.hidden=YES;
    cell.RowAcorda.hidden=YES;
    if(ROWWHOIS ==0) {
        if(INCHIDEALERTA ==NO) {
            cell.RowGalben.hidden=NO;
            cell.iconclose.userInteractionEnabled =YES;
            [cell bringSubviewToFront:cell.iconclose];
            [cell.iconclose addGestureRecognizer:singleTap];
        } else {
            cell.RowGalben.hidden=YES;
            
        }
        //INCHIDEALERTA
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1];
        
    } else {
        NSDictionary *calificativ =[[NSDictionary alloc]init];
        if(self.SEGCNTRL.selectedSegmentIndex ==0 && self.TOATEDEACORDAT.count >0) {
            cell.RowAcorda.hidden=NO;
            
            if([self.TOATEDEACORDAT objectAtIndex:ROWWHOIS-1 ] &&[[self.TOATEDEACORDAT objectAtIndex:ROWWHOIS-1 ] isKindOfClass: [NSDictionary class ]])   {
                //intotdeauna pentru ca primul rand e label galben
                calificativ =[[NSDictionary alloc]init];
                calificativ =[self.TOATEDEACORDAT objectAtIndex:ROWWHOIS-1];
                cell.sageatagri.hidden=YES;
                cell.iconcalificativ.hidden=YES;
                cell.acordacalificativ.hidden=NO;
                NSString *acordacalif =[NSString stringWithFormat:@"Acordă calificativ"];
                [cell.acordacalificativ setText:acordacalif afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
                    NSRange bigRange = [acordacalif rangeOfString:acordacalif];
                    // Core Text APIs use C functions without a direct bridge to UIFont. See Apple's "Core Text Programming Guide" to learn how to configure string attributes.
                    UIFont *cererefont =[UIFont boldSystemFontOfSize:15];
                    CTFontRef fontdoi = CTFontCreateWithName((__bridge CFStringRef)cererefont.fontName, cererefont.pointSize, NULL);
                    if (fontdoi) {
                        [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)fontdoi range:bigRange];
                        //[mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[[UIColor blackColor] CGColor] range:bigRange];
                        CFRelease(fontdoi);
                    }
                    return mutableAttributedString;
                }];
                
                
                
                cell.sageatablue.hidden=NO;
                cell.numeutilizator.hidden=NO;
                cell.numeutilizatorextins.hidden=YES;
                NSString *username=@"";
                if(calificativ[@"user_profile"]) {
                    NSDictionary *user_profile = [NSDictionary dictionaryWithDictionary:calificativ[@"user_profile"]];
                    if(user_profile[@"username"]) {
                        username =[NSString stringWithFormat:@"%@",user_profile[@"username"]];
                        //cell.numeutilizator.text =username;
                        [cell.numeutilizator setText:username afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
                            NSRange bigRange = [username rangeOfString:username];
                            
                            // Core Text APIs use C functions without a direct bridge to UIFont. See Apple's "Core Text Programming Guide" to learn how to configure string attributes.
                            UIFont *cererefont =[UIFont boldSystemFontOfSize:16];
                            CTFontRef fontdoi = CTFontCreateWithName((__bridge CFStringRef)cererefont.fontName, cererefont.pointSize, NULL);
                            if (fontdoi) {
                                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)fontdoi range:bigRange];
                                [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[[UIColor blackColor] CGColor] range:bigRange];
                                CFRelease(fontdoi);
                            }
                            return mutableAttributedString;
                        }];
                        
                        
                    }
                }
                
            }
        }
        if(self.SEGCNTRL.selectedSegmentIndex ==1 && self.TOATEACORDATE.count >0) {
            cell.RowAcorda.hidden=NO;
            calificativ =[[NSDictionary alloc]init];
            if([self.TOATEACORDATE objectAtIndex:ROWWHOIS-1 ] &&[[self.TOATEACORDATE objectAtIndex:ROWWHOIS-1 ] isKindOfClass: [NSDictionary class ]])   {
                //intotdeauna pentru ca primul rand e label galben
                calificativ =[self.TOATEACORDATE objectAtIndex:ROWWHOIS-1];
                cell.sageatagri.hidden=NO;
                cell.iconcalificativ.hidden=NO;
                cell.acordacalificativ.hidden=YES;
                cell.sageatablue.hidden=YES;
                cell.numeutilizator.hidden=YES;
                cell.numeutilizatorextins.hidden=NO;
                NSString *username=@"";
                if(calificativ[@"user_profile"]) {
                    NSDictionary *user_profile = [NSDictionary dictionaryWithDictionary:calificativ[@"user_profile"]];
                    if(user_profile[@"username"]) {
                        username =[NSString stringWithFormat:@"%@",user_profile[@"username"]];
                        // cell.numeutilizatorextins.text =username;
                        [cell.numeutilizatorextins setText:username afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
                            NSRange bigRange = [username rangeOfString:username];
                            
                            // Core Text APIs use C functions without a direct bridge to UIFont. See Apple's "Core Text Programming Guide" to learn how to configure string attributes.
                            UIFont *cererefont =[UIFont boldSystemFontOfSize:16];
                            CTFontRef fontdoi = CTFontCreateWithName((__bridge CFStringRef)cererefont.fontName, cererefont.pointSize, NULL);
                            if (fontdoi) {
                                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)fontdoi range:bigRange];
                                [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[[UIColor blackColor] CGColor] range:bigRange];
                                CFRelease(fontdoi);
                            }
                            return mutableAttributedString;
                        }];
                        
                    }
                }
            }
        }
        if(self.SEGCNTRL.selectedSegmentIndex ==2 && self.TOATEPRIMITE.count >0) {
            cell.RowAcorda.hidden=NO;
            calificativ =[[NSDictionary alloc]init];
            if([self.TOATEPRIMITE objectAtIndex:ROWWHOIS-1 ] &&[[self.TOATEPRIMITE objectAtIndex:ROWWHOIS-1 ] isKindOfClass: [NSDictionary class ]])   {
                //intotdeauna pentru ca primul rand e label galben
                calificativ =[self.TOATEPRIMITE objectAtIndex:ROWWHOIS-1];
                cell.sageatagri.hidden=NO;
                cell.iconcalificativ.hidden=NO;
                cell.acordacalificativ.hidden=YES;
                cell.sageatablue.hidden=YES;
                cell.numeutilizator.hidden=YES;
                cell.numeutilizatorextins.hidden=NO;
                NSString *username=@"";
                if(calificativ[@"user_profile"]) {
                    NSDictionary *user_profile = [NSDictionary dictionaryWithDictionary:calificativ[@"user_profile"]];
                    if(user_profile[@"username"]) {
                        username =[NSString stringWithFormat:@"%@",user_profile[@"username"]];
                        // cell.numeutilizatorextins.text =username;
                        [cell.numeutilizatorextins setText:username afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
                            NSRange bigRange = [username rangeOfString:username];
                            
                            // Core Text APIs use C functions without a direct bridge to UIFont. See Apple's "Core Text Programming Guide" to learn how to configure string attributes.
                            UIFont *cererefont =[UIFont boldSystemFontOfSize:16];
                            
                            CTFontRef fontdoi = CTFontCreateWithName((__bridge CFStringRef)cererefont.fontName, cererefont.pointSize, NULL);
                            if (fontdoi) {
                                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)fontdoi range:bigRange];
                                [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[[UIColor blackColor] CGColor] range:bigRange];
                                CFRelease(fontdoi);
                            }
                            return mutableAttributedString;
                        }];
                        
                    }
                }
                
            }
        }
        /*
         cell.iconcalificativ.image =[UIImage imageNamed:@"Icon_Calificativ_Pozitiv_180x180.png"];
         cell.iconcalificativ.image =[UIImage imageNamed:@"Icon_Calificativ_Neutru_180x180.png"];
         cell.iconcalificativ.image =[UIImage imageNamed:@"Icon_Calificativ_Negativ_180x180.png"];
         cell.iconcalificativ.image =[UIImage imageNamed:@"Icon_Calificativ_Neacordat_144x144.png"];
         */
        if(calificativ[@"rating_type"]) {
            NSString *rating_type =[NSString stringWithFormat:@"%@",calificativ[@"rating_type"]];
            if([self MyStringisEmpty:rating_type]) {
                cell.iconcalificativ.image =[UIImage imageNamed:@"Icon_Calificativ_Neacordat_144x144.png"];
            }
            if([rating_type isEqualToString:@"positive"]) {
                cell.iconcalificativ.image = [UIImage imageNamed:@"Icon_Calificativ_Pozitiv_Face_144x144.png"];
              
            }
            if([rating_type isEqualToString:@"neutral"]) {
                cell.iconcalificativ.image = [UIImage imageNamed:@"Icon_Calificativ_Neutru_Face_144x144.png"];
              
            }
            if([rating_type isEqualToString:@"negative"]) {
                cell.iconcalificativ.image =[UIImage imageNamed:@"Icon_Calificativ_Negativ_Face_144x144.png"];
            
            }

            
        }
        
        
        NSString *textcoment=@"";
        ////   NSLog(@" row -1 %i %@",ROWWHOIS-1,calificativ );
        if(calificativ[@"title"]) {
            CGFloat widthWithInsetsApplied = self.view.frame.size.width- 20;
                        double inaltimerand=0;
            if(calificativ[@"item_type"]) {
                NSString *tipitem = [NSString stringWithFormat:@"%@", calificativ[@"item_type"]];
                if([tipitem isEqualToString:@"cerere"]) {
                    
                    NSString *cerere = @"Cerere: ";
                    if(calificativ[@"title"]) {
                        textcoment =[NSString stringWithFormat:@"%@",calificativ[@"title"]];
                        NSString *compus =[NSString stringWithFormat:@"%@ %@",cerere,textcoment];
                        CGSize textSize = [compus boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19]} context:nil].size;
                             UIFont *tester = [UIFont systemFontOfSize:19];
                        inaltimerand= textSize.height;
                        double numberOfLines = textSize.height /tester.pointSize;
                        if(numberOfLines >2) {
                             cell.titlucerereanunt.numberOfLines = 2;
                            inaltimerand = 48;
                        } else {
                            inaltimerand = 24;
                             cell.titlucerereanunt.numberOfLines = 1;
                        }
                        cell.titlucerereanunt.lineBreakMode = NSLineBreakByWordWrapping;
                        cell.dynamiccellcomentariuheight.constant= inaltimerand;
                        
                        // If you're using a simple `NSString` for your text,
                        // assign to the `text` property last so it can inherit other label properties.
                        
                        [cell.titlucerereanunt setText:compus afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
                            NSRange bigRange = [compus rangeOfString:cerere];
                            NSRange mediumRange = [cerere rangeOfString:textcoment];
                            
                            // Core Text APIs use C functions without a direct bridge to UIFont. See Apple's "Core Text Programming Guide" to learn how to configure string attributes.
                            UIFont *cererefont =[UIFont systemFontOfSize:17];
                            UIFont *titlucererefont =[UIFont systemFontOfSize:19];
                            CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)cererefont.fontName, cererefont.pointSize, NULL);
                            CTFontRef fontdoi = CTFontCreateWithName((__bridge CFStringRef)titlucererefont.fontName, titlucererefont.pointSize, NULL);
                            if (font && fontdoi) {
                                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:bigRange];
                                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)fontdoi range:mediumRange];
                                [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[[UIColor lightGrayColor] CGColor] range:bigRange];
                                [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[[UIColor blackColor] CGColor] range:mediumRange];
                                CFRelease(font);
                            }
                            return mutableAttributedString;
                        }];
                        
                    }
                } else {
                    NSString *cerere = @"Anunț: ";
                    if(calificativ[@"title"]) {
                        textcoment =[NSString stringWithFormat:@"%@",calificativ[@"title"]];
                        NSString *compus =[NSString stringWithFormat:@"%@ %@",cerere,textcoment];
                        CGSize textSize = [compus boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19]} context:nil].size;
                        UIFont *tester = [UIFont systemFontOfSize:19];
                        inaltimerand= textSize.height;
                        double numberOfLines = textSize.height /tester.pointSize;
                        if(numberOfLines >2) {
                            cell.titlucerereanunt.numberOfLines = 2;
                            inaltimerand = 48;
                        } else {
                            inaltimerand = 24;
                            cell.titlucerereanunt.numberOfLines = 1;
                        }
                         cell.dynamiccellcomentariuheight.constant= inaltimerand;
                        cell.titlucerereanunt.lineBreakMode = NSLineBreakByWordWrapping;
                            [cell.titlucerereanunt setText:compus afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
                            NSRange bigRange = [compus rangeOfString:cerere];
                            NSRange mediumRange = [cerere rangeOfString:textcoment];
                            
                            // Core Text APIs use C functions without a direct bridge to UIFont. See Apple's "Core Text Programming Guide" to learn how to configure string attributes.
                            UIFont *cererefont =[UIFont systemFontOfSize:17];
                            UIFont *titlucererefont =[UIFont systemFontOfSize:19];
                            CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)cererefont.fontName, cererefont.pointSize, NULL);
                            CTFontRef fontdoi = CTFontCreateWithName((__bridge CFStringRef)titlucererefont.fontName, titlucererefont.pointSize, NULL);
                            if (font && fontdoi) {
                                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:bigRange];
                                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)fontdoi range:mediumRange];
                                [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[[UIColor lightGrayColor] CGColor] range:bigRange];
                                [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[[UIColor blackColor] CGColor] range:mediumRange];
                                CFRelease(font);
                            }
                            return mutableAttributedString;
                        }];
                        
                    }
                }
            }
           
        }
        
        
        
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(self.SEGCNTRL.selectedSegmentIndex ==0) {
        
        if (indexPath.row == [self.TOATEDEACORDAT count] - 1)
        {
            [self launchReload];
        }
    }
    if(self.SEGCNTRL.selectedSegmentIndex ==1) {
        if (indexPath.row == [self.TOATEACORDATE count] - 1)
        {
            [self launchReload];
        }
    }
    if(self.SEGCNTRL.selectedSegmentIndex ==2) {
        if (indexPath.row == [self.TOATEPRIMITE count] - 1)
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
-(void)launchReload {
    
    NSLog(@"lreload");
    utilitar = [[Utile alloc]init];
    NSString *authtoken=@"";
    BOOL elogat = NO;
    NSString *user_id=@"";
    elogat = [utilitar eLogat];
    if(elogat) {
        authtoken = [utilitar AUTHTOKEN];
        
        //- type (todo, done, received, toreceive)
        
        NSDictionary *userlogat = [DataMasterProcessor getLOGEDACCOUNT];
        /////   NSLog(@"usercalif %@", userlogat);
        if(userlogat[@"U_userid"]) {
            user_id =[NSString stringWithFormat:@"%@",userlogat[@"U_userid"]];
        }
        else if(userlogat[@"U_username"]) {
            user_id =[NSString stringWithFormat:@"%@",userlogat[@"U_username"]];
        }
        if(SEGMENTACTIV ==0) {
            {
                NSString *pagina = [NSString stringWithFormat:@"%i", _currentPage_deacordat];
                if(_currentPage_deacordat ==1) {
                    _currentPage_deacordat ++;
                    [self  list_ratings:authtoken :pagina :PE_PAGINA :@"todo" :user_id];
                } else  if(_currentPage_deacordat < catedeacordat)  {
                    _currentPage_deacordat ++;
                    [self  list_ratings:authtoken :pagina :PE_PAGINA :@"todo" :user_id];
                }
                
            }
        }
        if(SEGMENTACTIV ==1) {
            NSString *pagina = [NSString stringWithFormat:@"%i", _currentPage_acordate];
            if(elogat) {
                if(_currentPage_acordate ==1) {
                    _currentPage_acordate ++;
                    [self  list_ratings:authtoken :pagina :PE_PAGINA :@"done" :user_id];
                } else if(_currentPage_acordate < cateacordate) {
                    _currentPage_acordate ++;
                    [self  list_ratings:authtoken :pagina :PE_PAGINA :@"done" :user_id];
                }
            }
        }
        if(SEGMENTACTIV ==2) {
            NSString *pagina = [NSString stringWithFormat:@"%i", _currentPage_primite];
            if(elogat) {
                if(_currentPage_primite ==1) {
                    _currentPage_primite ++;
                    [self  list_ratings:authtoken :pagina :PE_PAGINA :@"received" :user_id];
                } else  if(_currentPage_primite < cateprimite) {
                    _currentPage_primite ++;
                    [self  list_ratings:authtoken :pagina :PE_PAGINA :@"received" :user_id];
                }
            }
        }
        
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int ROWWHOIS = (int)indexPath.row;
    if(ROWWHOIS>0) {
        NSDictionary *CALIFICATIV =[[NSDictionary alloc]init];
        if(self.SEGCNTRL.selectedSegmentIndex ==0 && self.TOATEDEACORDAT.count >0) {
            if([self.TOATEDEACORDAT objectAtIndex:ROWWHOIS-1 ] &&[[self.TOATEDEACORDAT objectAtIndex:ROWWHOIS-1 ] isKindOfClass: [NSDictionary class ]])   {
                [self addhud];
                CALIFICATIV =[[NSDictionary alloc]init];
                CALIFICATIV =[self.TOATEDEACORDAT objectAtIndex:ROWWHOIS-1];
                //ecran acorda
                EcranAcorda *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"EcranAcordaVC"];
                vc.CE_TIP_E=@"acorda";
                vc.CALIFICATIV =[[NSMutableDictionary alloc]init];
                vc.CALIFICATIV=CALIFICATIV;
                [self.navigationController pushViewController:vc animated:YES ];
            }
        }
        if(self.SEGCNTRL.selectedSegmentIndex ==1 && self.TOATEACORDATE.count >0) {
            CALIFICATIV =[[NSDictionary alloc]init];
            if([self.TOATEACORDATE objectAtIndex:ROWWHOIS-1 ] &&[[self.TOATEACORDATE objectAtIndex:ROWWHOIS-1 ] isKindOfClass: [NSDictionary class ]])   {
                  [self addhud];
                CALIFICATIV =[self.TOATEACORDATE objectAtIndex:ROWWHOIS-1];
                //ecran acordate
                EcranCalificativAcordatsauPrimit *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"EcranCalificativAcordatsauPrimitVC"];
                vc.CE_TIP_E=@"acordat";
                vc.CALIFICATIV =[[NSMutableDictionary alloc]init];
                vc.CALIFICATIV=CALIFICATIV;
                [self.navigationController pushViewController:vc animated:YES ];
            }
        }
        if(self.SEGCNTRL.selectedSegmentIndex ==2 && self.TOATEPRIMITE.count >0) {
            
            CALIFICATIV =[[NSDictionary alloc]init];
              [self addhud];
            if([self.TOATEPRIMITE objectAtIndex:ROWWHOIS-1 ] &&[[self.TOATEPRIMITE objectAtIndex:ROWWHOIS-1 ] isKindOfClass: [NSDictionary class ]])   {
                //intotdeauna pentru ca primul rand e label galben
                CALIFICATIV =[self.TOATEPRIMITE objectAtIndex:ROWWHOIS-1];
                //ecran de primit
                EcranCalificativAcordatsauPrimit *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"EcranCalificativAcordatsauPrimitVC"];
                vc.CE_TIP_E=@"primit";
                vc.CALIFICATIV =[[NSMutableDictionary alloc]init];
                vc.CALIFICATIV=CALIFICATIV;
                [self.navigationController pushViewController:vc animated:YES ];
            }
        }
    }
}
-(void)gotodetaliuProfil :(NSMutableDictionary*) multedate {
    DetaliuVanzator *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetaliuVanzatorVC"];
    vc.PROFILULMEU =NO;
    vc.DATEPROFIL =[[NSMutableDictionary alloc]init];
    vc._currentPage_toate=1;
    vc.DATEPROFIL =multedate;
    [self.navigationController pushViewController:vc animated:YES ];
    
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
-(void)addhud{
    [MBProgressHUD showHUDAddedTo:self.navigationController.visibleViewController.view animated:YES];
}
-(void)removehud{
    [MBProgressHUD hideAllHUDsForView:self.navigationController.visibleViewController.view animated:YES];
}

-(BOOL)MyStringisEmpty:(NSString *)str
{
    if(str.length==0 || [str isKindOfClass:[NSNull class]] || [str isEqualToString:@""]||[str  isEqualToString:@"NULL"]||[str isEqualToString:@"(null)"]|| [str isEqualToString:@"<null>"] || [str isEqualToString:@"null"] ||str==nil){
        return YES;
    }
    return NO;
}
-(void)doarupdatetabel {
    NSIndexSet *section =  [NSIndexSet indexSetWithIndex:0];
    [self.LISTASELECT beginUpdates];
    [self.LISTASELECT reloadSections:section withRowAnimation:UITableViewRowAnimationNone];
    [self.LISTASELECT endUpdates];
    
}
-(void)reloadsectiunea12 {
    if(SEGMENTACTIV ==0 && self.TOATEDEACORDAT.count>0) {
        [self doarupdatetabel];
    } else {
        [self.LISTASELECT reloadData];
    }
    
    if(SEGMENTACTIV ==1 && self.TOATEACORDATE.count>0) {
        [self doarupdatetabel];
    } else {
        [self.LISTASELECT reloadData];
    }
    if(SEGMENTACTIV ==2 && self.TOATEPRIMITE.count>0) {
        [self doarupdatetabel];
    } else {
        [self.LISTASELECT reloadData];
    }
    
    
    
}
/////METODA_LIST_RATINGS
-(NSMutableArray*)update_list_comments :(NSMutableArray *)multecomentarii :(NSString *)status {
    NSMutableArray *lista_cereri = multecomentarii;
    //todo/done/receive
    [self removehud];
    if([status isEqualToString:@"todo"]) {
        for(NSDictionary *itemnou in lista_cereri) {
            if(![self.TOATEDEACORDAT containsObject:itemnou]) {
                [self.TOATEDEACORDAT addObject:itemnou];
            }
        }
        [self reloadsectiunea12];
    }
    if([status isEqualToString:@"done"]) {
        for(NSDictionary *itemnou in lista_cereri) {
            if(![self.TOATEACORDATE containsObject:itemnou]) {
                [self.TOATEACORDATE addObject:itemnou];
            }
        }
        [self reloadsectiunea12];
    }
    if([status isEqualToString:@"received"]) {
        for(NSDictionary *itemnou in lista_cereri) {
            if(![self.TOATEPRIMITE containsObject:itemnou]) {
                [self.TOATEPRIMITE addObject:itemnou];
            }
        }
        [self reloadsectiunea12];
    }
    [self removehud];
    
    return lista_cereri;
}

-(void)list_ratings :(NSString *)AUTHTOKEN :(NSString *)PAGE :(NSString *)PER_PAGE :(NSString *)STATUS :(NSString *)USER_IDsauUSERNAME{
    /*
     list_ratings params
     - page
     - per_page
     echo 'm=list_ratings&p={"per_page":"20","os":"iOS","lang":"ro","authtoken":"1248f7g574da6a9gsdGrRElD1sOZF4Zl8_1zOvgt2DGFIsnguvMU0080K_w","user_id":"1198327","version":"9.2.1","page":"1","type":"todo"}'  | curl --tlsv1 --cacert ./dev5.activesoft.crt --data @- -- https://dev5.activesoft.ro:277/
     
     echo 'm=list_ratings&p={"per_page":"20","page":"1","type":"received","rating_type":"positive", "os":"iOS","lang":"ro","authtoken":"1248f7g574da6a9gsdGrRElD1sOZF4Zl8_1zOvgt2DGFIsnguvMU0080K_w","version":"9.0","page":"1","user_id":"1198327"}'  | curl --tlsv1 --cacert ./dev5.activesoft.crt --data @- -- https://dev5.activesoft.ro:277/
     
     status positive/negative/neutral
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
      ////      [MBProgressHUD hideAllHUDsForView:self.navigationController.visibleViewController.view animated:YES];
          
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
        [dic2 setObject:USER_IDsauUSERNAME forKey:@"user_id"];
        [dic2 setObject:STATUS forKey:@"type"]; //    todo = de acordat    - done = acordate     - receive = primite
        
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic2 options:0 error:&err];
        NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        compus =[NSString stringWithFormat:@"%@%@",METODA_LIST_RATINGS, myString];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://%@",base_url]]];
        [request setHTTPMethod:@"POST"];
        NSMutableData *postBody = [NSMutableData data];
        [postBody appendData:[compus dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:postBody];
        NSLog(@"my strin jjjjjjk %@", compus);
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
                }   else  if(REZULTAT_NOTIFY_COUNT[@"data"]) {
                      [self removehud];
                    /*
                     {"errors":{},"data":{"items":[{"item_type":"cerere","item_id":"1826878","main_item_id":"342739","external_url":"http:\/\/dev5.activesoft.ro\/~csaba\/4tilance\/cereri-piese-auto\/bugatti\/gfd-repostare-noua-e-www-342739.html#msg1826878","tb_url":"http:\/\/dev5.activesoft.ro\/~csaba\/4tilance\/attachment.php?id=b8626a0f2f52dfb5c695cd49abb7621d&cmd=thumb&w=130&h=130","title":"Gfd repostare noua e www","title_detailed":"Asdfasdfasdf Bugatti Veyron, an 2015","show_rating_grades":0,"user_profile":{"user_id":53782,"username":"bogdanpsc","first_name":"Bogdan","last_name":"Pascanu","seller":2,"score":11,"score_percent":92.3,"phone1":"0723243004","phone2":"0723659896","phone3":"0123133131","phone4":"0165454989","stars_class":"stars_green","company":{"name":"name","friendly_name":"friendly_name","phone":"asdf asdf asd","fax":"","type":"shop","url":"http:\/\/dev5.activesoft.ro\/~csaba\/4tilance\/magazine-piese-auto\/arad\/agrisu-mare\/friendly-name-1376.html","logo_img_url":"http:\/\/dev5.activesoft.ro\/~csaba\/4tilance\/attachment.php?id=31a1071e7ab91b3dfa3686603987437c&cmd=thumb&w=120&h=70"}},"rating_type":"positive","comment":"Hjhvn hb j jk","main_item_owner_id":"1198327"}],"total_count":1}
                     */
                    NSDictionary *multedate = REZULTAT_NOTIFY_COUNT[@"data"];
                    ////  NSLog(@"date cerere calificative %@",multedate);
                    int  round =0;
                    if( multedate[@"total_count"]) {
                        int  cateintotalrezolvate =[multedate[@"total_count"] intValue];
                        double originalFloat =(double)cateintotalrezolvate/ PE_PAGINA.intValue;
                        NSLog(@"originalFloat %f / %i ** %i %f", originalFloat,PE_PAGINA.intValue,[multedate[@"total_count"] intValue],(double)cateintotalrezolvate/ PE_PAGINA.intValue );
                        if(originalFloat - (int)originalFloat > 0) {
                            originalFloat += 1;
                            round = (int)originalFloat;
                            
                        } else {
                            round = (int)originalFloat;
                        }
                    }
                    
                    if([STATUS isEqualToString:@"todo"]) {
                        
                        //     if([PAGE isEqualToString:@"1"]) {
                        catedeacordat =round;
                        //  }
                    }
                    
                    if([STATUS isEqualToString:@"done"]) {
                        
                        if([PAGE isEqualToString:@"1"]) {
                            cateacordate =round;
                        }
                    }
                    
                    if([STATUS isEqualToString:@"received"]) {
                        if([PAGE isEqualToString:@"1"]) {
                            cateprimite =round;
                        }
                    }
                    if(multedate[@"items"]) {
                        NSMutableArray *multecomentarii =multedate[@"items"];
                        if(multecomentarii.count >0){
                            [self removehud];
                            [self update_list_comments:multecomentarii:STATUS];
                        } else {
                            [self removehud];
                            [self reloadsectiunea12];
                        }
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
   /// [self removehud];
}

@end
