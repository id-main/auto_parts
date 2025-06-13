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
#import "CellProfil.h"
#import "TutorialHomeViewController.h"
#import <CoreText/CoreText.h>
#import "SetariViewController.h"
#import "OferteLaCerereViewController.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "UIImageView+WebCache.h" //sdwebimage
#import "WebViewController.h"
#import "DetaliuVanzator.h"
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

@implementation DetaliuVanzator
@synthesize  LISTASELECT,titluriCAMPURI,PROFILULMEU,DATEPROFIL;
@synthesize catetoate,catepozitive,cateneutre,catenegative,TOATECALIFICATIVE,TOATEPOZITIVE, TOATENEUTRE,TOATENEGATIVE,AREFIRMA,SEGMENTACTIV;
@synthesize _currentPage_toate,_currentPage_pozitive,_currentPage_neutre,_currentPage_negative;
@synthesize  toateaduse; //to do
@synthesize  pozitiveaduse;
@synthesize  neutreaduse;
@synthesize  negativeaduse;

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
    NSLog(@"PROFIL");
    self.PROFILULMEU =PROFILULMEU;
    if(PROFILULMEU ==YES) {
        self.title = @"Profilul meu";
    } else {
        self.title = @"Detalii utilizator";
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
-(void)perfecttimeforback{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
  
    self.DATEPROFIL = DATEPROFIL;
    // jNSLog(@"date get_member_profile %@",DATEPROFIL);
    SEGMENTACTIV =0;
    TOATECALIFICATIVE =[[NSMutableArray alloc]init];
    TOATEPOZITIVE =[[NSMutableArray alloc]init];
    TOATENEUTRE =[[NSMutableArray alloc]init];
    TOATENEGATIVE =[[NSMutableArray alloc]init];
    self._currentPage_toate =_currentPage_toate;
    _currentPage_pozitive=1;
    _currentPage_neutre=1;
    _currentPage_negative=1;
    
    //   echo 'm=get_member_profile&p={"per_page":"20","page":"1","type":"received", "os":"iOS","lang":"ro","authtoken":"1248f7g574da6a9gsdGrRElD1sOZF4Zl8_1zOvgt2DGFIsnguvMU0080K_w","version":"9.0","page":"1","user_id":"1198327"}'  | curl --tlsv1 --cacert ./dev5.activesoft.crt --data @- -- https://dev5.activesoft.ro:277/
    //echo 'mm=get_member_profile&p={"per_page":"20","os":"iOS","lang":"ro","authtoken":"1248f7g574da6a9gsdGrRElD1sOZF4Zl8_1zOvgt2DGFIsnguvMU0080K_w","user_id":"40731","version":"9.2.1","page":"1"}
    //m=list_ratings&p={"per_page":"20","os":"iOS","lang":"ro","rating_type":"positive","authtoken":"1248f7g574da6a9gsdGrRElD1sOZF4Zl8_1zOvgt2DGFIsnguvMU0080K_w","version":"9.2.1","type":"received","page":"1","user_id":"40731"}
    // echo 'm=get_member_profile&p={"per_page":"20","os":"iOS","lang":"ro","authtoken":"1248f7g574da6a9gsdGrRElD1sOZF4Zl8_1zOvgt2DGFIsnguvMU0080K_w","user_id":"1198327","version":"9.2.1","page":"1"}'  | curl --tlsv1 --cacert ./dev5.activesoft.crt --data @- -- https://dev5.activesoft.ro:277/
    
    
    catetoate=0;catepozitive=0;cateneutre=0;
    catenegative =0;
    LISTASELECT.delegate =self;
    LISTASELECT.dataSource =self;
    LISTASELECT.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    NSMutableArray *telefoaneuser = [[NSMutableArray alloc]init];
    NSString *nrtelefon=@"";
    NSString *nrtelefon2=@"";
    NSString *nrtelefon3=@"";
    NSString *nrtelefon4=@"";
    if(DATEPROFIL[@"phone1"])     nrtelefon= [NSString stringWithFormat:@"%@",DATEPROFIL[@"phone1"]];
    if(DATEPROFIL[@"phone2"])     nrtelefon2= [NSString stringWithFormat:@"%@",DATEPROFIL[@"phone2"]];
    if(DATEPROFIL[@"phone3"])     nrtelefon3= [NSString stringWithFormat:@"%@",DATEPROFIL[@"phone3"]];
    if(DATEPROFIL[@"phone4"])     nrtelefon4= [NSString stringWithFormat:@"%@",DATEPROFIL[@"phone4"]];
    if(![self MyStringisEmpty:nrtelefon]) {
        if(![telefoaneuser containsObject:nrtelefon]) {
            [telefoaneuser addObject:nrtelefon];
        }
    }
    if(![self MyStringisEmpty:nrtelefon2]) {
        if(![telefoaneuser containsObject:nrtelefon2]) {
            [telefoaneuser addObject:nrtelefon2];
        }
    }
    if(![self MyStringisEmpty:nrtelefon3]) {
        if(![telefoaneuser containsObject:nrtelefon3]) {
            [telefoaneuser addObject:nrtelefon3];
        }
    }
    if(![self MyStringisEmpty:nrtelefon4]) {
        if(![telefoaneuser containsObject:nrtelefon4]) {
            [telefoaneuser addObject:nrtelefon4];
        }
    }
    
    NSArray *CRITERII =[[NSArray alloc]init];
    if([DATEPROFIL[@"criteria"] isKindOfClass:[NSArray class]]){
        CRITERII =DATEPROFIL[@"criteria"];
    }
    
    
    //prima data cand intra in ecran ia pagina 1, per page 20 -> au venit din get_user_profile
    /*
     echo 'm=list_ratings&p={"per_page":"20","page":"1","type":"received","rating_type":"positive", "os":"iOS","lang":"ro","authtoken":"1248f7g574da6a9gsdGrRElD1sOZF4Zl8_1zOvgt2DGFIsnguvMU0080K_w","version":"9.0","page":"1","user_id":"1198327"}'  | curl --tlsv1 --cacert ./dev5.activesoft.crt --data @- -- https://dev5.activesoft.ro:277/
     */
    /* "errors":{},"data": "items":[
     {
     "item_type":"cerere",
     "item_id":"1826878",
     "main_item_id":"342739",
     "external_url":"http:\/\/dev5.activesoft.ro\/~csaba\/4tilance\/cereri-piese-auto\/bugatti\/gfd-repostare-noua-e-www-342739.html#msg1826878",
     "tb_url":"http:\/\/dev5.activesoft.ro\/~csaba\/4tilance\/attachment.php?id=b8626a0f2f52dfb5c695cd49abb7621d&cmd=thumb&w=130&h=130",
     "title":"Gfd repostare noua e www",
     "title_detailed":"Asdfasdfasdf Bugatti Veyron, an 2015",
     "show_rating_grades":0,
     "user_profile":{
     "user_id":53782,
     "username":"bogdanpsc",
     "first_name":"Bogdan",
     "last_name":"Pascanu",
     "seller":2,
     "score":11,
     "score_percent":92.3,
     "phone1":"0723243004",
     "phone2":"0723659896",
     "phone3":"0123133131",
     "phone4":"0165454989",
     "stars_class":"stars_green",
     "company":{
     "name":"name",
     "friendly_name":"friendly_name",
     "phone":"asdf asdf asd",
     "fax":"",
     "type":"shop",
     "url":"http:\/\/dev5.activesoft.ro\/~csaba\/4tilance\/magazine-piese-auto\/arad\/agrisu-mare\/friendly-name-1376.html",
     "logo_img_url":"http:\/\/dev5.activesoft.ro\/~csaba\/4tilance\/attachment.php?id=31a1071e7ab91b3dfa3686603987437c&cmd=thumb&w=120&h=70"
     }
     },
     "rating_type":"positive",
     "comment":"Hjhvn hb j jk",
     "main_item_owner_id":"1198327"
     }
     ],
     "total_count":1
     }
     
     
     
     */
    
    /* m=get_member_profile&p={"per_page":"20","os":"iOS","lang":"ro","authtoken":"1248f7g574da6a9gsdGrRElD1sOZF4Zl8_1zOvgt2DGFIsnguvMU0080K_w","username":"bogdanpsc","version":"9.2.1","page":"1"}
     ratings =     {
     items =         (
     {
     comment = "F buna piesa";
     "external_url" = "http://dev5.activesoft.ro/~csaba/4tilance/cereri-piese-auto/bmw/bara-fata-342521.html#msg1826592";
     "item_id" = 1826592;
     "item_type" = cerere;
     "main_item_id" = 342521;
     "main_item_owner_id" = 83966;
     "rating_type" = positive;
     "show_rating_grades" = 0;
     "tb_url" = "";
     title = "Bara fata";
     "title_detailed" = "Bar\U0103 fa\U0163\U0103 Dacia Logan ro\U015fie f\U0103r\U0103 zg\U00e2rieturi BMW Seria 3 cupe E36, an 2009";
     "user_profile" =                 {
     company = "<null>";
     "first_name" = Dragos;
     "last_name" = Cristea;
     phone1 = 0722648895;
     phone2 = "";
     phone3 = "";
     phone4 = "";
     score = 1;
     "score_percent" = 100;
     seller = 0;
     "stars_class" = "stars_green";
     "user_id" = 83966;
     username = dragosc;
     };
     },
     */
    
    //last check pentru a vedea daca inseram date firma sau nu
    NSDictionary *firma =[[NSDictionary alloc]init];
    if([self checkDictionary:DATEPROFIL[@"company"]]){
        firma = [NSDictionary dictionaryWithDictionary:DATEPROFIL[@"company"]];
        AREFIRMA =YES;
    }
    if(DATEPROFIL[@"ratings"] && [DATEPROFIL[@"ratings"][@"items"]isKindOfClass:[NSArray class]] ){
        TOATECALIFICATIVE = [NSMutableArray arrayWithArray:DATEPROFIL[@"ratings"][@"items"]];
        //        NSDictionary *testcoment =@{@"comment" : @"F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa F buna piesa",
        //                                    @"user_profile" :@{
        //                               @"phone1" : @"0722648895",
        //                                @"score" :@"1",
        //                @"seller" : @"0",
        //                @"stars_class" : @"stars_green",
        //                                            @"user_id" : @"83966",
        //                @"username" : @"dragosc"
        //                                            }};
        //        [TOATECALIFICATIVE addObject:testcoment];
    }
    
    if(DATEPROFIL[@"ratings"][@"total_count"]) {
        NSString *catetotal = [NSString stringWithFormat:@"%@", DATEPROFIL[@"ratings"][@"total_count"]];
        int  round =0;
        int  cateintotalrezolvate =(int)catetotal.integerValue;
        double originalFloat =(double)cateintotalrezolvate/ PE_PAGINA.intValue;
        NSLog(@"originalFloat %f / %i ** %i %f", originalFloat,PE_PAGINA.intValue,[catetotal intValue],(double)cateintotalrezolvate/ PE_PAGINA.intValue );
        if(originalFloat - (int)originalFloat > 0) {
            originalFloat += 1;
            round = (int)originalFloat;
            
        } else {
            round = (int)originalFloat;
        }
        catetoate = round;
    }
    
    
    self.titluriCAMPURI =@[@"numeuser",@"seller gold",telefoaneuser,firma ,@"membrudin",@"eticheta calif",@"pozit",@"neut",@"neg",@"eticheta calif detaliate",CRITERII,@"tabbar",TOATECALIFICATIVE,@"vezimaimult"];
    utilitar = [[Utile alloc]init];
       [self.navigationController setNavigationBarHidden:NO]; self.navigationItem.leftBarButtonItem=nil;
   
    
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
    //                              0           1           2           3           4               5               6       7       8       9                           10              11          12          13
    // self.titluriCAMPURI =@[@"numeuser",@"seller gold",telefoaneuser, @"firma" ,@"membrudin",@"eticheta calif",@"pozit",@"neut",@"neg",@"eticheta calif detaliate",CRITERII,@"tabbar",@"arraytoate",@"vezimaimult"];
    if(section == 0 || section ==1 || section==4 ||section ==5 || section==6 || section==7|| section==8|| section==9|| section==11|| section==13) {
        numarranduri =1;
    }
    if(section == 2) {
        NSMutableArray *telefoane = [NSMutableArray arrayWithArray: [self.titluriCAMPURI objectAtIndex:2]];
        numarranduri = (int)telefoane.count;
    }
    
    if(section == 3) {
        if(AREFIRMA==YES) {
            numarranduri =1;
        }
    }
    
    if(section == 10) {
        //jmod dispar criteriile   NSMutableArray *criterii = [NSMutableArray arrayWithArray: [self.titluriCAMPURI objectAtIndex:10]];
        //  numarranduri = (int)criterii.count;
        numarranduri =0;
    }
    if(section == 12) {
        //TOATECALIFICATIVE,TOATEPOZITIVE, TOATENEUTRE,TOATENEGATIVE
        if(SEGMENTACTIV ==0) {
            numarranduri = (int)TOATECALIFICATIVE.count;
            if(numarranduri ==0) {
                numarranduri=1;
            }
        }
        if(SEGMENTACTIV ==1) {
            numarranduri = (int)TOATEPOZITIVE.count ;
            if(numarranduri ==0) {
                numarranduri=1;
            }
        }
        if(SEGMENTACTIV ==2) {
            numarranduri = (int)TOATENEUTRE.count;
            if(numarranduri ==0) {
                numarranduri=1;
            }
        }
        if(SEGMENTACTIV ==3) {
            numarranduri = (int)TOATENEGATIVE.count;
            if(numarranduri ==0) {
                numarranduri=1;
            }
        }
    }
    // return self.titluriCAMPURI.count;
    return numarranduri;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //                              0           1           2           3           4               5               6       7       8       9                           10              11          12          13
    // self.titluriCAMPURI =@[@"numeuser",@"seller gold",telefoaneuser, @"firma" ,@"membrudin",@"eticheta calif",@"pozit",@"neut",@"neg",@"eticheta calif detaliate",CRITERII,@"tabbar",@"arraytoate",@"vezimaimult"];
    double inaltimerand=0;
     if(indexPath.section ==0 || indexPath.section ==1 ) inaltimerand =42;
    if( indexPath.section ==5 || indexPath.section ==6 ||indexPath.section ==7 ||indexPath.section ==8||indexPath.section ==11|| indexPath.section ==14)  inaltimerand = 53;
    //jmod dispare rand 9 si aria pe 10
    if(indexPath.section ==9||indexPath.section ==10) inaltimerand=0;
   /// if(indexPath.section ==1 )  inaltimerand = 63;
    if(indexPath.section==4) inaltimerand=123;
    if(indexPath.section==3) {  if (AREFIRMA==YES) inaltimerand=56; }
    if(indexPath.section ==2) {
        NSMutableArray *telefoane = [NSMutableArray arrayWithArray: [self.titluriCAMPURI objectAtIndex:2]];
        if( telefoane.count>0) { inaltimerand =53;}
    }
    if(indexPath.section ==12) {
        /*   CGSize textSize = [compus_mesaj boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
         NECESARHeight =textSize.height+20; */
        NSDictionary *calculcomentariu = [[NSDictionary alloc]init];
        if(SEGMENTACTIV ==0) {
            if(self.TOATECALIFICATIVE.count ==0) {
                inaltimerand = 50;
            } else {
                if([self checkDictionary:[TOATECALIFICATIVE objectAtIndex:indexPath.row]]) {
                    calculcomentariu = [NSDictionary dictionaryWithDictionary:[TOATECALIFICATIVE objectAtIndex:indexPath.row]];
                    if(calculcomentariu[@"comment"]) {
                        CGFloat widthWithInsetsApplied = self.view.frame.size.width -60;
                        NSString *textcoment =[NSString stringWithFormat:@"%@",calculcomentariu[@"comment"]];
                        CGSize textSize = [textcoment boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
                        inaltimerand= textSize.height +50;
                    }
                    
                }
            }
        }
        if(SEGMENTACTIV ==1) {
            if(self.TOATEPOZITIVE.count ==0) {
                inaltimerand = 50;
            } else {
                if([self checkDictionary:[TOATEPOZITIVE objectAtIndex:indexPath.row]]) {
                    calculcomentariu = [NSDictionary dictionaryWithDictionary:[TOATEPOZITIVE objectAtIndex:indexPath.row]];
                    if(calculcomentariu[@"comment"]) {
                        CGFloat widthWithInsetsApplied = self.view.frame.size.width -60;
                        NSString *textcoment =[NSString stringWithFormat:@"%@",calculcomentariu[@"comment"]];
                        CGSize textSize = [textcoment boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
                        inaltimerand= textSize.height +50;
                    }
                    
                }
            }
        }
        if(SEGMENTACTIV ==2) {
            if(self.TOATENEUTRE.count ==0) {
                inaltimerand = 50;
            } else {
                if([self checkDictionary:[TOATENEUTRE objectAtIndex:indexPath.row]]) {
                    calculcomentariu = [NSDictionary dictionaryWithDictionary:[TOATENEUTRE objectAtIndex:indexPath.row]];
                    if(calculcomentariu[@"comment"]) {
                        CGFloat widthWithInsetsApplied = self.view.frame.size.width -60;
                        NSString *textcoment =[NSString stringWithFormat:@"%@",calculcomentariu[@"comment"]];
                        CGSize textSize = [textcoment boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
                        inaltimerand= textSize.height +50;
                    }
                    
                }
            }
        }
        if(SEGMENTACTIV ==3) {
            if(self.TOATENEGATIVE.count ==0) {
                inaltimerand = 50;
            } else {
                if([self checkDictionary:[TOATENEGATIVE objectAtIndex:indexPath.row]]) {
                    calculcomentariu = [NSDictionary dictionaryWithDictionary:[TOATENEGATIVE objectAtIndex:indexPath.row]];
                    if(calculcomentariu[@"comment"]) {
                        CGFloat widthWithInsetsApplied = self.view.frame.size.width -60;
                        NSString *textcoment =[NSString stringWithFormat:@"%@",calculcomentariu[@"comment"]];
                        CGSize textSize = [textcoment boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
                        inaltimerand= textSize.height +50;
                    }
                    
                }
            }
        }
    }
    if(indexPath.section ==13) {
        return 53;
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
-(void)doarupdatetabel {
    NSIndexSet *section =  [NSIndexSet indexSetWithIndex:12];
    [self.LISTASELECT beginUpdates];
    [self.LISTASELECT reloadSections:section withRowAnimation:UITableViewRowAnimationNone];
    [self.LISTASELECT endUpdates];
    NSIndexPath *pathToLastRow = [NSIndexPath indexPathForRow:0 inSection:11];
    [self.LISTASELECT scrollToRowAtIndexPath:pathToLastRow
                            atScrollPosition:UITableViewScrollPositionTop
                                    animated:NO];
    
}
- (IBAction)valueChanged:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    NSLog(@"uiseg %i",(int) segmentedControl.selectedSegmentIndex);
    SEGMENTACTIV =(int) segmentedControl.selectedSegmentIndex;
    [self launchReload];
    //[self reloadsectiunea12];
    
    if(SEGMENTACTIV ==0
       /*&& TOATECALIFICATIVE.count>0*/) {
        [self doarupdatetabel];
    }
    
    if(SEGMENTACTIV ==1
       /*&& self.TOATEPOZITIVE.count>0*/) {
        [self doarupdatetabel];
    }
    if(SEGMENTACTIV ==2
       /*&& self.TOATENEUTRE.count>0*/) {
        [self doarupdatetabel];
    }
    if(SEGMENTACTIV ==3
       /*&& self.TOATENEUTRE.count>0*/) {
        [self doarupdatetabel];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // self.titluriCAMPURI =@[@"numeuser",@"seller gold",array_tels, AREFIRMA ,@"membrudin",@"eticheta calif",@"pozit",@"neut",@"neg",@"eticheta calif detaliate",array_criterii,@"tabbar",@"arraytoate",@"vezimaimult"
    return self.titluriCAMPURI.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int ipx = (int)indexPath.section;
    int ROWWHOIS = (int)indexPath.row;
    static NSString *CellIdentifier = @"CellProfil";
    CellProfil *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (CellProfil*)[tableView dequeueReusableCellWithIdentifier:@"CellProfil"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(valueChanged:)];
    [singleTap setNumberOfTapsRequired:1];
    [cell.SEGCNTRL addTarget:self     action:@selector(valueChanged:)
            forControlEvents:UIControlEventValueChanged];
    cell.SEGCNTRL.selectedSegmentIndex =SEGMENTACTIV;
    
    cell.HeaderTabel.hidden=YES;
    cell.Row1.hidden=YES;
    cell.Row2.hidden=YES;
    cell.Row3.hidden=YES;
    cell.Row4.hidden=YES;
    cell.Row5.hidden=YES;
    cell.Row6.hidden=YES;
    cell.Row7.hidden=YES;
    cell.Row8.hidden=YES;
    
    cell.Row12.hidden=YES;
    cell.Row13.hidden=YES;
    if(ipx ==0) {
        // HeaderTabel,NUMEPROFIL,score,stars_class
        cell.HeaderTabel.hidden=NO;
        NSString *username  =  @"";
        NSString *scor  =  @"";
        NSString *stars_class  =  @"";
        NSString *NUME_IMAGINE_stars_class=@"";
        if(DATEPROFIL[@"username"]) username = [NSString stringWithFormat:@"%@",DATEPROFIL[@"username"]];
        cell.NUMEPROFIL.text = username;
        if(DATEPROFIL[@"score"]) scor = [NSString stringWithFormat:@"%@",DATEPROFIL[@"score"]];
        cell.score.text = scor;
        if(DATEPROFIL[@"stars_class"])     stars_class= [NSString stringWithFormat:@"%@",DATEPROFIL[@"stars_class"]];
        if(![self MyStringisEmpty:stars_class]) {
            cell.stars_class.hidden=NO;
            
//            if([stars_class isEqualToString:@"stars_green"])   NUME_IMAGINE_stars_class =@"Icon_Steluta_User_01_180x180.png";
//            if([stars_class isEqualToString:@"stars_blue"])    NUME_IMAGINE_stars_class =@"Icon_Steluta_User_02_180x180.png";
//            if([stars_class isEqualToString:@"stars_purple"])  NUME_IMAGINE_stars_class =@"Icon_Steluta_User_03_180x180.png";
//            if([stars_class isEqualToString:@"stars_orange"])  NUME_IMAGINE_stars_class =@"Icon_Steluta_User_04_180x180.png";
//            if([stars_class isEqualToString:@"stars_silver"])  NUME_IMAGINE_stars_class =@"icon_vanzator_silver_144x144.png";
             NUME_IMAGINE_stars_class =@"Icon_Steluta_User_144x144.png";
            cell.stars_class.image = [UIImage imageNamed:NUME_IMAGINE_stars_class];
            
        } else {
            cell.stars_class.hidden=YES;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1];
        
    }
    if(ipx ==1) {
        //Row1,sellericon,sellerlabel,score_percent,verdepozitiv;
        cell.Row1.hidden=NO;
        NSString *NUME_IMAGINE_seller=@"";
        NSString *IMAGINE_seller=@"";
        NSString *LABEL_SELLER=@"";
        NSString *SCORPROCENT=@"";
        
        if(DATEPROFIL[@"seller"])     NUME_IMAGINE_seller= [NSString stringWithFormat:@"%@",DATEPROFIL[@"seller"]];
        if(![self MyStringisEmpty:NUME_IMAGINE_seller]) {
            cell.stars_class.hidden=NO;
            if([NUME_IMAGINE_seller isEqualToString:@"0"])  { IMAGINE_seller =@""; LABEL_SELLER=@"";
                cell.dynamiccellLEFT.constant =self.view.frame.size.width/2 -cell.verdepozitiv.frame.size.width/2;
                cell.dynamiccellLEFT2.constant =self.view.frame.size.width/2 -cell.score_percent.frame.size.width/2;
            }
            cell.verdepozitiv.hidden=YES;
            if([NUME_IMAGINE_seller isEqualToString:@"1"])  { IMAGINE_seller =@"icon_vanzator_silver_144x144.png"; LABEL_SELLER=@"Vânzător Silver"; }
            if([NUME_IMAGINE_seller isEqualToString:@"2"])  { IMAGINE_seller =@"Icon_Vanzator_Gold_180x180.png"; LABEL_SELLER=@"Vânzător Gold"; }
            if([NUME_IMAGINE_seller isEqualToString:@"3"])  { IMAGINE_seller =@"Icon_Vanzator_Premium_180x180"; LABEL_SELLER=@"Vânzător Premium";}
            if([NUME_IMAGINE_seller isEqualToString:@"4"])  { IMAGINE_seller =@"Icon_Vanzator_Platinum_180x180"; LABEL_SELLER=@"Vânzător Platinum";}
            if(![self MyStringisEmpty:IMAGINE_seller]) {
                cell.sellericon.image = [UIImage imageNamed:IMAGINE_seller];
            }
        } else {
            cell.sellericon.hidden=YES;
        }
        cell.sellerlabel.text = LABEL_SELLER;
        NSString *final =@"";
        if(DATEPROFIL[@"score_percent"])    {
            SCORPROCENT= [NSString stringWithFormat:@"%@",DATEPROFIL[@"score_percent"]];
            double cal = [SCORPROCENT doubleValue];
            if(cal >=100) {
                  final =@"100";
            } else {
             final =[[NSString alloc] initWithFormat:@"%.1f",cal];
            }
        }
        NSString *compusSCORPROCENT =@"";
        ///JJJ  cell.iconpozitivnegativ.hidden =NO; Icon_Calificativ_Pozitiv_Face_144x144.png  Icon_Calificativ_Negativ_Face_144x144.png
   
        if(![self MyStringisEmpty:final]) {
            double calculat = [final doubleValue];
            if(calculat <90) {
                double diferenta = 100 -calculat;
                final =[[NSString alloc] initWithFormat:@"%.1f",diferenta];
                compusSCORPROCENT= [NSString stringWithFormat:@"%@%% negativ",final];
                cell.iconpozitivnegativ.image =[UIImage imageNamed:@"Icon_Calificativ_Negativ_Face_144x144.png"];
                cell.score_percent.textColor = [UIColor redColor];
            } else {
                compusSCORPROCENT= [NSString stringWithFormat:@"%@%% pozitiv",final];
                cell.iconpozitivnegativ.image =[UIImage imageNamed:@"Icon_Calificativ_Pozitiv_Face_144x144.png"];
                cell.score_percent.textColor = [UIColor colorWithRed:(5/255.0) green:(127/255.0) blue:(54/255.0) alpha:1];
            }
            cell.score_percent.text = compusSCORPROCENT;
//            CGRect framedorit = cell.iconpozitivnegativ.frame;
//            framedorit.origin.x = cell.score_percent.frame.origin.x + cell.score_percent.frame.size.width +6;
//            cell.iconpozitivnegativ.frame =framedorit;
            
        } else {
            cell.verdepozitiv.hidden=YES;
            cell.score_percent.hidden=YES;
        }
        [cell.Row1 bringSubviewToFront:cell.score_percent];
    }
    if(ipx ==2) {
        //    Row2,telefonicon,telefon
        cell.Row2.hidden=NO;
        NSString *nrtelefon=@"";
        NSMutableArray *telefoane = [NSMutableArray arrayWithArray: [self.titluriCAMPURI objectAtIndex:2]];
        nrtelefon= [NSString stringWithFormat:@"%@",[telefoane objectAtIndex:ROWWHOIS]]; // :)
        cell.telefon.text = nrtelefon;
    }
    if(ipx==3) {
        // Row3,siglafirma,numefirma,reprezinta,sageatablue;
        
        NSString *siglafirma=@"";
        NSString *numefirma=@"";NSString *reprezinta=@"";
        if([self checkDictionary:DATEPROFIL[@"company"]] && AREFIRMA ==YES){
            NSDictionary *firma = [NSDictionary dictionaryWithDictionary:DATEPROFIL[@"company"]];
            cell.Row3.hidden=NO;
            /*
             company =     {
             fax = "";
             "friendly_name" = "friendly_name";
             "logo_img_url" = "http://dev5.activesoft.ro/~csaba/4tilance/attachment.php?id=31a1071e7ab91b3dfa3686603987437c&cmd=thumb&w=120&h=70";
             name = name;
             phone = "asdf asdf asd";
             type = shop;
             url = "http://dev5.activesoft.ro/~csaba/4tilance/magazine-piese-auto/arad/agrisu-mare/friendly-name-1376.html";
             };
             */
            if(firma[@"logo_img_url"]) {
                siglafirma = [NSString stringWithFormat:@"%@", firma[@"logo_img_url"]];
                [cell.siglafirma sd_setImageWithURL:[NSURL URLWithString:siglafirma]
                                   placeholderImage:[UIImage imageNamed:@"Icon-40@3x.png"] //[UIImage imageNamed:@"redblock.png"]
                                          completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                              //  ... completion code here ...
                                              if(image) {  cell.siglafirma.image = image; }
                                              cell.dynamiccellLEFT3.constant =3;
                                              cell.dynamiccellLEFT4.constant =3;
                                          }];
            } else {
                cell.dynamiccellLEFT3.constant =-44;
                cell.dynamiccellLEFT4.constant =-44;
           }
            if(firma[@"name"])     numefirma= [NSString stringWithFormat:@"%@",firma[@"name"]];
            cell.numefirma.text =numefirma;
            if(firma[@"type"])     reprezinta= [NSString stringWithFormat:@"%@",firma[@"type"]];
            if([reprezinta isEqualToString:@"shop"]) cell.reprezinta.text =@"Reprezintă magazin piese auto";
            if([reprezinta isEqualToString:@"park"])cell.reprezinta.text =@"Reprezintă parcul de dezmembrări";
            NSString *urlfirma =@"";
            if(firma[@"url"])     urlfirma= [NSString stringWithFormat:@"%@",firma[@"url"]];
            if([self MyStringisEmpty:urlfirma]) {
                cell.sageatablue.hidden=YES;
            }
        }
        
        //        if( company = "<null>";)
    }
    if(ipx==4) {
        // Row4,membrudindata,utlimadataonline,localizarea,nranunturipublicate,sageatablue2;
        cell.Row4.hidden=NO;
        NSString *MEMBRUDIN = @"";
        NSString *UTLIMADATAONLINE = @"";
        NSString *LOCALIZARE = @"";
        
        NSString *date_lastseen_formatted=@"";
        NSString *date_registered_formatted=@"";
        NSString *localitate_id=@"";
        NSString *product_count=@"0";
        NSString *product_listing_url=@"";
        NSString *LOCALITATENAME=@"";
        NSString *JUDETNAME =@"";
        NSString *cateANUNTURICOMPUS =@"";
        
        if(DATEPROFIL[@"date_registered_formatted"])     date_registered_formatted= [NSString stringWithFormat:@"%@",DATEPROFIL[@"date_registered_formatted"]];
        MEMBRUDIN= [NSString stringWithFormat:@"Membru din:%@", date_registered_formatted];
        if(DATEPROFIL[@"date_lastseen_formatted"])     date_lastseen_formatted= [NSString stringWithFormat:@"%@",DATEPROFIL[@"date_lastseen_formatted"]];
        UTLIMADATAONLINE= [NSString stringWithFormat:@"Ultima dată online:%@", date_lastseen_formatted];
        
        if(DATEPROFIL[@"localitate_id"])     localitate_id= [NSString stringWithFormat:@"%@",DATEPROFIL[@"localitate_id"]];
        if(DATEPROFIL[@"product_count"])     product_count= [NSString stringWithFormat:@"%@",DATEPROFIL[@"product_count"]];
        if(DATEPROFIL[@"product_listing_url"])     product_listing_url= [NSString stringWithFormat:@"%@",DATEPROFIL[@"product_listing_url"]];
        cateANUNTURICOMPUS = [NSString stringWithFormat:@"%@ anunțuri publicate", product_count];
        NSDictionary *getLocalitate = [DataMasterProcessor getLocalitate:localitate_id];
        if(getLocalitate && getLocalitate[@"name"]) {
            LOCALITATENAME = [NSString stringWithFormat:@"%@",getLocalitate[@"name"]];
        }
        if(getLocalitate[@"county_id"]) {
            //ia judet
            NSString *judet_id = [NSString stringWithFormat:@"%@",getLocalitate[@"county_id"]];
            NSDictionary *judbaza = [DataMasterProcessor getJudet:judet_id];
            if(judbaza && judbaza[@"name"]) {
                JUDETNAME = [NSString stringWithFormat:@"%@",judbaza[@"name"]];
            }
        }
        LOCALIZARE= [NSString stringWithFormat:@"Localizare:%@, jud:%@", LOCALITATENAME,JUDETNAME];
        
        cell.membrudindata.text =MEMBRUDIN;
        cell.ultimadataonline.text =UTLIMADATAONLINE;
        cell.localizarea.text =LOCALIZARE;
        cell.nranunturipublicate.text=cateANUNTURICOMPUS;
        
        if(DATEPROFIL[@"product_listing_url"])     product_listing_url= [NSString stringWithFormat:@"%@",DATEPROFIL[@"product_listing_url"]];
        if([self MyStringisEmpty:product_listing_url]) {
            cell.sageatablue2.hidden=YES;
        }
    }
    if(ipx==5) {
        ///Row5,calificative,ultimulan,intotal
        cell.Row5.hidden=NO;
        cell.calificative.hidden=NO;
        cell.calificativedetaliate.hidden=YES;
        cell.calificative.text=@"Calificative";
        cell.ultimulan.text=@"Ultimul an";
        cell.intotal.text=@"În total";
    }
    /*jmod  se modifica icons
     [UIImage imageNamed:@"Icon_Calificativ_Pozitiv_Face_144x144.png"];
     [UIImage imageNamed:@"Icon_Calificativ_Neutru_Face_144x144.png"];
     [UIImage imageNamed:@"Icon_Calificativ_Negativ_Face_144x144.png"];
     */

    if(ipx==6) {
        ///Row6,iconpozitive,descrierepozitive,nrpean,total
        cell.Row6.hidden=NO;
        
        //jmod   cell.iconpozitive.image =[UIImage imageNamed:@"Icon_Calificativ_Pozitiv_180x180.png"];
        cell.iconpozitive.image =[UIImage imageNamed:@"Icon_Calificativ_Pozitiv_Face_144x144.png"];
        cell.descrierepozitive.text =@"Pozitive";
        cell.total.text =@"";
        cell.nrpean.text =@"";
        cell.total.textColor =[UIColor colorWithRed:(5/255.0) green:(127/255.0) blue:(54/255.0) alpha:1] ;
        cell.nrpean.textColor =[UIColor colorWithRed:(5/255.0) green:(127/255.0) blue:(54/255.0) alpha:1] ;
        
        if(DATEPROFIL[@"rating"] && [self checkDictionary:DATEPROFIL[@"rating"]]) {
            NSDictionary *rating =DATEPROFIL[@"rating"];
            if(rating[@"pos"])  cell.total.text =[NSString stringWithFormat:@"%@",rating[@"pos"]];
            //ultimul an e bold verde
            if(rating[@"pos365"]) cell.nrpean.text =[NSString stringWithFormat:@"%@",rating[@"pos365"]];
        }
    }
    if(ipx==7) {
        ///Row6,iconpozitive,descrierepozitive,nrpean,total
        cell.Row6.hidden=NO;
        //jmod cell.iconpozitive.image =[UIImage imageNamed:@"Icon_Calificativ_Neutru_180x180.png"];
        cell.iconpozitive.image =[UIImage imageNamed:@"Icon_Calificativ_Neutru_Face_144x144.png"];
        cell.descrierepozitive.text =@"Neutre";
        cell.total.text =@"";
        cell.nrpean.text =@"";
        cell.total.textColor =[UIColor blackColor];
        cell.nrpean.textColor =[UIColor blackColor];
        if(DATEPROFIL[@"rating"] && [self checkDictionary:DATEPROFIL[@"rating"]]) {
            NSDictionary *rating =DATEPROFIL[@"rating"];
            if(rating[@"neu"]) cell.total.text =[NSString stringWithFormat:@"%@",rating[@"neu"]];
            //ultimul an e bold negru
            if(rating[@"neu365"]) cell.nrpean.text =[NSString stringWithFormat:@"%@",rating[@"neu365"]];
        }
    }
    if(ipx==8) {
        ///Row6,iconpozitive,descrierepozitive,nrpean,total
        cell.Row6.hidden=NO;
        //jmod  cell.iconpozitive.image =[UIImage imageNamed:@"Icon_Calificativ_Negativ_180x180.png"];
        cell.iconpozitive.image =  [UIImage imageNamed:@"Icon_Calificativ_Negativ_Face_144x144.png"];
        cell.descrierepozitive.text =@"Negative";
        cell.total.text =@"";
        cell.nrpean.text =@"";
        cell.total.textColor =[UIColor redColor];
        cell.nrpean.textColor =[UIColor redColor];
        if(DATEPROFIL[@"rating"] && [self checkDictionary:DATEPROFIL[@"rating"]]) {
            NSDictionary *rating =DATEPROFIL[@"rating"];
            if(rating[@"neg"]) cell.total.text =[NSString stringWithFormat:@"%@",rating[@"neg"]];
            if(rating[@"neg365"]) cell.nrpean.text =[NSString stringWithFormat:@"%@",rating[@"neg365"]];
        }
    }
    if(ipx==9) {
        ///Row5,calificative,ultimulan,intotal
// jmod dispare       cell.Row5.hidden=NO;
//        cell.calificative.hidden=YES;
//        cell.calificativedetaliate.hidden=NO;
//        cell.calificativedetaliate.text=@"Calificative detaliate";
//        cell.ultimulan.text=@"";
//        cell.intotal.text=@"";
    }
    if(ipx==10) {
        /// Row7,descriereRandCal,nrrating,stelutarosie
  // jmod dispare
//        cell.Row7.hidden=NO;
//        if( [[self.titluriCAMPURI objectAtIndex:10] isKindOfClass:[NSArray class]]){
//            NSMutableArray *CRITERII = [NSMutableArray arrayWithArray: [self.titluriCAMPURI objectAtIndex:10]];
//            NSDictionary *randcal = [CRITERII objectAtIndex:ROWWHOIS];
//            if(randcal[@"title"]) cell.descriereRandCal.text =[NSString stringWithFormat:@"%@",randcal[@"title"]];
//            if(randcal[@"score_avg"]) cell.nrrating.text =[NSString stringWithFormat:@"%@/5",randcal[@"score_avg"]];
//        }
    }
    if(ipx==11) {
        /// Row7,descriereRandCal,nrrating,stelutarosie
        cell.Row8.hidden=NO;
        cell.SEGCNTRL.selectedSegmentIndex =SEGMENTACTIV;
        
    }
    
    //12 mesaj  comment = "F buna piesa";
    /* comment = "F buna piesa";
     "external_url" = "http://dev5.activesoft.ro/~csaba/4tilance/cereri-piese-auto/bmw/bara-fata-342521.html#msg1826592";
     "item_id" = 1826592;
     "item_type" = cerere;
     "main_item_id" = 342521;
     "main_item_owner_id" = 83966;
     "rating_type" = positive;
     "show_rating_grades" = 0;
     "tb_url" = "";
     title = "Bara fata";
     "title_detailed" = "Bar\U0103 fa\U0163\U0103 Dacia Logan ro\U015fie f\U0103r\U0103 zg\U00e2rieturi BMW Seria 3 cupe E36, an 2009";
     "user_profile" =                 {
     company = "<null>";
     "first_name" = Dragos;
     "last_name" = Cristea;
     phone1 = 0722648895;
     phone2 = "";
     phone3 = "";
     phone4 = "";
     score = 1;
     "score_percent" = 100;
     seller = 0;
     "stars_class" = "stars_green";
     "user_id" = 83966;
     username = dragosc;
     };
     },
     cell.iconpozitive.image =[UIImage imageNamed:@"Icon_Calificativ_Pozitiv_180x180.png"];
     cell.iconpozitive.image =[UIImage imageNamed:@"Icon_Calificativ_Neutru_180x180.png"];
     cell.iconpozitive.image =[UIImage imageNamed:@"Icon_Calificativ_Negativ_180x180.png"];
     
     */
    //SI AICI TREBUIE FACUT IN FUNCTIE DE SEGMENTUL SELECTAT
    if(ipx ==12) {
        // Row12,iconcalificativprimit,comentariu,dela,numecomentator,stelutaverde,scorcomentator
        cell.Row12.hidden=NO;
        cell.comentariu.verticalAlignment =TTTAttributedLabelVerticalAlignmentTop;
        cell.numecomentator.verticalAlignment =TTTAttributedLabelVerticalAlignmentTop;
        cell.dela.verticalAlignment =TTTAttributedLabelVerticalAlignmentTop;
        cell.scorcomentator.verticalAlignment =TTTAttributedLabelVerticalAlignmentTop;
        NSDictionary *randcal=[[NSDictionary alloc]init];
        
        
        
        if(SEGMENTACTIV ==0) {
            if(TOATECALIFICATIVE.count ==0) {
                if(indexPath.row==0) {
                    cell.dela.hidden=YES;
                    cell.nusuntcalificative.hidden=NO;
                    cell.numecomentator.hidden=YES;
                    cell.comentariu.hidden=YES;
                    cell.iconcalificativprimit.hidden=YES;
                    cell.stelutaverde.hidden=YES;
                    cell.scorcomentator.hidden=YES;
                    cell.nusuntcalificative.text=@"Nu sunt calificative";
                    [cell setNeedsLayout];
                }
            } else {
                cell.nusuntcalificative.hidden=YES;
                if([self checkDictionary:[TOATECALIFICATIVE objectAtIndex:indexPath.row]]) {
                    randcal = [NSDictionary dictionaryWithDictionary:[TOATECALIFICATIVE objectAtIndex:ROWWHOIS]];
                }
            }
            
        }
        
        if(SEGMENTACTIV ==1) {
            if(TOATEPOZITIVE.count ==0) {
                if(indexPath.row==0) {
                    cell.dela.hidden=YES;
                    cell.nusuntcalificative.hidden=NO;
                    cell.numecomentator.hidden=YES;
                    cell.comentariu.hidden=YES;
                    cell.iconcalificativprimit.hidden=YES;
                    cell.stelutaverde.hidden=YES;
                    cell.scorcomentator.hidden=YES;
                    cell.nusuntcalificative.text=@"Nu sunt calificative";
                    [cell setNeedsLayout];

                }
            } else {
                cell.nusuntcalificative.hidden=YES;
                if([self checkDictionary:[TOATEPOZITIVE objectAtIndex:indexPath.row]]) {
                    randcal = [NSDictionary dictionaryWithDictionary:[TOATEPOZITIVE objectAtIndex:ROWWHOIS]];
                }
            }
        }
        if(SEGMENTACTIV ==2) {
            if(TOATENEUTRE.count ==0) {
                if(indexPath.row==0) {
                    cell.dela.hidden=YES;
                    cell.nusuntcalificative.hidden=NO;
                    cell.numecomentator.hidden=YES;
                    cell.comentariu.hidden=YES;
                    cell.iconcalificativprimit.hidden=YES;
                    cell.stelutaverde.hidden=YES;
                    cell.scorcomentator.hidden=YES;
                    cell.nusuntcalificative.text=@"Nu sunt calificative";
                    [cell setNeedsLayout];

                }
            } else {
                cell.nusuntcalificative.hidden=YES;
                if([self checkDictionary:[TOATENEUTRE objectAtIndex:indexPath.row]]) {
                    randcal = [NSDictionary dictionaryWithDictionary:[TOATENEUTRE objectAtIndex:ROWWHOIS]];
                }
            }
        }
        if(SEGMENTACTIV ==3) {
            if(TOATENEGATIVE.count ==0) {
                if(indexPath.row==0) {
                    cell.dela.hidden=YES;
                    cell.nusuntcalificative.hidden=NO;
                    cell.numecomentator.hidden=YES;
                    cell.comentariu.hidden=YES;
                    cell.iconcalificativprimit.hidden=YES;
                    cell.stelutaverde.hidden=YES;
                    cell.scorcomentator.hidden=YES;
                    cell.nusuntcalificative.text=@"Nu sunt calificative";
                    [cell setNeedsLayout];

                }
            } else {
                cell.nusuntcalificative.hidden=YES;
                if([self checkDictionary:[TOATENEGATIVE objectAtIndex:indexPath.row]]) {
                    randcal = [NSDictionary dictionaryWithDictionary:[TOATENEGATIVE objectAtIndex:ROWWHOIS]];
                }
            }
        }
        
        
        NSString *tipcomentariu =@"";
        NSString *username =@"";
        NSString *steleuser =@"";
        NSString *NUME_IMAGINE_stars_class=@"";
        NSString *scorcomentator=@"";
        if(randcal[@"rating_type"]) tipcomentariu =[NSString stringWithFormat:@"%@",randcal[@"rating_type"]];
        if(![self MyStringisEmpty:tipcomentariu]) {
//JMOD            if([tipcomentariu isEqualToString:@"positive"]) cell.iconcalificativprimit.image =[UIImage imageNamed:@"Icon_Calificativ_Pozitiv_180x180.png"];
//            if([tipcomentariu isEqualToString:@"neutral"]) cell.iconcalificativprimit.image =[UIImage imageNamed:@"Icon_Calificativ_Neutru_180x180.png"];
//            if([tipcomentariu isEqualToString:@"negative"]) cell.iconcalificativprimit.image =[UIImage imageNamed:@"Icon_Calificativ_Negativ_180x180.png"];
            if([tipcomentariu isEqualToString:@"positive"]) cell.iconcalificativprimit.image =[UIImage imageNamed:@"Icon_Calificativ_Pozitiv_Face_144x144.png"];
            if([tipcomentariu isEqualToString:@"neutral"]) cell.iconcalificativprimit.image =[UIImage imageNamed:@"Icon_Calificativ_Neutru_Face_144x144.png"];
            if([tipcomentariu isEqualToString:@"negative"]) cell.iconcalificativprimit.image =[UIImage imageNamed:@"Icon_Calificativ_Negativ_Face_144x144.png"];
            cell.iconcalificativprimit.hidden=NO;
        } else {
            cell.iconcalificativprimit.hidden=YES;
        }
        
        if(randcal[@"comment"])  {cell.comentariu.text =[NSString stringWithFormat:@"%@",randcal[@"comment"]];
            cell.comentariu.hidden=NO;
            cell.comentariu.numberOfLines=0;
            CGFloat widthWithInsetsApplied = self.view.frame.size.width -60;
            CGSize textSize = [[NSString stringWithFormat:@"%@",randcal[@"comment"]] boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
            cell.dynamiccellcomentariuheight.constant = textSize.height+8; //suficient pentru label de sub text
        }
        
        //JJJJ NU UITA dynamiccellcomentariuheight
        if(randcal[@"user_profile"]) {
            NSDictionary *COMENTATOR =  [NSDictionary dictionaryWithDictionary:randcal[@"user_profile"]];
            if(COMENTATOR[@"username"]) username =[NSString stringWithFormat:@"%@",COMENTATOR[@"username"]];
            cell.numecomentator.hidden=NO;
            cell.numecomentator.text =username;
            cell.dela.hidden=NO;
            
            if(COMENTATOR[@"stars_class"])     steleuser= [NSString stringWithFormat:@"%@",COMENTATOR[@"stars_class"]];
            if(![self MyStringisEmpty:steleuser]) {
                cell.stelutaverde.hidden=NO;
//                if([steleuser isEqualToString:@"stars_green"])   NUME_IMAGINE_stars_class =@"Icon_Steluta_User_01_180x180.png";
//                if([steleuser isEqualToString:@"stars_blue"])    NUME_IMAGINE_stars_class =@"Icon_Steluta_User_02_180x180.png";
//                if([steleuser isEqualToString:@"stars_purple"])  NUME_IMAGINE_stars_class =@"Icon_Steluta_User_03_180x180.png";
//                if([steleuser isEqualToString:@"stars_orange"])  NUME_IMAGINE_stars_class =@"Icon_Steluta_User_04_180x180.png";
//                if([steleuser isEqualToString:@"stars_silver"])  NUME_IMAGINE_stars_class =@"icon_vanzator_silver_144x144.png";
                NUME_IMAGINE_stars_class =@"Icon_Steluta_User_144x144.png";
                cell.stelutaverde.image = [UIImage imageNamed:NUME_IMAGINE_stars_class];
                
            } else {
                cell.stelutaverde.hidden=YES;
            }
            
            if(COMENTATOR[@"score"])     scorcomentator= [NSString stringWithFormat:@"%@",COMENTATOR[@"score"]];
            cell.scorcomentator.hidden=NO;
            cell.scorcomentator.text=scorcomentator;
            
        }
        
    }
    // 13 ultimul rand ..mai multe
    if(ipx ==13 ){
        cell.Row13.hidden=NO;
        cell.vezimaimult.hidden=YES; cell.iconmaimult.hidden=YES;
        // Row13,iconmaimult,vezimaimult;
        if(SEGMENTACTIV ==0) {
            if(_currentPage_toate < catetoate)  {cell.vezimaimult.hidden=NO; cell.iconmaimult.hidden=NO;}
        }
        if(SEGMENTACTIV ==1) {
            if(_currentPage_pozitive < catepozitive) {cell.vezimaimult.hidden=NO; cell.iconmaimult.hidden=NO;}
        }
        if(SEGMENTACTIV ==2) {
            if(_currentPage_neutre < cateneutre){cell.vezimaimult.hidden=NO; cell.iconmaimult.hidden=NO;}
        }
        if(SEGMENTACTIV ==3) {
            if(_currentPage_negative < catenegative) {cell.vezimaimult.hidden=NO; cell.iconmaimult.hidden=NO;}
        }
        
    }
    /////   cell.TitluRand.textColor =  [UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] ;
    return cell;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // [LISTASELECT cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}
-(void)launchReload {
    // increase page positive/negative/neutral
    NSLog(@"lreload");
    utilitar = [[Utile alloc]init];
    NSString *authtoken=@"";
    BOOL elogat = NO;
    elogat = [utilitar eLogat];
    if(elogat) {
        authtoken = [utilitar AUTHTOKEN];
    }
    
    NSString *user_id=@"";
    if(DATEPROFIL[@"user_id"]) {
        user_id =[NSString stringWithFormat:@"%@",DATEPROFIL[@"user_id"]];
    }
    else if(DATEPROFIL[@"username"]) {
        user_id =[NSString stringWithFormat:@"%@",DATEPROFIL[@"username"]];
    }
    if(SEGMENTACTIV ==0) {
        {
            NSString *pagina = [NSString stringWithFormat:@"%i", _currentPage_toate];
            if(elogat) { //accepta fie user_id fie username
                //                  if(DATEPROFIL[@"user_id"]) {
                //                    user_id =[NSString stringWithFormat:@"%@",DATEPROFIL[@"user_id"]];
                //                    [self get_member_profile:user_id :authtoken :@"user_id" :@"inacestecran"];
                //                } else if(DATEPROFIL[@"username"]) {
                //                    user_id =[NSString stringWithFormat:@"%@",DATEPROFIL[@"username"]];
                //                    [self get_member_profile:user_id :authtoken :@"username" :@"inacestecran"];
                //                }
                if(_currentPage_toate ==1) {
                    _currentPage_toate ++;
                    [self  list_ratings:authtoken :pagina :PE_PAGINA :@"toate" :user_id];
                } else  if(_currentPage_toate < catetoate)  {
                    _currentPage_toate ++;
                    [self  list_ratings:authtoken :pagina :PE_PAGINA :@"toate" :user_id];
                }
                
            }
        }
    }
    if(SEGMENTACTIV ==1) {
        NSString *pagina = [NSString stringWithFormat:@"%i", _currentPage_pozitive];
        if(elogat) {
            if(_currentPage_pozitive ==1) {
                _currentPage_pozitive ++;
                [self  list_ratings:authtoken :pagina :PE_PAGINA :@"positive" :user_id];
            } else if(_currentPage_pozitive < catepozitive) {
                _currentPage_pozitive ++;
                [self  list_ratings:authtoken :pagina :PE_PAGINA :@"positive" :user_id];
            }
        }
    }
    if(SEGMENTACTIV ==2) {
        NSString *pagina = [NSString stringWithFormat:@"%i", _currentPage_neutre];
        if(elogat) {
            if(_currentPage_neutre ==1) {
                _currentPage_neutre ++;
                [self  list_ratings:authtoken :pagina :PE_PAGINA :@"neutral" :user_id];
            } else  if(_currentPage_neutre < cateneutre) {
                _currentPage_neutre ++;
                [self  list_ratings:authtoken :pagina :PE_PAGINA :@"neutral" :user_id];
            }
        }
    }
    if(SEGMENTACTIV ==3) {
        NSString *pagina = [NSString stringWithFormat:@"%i", _currentPage_negative];
        if(elogat) {
            if(_currentPage_neutre ==1) {
                _currentPage_negative ++;
                [self  list_ratings:authtoken :pagina :PE_PAGINA :@"negative" :user_id];
            } else   if(_currentPage_negative < catenegative) {
                _currentPage_negative ++;
                [self  list_ratings:authtoken :pagina :PE_PAGINA :@"negative" :user_id];
            }
        }
    }
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int ipx = (int)indexPath.section;
    int ROWWHOIS = (int)indexPath.row;
    
    //telefon action
    if(ipx ==2) {
        NSMutableArray *telefoane = [NSMutableArray arrayWithArray: [self.titluriCAMPURI objectAtIndex:2]];
        NSString * gototelefon= [NSString stringWithFormat:@"%@",[telefoane objectAtIndex:ROWWHOIS]]; // :)
      
        UIDevice *device = [UIDevice currentDevice];
        if ([[device model] isEqualToString:@"iPhone"] ) {
            NSString *cleanedString = [[gototelefon componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
            BOOL egol  = [ self MyStringisEmpty:cleanedString];
            if(!egol & ![cleanedString isEqualToString:@"-"]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",cleanedString]]];
            }
        } else {
           UIAlertView *notPermitted=[[UIAlertView alloc] initWithTitle:@"Atenție" message:@"Telefonul nu poate iniția apeluri." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [notPermitted show];
        }
        
        
    }
    if(ipx ==3) {
        if([self checkDictionary:DATEPROFIL[@"company"]]){
            if(AREFIRMA==YES) {
                NSDictionary *firma = [NSDictionary dictionaryWithDictionary:DATEPROFIL[@"company"]];
                NSString *urlfirma =@"";
                if(firma[@"url"])     urlfirma= [NSString stringWithFormat:@"%@",firma[@"url"]];
                if(![self MyStringisEmpty:urlfirma]) {
                    // browser extern
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlfirma]];
                } else {
                    NSLog(@"nu are url");
                }
            }
        }
    }
    if(ipx ==4) {
        NSString *product_listing_url=@"";
        if(DATEPROFIL[@"product_listing_url"])     product_listing_url= [NSString stringWithFormat:@"%@",DATEPROFIL[@"product_listing_url"]];
        if(![self MyStringisEmpty:product_listing_url]) {
            // browser extern
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:product_listing_url]];
        } else {
            NSLog(@"nu are url");
        }
    }
    // vc.PROFILULMEU =NO;
    if(ipx ==12) {
        if(self.PROFILULMEU ==NO) {
            NSLog(@"MADE MY DAY"); //->ia date user si du-l la un ecran similar cu asta [vezi DetaliuVanzator]
            utilitar = [[Utile alloc]init];
            NSString *authtoken=@"";
            BOOL elogat = NO;
            elogat = [utilitar eLogat];
            if(elogat) {
                NSString *user_id=@"";
                authtoken = [utilitar AUTHTOKEN];
                NSDictionary *randcal=[[NSDictionary alloc]init];
                
                if(SEGMENTACTIV ==0) {
                    if(TOATECALIFICATIVE.count >0) {
                        if([self checkDictionary:[TOATECALIFICATIVE objectAtIndex:indexPath.row]]) {
                            randcal = [NSDictionary dictionaryWithDictionary:[TOATECALIFICATIVE objectAtIndex:ROWWHOIS]];
                            NSLog(@"randcaltoate %@",randcal);
                        }
                    }
                }
                if(SEGMENTACTIV ==1) {
                    if(TOATEPOZITIVE.count >0) {
                        if([self checkDictionary:[TOATEPOZITIVE objectAtIndex:indexPath.row]]) {
                            randcal = [NSDictionary dictionaryWithDictionary:[TOATEPOZITIVE objectAtIndex:ROWWHOIS]];
                            NSLog(@"randcalpozitive %@",randcal);
                        }
                    }
                }
                if(SEGMENTACTIV ==2) {
                    if(TOATENEUTRE.count >0) {
                        if([self checkDictionary:[TOATENEUTRE objectAtIndex:indexPath.row]]) {
                            randcal = [NSDictionary dictionaryWithDictionary:[TOATENEUTRE objectAtIndex:ROWWHOIS]];
                            NSLog(@"randcalneutre %@",randcal);
                        }
                    }
                }
                if(SEGMENTACTIV ==3) {
                    if(TOATENEGATIVE.count >0) {
                        if([self checkDictionary:[TOATENEGATIVE objectAtIndex:indexPath.row]]) {
                            randcal = [NSDictionary dictionaryWithDictionary:[TOATENEGATIVE objectAtIndex:ROWWHOIS]];
                            NSLog(@"randcalnegative %@",randcal);
                        }
                    }
                }
                
                if(randcal && randcal[@"user_profile"]) {
                    NSDictionary *COMENTATOR =  [NSDictionary dictionaryWithDictionary:randcal[@"user_profile"]];
                    if(COMENTATOR[@"user_id"]) {
                        user_id =[NSString stringWithFormat:@"%@",COMENTATOR[@"user_id"]];
                        [self get_member_profile:user_id :authtoken :@"user_id" :@"laecrannou"];
                    }  else if(COMENTATOR[@"username"]) {
                        user_id =[NSString stringWithFormat:@"%@",COMENTATOR[@"username"]];
                        [self get_member_profile:user_id :authtoken :@"username" :@"laecrannou"];
                    }
                }
            }
        }
    }
    if(ipx==13) {
        [self launchReload];
    }
    NSDictionary *cerererow =[[NSDictionary alloc]init];
    cerererow = [self.titluriCAMPURI objectAtIndex:ipx];
}
-(void)gotodetaliuProfil :(NSMutableDictionary*) multedate {
    DetaliuVanzator *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetaliuVanzatorVC"];
    vc.PROFILULMEU =NO;
    vc.DATEPROFIL =[[NSMutableDictionary alloc]init];
    vc._currentPage_toate=1;
    vc.DATEPROFIL =multedate;
    [self.navigationController pushViewController:vc animated:YES ];
    
}
//METODA_GET_MEMBER_PROFILE @"m=get_member_profile&p=" user_id username
-(void)get_member_profile :(NSString *)userid :(NSString *)AUTHTOKEN :(NSString *)tipuserid :(NSString*)MODINCREMENTARE{ //user_id sau username  MODINCREMENTARE este fie pagina 1 cand merge in alt ecran fie _currentPage_toate
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
        [dic2 setObject:@"20" forKey:@"per_page"];
        if([MODINCREMENTARE isEqualToString:@"laecrannou"]) {
            [dic2 setObject:@"1" forKey:@"page"];
        } else  if([MODINCREMENTARE isEqualToString:@"inacestecran"]) {
            NSString *vezi_currentPage_toate =[NSString stringWithFormat:@"%i",_currentPage_toate];
            [dic2 setObject:vezi_currentPage_toate forKey:@"page"];
        }
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
                  //  jNSLog(@"date get_member_profile %@",multedate);
                    if([MODINCREMENTARE isEqualToString:@"laecrannou"]) {
                        [self gotodetaliuProfil:multedate];
                    } else  if([MODINCREMENTARE isEqualToString:@"inacestecran"]) {
                        if(multedate[@"ratings"] && [multedate[@"ratings"][@"items"]isKindOfClass:[NSArray class]] ){
                            NSMutableArray *multecomentarii =[NSMutableArray arrayWithArray: multedate[@"ratings"][@"items"]];
                            if(multecomentarii.count >0){
                                [self update_list_comments:multecomentarii:@"toate"];
                                /*
                                 comment = Promt;
                                 "external_url" = "http://dev5.activesoft.ro/~csaba/4tilance/prelungire-bara-fata/vw/golf-3/prelungire-bara-fata-golf-3-vr6-262922893.html";
                                 "item_id" = 91813;
                                 */
                            } else {
                                [self reloadsectiunea12];
                            }
                        }
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
-(void)reloadsectiunea12 {
    NSIndexSet *section =  [NSIndexSet indexSetWithIndex:12];
    [self.LISTASELECT beginUpdates];
    [self.LISTASELECT reloadSections:section withRowAnimation:UITableViewRowAnimationNone];
    [self.LISTASELECT endUpdates];
    //    NSIndexPath *pathToLastRow = [NSIndexPath indexPathForRow:0 inSection:11];
    //   [self.LISTASELECT scrollToRowAtIndexPath:pathToLastRow
    //                            atScrollPosition:UITableViewScrollPositionTop
    //                                    animated:NO];
    
}
/////METODA_LIST_RATINGS
-(NSMutableArray*)update_list_comments :(NSMutableArray *)multecomentarii :(NSString *)status {
    NSMutableArray *lista_cereri = multecomentarii;
    //toate/positive/negative/neutral
    if([status isEqualToString:@"toate"]) {
        for(NSDictionary *itemnou in lista_cereri) {
            if(![self.TOATECALIFICATIVE containsObject:itemnou]) {
                [self.TOATECALIFICATIVE addObject:itemnou];
            }
        }
        [self reloadsectiunea12];
    }
    if([status isEqualToString:@"positive"]) {
        for(NSDictionary *itemnou in lista_cereri) {
            if(![self.TOATEPOZITIVE containsObject:itemnou]) {
                [self.TOATEPOZITIVE addObject:itemnou];
            }
        }
        [self reloadsectiunea12];
    }
    if([status isEqualToString:@"neutral"]) {
        for(NSDictionary *itemnou in lista_cereri) {
            if(![self.TOATENEUTRE containsObject:itemnou]) {
                [self.TOATENEUTRE addObject:itemnou];
            }
        }
        [self reloadsectiunea12];
    }
    if([status isEqualToString:@"negative"]) {
        for(NSDictionary *itemnou in lista_cereri) {
            if(![self.TOATENEGATIVE containsObject:itemnou]) {
                [self.TOATENEGATIVE addObject:itemnou];
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
     ///       [MBProgressHUD hideAllHUDsForView:self.navigationController.visibleViewController.view animated:YES];
         
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
        if([STATUS isEqualToString:@"toate"]) {
            
        } else {
            [dic2 setObject:STATUS forKey:@"rating_type"];  // 'positive', 'neutral' sau 'negative' sau gol
        }
        [dic2 setObject:@"received" forKey:@"type"];    // type":"received
        [dic2 setObject:USER_IDsauUSERNAME forKey:@"user_id"];
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
                    NSLog(@"date cerere comentarii %@",multedate);
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
                    
                    if([STATUS isEqualToString:@"positive"]) {
                        
                        if([PAGE isEqualToString:@"1"]) {
                            catepozitive =round;
                        }
                    }
                    
                    if([STATUS isEqualToString:@"neutral"]) {
                        
                        if([PAGE isEqualToString:@"1"]) {
                            cateneutre =round;
                        }
                    }
                    
                    if([STATUS isEqualToString:@"negative"]) {
                        if([PAGE isEqualToString:@"1"]) {
                            catenegative =round;
                        }
                    }
                    if([STATUS isEqualToString:@"toate"]) {
                        if([PAGE isEqualToString:@"1"]) {
                            catenegative =round;
                        }
                    }
                    if(multedate[@"items"]) {
                        NSMutableArray *multecomentarii =multedate[@"items"];
                        if(multecomentarii.count >0){
                            [self update_list_comments:multecomentarii:STATUS];
                        } else {
                            [self reloadsectiunea12];
                        }
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





@end
