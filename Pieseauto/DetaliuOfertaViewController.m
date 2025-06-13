//
//  DetaliuOfertaViewController.m
//  Pieseauto
//
//  Created by Ioan Ungureanu on 13/04/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//
#import "utile.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"
#import "Reachability.h"
#import "DetaliuOfertaViewController.h"
#import "CellDetaliuOferta.h"
#import "TutorialHomeViewController.h"
#import <CoreText/CoreText.h>
#import "SetariViewController.h"
#import "UIImageView+WebCache.h" //sdwebimage
#import "SDWebImagePrefetcher.h"

#import <QuartzCore/QuartzCore.h>
#import <CoreText/CTStringAttributes.h>
#import <CoreText/CoreText.h>
#import "EcranFormularComanda.h"
#import "CustomBadge.h"
#import "CustomBadge1.h"
#import "pozemesajeviewVC.h"
#import "TabelPozeMesajeVC.h"
#import "DetaliuProfil.h"
#import "Galerieslide.h"
#import "TTTAttributedLabel.h"
#import "butoncustomback.h"
#import "EcranAcorda.h"
#import "UIAlertView+Blocks.h"

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
static NSString *PE_PAGINA = @"20";
double cellheightmodificatoferta=60;
@interface ClockFace ()

@end

@implementation ClockFace

- (id)init
{
    if ((self = [super init]))
    {
        
    }
    return self;
}

@end

//@interface SpecialText: UILabel
@interface SpecialText ()

@end

@implementation SpecialText

- (id)init
{
    if ((self = [super init]))
    {
        
    }
    return self;
}

@end

@interface IMAGINESERVER ()

@end

@implementation IMAGINESERVER

- (id)init
{
    if ((self = [super init]))
    {
        
    }
    return self;
}

@end

@interface DetaliuOfertaViewController(){
    CGFloat textViewHeight;
}
@property (nonatomic, strong) ClockFace *clockFace;
@end

@implementation DetaliuOfertaViewController
@synthesize  LISTASELECT,titluriCAMPURI,TOATE,RANDURIOFERTA,RANDOFERTANT,RANDURIEXPANDABILE,TEXTMESAJTEMPORAR;
@synthesize idoferta,CORPDATE,DETALIUOFERTA,ladreapta,lastanga,pieseselectate,lastmessageid,stareexpand,pozele,pozetemporare,pozeprocesate,idmesaj,arewinner,cerereexpirata,afostanulata,dinpush;
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

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets;
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize.height+40), 0.0);
    } else {
        contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize.width), 0.0);
    }
    self.LISTASELECT.contentInset = contentInsets;
    self.LISTASELECT.scrollIndicatorInsets = contentInsets;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:6]; // sa urce peste keyboard
    [self.LISTASELECT scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    self.LISTASELECT.contentInset = UIEdgeInsetsMake(0, 0, 0, 0) ; //are nav bar
    NSInteger lastRowIndex = [self.LISTASELECT numberOfRowsInSection:5] - 1;
    NSIndexPath *pathToLastRow = [NSIndexPath indexPathForRow:lastRowIndex inSection:5];
    [self.LISTASELECT scrollToRowAtIndexPath:pathToLastRow
                            atScrollPosition:UITableViewScrollPositionTop
                                    animated:NO];
}
-(void)addhud{
    [MBProgressHUD showHUDAddedTo:self.navigationController.visibleViewController.view animated:YES];
}
-(void)removehud{
    [MBProgressHUD hideAllHUDsForView:self.navigationController.visibleViewController.view animated:YES];
}
-(void)perfecttimeforback{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)viewWillAppear:(BOOL)animated {
    
    previousRect = CGRectZero;
    self.idmesaj =idmesaj;
    NSLog(@"detaliu oferta");
      /// sunt randuri selectate sau nu la tap pe rows se schimba val in 1 // revine la 0 sectiunile 2-5
    self.pozetemporare = [[NSArray alloc]init];
    self.pozeprocesate =[[NSMutableArray alloc]init];
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(del.ARRAYASSETURIMESAJ.count >0) {
        pozele= [[NSMutableArray alloc]init];
        pozele = del.ARRAYASSETURIMESAJ;
        [self.LISTASELECT reloadData];
    } else {
        pozele = [[NSMutableArray alloc]init];
        del.POZEMESAJ= [[NSMutableArray alloc]init];
        del.ARRAYASSETURIMESAJ= [[NSMutableArray alloc]init];
        del.ARRAYASSETURIMESAJEXTERNE= [[NSMutableArray alloc]init];
       }
    [self removehud];
    
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)viewDidAppear:(BOOL)animated {
    NSArray *ariestareexpand =@[@{@"expand":@"0"},@{@"expand":@"0"},@{@"expand":@"0"},@{@"expand":@"0"}];
    stareexpand= [[NSMutableArray alloc]init];
    stareexpand =[NSMutableArray arrayWithArray:ariestareexpand];
    NSLog(@"stareexpand %@", stareexpand);
    NSMutableArray *MESAJEREXP = [self.TOATE objectAtIndex:5];
    if(![self MyStringisEmpty:idmesaj]) {
        NSLog(@"mesageidmesageid %@",idmesaj);
        if([MESAJEREXP objectAtIndex:0] ) {
            NSDictionary *elementmesaje = [MESAJEREXP objectAtIndex:0];
            NSLog(@"elementmesaje %@",elementmesaje);
            if(elementmesaje[@"SubItems"]) {
                NSArray *mesajeitems= elementmesaje[@"SubItems"];
                for(int i=0; i < mesajeitems.count; i++) {
                    NSDictionary *detaliumesaj = [mesajeitems objectAtIndex:i];
                    if(detaliumesaj[@"messageid"]) {
                        NSString *messageid =[NSString stringWithFormat:@"%@", detaliumesaj[@"messageid"]];
                        NSLog(@"messageid de verificat %@",messageid);
                        if ([messageid isEqualToString:idmesaj]) {
                            NSLog(@"iiiiiiiii %i",i);
                            NSArray *ariestareexpand =@[@{@"expand":@"0"},@{@"expand":@"0"},@{@"expand":@"0"},@{@"expand":@"1"}];
                            stareexpand= [[NSMutableArray alloc]init];
                            stareexpand =[NSMutableArray arrayWithArray:ariestareexpand];
                            NSLog(@"stareexpand %@", stareexpand);
                            //[buttonObj sendActionsForControlEvents: UIControlEventTouchUpInside];
                            NSIndexPath *indexPathreload = [NSIndexPath indexPathForRow:0 inSection:5];
                            CellDetaliuOferta* cell = (CellDetaliuOferta*)[self.LISTASELECT cellForRowAtIndexPath:indexPathreload];
                            if(cell) {
                                [self expandmesajespecial:i];
                            }
                            break;
                        }
                    }
                    
                }
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
-(AFHTTPSessionManager*)SESSIONMANAGER {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy =[self customSecurityPolicy];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
    return manager;
}
-(void)gohome {
      utilitar = [[Utile alloc]init];
      [utilitar mergiLaMainViewVC];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    textViewHeight = 60;
    self.dinpush =dinpush;
    afostanulata =NO;
    self.cerereexpirata = cerereexpirata;
    self.idmesaj =idmesaj;
    NSLog(@"mesageidmesageid %@",idmesaj);
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    self.title = @"Detaliu Ofertă";
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
    if(self.dinpush ==YES) {
    [ceva addTarget:self action:@selector(gohome) forControlEvents:UIControlEventTouchUpInside];
     self.dinpush =NO;
    } else {
         self.dinpush =NO;
     [ceva addTarget:self action:@selector(perfecttimeforback) forControlEvents:UIControlEventTouchUpInside];
    }
    UIBarButtonItem *inapoibtn =[[UIBarButtonItem alloc] initWithCustomView:ceva];
    self.navigationItem.leftBarButtonItem = inapoibtn;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    TOATE= [[NSMutableArray alloc]init];
    RANDOFERTANT= [[NSMutableArray alloc]init];
    RANDURIEXPANDABILE= [[NSMutableArray alloc]init];
    LISTASELECT.delegate =self;
    LISTASELECT.dataSource =self;
    LISTASELECT.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    LISTASELECT.separatorColor = [UIColor darkGrayColor];
    self.CORPDATE = [NSMutableDictionary dictionaryWithDictionary:CORPDATE];
    DETALIUOFERTA = [NSMutableDictionary dictionaryWithDictionary:CORPDATE];
    NSLog(@"DETALIUOFERTADETALIUOFERTA %@", DETALIUOFERTA);
    //   _currentPage,_currentPagePreferate,numarpagini,numarpaginipreferate
    if([self checkDictionary:DETALIUOFERTA]) {
        //dictionar detaliu oferta
        if(DETALIUOFERTA[@"id"]) {
            idoferta =[NSString stringWithFormat:@"%@", DETALIUOFERTA[@"id"]];
        }
        if(DETALIUOFERTA[@"items"]) {
            RANDURIOFERTA= [[NSMutableArray alloc]init];
            RANDURIOFERTA = [NSMutableArray arrayWithArray:DETALIUOFERTA[@"items"]];
            self.pieseselectate =[[NSMutableArray alloc]init];
            self.pieseselectate =[NSMutableArray arrayWithArray:RANDURIOFERTA];
            
        }
    }
    if(DETALIUOFERTA[@"messageid"]) {
        lastmessageid=@"";
        lastmessageid =  [NSString stringWithFormat:@"%@",DETALIUOFERTA[@"messageid"]]; //va fi idul ofertei din start -> daca sunt mesaje de la vanzator devine ultimul mesaj din lista trimis de vanzator
    }
    
    NSMutableArray *GARANTIEEXP =[[NSMutableArray alloc]init];
    NSMutableArray *RETUREXP =[[NSMutableArray alloc]init];
    NSMutableArray *EXPEDIEREREXP =[[NSMutableArray alloc]init];
    NSMutableArray *expandabile =[[NSMutableArray alloc]init];
    
    if(  DETALIUOFERTA[@"winner"] ) {
        NSString *verificawinner = [NSString stringWithFormat:@"%@", DETALIUOFERTA[@"winner"]];
        if(verificawinner.integerValue ==1) {
            arewinner =YES;
        }
        
    }
    
    if( DETALIUOFERTA[@"expandables"]) {
        NSLog(@"expands %@",DETALIUOFERTA[@"expandables"]);
        expandabile = [NSMutableArray arrayWithArray:DETALIUOFERTA[@"expandables"]];
        
        if([expandabile objectAtIndex:0]) {
            NSMutableArray *itemuriexpandabile =[[NSMutableArray alloc]init];
            NSString *name =@"";
            NSString *label_name =@"";
            NSString *label_value =@"";
            NSString *html =@"";
            NSDictionary *expanddict = [NSDictionary dictionaryWithDictionary:[expandabile objectAtIndex:0]];
            name =[NSString stringWithFormat:@"%@",expanddict[@"name"]];
            if(![self MyStringisEmpty:name] && [name isEqualToString:@"warranty"] ) {
                NSMutableDictionary *CORPEXPANDABIL = [[NSMutableDictionary alloc]init];
                NSMutableDictionary *SECONDEXPANDABIL =[[NSMutableDictionary alloc]init];
                if(expanddict[@"label_name"]) label_name =expanddict[@"label_name"];
                if(expanddict[@"label_value"]) label_value =expanddict[@"label_value"];
                if(expanddict[@"html"]) html =expanddict[@"html"];
                [CORPEXPANDABIL setObject:label_name forKey:@"label_name"];
                [CORPEXPANDABIL setObject:label_value forKey:@"label_value"];
                [SECONDEXPANDABIL setObject:html forKey:@"html"];
                [itemuriexpandabile addObject:SECONDEXPANDABIL];
                [CORPEXPANDABIL setObject:itemuriexpandabile forKey:@"SubItems"];
                GARANTIEEXP =[NSMutableArray arrayWithArray:[NSArray arrayWithObjects:CORPEXPANDABIL, nil]];
                NSLog(@"GARANTIEEXP %@",GARANTIEEXP);
            }
        }
        if([expandabile objectAtIndex:1]) {
            
            NSMutableArray *itemuriexpandabile =[[NSMutableArray alloc]init];
            NSString *name =@"";
            NSString *label_name =@"";
            NSString *label_value =@"";
            NSString *html =@"";
            NSDictionary *expanddict = [NSDictionary dictionaryWithDictionary:[expandabile objectAtIndex:1]];
            name =[NSString stringWithFormat:@"%@",expanddict[@"name"]];
            if( ![self MyStringisEmpty:name] && [name isEqualToString:@"return"]) {
                NSMutableDictionary *CORPEXPANDABIL = [[NSMutableDictionary alloc]init];
                NSMutableDictionary *SECONDEXPANDABIL =[[NSMutableDictionary alloc]init];
                if(expanddict[@"label_name"]) label_name =expanddict[@"label_name"];
                if(expanddict[@"label_value"]) label_value =expanddict[@"label_value"];
                if(expanddict[@"html"]) html =expanddict[@"html"];
                [CORPEXPANDABIL setObject:label_name forKey:@"label_name"];
                [CORPEXPANDABIL setObject:label_value forKey:@"label_value"];
                [SECONDEXPANDABIL setObject:html forKey:@"html"];
                [itemuriexpandabile addObject:SECONDEXPANDABIL];
                [CORPEXPANDABIL setObject:itemuriexpandabile forKey:@"SubItems"];
                RETUREXP =[NSMutableArray arrayWithArray:[NSArray arrayWithObjects:CORPEXPANDABIL, nil]];
                NSLog(@"RETUREXP %@",RETUREXP);
            }
        }
        if([expandabile objectAtIndex:2]) {
            
            NSMutableArray *itemuriexpandabile =[[NSMutableArray alloc]init];
            NSString *name =@"";
            NSString *label_name =@"";
            NSString *label_value =@"";
            NSString *html =@"";
            NSDictionary *expanddict = [NSDictionary dictionaryWithDictionary:[expandabile objectAtIndex:2]];
            name =[NSString stringWithFormat:@"%@",expanddict[@"name"]];
            if( ![self MyStringisEmpty:name] && [name isEqualToString:@"shipping"]) {
                NSMutableDictionary *CORPEXPANDABIL = [[NSMutableDictionary alloc]init];
                NSMutableDictionary *SECONDEXPANDABIL =[[NSMutableDictionary alloc]init];
                if(expanddict[@"label_name"]) label_name =expanddict[@"label_name"];
                if(expanddict[@"label_value"]) label_value =expanddict[@"label_value"];
                if(expanddict[@"html"]) html =expanddict[@"html"];
                [CORPEXPANDABIL setObject:label_name forKey:@"label_name"];
                [CORPEXPANDABIL setObject:label_value forKey:@"label_value"];
                [SECONDEXPANDABIL setObject:html forKey:@"html"];
                [itemuriexpandabile addObject:SECONDEXPANDABIL];
                [CORPEXPANDABIL setObject:itemuriexpandabile forKey:@"SubItems"];
                EXPEDIEREREXP =[NSMutableArray arrayWithArray:[NSArray arrayWithObjects:CORPEXPANDABIL, nil]];
                NSLog(@"EXPEDIEREREXP %@",EXPEDIEREREXP);
            }
        }
    }
    
    
    NSMutableDictionary *RANDULUNU =[[NSMutableDictionary alloc]init];
    if(DETALIUOFERTA[@"user"]) RANDULUNU =DETALIUOFERTA[@"user"];
    RANDOFERTANT = [NSMutableArray arrayWithArray:[NSArray arrayWithObjects:RANDULUNU, nil]];
    //la mesaje avem Arii cu Dictionare [pentru un mai usor row count si insert la expand]
    
    NSMutableArray *MESAJEREXP = [[NSMutableArray alloc]init];
    NSMutableArray *MESAJELEALTORA = [[NSMutableArray alloc]init];
    NSString *comments_count=@"";
    NSString *comments_unread_count=@"";
    if(DETALIUOFERTA[@"comments_count"]) comments_count = [NSString stringWithFormat:@"%@",DETALIUOFERTA[@"comments_count"]];
    if(DETALIUOFERTA[@"comments_unread_count"]) comments_unread_count = [NSString stringWithFormat:@"%@",DETALIUOFERTA[@"comments_unread_count"]];
    if( DETALIUOFERTA[@"comments"]) {
        NSMutableArray *itemuriexpandabile =[[NSMutableArray alloc]init];
        itemuriexpandabile = [NSMutableArray arrayWithArray: [DETALIUOFERTA[@"comments"]mutableCopy]];
        if( itemuriexpandabile.count>0) {
            //acum parcurge aria si  stabileste lastmessageid
            for(int i=0;i< itemuriexpandabile.count;i++) {
                NSDictionary *dictmesaj = [NSDictionary dictionaryWithDictionary:[itemuriexpandabile objectAtIndex:i]];
                NSMutableDictionary *perfectsense =[NSMutableDictionary dictionaryWithDictionary:dictmesaj];
                if(dictmesaj[@"is_myself"]) {
                    NSString *eusender =[NSString stringWithFormat:@"%@",dictmesaj[@"is_myself"]];
                    NSInteger z=[eusender integerValue];
                    if(z==0) {
                        //ADD IN ARRAY
                        [MESAJELEALTORA addObject:dictmesaj];
                    }
                }
                if(dictmesaj[@"images"]) {
                    NSArray *imagini = [NSArray arrayWithArray:dictmesaj[@"images"]];
                    if(imagini.count >0) {
                        NSDictionary *imagine = [imagini objectAtIndex:0];
                        if(imagine[@"tb"]) {
                            
                            UIImage *IHAVEIMAGE = [[UIImage alloc]init];
                            NSString *stringurlthumbnail = [NSString stringWithFormat:@"%@", imagine[@"tb"]];
                            
                            IHAVEIMAGE = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: stringurlthumbnail]]];
                            if(IHAVEIMAGE && IHAVEIMAGE.size.height >0) {
                                [perfectsense setObject:IHAVEIMAGE forKey:@"imaginea0"];
                                [itemuriexpandabile replaceObjectAtIndex:i withObject:perfectsense];
                                
                            }
                        }
                    }
                }
            }
        }
        //ATENTIE ! aici se insereaza intotdeauna 2 randuri goale text mesaj + buton de trimite mesaj
     
        NSDictionary *trimitemesaj =@{@"special" : @"1"};
        NSDictionary *trimitemesajaltul =@{@"specialrand" : @"2"};
        NSDictionary *nusuntmesaje =@{@"Momentan nu sunt mesaje" : @"0"};
        [itemuriexpandabile addObject:nusuntmesaje];
        [itemuriexpandabile addObject:trimitemesaj];
        [itemuriexpandabile addObject:trimitemesajaltul];
        NSMutableDictionary *CORPEXPANDABIL = [[NSMutableDictionary alloc]init];
        NSString *name =@"Mesaje:";
        [CORPEXPANDABIL setObject:name forKey:@"label_name"];
        [CORPEXPANDABIL setObject:comments_count forKey:@"comments_count"];
        [CORPEXPANDABIL setObject:comments_unread_count forKey:@"comments_unread_count"];
        [CORPEXPANDABIL setObject:itemuriexpandabile forKey:@"SubItems"];
        MESAJEREXP =[NSMutableArray arrayWithArray:[NSArray arrayWithObjects:CORPEXPANDABIL, nil]];
        NSLog(@"MESAJEREXP %@",MESAJEREXP);
    }
    
    NSLog(@"MESAJELEALTORA %@",MESAJELEALTORA);
    if(MESAJELEALTORA.count >0) {
        NSDictionary *ULTIMULMESAJDELAALTII = [NSDictionary dictionaryWithDictionary:[MESAJELEALTORA lastObject]];
        if(ULTIMULMESAJDELAALTII[@"messageid"]) {
            NSString *lastmesajid =[NSString stringWithFormat:@"%@",ULTIMULMESAJDELAALTII[@"messageid"]];
            lastmessageid =lastmesajid;
        }
    }
  
    //1826953
    /*
     NSArray *MESAJEREX=  @[@{@"nume":@"Mesaje:", @"altext":@"da",@"SubItems":@[
     @{@"nume":@"mesaj1",@"descriere":@"textmesaj1", @"eusender":@"0"},
     @{@"nume":@"alt mesaj lung\nalt mesaj lungalt mesaj lungalt mesaj lungalt mesaj lung\nalt mesaj lung",@"descriere":@"textalt mesaj lung", @"eusender":@"1"},
     @{@"nume":@"mesaj3",@"descriere":@"textmesaj3", @"eusender":@"1"},
     @{@"nume":@"mesaj4",@"descriere":@"textmesaj4", @"eusender":@"0"}]}];
     */
    //    NSArray *MESAJEREXPtest =@[@{@"comments_count": @"3", @"comments_unread_count":@"0" ,@"label_name" : @"Mesaje",
    //                                @"SubItems": @[@{@"special":@"1"}, @{@"special":@"1"}, @{@"special":@"1"}, @{@"special":@"1"}, @{@"special":@"1"}]}];
    //
    //    MESAJEREXP =[NSMutableArray arrayWithArray:MESAJEREXPtest];
    //     NSLog(@"MESAJEREXP2 %@",MESAJEREXP);
    NSArray *ULTIMULRANDBUTOANE=  @[@{@"nume":@"BUTOANE",@"SubItems":@[
                                              ]}];
    
       //    RANDURIEXPANDABILE =[NSMutableArray arrayWithArray:[NSArray arrayWithObjects:@"GARANTIE", @"RETUR",  @"EXPEDIERE", @"MESAJE", @"", nil]];
    if(arewinner ==YES) {
        self.TOATE = [[NSMutableArray alloc] initWithObjects:RANDURIOFERTA, RANDOFERTANT, GARANTIEEXP,RETUREXP,EXPEDIEREREXP,MESAJEREXP,ULTIMULRANDBUTOANE,@"Anulează câștigător",@"Acordă calificativ", nil];
       
    } else {
    self.TOATE = [[NSMutableArray alloc] initWithObjects:RANDURIOFERTA, RANDOFERTANT, GARANTIEEXP,RETUREXP,EXPEDIEREREXP,MESAJEREXP,ULTIMULRANDBUTOANE, nil];
    NSLog(@"self.toate detaliu %@", self.TOATE);
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // return 1;
    NSInteger sections = [[self TOATE] count];
    return sections;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows=0;
       if(section ==7 || section ==8) {
           rows=1;
       }
    
       else {
    NSArray *sectionContents = [[self TOATE] objectAtIndex:section];
     rows = [sectionContents count];
       }
    return rows;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // NSLog(@"textviewheight : %f",textViewHeight);
    double inaltimerand =0;
    if(indexPath.section ==6) {
        //cand are winner nu mai apare salveaza la pref sau accepta oferta
        if(arewinner ==YES ||  cerereexpirata==YES) {
           inaltimerand =0;
        } else {
            inaltimerand =74;
        }
        return inaltimerand;
    }
    if(indexPath.section ==7 || indexPath.section ==8) {
        if(arewinner ==YES) {
            inaltimerand =55;
        } else {
           inaltimerand =0;
            }
        return inaltimerand;
     }
    if(indexPath.section ==0 ) { //ok
        NSInteger ipx= indexPath.row;
        double inaltimerandverde = 0;
        if(ipx ==0) {
            if(arewinner ==YES) {
                inaltimerandverde =40;
            }
        }
        CGFloat widthWithInsetsApplied = self.view.frame.size.width;
        NSArray *imagini = [NSArray arrayWithArray:DETALIUOFERTA[@"images"]];
        NSInteger rightsize=20;
        if(imagini.count >0) {
            NSDictionary *imagine = [imagini objectAtIndex:0];
            if(imagine[@"tb"]) {
                rightsize =46;
            }
        }
        
        widthWithInsetsApplied = self.view.frame.size.width - rightsize;
        NSMutableArray *RANDURI=RANDURIOFERTA;
        NSDictionary *la0 = [RANDURI objectAtIndex:0];
        NSString *C_titlu = [NSString stringWithFormat:@"%@",la0[@"description"]];
        CGSize textSize = [C_titlu boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18]} context:nil].size;
        double inaltimerandx= textSize.height;
        UIFont *tester = [UIFont boldSystemFontOfSize:18];
        double numberOfLines = textSize.height /tester.pointSize;
        if(numberOfLines <2) {
            if(rightsize == 46) {
                inaltimerandx =46;
            } else {
                inaltimerandx =24;
            }
        }
        inaltimerand= inaltimerandx  +60 + inaltimerandverde; // pt ca are si tip oferta pe 2 randuri + randul verde daca e oferta castigatoare
        return inaltimerand;
    }
    if(indexPath.section ==1 ) {
        return  66;
    }
    
    if(indexPath.section ==5 ) {
        NSDictionary *MAJORDICT = [[self.TOATE objectAtIndex:5] objectAtIndex:0];
        NSArray *minorrarray = [[NSArray alloc]init];
        if(MAJORDICT[@"SubItems"] ) minorrarray =MAJORDICT[@"SubItems"];
        NSInteger totalRow = minorrarray.count;
        if(indexPath.row == 0){
            inaltimerand = 54;
        } else   if(indexPath.row == totalRow -2 && minorrarray.count ==3) {
            inaltimerand= 54 ;
        } else if(indexPath.row == totalRow -2 && minorrarray.count >3) {
             inaltimerand =0;
        }
        
        else if(indexPath.row == totalRow -1 ) {
            inaltimerand= textViewHeight ;
        } else if(indexPath.row == totalRow ) {
            inaltimerand = 47; //e buton trimite mesaj
        }
        else {
            double NECESARHeight =0;
            double NECESARHeightIMAGINE = 0;
            NSDictionary *MINORDICT = [minorrarray objectAtIndex:indexPath.row -1]; //pentru ca 0 e num si randurile sunt 1 2 3...
            NSString *continutmesaj=@"";
            NSString *datafromatatamesaj=@"";
            if(MINORDICT[@"message"]) continutmesaj =[NSString stringWithFormat:@"%@",MINORDICT[@"message"]];
            if(MINORDICT[@"date_formatted"]) datafromatatamesaj =[NSString stringWithFormat:@"%@",MINORDICT[@"date_formatted"]];
            NSString *compus_mesaj= [NSString stringWithFormat:@"%@\n %@",continutmesaj,datafromatatamesaj];
            CGFloat widthWithInsetsApplied = self.view.frame.size.width -30;
            CGSize textSize = [compus_mesaj boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
            NECESARHeight =textSize.height+20; //20 +
            // inaltimerand =NECESARHeight;
            NSArray *pozeatasatemesajdelaserver = [[NSArray alloc]init];
            if(MINORDICT[@"images"])  pozeatasatemesajdelaserver =[NSArray arrayWithArray:MINORDICT[@"images"]];
            if(pozeatasatemesajdelaserver.count >0) {
                if( [[pozeatasatemesajdelaserver objectAtIndex:0]isKindOfClass:[NSDictionary class]] && [[pozeatasatemesajdelaserver objectAtIndex:0]respondsToSelector:@selector(allKeys)]) {
                    NSDictionary *detaliupoza =[pozeatasatemesajdelaserver objectAtIndex:0];
                    if(detaliupoza[@"tb"]) {
                        NECESARHeightIMAGINE = 240;
                    }
                }
            }
            
            ////jjjj vezi 60
            inaltimerand = NECESARHeight +NECESARHeightIMAGINE + 60;
        }
        return inaltimerand;
    }
    if(indexPath.section ==2 || indexPath.section ==3|| indexPath.section ==4 ) {
        int sectiune =(int)indexPath.section;
        if(indexPath.row == 0){
            inaltimerand = 54;
        }  else {
            NSDictionary *MAJORDICT = [[self.TOATE objectAtIndex:sectiune] objectAtIndex:0];
            if(MAJORDICT[@"SubItems"] ) {
                NSArray *minorrarray =MAJORDICT[@"SubItems"];
                NSDictionary *MINORDICT = [minorrarray objectAtIndex:indexPath.row-1]; //pentru ca 0 e nume,row e 1 si subitems incep pe 0
                NSString *rand1 =@"";
                if(MINORDICT[@"html"]) {
                    rand1 =[NSString stringWithFormat:@"%@",MINORDICT[@"html"]];
                    NSString *aux = [NSString stringWithFormat:@"<span style=\"font-family: HelveticaNeue; font-size: 16\">%@</span>", rand1];
                    NSAttributedString *attrString = [[NSAttributedString alloc] initWithData:[aux dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
                    NSString *final = [NSString stringWithFormat:@"%@", attrString.string];
                    CGFloat widthWithInsetsApplied = self.view.frame.size.width - 30;
                    CGSize textSize = [final boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
                    inaltimerand= textSize.height+60; //top... nu uita sa verifici pe 6
                }
            }
        }
        return inaltimerand;
    }
    // }
    return inaltimerand;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section]== 0) {
        cell.separatorInset = UIEdgeInsetsMake(0.f, 0.f, 0.f, cell.bounds.size.width);
    }
    else {
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    }
}
//#define METODA_COMMENT_VIEWED @"m=comment_viewed&p=" //se trimite ca s-a citit intrebarea

-(void)comment_viewed :(NSString *)AUTHTOKEN :(NSString *) messageid {
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
        [dic2 setObject:messageid forKey:@"messageid"];
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic2 options:0 error:&err];
        NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        compus =[NSString stringWithFormat:@"%@%@",METODA_COMMENT_VIEWED, myString];
        
        
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
                    NSLog(@"date comment viewed %@",multedate);
                    
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
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"";
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSInteger heisection =0;
    if(section ==0 || section ==6) { //nu vrem linii separatoare in  head oferta si pt footer
    heisection = 0;
    } else {
    heisection = 1;
    }
    return heisection;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [UIColor colorWithRed:(232/255.0) green:(232/255.0) blue:(232/255.0) alpha:1];
}

-(IBAction)debifeaza:(id)sender {
    UIButton* button = (UIButton*) [(UIGestureRecognizer *)sender view];
    button.selected = !button.selected;
    int ROWSELECT =(int)button.tag -100;
    NSLog(@"bifa tag %li",(long)button.tag);
    if(button.selected == YES) {
        NSDictionary *PIESA = [RANDURIOFERTA objectAtIndex:ROWSELECT];
        if(![self.pieseselectate containsObject:PIESA]) {
            [self.pieseselectate addObject:PIESA];
        }
    } else {
        NSDictionary *PIESA = [RANDURIOFERTA objectAtIndex:ROWSELECT];
        if([self.pieseselectate containsObject:PIESA]) {
            [self.pieseselectate removeObject:PIESA];
        }
    }
    NSLog(@"self.pieseselectate %@",self.pieseselectate);
}

-(IBAction)salveazalapreferateAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    NSMutableDictionary *trimitelaserver =[[NSMutableDictionary alloc]init];
    NSString  *offerta_id=@"";
    if(DETALIUOFERTA[@"messageid"]) {
        //offerta_id =@"1826649";
        offerta_id =  [NSString stringWithFormat:@"%@",DETALIUOFERTA[@"messageid"]];
    }
    utilitar = [[Utile alloc]init];
    NSString *authtoken=@"";
    BOOL elogat = NO;
    elogat = [utilitar eLogat];
    if(elogat) {
        authtoken = [utilitar AUTHTOKEN];
    }
    NSString  *valoare1sau0=@"";
    //     -(void)offerPrefered  :(NSString *)AUTHTOKEN :(NSDictionary *)OFFERTA_ID + sender
    if([button.titleLabel.text isEqualToString:@"Salvată la Preferate"]) {
        valoare1sau0= @"0";
        [trimitelaserver setObject:offerta_id forKey:@"offer_id"];
        [trimitelaserver setObject:valoare1sau0 forKey:@"valoare1sau0"];
        [self offerPrefered:authtoken :trimitelaserver:sender];
        
    } else {
        valoare1sau0= @"1";
        [trimitelaserver setObject:offerta_id forKey:@"offer_id"];
        [trimitelaserver setObject:valoare1sau0 forKey:@"valoare1sau0"];
        [self offerPrefered:authtoken :trimitelaserver:sender];
    }
}
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return UITableViewAutomaticDimension;
//}
-(IBAction)vezipozeOFERTA{
    NSLog(@"MERGI LA POZE ");
    if(DETALIUOFERTA[@"images"]) {
        NSArray *imagini = [NSArray arrayWithArray:DETALIUOFERTA[@"images"]];
        NSMutableArray *pozeoferta = [[NSMutableArray alloc]init];
        for(int i=0;i<imagini.count;i++) {
            NSDictionary *pozamea = [NSDictionary dictionaryWithDictionary:[imagini objectAtIndex:i]];
            if(pozamea[@"original"]) {
                [self addhud];
                NSString *stringurlthumbnail = [NSString stringWithFormat:@"%@", pozamea[@"original"]];
                UIImage *IHAVEIMAGE = [[UIImage alloc]init];
                IHAVEIMAGE = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: stringurlthumbnail]]];
                if(IHAVEIMAGE && IHAVEIMAGE.size.height >0) {
                    if(![pozeoferta containsObject:IHAVEIMAGE]) {
                        [pozeoferta addObject:IHAVEIMAGE];
                        [self removehud];
                    }
                }
            }
        }
        //just in case something goes wrong
        [self removehud];
        NSLog(@"pozeoferta  %@",pozeoferta);
        Galerieslide *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"GalerieslideVC"];
        vc.imagini =[[NSArray alloc]init];
        
        vc.imagini = [NSArray arrayWithArray:pozeoferta];
        [self.navigationController pushViewController:vc animated:NO ];
        
    }
    
    
}
/*
 #define METODA GET_ORDER_FORM @"m=get_order_form&p=" //preia detalii inainte de comanda
 echo 'm=get_order_form&p={"authtoken":"1248f7g573318edgJfkUe-bGdF_jiFmVpB2GoW_W7omHlcAEstY9NttcMj4","os":"iOS","lang":"ro","version":"9.0","offer_id":"1826672"}'  | curl --tlsv1 --cacert ./dev5.activesoft.crt --data @- -- https://dev5.activesoft.ro:277/
 {"errors":{},"data":{"first_name":"johnx","last_name":"doex","localitate_id":3,"address":"Str.dfhhhh ert","zip_code":"1335121","messageid":1826672,"cerere_id":342682,"offer_extra_info":{"shipping":{"ship_method_local_delivery":1,"ship_method_courier":0,"ship_courier_price":0,"ship_free_shipping":0,"ship_method_posta":0,"ship_posta_price":0,"ship_posta_free_shipping":0,"ship_handling_time":1,"ship_generic_shipping":""},"payment":[{"id":8,"title":"_plata_ramburs","name":"Ramburs"}],"guarantee":{"accept_guarantee":0,"guarantee_time":0,"guarantee_terms":null},"return":{"returnaccepted":0,"returnwithin":0,"return_ramburs":0,"return_replace":0,"return_transp_cost":0,"returnpolicy":""}},"is_deleted":"0","is_solved":"0","seller_username":"bogdanpsc","shipping":[{"name":"Ridicare personal\u0103","type":"local_delivery"}]}}
 
 */
// METODA GET_ORDER_FORM

-(void)get_order_form :(NSString *)AUTHTOKEN :(NSString*)OFFERID{
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
        NSString *ofertaid= OFFERID;
        [dic2 setObject:ofertaid forKey:@"offer_id"];
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic2 options:0 error:&err];
        NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        compus =[NSString stringWithFormat:@"%@%@",METODA_GET_ORDER_FORM, myString];
        
        
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
                    NSLog(@"date order form %@",multedate);
                    if(multedate[@"okmsg"]) {
                        NSString *mesajchangeemailserver=[NSString stringWithFormat:@"%@",multedate[@"okmsg"]];
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"PieseAuto"
                                                                            message:mesajchangeemailserver
                                                                           delegate:nil
                                                                  cancelButtonTitle:@"Ok"
                                                                  otherButtonTitles:nil];
                        [alertView show];
                    }
                    EcranFormularComanda *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"EcranFormularComandaVC"];
                    vc.METODELIVRARE = [[NSMutableArray alloc]init];
                    if(multedate[@"shipping"])vc.METODELIVRARE =multedate[@"shipping"];
                    vc.detaliuoferta =DETALIUOFERTA;
                    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                    del.MODPLATATEMPORAR =[[NSMutableDictionary alloc]init];
                    del.MODLIVRARETEMPORAR =[[NSMutableDictionary alloc]init];
                    del.CLONADATEUSER = [[NSMutableDictionary alloc]init];
                    [vc.detaliuoferta   setObject:self.pieseselectate forKey:@"items"];
                    [self.navigationController pushViewController:vc animated:YES ];
                    
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
-(IBAction)acceptaOfertaAction{
    NSLog(@"accepta oferta");
    utilitar = [[Utile alloc]init];
    NSString *authtoken=@"";
    BOOL elogat = NO;
    elogat = [utilitar eLogat];
    if(elogat) {
        authtoken = [utilitar AUTHTOKEN];
    }
    NSString  *offerta_id=@"";
    if(DETALIUOFERTA[@"messageid"]) {
        //offerta_id =@"1826649";
        offerta_id =  [NSString stringWithFormat:@"%@",DETALIUOFERTA[@"messageid"]];
    }
    
    [self get_order_form:authtoken :offerta_id];
    
    //  }
}
-(void)schimbaicon :(NSInteger) sectiune {
    NSLog(@"sectiunea x %i", (int)sectiune);
    NSInteger nrsectiune = sectiune -2; //pentru ca sectiunile expandabile incep de la 2 iar indexul din stareexpand incepe de la 0
    if([stareexpand objectAtIndex:nrsectiune]) {
        NSMutableDictionary *deschimbat = [NSMutableDictionary dictionaryWithDictionary:[stareexpand objectAtIndex:nrsectiune]];
        if([self checkDictionary:deschimbat]) {
            if(deschimbat[@"expand"]) {
                NSString *valoare = [NSString stringWithFormat:@"%@",deschimbat[@"expand"]];
                
                NSIndexPath *indexPathreload = [NSIndexPath indexPathForRow:0 inSection:sectiune];
                BOOL eselectat =NO;
                CellDetaliuOferta* cell = (CellDetaliuOferta*)[self.LISTASELECT cellForRowAtIndexPath:indexPathreload];
                NSString *valoaredschimbat =@"0";
                if([valoare isEqualToString:@"0"]) {
                    valoaredschimbat =@"1";
                    eselectat=YES;
                    
                } else {
                    valoaredschimbat =@"0";
                    eselectat =NO;
                }
                NSLog(@"vera %@",deschimbat[@"expand"]);
                [deschimbat setObject:valoaredschimbat forKey:@"expand"];
                [stareexpand replaceObjectAtIndex:nrsectiune withObject:deschimbat];
                cell.expandcollapsecell.selected=eselectat;
                [cell setNeedsLayout];
                [cell setNeedsDisplay];
            }
        }
    }
}

-(void)CollapseRowsSpecial:(NSArray*)ar
{
    NSLog(@"aaaaarrr %@",ar);
    int sectiune =5;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:5];
    NSLog(@"indexpath %@ %li", indexPath, (long)indexPath.section);
    
    for(NSDictionary *dInner in ar )
    {
        NSUInteger indexToRemove=[[self.TOATE objectAtIndex:sectiune] indexOfObjectIdenticalTo:dInner];
        NSArray *arInner=[dInner valueForKey:@"SubItems"];
        NSLog(@"indexToRemove %lu arInner %@",(unsigned long)indexToRemove, arInner);
        if(arInner && [arInner count]>0)
        {
            [self CollapseRowsSpecial:arInner];
        }
        if([[self.TOATE objectAtIndex:sectiune] indexOfObjectIdenticalTo:dInner]!=NSNotFound)
        {
            [self.LISTASELECT beginUpdates];
            [[self.TOATE objectAtIndex:sectiune] removeObjectIdenticalTo:dInner];
            [self.LISTASELECT deleteRowsAtIndexPaths:[NSArray arrayWithObject:
                                                      [NSIndexPath indexPathForRow:indexToRemove inSection:sectiune]
                                                      ]
                                    withRowAnimation:UITableViewRowAnimationFade];
            
            [self.LISTASELECT endUpdates];
            
        }
    }
    [self schimbaicon:sectiune];
    
}



-(void)CollapseRows:(NSArray*)ar :(int)sectiune :(id)sender
{
    NSLog(@"aaaaarrr %@",ar);
    CellDetaliuOferta *CELL = (CellDetaliuOferta *) [(UIGestureRecognizer *)sender view];
    CGRect buttonFrameInTableView = [CELL convertRect:CELL.bounds toView:self.LISTASELECT];
    NSIndexPath *indexPath = [self.LISTASELECT indexPathForRowAtPoint:buttonFrameInTableView.origin];
    NSLog(@"indexpath %@ %li", indexPath, (long)indexPath.section);
      for(NSDictionary *dInner in ar )
    {
        NSUInteger indexToRemove=[[self.TOATE objectAtIndex:sectiune] indexOfObjectIdenticalTo:dInner];
        NSArray *arInner=[dInner valueForKey:@"SubItems"];
        NSLog(@"indexToRemove %lu arInner %@",(unsigned long)indexToRemove, arInner);
        if(arInner && [arInner count]>0)
        {
            [self CollapseRows:arInner:sectiune:sender];
        }
        if([[self.TOATE objectAtIndex:sectiune] indexOfObjectIdenticalTo:dInner]!=NSNotFound)
        {
            [self.LISTASELECT beginUpdates];
            [[self.TOATE objectAtIndex:sectiune] removeObjectIdenticalTo:dInner];
            [self.LISTASELECT deleteRowsAtIndexPaths:[NSArray arrayWithObject:
                                                      [NSIndexPath indexPathForRow:indexToRemove inSection:sectiune]
                                                      ]
                                    withRowAnimation:UITableViewRowAnimationFade];
            
            [self.LISTASELECT endUpdates];
         }
    }
    [self schimbaicon:sectiune];
    
}

-(void)expandmesajespecial :(NSInteger) randulmeu{
    NSInteger sectiune =5;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:5];
    NSDictionary *d=[[self.TOATE objectAtIndex:sectiune]objectAtIndex:0] ;
    NSArray *arr=[d valueForKey:@"SubItems"];
    NSLog(@"SubItems %@",arr);
    if([d valueForKey:@"SubItems"])
    {
        BOOL isTableExpanded=NO;
        for(NSDictionary *subitems in arr )
        {
          NSInteger index=[[self.TOATE objectAtIndex:sectiune] indexOfObjectIdenticalTo:subitems];
            isTableExpanded=(index>0 && index!=NSIntegerMax);
            if(isTableExpanded) break;
        }
        
        if(isTableExpanded)
        {
            [self CollapseRowsSpecial:arr];
        }
        else
        {
            NSUInteger count=indexPath.row+1;
            NSMutableArray *arrCells=[NSMutableArray array];
            [self schimbaicon:sectiune];
            for(NSDictionary *dInner in arr )
            {
                [arrCells addObject:[NSIndexPath indexPathForRow:count inSection:5]];
                [[self.TOATE objectAtIndex:sectiune] insertObject:dInner atIndex:count++];
            }
            
            
            [self.LISTASELECT beginUpdates];
            [self.LISTASELECT insertRowsAtIndexPaths:arrCells withRowAnimation:UITableViewRowAnimationFade];
            [self.LISTASELECT endUpdates];
            [self.LISTASELECT scrollToRowAtIndexPath:indexPath atScrollPosition:randulmeu animated:YES];
            ////////[self veziultimulcommentnecitit];
            NSLog(@"zeus");
        }
    }
    NSLog(@"never %li", (long)sectiune);
}
-(void)veziultimulcommentnecitit {
    NSMutableDictionary *d= [NSMutableDictionary dictionaryWithDictionary:[[self.TOATE objectAtIndex:5]objectAtIndex:0]];
    NSMutableArray *catenecitite = [[NSMutableArray alloc]init];
    NSArray *arr=[d valueForKey:@"SubItems"];
    for(int i=0;i< arr.count; i++) {
        NSDictionary *commentview = [arr objectAtIndex:i];
        if(commentview[@"is_viewed"]) {
            NSString *is_viewed =  [NSString stringWithFormat:@"%@",commentview[@"is_viewed"]];
            if(is_viewed.integerValue==0) {
                if(![catenecitite containsObject:commentview]) {
                    [catenecitite addObject:commentview];
                }
            }
        }
    }
    if(catenecitite.count >0) {
        NSMutableArray *finaletoatecitite= [[NSMutableArray alloc]init];
        
        for(int i=0;i< arr.count; i++) {
            NSDictionary *commentview = [arr objectAtIndex:i];
            NSMutableDictionary *comentcopie = [NSMutableDictionary dictionaryWithDictionary:commentview];
            [comentcopie setObject:@"1" forKey:@"is_viewed"];
            if(![finaletoatecitite containsObject:comentcopie]) {
                [finaletoatecitite addObject:comentcopie];
            }
        }
        [d setObject:finaletoatecitite forKey:@"SubItems"];
        [[self.TOATE objectAtIndex:5] replaceObjectAtIndex:0 withObject:d];
        [self.LISTASELECT reloadData];
        
        NSDictionary *lastid= [catenecitite lastObject];
        if(lastid[@"messageid"]) {
            NSString *messageid = [NSString stringWithFormat:@"%@",lastid[@"messageid"]];
            utilitar = [[Utile alloc]init];
            NSString *authtoken=@"";
            BOOL elogat = NO;
            elogat = [utilitar eLogat];
            if(elogat) {
                authtoken = [utilitar AUTHTOKEN];
                [self comment_viewed:authtoken :messageid];
            }
        }
    }
}

-(IBAction)expandsaustrangerows:(id)sender {
    CellDetaliuOferta *CELL = (CellDetaliuOferta *) [(UIGestureRecognizer *)sender view]; //cell.backgroundview
    NSLog(@"cell tag %i", (int)CELL.expandcollapsecell.tag);
    int sectiune =(int)CELL.expandcollapsecell.tag;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:
                              sectiune];
    // CELL.expandcollapsecell.selected =!CELL.expandcollapsecell.selected;
    // UIView* btn = CELL.backgroundView;
    // CGRect buttonFrameInTableView = [btn convertRect:btn.bounds toView:self.LISTASELECT];
    // CGRect buttonFrameInTableView = [CELL.backgroundView convertRect:CELL.backgroundView.bounds toView:self.LISTASELECT];
    
    
    if(sectiune ==-100) {
        [self trimitemesaj];
    } else if(sectiune ==2 ||sectiune ==3 || sectiune ==4 || sectiune ==5 ) {
        
        NSDictionary *d=[[self.TOATE objectAtIndex:sectiune]objectAtIndex:0] ;
        NSArray *arr=[d valueForKey:@"SubItems"];
        //jNSLog(@"SubItems %@",arr);
        if([d valueForKey:@"SubItems"])
        {
            BOOL isTableExpanded=NO;
            for(NSDictionary *subitems in arr )
            {
                //jNSLog(@"subitems %@",subitems);
                NSInteger index=[[self.TOATE objectAtIndex:sectiune] indexOfObjectIdenticalTo:subitems];
                isTableExpanded=(index>0 && index!=NSIntegerMax);
                if(isTableExpanded) break;
            }
            if(isTableExpanded)
            {
                [self CollapseRows:arr:sectiune:sender];
            }
            else
            {
                NSUInteger count=indexPath.row+1;
                NSMutableArray *arrCells=[NSMutableArray array];
                [self schimbaicon:sectiune];
                for(NSDictionary *dInner in arr )
                {
                    [arrCells addObject:[NSIndexPath indexPathForRow:count inSection:sectiune]];
                    [[self.TOATE objectAtIndex:sectiune] insertObject:dInner atIndex:count++];
                }
                [self.LISTASELECT beginUpdates];
                [self.LISTASELECT insertRowsAtIndexPaths:arrCells withRowAnimation:UITableViewRowAnimationFade];//UITableViewRowAnimationTop
                [self.LISTASELECT endUpdates];
                [self veziultimulcommentnecitit];
            }
        }
    }
    NSLog(@"never %i", sectiune);
}

-(void)doneWithNumberPad {
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableArray *RANDURI = [[NSMutableArray alloc]init];
    NSDictionary *CORPEXPANDABIL =[NSDictionary dictionaryWithDictionary: [[self.TOATE objectAtIndex:5]objectAtIndex:0]];
    if( CORPEXPANDABIL[@"SubItems"]) {  RANDURI=[NSMutableArray arrayWithArray:CORPEXPANDABIL[@"SubItems"]];
    }
    NSInteger ipx=0;
    NSInteger totalRow = RANDURI.count;
    ipx = totalRow-1;
    NSIndexPath *indexPathreload = [NSIndexPath indexPathForRow:ipx inSection:5];
    CellDetaliuOferta *updateCell = (CellDetaliuOferta *)[self.LISTASELECT cellForRowAtIndexPath:indexPathreload];
    if ([updateCell.compunetextmesaj.text isEqualToString:@""]) {
        updateCell.compunetextmesaj.text =  @"Mesaj către vânzător";
        updateCell.compunetextmesaj.textColor = [UIColor lightGrayColor]; //optional
    } else {
        updateCell.compunetextmesaj.textColor = [UIColor blackColor];
    }
    del.TEXTMESAJTEMPORAR =updateCell.compunetextmesaj.text;
    [updateCell.compunetextmesaj resignFirstResponder];
    [self.view endEditing:YES];
}



//-(void)textViewDidChange:(UITextView *)textView
//{
//
//    
//   
////    NSMutableArray *RANDURI = [[NSMutableArray alloc]init];
////    NSDictionary *CORPEXPANDABIL =[NSDictionary dictionaryWithDictionary: [[self.TOATE objectAtIndex:5]objectAtIndex:0]];
////    if( CORPEXPANDABIL[@"SubItems"]) {  RANDURI=[NSMutableArray arrayWithArray:CORPEXPANDABIL[@"SubItems"]];
////    }
////    NSInteger ipx=0;
////    NSInteger totalRow = RANDURI.count;
////    ipx = totalRow-1;
////    NSIndexPath *indexPathreload = [NSIndexPath indexPathForRow:ipx inSection:5];
////    CellDetaliuOferta *updateCell = (CellDetaliuOferta *)[self.LISTASELECT cellForRowAtIndexPath:indexPathreload];
////    if ([updateCell.compunetextmesaj.text isEqualToString:@""]) {
////        updateCell.compunetextmesaj.text =  @"Mesaj către vânzător";
////        updateCell.compunetextmesaj.textColor = [UIColor lightGrayColor];
////        [updateCell.compunetextmesaj resignFirstResponder];
////    } else {
////        updateCell.compunetextmesaj.textColor = [UIColor blackColor];
////    }
////    
////    NSLog(@"Dilip : %@",textView.text);
////    CGSize sizeToFitIn = CGSizeMake(textView.bounds.size.width, MAXFLOAT);
////    CGSize newSize = [textView sizeThatFits:sizeToFitIn];
////    double heightrow = newSize.height;
////    
////    NSLog(@"heightrow specx %f",heightrow);
////    
////    if(heightrow < 48) {
////        updateCell.dynamicTEXTVIEWHEIGHT.constant =48;
////    } else {
////        updateCell.dynamicTEXTVIEWHEIGHT.constant =heightrow;
////    }
////    [self.LISTASELECT beginUpdates];
////    updateCell.dynamicTEXTVIEWHEIGHT.constant =heightrow;
////    updateCell.dynamicCOMPUNEROWHEIGHT.constant =heightrow+30;
////    updateCell.dynamicLINIEGRIHEIGHT.constant =heightrow+30;
////    cellheightmodificatoferta = heightrow;
////    [updateCell setNeedsLayout];
////    [updateCell layoutIfNeeded];
////    [self.LISTASELECT endUpdates];
////     AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
////     del.TEXTMESAJTEMPORAR =updateCell.compunetextmesaj.text;
//    
//    
//}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    NSMutableArray *RANDURI = [[NSMutableArray alloc]init];
    NSDictionary *CORPEXPANDABIL =[NSDictionary dictionaryWithDictionary: [[self.TOATE objectAtIndex:5]objectAtIndex:0]];
    if( CORPEXPANDABIL[@"SubItems"]) {  RANDURI=[NSMutableArray arrayWithArray:CORPEXPANDABIL[@"SubItems"]];
    }
    NSInteger ipx=0;
    NSInteger totalRow = RANDURI.count;
    ipx = totalRow-1;
    NSIndexPath *indexPathreload = [NSIndexPath indexPathForRow:ipx inSection:5];
    CellDetaliuOferta *updateCell = (CellDetaliuOferta *)[self.LISTASELECT cellForRowAtIndexPath:indexPathreload];
    
    if ([updateCell.compunetextmesaj.text isEqualToString: @"Mesaj către vânzător"]) {
        updateCell.compunetextmesaj.text = @"";
        updateCell.compunetextmesaj.textColor = [UIColor blackColor];
    }

//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:5]; // sa urce peste keyboard
    [self.LISTASELECT scrollToRowAtIndexPath:indexPathreload atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /// AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSInteger ipx = indexPath.row;
    
    NSLog(@"ipx ofer %li", (long)ipx);
    NSArray *ofertaROW =[[NSArray alloc]init];
    CellDetaliuOferta *cell = [self createcell];
    
    for (CAShapeLayer *sublayer in cell.fundalmesaj.layer.sublayers) {
        if([sublayer isKindOfClass:[ClockFace class]]){
            [sublayer removeFromSuperlayer];
        }
    }
    
    
    for (UIImageView *sublayer in cell.contentView.subviews) {
        if([sublayer isKindOfClass:[IMAGINESERVER class]]){
            [sublayer removeFromSuperview];
        }
    }
    //SpecialText
    for (UILabel *specialtext in cell.contentView.subviews) {
        if([specialtext isKindOfClass:[SpecialText class]]){
            [specialtext removeFromSuperview];
        }
    }
     cell.sageataGri3.hidden=YES;
    //vasile

    cell.compunetextmesaj.delegate =self;
    
   // [cell.compunetextmesaj setTextContainerInset:UIEdgeInsetsZero];
    cell.contentView.frame = cell.bounds;
    ofertaROW = [[self TOATE] objectAtIndex:[indexPath section]];
    cell.pozamesajdejatrimis.hidden=YES;
    /////  NSLog(@"sectionContents %@", ofertaROW);
   // cell.TitluRand.text = [NSString stringWithFormat:@"%i",(int)ofertaROW.count];
    self.LISTASELECT.allowsMultipleSelection =NO;
    // echo 'm=prefered_offer&p={"os":"iOS","lang":"ro","authtoken":"1248f7g57051f23gqf9ZSL2qTKiEbDmhgjYVLfFmbc8cm6UBR0ekyW-HP28","version":"9.0","offer_id":"1826653","is_prefered":"1"}'  | curl --tlsv1 --cacert ./dev5.activesoft.crt --data @- -- https://dev5.activesoft.ro:277/
    
    // echo 'm=tutorial&p={"os":"iOS","lang":"ro","authtoken":"1248f7g57051f23gqf9ZSL2qTKiEbDmhgjYVLfFmbc8cm6UBR0ekyW-HP28","version":"9.0"}'  | curl --tlsv1 --cacert ./dev5.activesoft.crt --data @- -- https://dev5.activesoft.ro:277/
    
    
    //  cell.contentView.layer.mask = shapeLayer;
    
    cell.bluecell.hidden =YES; //icons
    cell.titlurandul2.hidden=YES;
    cell.titlurandulextra.hidden=YES;
    if ([indexPath section]== 0) {
        
        self.LISTASELECT.allowsMultipleSelection =YES;
        cell.icontelefon.hidden=YES;
        cell.stelutacalificative.hidden=YES;
        cell.catecalificative.hidden=YES;
        cell.telefonuser.hidden=YES;
        cell.bifablue.hidden=YES;
        cell.TitluRand.hidden=NO;
        cell.tipoferta.hidden=NO;
        cell.pretoferta.hidden =NO;
        //        [cell.bifablue setImage:[UIImage imageNamed:@"Checkbox_unchecked_blue_72x72.png"] forState:UIControlStateNormal];
        //        [cell.bifablue setImage:[UIImage imageNamed:@"Checkbox_checked_blue_72x72.png"] forState:UIControlStateSelected];
        //        UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(debifeaza:)];
        //        [singleTap setNumberOfTapsRequired:1];
        //        [cell.bifablue  setUserInteractionEnabled:YES];
        //        [cell.bifablue  addGestureRecognizer:singleTap];
        //        cell.bifablue.selected=YES;
        cell.contentView.backgroundColor =[UIColor whiteColor];
        cell.bifablue.tag = ipx+100;
        // cell.separatorInset = UIEdgeInsetsMake(0.f, 0.f, 0.f, cell.bounds.size.width);
        cell.dynamiccellLEFT.constant =10;
        cell.TitluRand.textColor=[UIColor blackColor];
        cell.toptitlurand.constant  =10;
        cell.toppoza.constant =4;
        cell.verdetop.hidden=YES;
        if(ipx==0 ) {
            //            cell.heighttitlurand.constant = inaltimerand;
            if(arewinner ==YES) {
                cell.verdetop.hidden=NO;
                cell.toptitlurand.constant  =42;
                cell.toppoza.constant =41;
                
            } else {
                cell.toptitlurand.constant  =10;
                cell.toppoza.constant =4;
                cell.verdetop.hidden=YES;
            }
            //cell.dynamiccellLEFT.constant =46;
            //               cell.pozaRow.image = [UIImage imageNamed:@"badge_red.png"];
            //
            //            cell.pozaRow.hidden=NO;
            NSLog(@"000000000");
            if(DETALIUOFERTA[@"images"]) {
                NSLog(@"DETALIUOFERTA images %@",DETALIUOFERTA[@"images"]);
                
                NSArray *imagini = [NSArray arrayWithArray:DETALIUOFERTA[@"images"]];
                if(imagini.count >0) {
                    NSDictionary *imagine = [imagini objectAtIndex:0];
                    if(imagine[@"tb"]) {
                        NSString *stringurlthumbnail = [NSString stringWithFormat:@"%@", imagine[@"tb"]];
                        [cell.pozaRow sd_setImageWithURL:[NSURL URLWithString:stringurlthumbnail]
                                        placeholderImage:nil //[UIImage imageNamed:@"redblock.png"]
                                               completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                   //  ... completion code here ...
                                                   if(image) {
                                                       cell.pozaRow.image = image;
                                                       cell.pozaRow.hidden =NO;
                                                       cell.dynamiccellLEFT.constant =46;
                                                   }
                                               }];
                    }
                    UITapGestureRecognizer *singleTapPOZE =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(vezipozeOFERTA)];
                    [singleTapPOZE setNumberOfTapsRequired:1];
                    [cell.pozaRow  setUserInteractionEnabled:YES];
                    [cell.pozaRow  addGestureRecognizer:singleTapPOZE];
                }
            }
        }
        
        NSMutableArray *RANDURI=RANDURIOFERTA;
        NSDictionary *la0 = [RANDURI objectAtIndex:ipx];
        NSString *C_titlu = [NSString stringWithFormat:@"%@",la0[@"description"]];
        cell.TitluRand.font =[UIFont boldSystemFontOfSize: 18];
        NSInteger rightsize =  cell.dynamiccellLEFT.constant;
        
        
        CGFloat widthWithInsetsApplied = self.view.frame.size.width;
        if(rightsize == 46) {
         widthWithInsetsApplied = self.view.frame.size.width -46;
        } else {
         widthWithInsetsApplied = self.view.frame.size.width -20;
        }
        CGSize textSize = [C_titlu boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18]} context:nil].size;
        double inaltimerand= textSize.height;
        UIFont *tester = [UIFont boldSystemFontOfSize:18];
        double numberOfLines = textSize.height /tester.pointSize;
        if(numberOfLines <2) {
            if(rightsize == 46) {
            inaltimerand = 46;
            } else {
            inaltimerand =24;
            }
            cell.heighttitlurand.constant = inaltimerand;
        } else {
            cell.heighttitlurand.constant = inaltimerand+10;
        }
        cell.TitluRand.text = C_titlu;
        cell.TitluRand.verticalAlignment =TTTAttributedLabelVerticalAlignmentTop;
        cell.pretoferta.verticalAlignment=TTTAttributedLabelVerticalAlignmentTop;
        cell.TitluRand.numberOfLines = 0;
        
        NSString *C_leisaualtavaluta =@"";
        NSString *C_pret=@"";
        NSString *C_um =@"";
        NSString *C_tipnousecond =@"";
        NSString *C_instocsaulacomanda =@"";
        NSString *C_cufacturasaufara =@"";
        
        if(la0[@"currency_id"]) {
            NSString *Curencyid= [NSString stringWithFormat:@"%@",la0[@"currency_id"]];
            NSDictionary *curencydinbaza = [NSDictionary dictionaryWithDictionary:[DataMasterProcessor getCURRENCY:Curencyid]];
            if(curencydinbaza[@"name"]) {
                C_leisaualtavaluta= [NSString stringWithFormat:@"%@",curencydinbaza[@"name"]];
            }
        }
        if(la0[@"price"]) {
            C_pret= [NSString stringWithFormat:@"%@",la0[@"price"]];
        }
        if(la0[@"um"]) {
            C_um= [NSString stringWithFormat:@"%@",la0[@"um"]];
        }
        NSString *compus_pret_um= [NSString stringWithFormat:@"%@ %@/ %@", C_pret,C_leisaualtavaluta,C_um];
        NSRange bigRange = [compus_pret_um rangeOfString:C_pret];
        NSRange mediumRange = [compus_pret_um rangeOfString:C_leisaualtavaluta];
        NSRange smallRange = [compus_pret_um rangeOfString:C_um];
        NSMutableAttributedString * attributedString= [[NSMutableAttributedString alloc] initWithString:compus_pret_um];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize: 16] range:bigRange];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:10] range:mediumRange];
        [attributedString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:mediumRange];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:smallRange];
        cell.pretoferta.attributedText=attributedString;
        if(DETALIUOFERTA[@"new_sh"]) {
            NSString *valoaretipnousecond= [NSString stringWithFormat:@"%@",DETALIUOFERTA[@"new_sh"]];
            if(valoaretipnousecond.integerValue ==1) {
                C_tipnousecond =@"Piesă nouă";
            }
            if(valoaretipnousecond.integerValue ==2) {
                C_tipnousecond =@"Piesă second";
            }
        }
        
        if(DETALIUOFERTA[@"availability"]) {
            NSString *instocsaulacomanda= [NSString stringWithFormat:@"%@",DETALIUOFERTA[@"availability"]];
            if(instocsaulacomanda.integerValue ==1) {
                C_instocsaulacomanda =@"în stoc";
            }
            if(instocsaulacomanda.integerValue ==2) {
                C_instocsaulacomanda =@"la comandă";
            }
        }
        if(DETALIUOFERTA[@"billing"]) {
            NSString *billing= [NSString stringWithFormat:@"%@",DETALIUOFERTA[@"billing"]];
            if(billing.integerValue ==1) {
                C_cufacturasaufara =@"cu factură:";
            }
            if(billing.integerValue ==0) {
                C_cufacturasaufara =@"fără factură:";
            }
        }
        NSMutableArray *compunere = [[NSMutableArray alloc]init];
        if(![self MyStringisEmpty:C_tipnousecond]) {
            [compunere addObject:C_tipnousecond];
        }
        if(![self MyStringisEmpty:C_instocsaulacomanda]) {
            [compunere addObject:C_instocsaulacomanda];
        }
        if(![self MyStringisEmpty:C_cufacturasaufara]) {
            [compunere addObject:C_cufacturasaufara];
        }
        NSString *COMPUS =  [compunere componentsJoinedByString:@", "];
        cell.tipoferta.text =COMPUS;
        cell.tipoferta.numberOfLines =2;
        
        //  [cell.tipoferta sizeToFit];
        
        
        
    }
    
    /*
     Valori "company.type":
     - shop = magazin piese auto
     - park = parc de dezmembrari
     
     user =     {
     company =         {
     fax = 0365815214;
     "friendly_name" = Dogaru;
     "logo_img_url" = "http://www.pieseauto.ro/poze/dogaru/dogaru-8c9f51472cac0f33d7-120-70-2-95-1.jpg";
     name = "SC Stil Servimpex SRL";
     phone = "0744112721 ; 0741092441";
     type = park;
     url = "http://dev5.activesoft.ro/~csaba/4tilance/parcuri-dezmembrari/mures/targu-mures/dogaru-23.html";
     };
     "first_name" = Corneliu;
     "last_name" = Dogar;
     phone1 = 0744112721;
     phone2 = "";
     phone3 = "";
     phone4 = "";
     score = 426;
     "score_percent" = "99.8";
     seller = 2;
     "stars_class" = "stars_purple";
     "user_id" = 98629;
     username = codogar;
     };
     
     */
    
    if ([indexPath section]== 1) {
        cell.randul1.hidden=NO;
        cell.catecalificative.hidden=NO;
        [cell.contentView bringSubviewToFront:cell.randul1];
        NSDictionary *dateuser =[NSDictionary dictionaryWithDictionary:[RANDOFERTANT objectAtIndex:0]];
        NSDictionary *companie =[[NSDictionary alloc]init];
        cell.contentView.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1] ;
        NSString *titlurandofertant =@""; //oferta facuta de
        NSString *numeofertant =@"";
        NSString *telefonofertant =@"";
        NSString *seller =@"";
        NSString *labelofertant =@"";
        NSString *score_percent =@"";
        NSString *stars_class =@"";
        NSString *NUME_IMAGINE_stars_class =@"";
        BOOL usernormal = YES;
        NSInteger inttipofertant =0;
        
        if(dateuser[@"seller"]) {
            seller =[NSString stringWithFormat:@"%@",dateuser[@"seller"]];
            inttipofertant = seller.integerValue;
            
            if(dateuser[@"username"])     numeofertant= [NSString stringWithFormat:@"%@",dateuser[@"username"]];
            if(dateuser[@"company"] && [self checkDictionary:dateuser[@"company"]] &&inttipofertant >0) {
                companie = dateuser[@"company"];
                NSLog(@"companie din oferta %@",companie);
                if(companie[@"type"]) seller= [NSString stringWithFormat:@"%@",companie[@"type"]];
                if([seller isEqualToString:@"shop"]) labelofertant =@"magazin piese auto";
                if([seller isEqualToString:@"park"]) labelofertant =@"parc de dezmembrări";
                usernormal =NO;
            } else {
                usernormal =YES;
            }
        }
        if(dateuser[@"score"])     score_percent= [NSString stringWithFormat:@"%@",dateuser[@"score"]];
        if(dateuser[@"phone1"])     telefonofertant= [NSString stringWithFormat:@"%@",dateuser[@"phone1"]];
        if(dateuser[@"stars_class"])     stars_class= [NSString stringWithFormat:@"%@",dateuser[@"stars_class"]];
        if(![self MyStringisEmpty:stars_class]) {
            cell.stelutacalificative.hidden=NO;
            if([stars_class isEqualToString:@"stars_green"])   NUME_IMAGINE_stars_class =@"Icon_Steluta_User_01_180x180.png";
            if([stars_class isEqualToString:@"stars_blue"])    NUME_IMAGINE_stars_class =@"Icon_Steluta_User_02_180x180.png";
            if([stars_class isEqualToString:@"stars_purple"])  NUME_IMAGINE_stars_class =@"Icon_Steluta_User_03_180x180.png";
            if([stars_class isEqualToString:@"stars_orange"])  NUME_IMAGINE_stars_class =@"Icon_Steluta_User_04_180x180.png";
            if([stars_class isEqualToString:@"stars_silver"])  NUME_IMAGINE_stars_class =@"icon_vanzator_silver_144x144.png";
            cell.stelutacalificative.image = [UIImage imageNamed:NUME_IMAGINE_stars_class];
            
        } else {
            cell.stelutacalificative.hidden=YES;
        }
        titlurandofertant= [NSString stringWithFormat:@"Ofertă facută de %@:",labelofertant];
        cell.titlurandul1.text =titlurandofertant;
        [cell.titlurandul1 sizeToFit];
        
        cell.numeofertant.text =numeofertant;
        cell.numeofertant.textColor =[UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1];
        [cell.numeofertant sizeToFit];
        
        cell.telefonuser.text =telefonofertant;
        cell.catecalificative.text =score_percent;
        cell.stelutacalificative.hidden=NO;
        cell.telefonuser.hidden=NO;
        cell.icontelefon.hidden=NO;
        cell.numeofertant.hidden=NO;
        cell.titlurandul1.hidden=NO;
       
        cell.tag =102;
        
    }
    
    ///GARANTIE
    if (indexPath.section== 2 || indexPath.section== 3 ||indexPath.section==4) {
        int sectiune =(int)indexPath.section;
        
        if([stareexpand objectAtIndex:sectiune-2]) {
            NSMutableDictionary *deschimbat = [NSMutableDictionary dictionaryWithDictionary:[stareexpand objectAtIndex:sectiune-2]];
            if([self checkDictionary:deschimbat]) {
                if(deschimbat[@"expand"]) {
                    NSString *valoare = [NSString stringWithFormat:@"%@",deschimbat[@"expand"]];
                    if([valoare isEqualToString:@"0"]) {
                        cell.expandcollapsecell.selected =NO;
                    } else {
                        cell.expandcollapsecell.selected =YES;
                    }
                }
            }
        }
        
        NSDictionary *specificaDETALII =[[self.TOATE objectAtIndex:sectiune]objectAtIndex:0];
        ///////  NSLog(@"specificadet %@",specificaDETALII);
        cell.toptitlurand.constant =20;
        NSMutableArray *RANDURI = [[NSMutableArray alloc]init];
        NSDictionary *specialitem= [[NSDictionary alloc]init];
        RANDURI=specificaDETALII[@"SubItems"];
        specialitem =[RANDURI objectAtIndex:0]; //pentru ca 0 e nume iar subitems au acelasi nivel in structura ca si nume [0]
        
        NSString *rand1 =@"";
        if(specialitem[@"html"]) rand1 =[NSString stringWithFormat:@"%@",specialitem[@"html"]];
        NSString *aux = [NSString stringWithFormat:@"<span style=\"font-family: HelveticaNeue; font-size: 16\">%@</span>", rand1];
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithData:[aux dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        NSString *final = [NSString stringWithFormat:@"%@", attrString.string];
        if(ipx==0 ) {
            cell.expandcollapsecell.tag=indexPath.section;
            cell.TitluRand.hidden=YES;
            cell.titlurandulextra.hidden=NO;
            cell.titlurandulextra.textColor=[UIColor blackColor];
            cell.contentView.backgroundColor = [UIColor whiteColor] ;
            cell.titlurandul2.hidden=YES;
            NSString *label_name =@"";
            NSString *label_value =@"";
            NSString *html =@"";
            if(specificaDETALII[@"label_name"]) label_name =[NSString stringWithFormat:@"%@:",specificaDETALII[@"label_name"]];
            if(specificaDETALII[@"label_value"]) label_value =[NSString stringWithFormat:@"%@",specificaDETALII[@"label_value"]];
            if(specificaDETALII[@"html"]) html =[NSString stringWithFormat:@"%@",specificaDETALII[@"html"]];
            NSString *compus_titlu_rand= [NSString stringWithFormat:@"%@ %@",label_name,label_value];
            NSRange bigRange = [compus_titlu_rand rangeOfString:label_name];
            NSRange mediumRange = [compus_titlu_rand rangeOfString:label_value];
            NSMutableAttributedString * attributedString= [[NSMutableAttributedString alloc] initWithString:compus_titlu_rand];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize: 19] range:bigRange];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:mediumRange];
            cell.contentView.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1] ;
            cell.titlurandulextra.attributedText=attributedString;
            cell.titlurandulextra.numberOfLines =1;
            if(![self MyStringisEmpty:rand1]) {
                cell.expandcollapsecell.hidden=NO;
                cell.expandcollapsecell.userInteractionEnabled=NO;
            } else {
                cell.expandcollapsecell.hidden=YES;
                cell.expandcollapsecell.userInteractionEnabled=NO;
            }
            cell.titlurandulextra.userInteractionEnabled=NO;
            UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(expandsaustrangerows:)];
            [singleTap setNumberOfTapsRequired:1];
            [cell  addGestureRecognizer:singleTap];
            //aici doar programatic vezi in didload ca are nevoie sa faca expand cells automat
            
            
            
            
        } else {
            cell.expandcollapsecell.tag=-5;
            cell.titlurandulextra.hidden=YES;
            cell.TitluRand.hidden=YES;
            cell.titlurandul2.hidden=NO;
            
            cell.titlurandul2.textColor=[UIColor blackColor];
            cell.expandcollapsecell.hidden=YES;
            cell.expandcollapsecell.userInteractionEnabled=NO;
            cell.toptitlurand.constant =20;
            cell.titlurandul2.attributedText=attrString;
            CGFloat widthWithInsetsApplied = self.view.frame.size.width - 30;
            double inaltimerand=0;
            CGSize textSize = [final boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
            inaltimerand= textSize.height+55;
            cell.titlurandul2.numberOfLines =0;
            cell.dynamictableheightJ.constant = inaltimerand; //the key for succes in not here :))
            cell.contentView.backgroundColor = [UIColor colorWithRed:(232/255.0) green:(232/255.0) blue:(232/255.0) alpha:1] ;
        }
    }
    //////MESAJE
    if(indexPath.section ==5) {
        cell.continutmesaj.hidden=YES;
        NSInteger sectiune =indexPath.section;
        if([stareexpand objectAtIndex:sectiune-2]) {
            NSMutableDictionary *deschimbat = [NSMutableDictionary dictionaryWithDictionary:[stareexpand objectAtIndex:sectiune-2]];
            if([self checkDictionary:deschimbat]) {
                if(deschimbat[@"expand"]) {
                    NSString *valoare = [NSString stringWithFormat:@"%@",deschimbat[@"expand"]];
                    if([valoare isEqualToString:@"0"]) {
                        cell.expandcollapsecell.selected =NO;
                    } else {
                        cell.expandcollapsecell.selected =YES;
                    }
                }
            }
        }
        NSDictionary *CORPEXPANDABIL =[NSDictionary dictionaryWithDictionary: [[self.TOATE objectAtIndex:sectiune]objectAtIndex:0]];
        cell.icontelefon.hidden=YES;
        cell.stelutacalificative.hidden=YES;
        cell.contentView.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1] ;
        cell.catecalificative.hidden=YES;
        cell.telefonuser.hidden=YES;
        cell.bifablue.hidden=YES;
        NSMutableArray *RANDURI = [[NSMutableArray alloc]init];
        
        if( CORPEXPANDABIL[@"SubItems"]) {  RANDURI=[NSMutableArray arrayWithArray:CORPEXPANDABIL[@"SubItems"]];
        }
        NSLog(@"randurile %@ si count %lu",RANDURI,(unsigned long)RANDURI.count);
        NSString *comments_count=@"0";
        NSString *comments_unread_count=@"0";
        NSInteger totalRow = RANDURI.count; // sunt toate comentariile + 1 [text mesaj]  +1 rand pentru trimite mesaj
        if(ipx==0 ) {
            cell.expandcollapsecell.tag=indexPath.section;
            cell.expandcollapsecell.hidden=NO;
            cell.expandcollapsecell.userInteractionEnabled=NO;
            cell.expandcollapsecell.tag=indexPath.section;
            cell.TitluRand.hidden=YES;
            cell.titlurandulextra.hidden=NO;
            cell.titlurandulextra.textColor=[UIColor blackColor];
            cell.contentView.backgroundColor = [UIColor whiteColor] ;
            cell.titlurandul2.hidden=YES;
            
            NSString *numerand =[NSString stringWithFormat:@"%@",CORPEXPANDABIL[@"label_name"]];
            if(CORPEXPANDABIL[@"comments_count"]) comments_count = [NSString stringWithFormat:@"%@",CORPEXPANDABIL[@"comments_count"]];
            if(CORPEXPANDABIL[@"comments_unread_count"]) comments_unread_count = [NSString stringWithFormat:@"%@",CORPEXPANDABIL[@"comments_unread_count"]];
            
            // cell.toptitlurand.constant =20;
            cell.contentView.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1] ;
            cell.titlurandulextra.text=numerand;
            cell.titlurandulextra.numberOfLines =1;
            cell.titlurandulextra.textColor=[UIColor blackColor];
            cell.titlurandulextra.hidden=NO;
            cell.titlurandulextra.font = [UIFont boldSystemFontOfSize: 19];
            [cell.titlurandulextra sizeToFit];
            CGRect nrtotaleframe =cell.titlurandulextra.frame;
            UILabel *catetotal = [[UILabel alloc]init];
            CGRect framenecesar = CGRectMake(nrtotaleframe.origin.x+ nrtotaleframe.size.width +12,cell.titlurandulextra.frame.origin.y+4, 25, 25);
            
            catetotal.frame = framenecesar;
            catetotal.text = comments_count;
            CustomBadge1 *badge = [CustomBadge1 customBadgeWithString:comments_count:framenecesar:[UIColor whiteColor]];
            badge.hidden =NO;
            [cell.contentView addSubview:badge];
            if(comments_unread_count.integerValue ==0) {
                //do nothing
            } else {
                CGRect framenecesar1 = CGRectMake(catetotal.frame.origin.x+ catetotal.frame.size.width +10,cell.titlurandulextra.frame.origin.y+4, 25, 25);
                NSString *mybadgenr = comments_unread_count;
                CustomBadge *badge1 = [CustomBadge customBadgeWithString:mybadgenr:framenecesar1];
                badge1.hidden =NO;
                [cell.contentView addSubview:badge1];
                
            }
            UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(expandsaustrangerows:)];
            [singleTap setNumberOfTapsRequired:1];
            [cell  addGestureRecognizer:singleTap];
            ///////[cell.expandcollapsecell  addGestureRecognizer:singleTap];
            
        } else  if(RANDURI.count==3 && ipx == totalRow-2) { //stim ca nu sunt mesaje
             cell.expandcollapsecell.tag=-5;
             // cell.expandcollapsecell.tag=indexPath.section;
            cell.expandcollapsecell.hidden=YES;
            cell.expandcollapsecell.userInteractionEnabled=NO;
            cell.expandcollapsecell.tag=indexPath.section;
            cell.TitluRand.hidden=YES;
            cell.titlurandulextra.hidden=NO;
            cell.titlurandulextra.textColor=[UIColor blackColor];
            //cell.titlurandulextra.backgroundColor = [UIColor clearColor];
            cell.contentView.backgroundColor = [UIColor colorWithRed:(232/255.0) green:(232/255.0) blue:(232/255.0) alpha:1] ;
           // cell.backgroundColor = [UIColor lightGrayColor] ;
            cell.titlurandul2.hidden=YES;
            cell.titlurandulextra.textAlignment =NSTextAlignmentCenter;
            cell.titlurandulextra.font =[UIFont boldSystemFontOfSize:19];
            cell.titlurandulextra.text=@"Momentan nu sunt mesaje";
            
            
        }

        
        else if(ipx == totalRow-1){ //TEXT TRIMITE MESAJ ->incarca view mesaj
            cell.expandcollapsecell.tag=-5;
            cell.tag = 666;
            cell.COMPUNE.hidden=NO;
            cell.TRIMITE.hidden=YES;
            cell.TitluRand.hidden=YES;
            cell.toptitlurand.constant =20;
            cell.expandcollapsecell.hidden=YES;
            cell.expandcollapsecell.userInteractionEnabled=NO;
            cell.compunetextmesaj.userInteractionEnabled=YES;
            cell.compunetextmesaj.hidden=NO;
            cell.compunetextmesaj.delegate =self;
            [cell.compunetextmesaj setScrollEnabled:NO];
            UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
            numberToolbar.barStyle = UIBarStyleBlackTranslucent;
            numberToolbar.items = [NSArray arrayWithObjects:
                                   [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                                   nil];
            [numberToolbar sizeToFit];
            cell.compunetextmesaj.inputAccessoryView = numberToolbar;
            AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            
            if( ![self MyStringisEmpty:[NSString stringWithFormat:@"%@",del.TEXTMESAJTEMPORAR]] && ![del.TEXTMESAJTEMPORAR isEqualToString:@"Mesaj către vânzător"]) {
                cell.compunetextmesaj.textColor = [UIColor blackColor];
                cell.compunetextmesaj.text =del.TEXTMESAJTEMPORAR;
            } else {
                cell.compunetextmesaj.textColor = [UIColor lightGrayColor];
                cell.compunetextmesaj.text =@"Mesaj către vânzător";
                
            }
            
            CGFloat widthWithInsetsApplied = self.view.frame.size.width-45;
            
            CGSize textSize = [cell.compunetextmesaj.text boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
            double heightrow= textSize.height +25;
            
            NSLog(@"heightrow spec %f",heightrow);
            if(textSize.height < 48) {
                heightrow =48;
            }
//            cellheightmodificatoferta = heightrow;
//            cell.dynamicTEXTVIEWHEIGHT.constant =heightrow+30;
//            cell.dynamicCOMPUNEROWHEIGHT.constant =heightrow+30;
//            cell.dynamicLINIEGRIHEIGHT.constant =heightrow+30;
//            [cell setNeedsLayout];
//            [cell layoutIfNeeded];
            /*
             dynamicTEXTVIEWHEIGHT;
             @property (nonatomic,weak) IBOutlet  NSLayoutConstraint *dynamicCOMPUNEROWHEIGHT
             */
            //              if(![self MyStringisEmpty:idmesaj]) {
            //                  [cell.compunetextmesaj becomeFirstResponder];
            //              }
            if(pozele.count >0) {
                if( [[del.ARRAYASSETURIMESAJ objectAtIndex:0]isKindOfClass:[NSDictionary class]] && [[del.ARRAYASSETURIMESAJ objectAtIndex:0]respondsToSelector:@selector(allKeys)]) {
                    NSDictionary *detaliupoza =[del.ARRAYASSETURIMESAJ objectAtIndex:0];
                    
                    if(detaliupoza[@"tb"]) {
                        
                        NSString *stringurlthumbnail = [NSString stringWithFormat:@"%@", detaliupoza[@"tb"]];
                        [cell.fapoza.imageView sd_setImageWithURL:[NSURL URLWithString:stringurlthumbnail]
                                                 placeholderImage:nil
                                                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                            //  ... completion code here ...
                                                            if(image && image.size.height !=0) {  cell.fapoza.imageView.image = image;  }
                                                        }];
                        
                        [cell.fapoza.imageView setContentMode:UIViewContentModeScaleAspectFit];
                        //                              [cell.fapoza setImage:thumbpoza1 forState:UIControlStateNormal];
                        //                              [cell.fapoza setImage:thumbpoza1 forState:UIControlStateSelected];
                        
                    }
                } else if ([[del.ARRAYASSETURIMESAJ objectAtIndex:0]isKindOfClass:[UIImage class]]) {
                    ////////  NSLog(@"ce avem pe aici %@",del.ARRAYASSETURIMESAJ);
                    UIImage *thumbpoza1 = [del.ARRAYASSETURIMESAJ objectAtIndex:0];
                    [cell.fapoza.imageView setContentMode:UIViewContentModeScaleAspectFit];
                    [cell.fapozaImageView setImage:thumbpoza1];
                    [cell.fapozaImageView setImage:thumbpoza1];
                }else {
                    [cell.fapozaImageView setImage:[UIImage imageNamed:@"Icon_Camera_LightGrey_144x144.png"]];
                    [cell.fapozaImageView setImage:[UIImage imageNamed:@"Icon_Camera_BlueJ_144x144.png"]];
                }
            }else {
                [cell.fapozaImageView setImage:[UIImage imageNamed:@"Icon_Camera_LightGrey_144x144.png"]];
                [cell.fapozaImageView setImage:[UIImage imageNamed:@"Icon_Camera_BlueJ_144x144.png"]];
            }
            
            cell.fapozaImageView.contentMode =UIViewContentModeScaleAspectFit;
        }
        else if(ipx == totalRow   ){ //ULTIMUL RAND BUTON TRIMITE MESAJ
            cell.expandcollapsecell.tag=-100;
            cell.backgroundColor =[UIColor lightGrayColor];
            cell.COMPUNE.hidden=YES;
            cell.TRIMITE.hidden=NO;
            cell.TitluRand.hidden=YES;
            [cell.COMPUNE bringSubviewToFront:cell.trimitetextmesaj];
            [cell.trimitetextmesaj  setUserInteractionEnabled:NO];
            cell.sageatatrimite.hidden=NO;
            
        }
        else  {
            cell.expandcollapsecell.tag=-5;
            /*
             {
             date = 1463060733;
             "date_formatted" = "12 mai 2016, 16:45";
             images =             (
             );
             "is_myself" = 1;
             "is_viewed" = 1;
             message = "asd fas dfas dfasd f";
             messageid = 1826884;
             username = ioanungureanu;
             },
             {
             date = 1463061000;
             "date_formatted" = "12 mai 2016, 16:50";
             images =             (
             );
             "is_myself" = 0;
             "is_viewed" = 1;
             message = "sdfg sdf gsdf";
             messageid = 1826885;
             username = bogdanpsc;
             },
             
             */
            
            cell.continutmesaj.hidden=NO;
            cell.TitluRand.hidden=YES;
            cell.expandcollapsecell.hidden=YES;
            cell.expandcollapsecell.userInteractionEnabled=NO;
            cell.toptitlurand.constant =20;
            cell.fundalmesaj.hidden=NO;
            cell.elpozaalbastra.hidden=NO;
            cell.eupozagri.hidden=NO;
            
            NSDictionary *specialitem= [[NSDictionary alloc]init];
            //nu uita    if(RANDURI.count >0) {
            specialitem =[RANDURI objectAtIndex:ipx -1]; //pentru ca 0 e nume iar subitems au acelasi nivel in structura ca si nume [0] dar row e 1 2 3 ....
            /*
             images =         (
             {
             original = "http://dev5.activesoft.ro/~csaba/4tilance/attachment.php?id=6d585cd4c70819b2590fc9855e3c0a29";
             tb = "http://dev5.activesoft.ro/~csaba/4tilance/attachment.php?id=6d585cd4c70819b2590fc9855e3c0a29&cmd=thumb&w=148&h=111";
             },
             */
            
            
            NSString *continutmesaj =[NSString stringWithFormat:@"%@",specialitem[@"message"]];
            NSString *datafromatatamesaj =[NSString stringWithFormat:@"%@",specialitem[@"date_formatted"]];
            NSString *compus_mesaj= [NSString stringWithFormat:@"%@\n %@",continutmesaj,datafromatatamesaj];
            NSRange bigRange = [compus_mesaj rangeOfString:continutmesaj];
            NSRange mediumRange = [compus_mesaj rangeOfString:datafromatatamesaj];
            NSMutableAttributedString * attributedString= [[NSMutableAttributedString alloc] initWithString:compus_mesaj];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize: 18] range:bigRange];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:mediumRange];
            cell.contentView.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1] ;
            cell.contentView.backgroundColor = [UIColor colorWithRed:(232/255.0) green:(232/255.0) blue:(232/255.0) alpha:1] ;
            NSLog(@"ce..funda %f %f %f %f", cell.fundalmesaj.frame.origin.x,cell.fundalmesaj.frame.origin.y,cell.fundalmesaj.frame.size.width,cell.fundalmesaj.frame.size.height);
            
            NSInteger x =0;
            NSString *eusender =[[NSString alloc]init];
            //"nume":@"mesaj1",@"descriere":@"textmesaj1", @"eusender":@"0"
            eusender =[NSString stringWithFormat:@"%@",specialitem[@"is_myself"]];
            x=[eusender integerValue];
            
            NSLog(@"ipxxxxxxxxxx %li si x %li", (long)ipx,(long)x);
            
            CGFloat widthWithInsetsApplied = self.view.frame.size.width;
            if(SYSTEM_VERSION_LESS_THAN(@"8.0")){
                widthWithInsetsApplied = self.view.frame.size.width - 50;
            } else {
                widthWithInsetsApplied = self.view.frame.size.width - 30;
            }
            cell.textmesaj.hidden=YES;
            cell.textmesaj.attributedText=attributedString;
            cell.textmesaj.numberOfLines =0;
            ////jjjjj de testat pe 4 ->
            [cell.textmesaj sizeToFit];
            
            CGSize textSize = [cell.textmesaj.text boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
            NSLog(@"vsss %f %f",self.view.frame.size.width,cell.textmesaj.frame.size.height);
            double NECESARHeight =textSize.height+20;
            CGRect FUNDALMSG = cell.fundalmesaj.frame;
            if(SYSTEM_VERSION_LESS_THAN(@"8.0")){
                FUNDALMSG.size.width = self.view.frame.size.width - 20;
                cell.fundalmesaj.clipsToBounds =NO;
            } else {
                FUNDALMSG.size.width = self.view.frame.size.width - 30;
                cell.fundalmesaj.clipsToBounds =YES;
            }
            double NECESARHeightIMAGINE = 0;
            UIImageView *pozamesajserver = [[IMAGINESERVER alloc]init];
            NSArray *pozeatasatemesajdelaserver = [[NSArray alloc]init];
            pozeatasatemesajdelaserver =[NSArray arrayWithArray:specialitem[@"images"]];
            if(specialitem[@"imaginea0"] && [specialitem[@"imaginea0"] isKindOfClass:[UIImage class]]) {
                //inseamna ca a tras imaginea la load cu NSData dataWithContentsOfURL: am preferat sa fac asta sus la load///
                UIImage *FLUXCONTINUU = [[UIImage alloc]init];
                FLUXCONTINUU =specialitem[@"imaginea0"];
                pozamesajserver.image = FLUXCONTINUU;
                pozamesajserver.frame =cell.pozamesajdejatrimis.frame;
                [pozamesajserver setContentMode:UIViewContentModeScaleAspectFit];
                [pozamesajserver clipsToBounds];
                NECESARHeightIMAGINE = pozamesajserver.frame.size.height;
                NSLog(@" NECESARHeightIMAGINE PRELOADED %f", NECESARHeightIMAGINE);
                if(pozeatasatemesajdelaserver.count >0) {
                    UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mergilapoze)];
                    self.pozeprocesate =[[NSMutableArray alloc]init];
                    pozetemporare =[[NSArray alloc]init];
                    pozetemporare= pozeatasatemesajdelaserver;
                    [singleTap setNumberOfTapsRequired:1];
                    [cell.contentView bringSubviewToFront:pozamesajserver];
                    [cell.pozamesajdejatrimis  setUserInteractionEnabled:YES];
                    [cell.pozamesajdejatrimis  addGestureRecognizer:singleTap];
                }
                
                
            } else if(specialitem[@"images"]) {
                //se poate sa nu fi luat poza atunci reincearca aici
                
                if(pozeatasatemesajdelaserver.count >0) {
                    if( [[pozeatasatemesajdelaserver objectAtIndex:0]isKindOfClass:[NSDictionary class]] && [[pozeatasatemesajdelaserver objectAtIndex:0]respondsToSelector:@selector(allKeys)]) {
                        NSDictionary *detaliupoza =[pozeatasatemesajdelaserver objectAtIndex:0];
                        if(detaliupoza[@"tb"]) {
                            NSString *calepozaserver = [NSString stringWithFormat:@"%@",detaliupoza[@"tb"]];
                            [pozamesajserver sd_setImageWithURL:[NSURL URLWithString:calepozaserver]
                                               placeholderImage:nil
                                                      completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                          //  ... completion code here ...
                                                          if(image && image.size.height !=0) {  pozamesajserver.image = image;  }
                                                      }];
                            pozamesajserver.frame =cell.pozamesajdejatrimis.frame;
                            [pozamesajserver setContentMode:UIViewContentModeScaleAspectFit];
                            [pozamesajserver clipsToBounds];
                            
                            NECESARHeightIMAGINE = pozamesajserver.frame.size.height;
                            NSLog(@" NECESARHeightIMAGINE %f", NECESARHeightIMAGINE);
                            UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mergilapoze)];
                            self.pozeprocesate =[[NSMutableArray alloc]init];
                            pozetemporare =[[NSArray alloc]init];
                            pozetemporare= pozeatasatemesajdelaserver;
                            [singleTap setNumberOfTapsRequired:1];
                            [cell.contentView bringSubviewToFront:cell.pozamesajdejatrimis];
                            [cell.pozamesajdejatrimis  setUserInteractionEnabled:YES];
                            [cell.pozamesajdejatrimis  addGestureRecognizer:singleTap];
                            
                        }
                    }
                }
            }
            
            ////jjjj vezi 40
            FUNDALMSG.size.height = NECESARHeight +NECESARHeightIMAGINE+40;
            
            NECESARHeight =FUNDALMSG.size.height;
            cell.fundalmesaj.frame= FUNDALMSG;
            NSLog(@"  FUNDALMSG.size.height %f", FUNDALMSG.size.height);
            
            CAShapeLayer *shapeLayer = [[ClockFace alloc] init]; //nu uita iOS7 needs fix.
            UIBezierPath *aPath = [UIBezierPath bezierPath];
            NSInteger radius = 5.0;
            
            [aPath moveToPoint:CGPointMake(10.0, 10.0)];
            // Draw the lines.
            //top right
            [aPath addArcWithCenter:CGPointMake(cell.fundalmesaj.frame.size.width -20 -radius,10+radius)
                             radius:radius
                         startAngle:- (M_PI / 2)
                           endAngle:0
                          clockwise:YES];
            [aPath addLineToPoint:CGPointMake(cell.fundalmesaj.frame.size.width -20, 10.0+radius)];
            //bottom right
            [aPath addArcWithCenter:CGPointMake(cell.fundalmesaj.frame.size.width -20 - radius, NECESARHeight -radius)
                             radius:radius
                         startAngle:0
                           endAngle:- ((M_PI * 3) / 2)
                          clockwise:YES];
            [aPath addLineToPoint:CGPointMake(cell.fundalmesaj.frame.size.width -20-radius, NECESARHeight)];
            //bottom left
            [aPath addArcWithCenter:CGPointMake(25, NECESARHeight -radius)
                             radius:radius
                         startAngle:- ((M_PI * 3) / 2)
                           endAngle:- M_PI
                          clockwise:YES];
            [aPath addLineToPoint:CGPointMake(20.0,NECESARHeight-radius)];
            //finish line
            //top left
            //    [aPath addArcWithCenter:CGPointMake(10, 10)
            //                    radius:radius
            //                startAngle:- M_PI
            //                  endAngle:- (M_PI / 2)
            //                 clockwise:YES];
            [aPath addLineToPoint:CGPointMake(20.0,20)];
            [aPath closePath];
            shapeLayer.path = aPath.CGPath;
            shapeLayer.opacity = 1;
            //
            
            // shapeLayer.bounds = CGPathGetBoundingBox(aPath.CGPath);
            
            //                 shapeLayer.bounds =CGRectMake(0, 0, cell.fundalmesaj.frame.size.width -30, 55);
            //                  shapeLayer.anchorPoint= CGPointMake(10.0,10.0);
            //                  shapeLayer.position=CGPointMake(0,0);
            //  }
            
            
            switch (x) {
                    
                case 0: { //ramane apath default+
                    cell.textmesaj.textColor =[UIColor darkGrayColor];
                    cell.elpozaalbastra.hidden=YES;
                    if(specialitem[@"is_viewed"]) {
                        NSString *is_viewed =  [NSString stringWithFormat:@"%@",specialitem[@"is_viewed"]];
                        if(is_viewed.integerValue==0) {
                            cell.cercalbastru.hidden=NO;
                        } else {
                            cell.cercalbastru.hidden=YES;
                        }
                    }
                    
                    // cell.cercalbastru.hidden=NO;
                    shapeLayer.strokeColor = [[UIColor colorWithRed:(199/255.0) green:(199/255.0) blue:(199/255.0) alpha:1] CGColor];
                    shapeLayer.fillColor = [[UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1] CGColor];
                    shapeLayer.lineWidth = 2;
                    CGRect framedorit = CGRectNull;
                    
                    if(SYSTEM_VERSION_LESS_THAN(@"8.0")){
                        framedorit = shapeLayer.frame;
                        shapeLayer.bounds = CGPathGetPathBoundingBox(aPath.CGPath);
                        framedorit.origin.x = 2;
                        framedorit.origin.y = 0;
                        framedorit.size.height =NECESARHeight;
                        shapeLayer.frame =framedorit;
                    }else {
                        framedorit = shapeLayer.frame;
                        framedorit.origin.x = -6;
                        framedorit.origin.y =0;
                        framedorit.size.height =NECESARHeight;
                        shapeLayer.frame =framedorit;
                    }
                    [cell.fundalmesaj.layer insertSublayer:shapeLayer above:[cell.fundalmesaj.layer.sublayers firstObject]];
                    if(NECESARHeightIMAGINE>0) {
                        cell.textmesaj.hidden=YES;
                        cell.pozamesajdejatrimis.hidden=NO;
                        cell.pozamesajdejatrimis.image =pozamesajserver.image;
                        UILabel *SPECIALTEXTMESAJ =[[SpecialText alloc]init];
                        SPECIALTEXTMESAJ.attributedText = cell.textmesaj.attributedText;
                        CGRect framedorititext = cell.textmesaj.frame;
                        framedorititext.origin.x=40;
                        framedorititext.origin.y = NECESARHeightIMAGINE+30;
                        framedorititext.size.width =NECESARHeightIMAGINE;
                        SPECIALTEXTMESAJ.frame =framedorititext;
                        SPECIALTEXTMESAJ.font = cell.textmesaj.font;
                        SPECIALTEXTMESAJ.textColor= cell.textmesaj.textColor;
                        SPECIALTEXTMESAJ.numberOfLines =0;
                        [SPECIALTEXTMESAJ sizeToFit];
                        [cell.contentView addSubview:SPECIALTEXTMESAJ];
                        [cell.contentView bringSubviewToFront:SPECIALTEXTMESAJ];
                        NSLog(@"My view frame: %@", NSStringFromCGRect(SPECIALTEXTMESAJ.frame));
                        [cell.contentView bringSubviewToFront:cell.pozamesajdejatrimis];
                    } else {
                        cell.textmesaj.hidden=NO;
                        [cell.contentView bringSubviewToFront:cell.textmesaj];
                    }
                } break;
                case 1: {
                    cell.eupozagri.hidden=YES;
                    cell.cercalbastru.hidden=YES;
                    cell.textmesaj.textColor =[UIColor whiteColor];
                    shapeLayer.affineTransform =  CGAffineTransformMakeScale(-1, 1);
                    shapeLayer.strokeColor = [[UIColor whiteColor] CGColor];
                    shapeLayer.fillColor = [[UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] CGColor];
                    CGRect framedorit = CGRectNull;
                    if(SYSTEM_VERSION_LESS_THAN(@"8.0")){
                        framedorit = shapeLayer.frame;
                        shapeLayer.bounds = CGPathGetPathBoundingBox(aPath.CGPath);
                        //  framedorit.origin.x = cell.elpozaalbastra.frame.origin.x;
                        framedorit.origin.x = self.view.frame.size.width-50;
                        // framedorit.origin.x = -6;
                        framedorit.origin.y =0;
                        framedorit.size.height =NECESARHeight;
                        // framedorit.size.width = self.view.frame.size.width-20;
                        shapeLayer.frame =framedorit;
                    }else {
                        framedorit = shapeLayer.frame;
                        framedorit.origin.x = cell.eupozagri.frame.origin.x +cell.fundalmesaj.frame.size.width -cell.eupozagri.frame.size.width;
                        framedorit.size.height =NECESARHeight;
                        framedorit.origin.y =0;
                        //  framedorit.size.width = self.view.frame.size.width-20;
                        shapeLayer.frame =framedorit;
                    }
                    [cell.fundalmesaj.layer insertSublayer:shapeLayer above:[cell.fundalmesaj.layer.sublayers firstObject]];
                    if(NECESARHeightIMAGINE>0) {
                        cell.textmesaj.hidden=YES;
                        cell.pozamesajdejatrimis.hidden=NO;
                        cell.pozamesajdejatrimis.image =pozamesajserver.image;
                        UILabel *SPECIALTEXTMESAJ =[[SpecialText alloc]init];
                        SPECIALTEXTMESAJ.attributedText = cell.textmesaj.attributedText;
                        CGRect framedorititext = cell.textmesaj.frame;
                        framedorititext.origin.x=35;
                        framedorititext.origin.y = NECESARHeightIMAGINE+30;
                        framedorititext.size.width =NECESARHeightIMAGINE;
                        SPECIALTEXTMESAJ.frame =framedorititext;
                        SPECIALTEXTMESAJ.font = cell.textmesaj.font;
                        SPECIALTEXTMESAJ.textColor= cell.textmesaj.textColor;
                        SPECIALTEXTMESAJ.numberOfLines =0;
                        [SPECIALTEXTMESAJ sizeToFit];
                        [cell.contentView addSubview:SPECIALTEXTMESAJ];
                        [cell.contentView bringSubviewToFront:SPECIALTEXTMESAJ];
                        NSLog(@"My view frame: %@", NSStringFromCGRect(SPECIALTEXTMESAJ.frame));
                        [cell.contentView bringSubviewToFront:cell.pozamesajdejatrimis];
                    } else {
                        cell.textmesaj.hidden=NO;
                        [cell.contentView bringSubviewToFront:cell.textmesaj];
                        
                    }
                    //  cell.fundalmesaj.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
                    //  cell.fundalmesaj.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0); //flip orizontal
                    
                } break;
                default:
                    break;
            }
            //nu uita           CGRect frame1 =cell.fundalmesaj.frame;
            //            frame1.size.height = cell.textmesaj.frame.size.height;
            //            cell.fundalmesaj.frame =frame1;
            
            
            
        }
    }
    /////// ULTIMULRANDBUTOANE
    if(indexPath.section ==6) {
        //cand are winner nu mai apare salveaza la pref sau accepta oferta
        if(arewinner !=YES || cerereexpirata !=YES) {
            cell = [self createcell6];
        }
    }
    
    if ([indexPath section]== 7) {
        cell.bluecell.hidden=NO;
        cell.Altrandalbastru.text = [NSString stringWithFormat:@"%@", [self.TOATE objectAtIndex:7]];
        cell.Altrandalbastru.textColor =  [UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] ;
        cell.IconRand.image = [UIImage imageNamed:@"Icon_Anulare_Castigator_144x144.png"];
        [cell.contentView bringSubviewToFront:cell.IconRand];
       
        
    }
    if ([indexPath section]== 8) {
        cell.bluecell.hidden=NO;
        BOOL ARECALIFICATIV =NO;
        if(arewinner ==YES ) {
            if( DETALIUOFERTA[@"buyerfeedback"]) {
                NSString *buyerfeed= [NSString stringWithFormat:@"%@",DETALIUOFERTA[@"buyerfeedback"]];
                if(buyerfeed.integerValue ==1) {
                    ARECALIFICATIV =YES;
                }  else {
                    ARECALIFICATIV=NO;
                }
            }
        }
        if(ARECALIFICATIV ==YES) {
            cell.bluecell.hidden=NO;
            cell.Altrandalbastru.textColor =  [UIColor lightGrayColor] ;
            cell.Altrandalbastru.text = [NSString stringWithFormat:@"%@", [self.TOATE objectAtIndex:8]];
         ///JMOD    cell.IconRand.image = [UIImage imageNamed:@"Icon_Acorda_Calificativ_Grayedout_144x144.png"];
            cell.IconRand.image = [UIImage imageNamed:@"Icon_Acorda_Calificativ_Face_Grayedout_144x144.png"];
            cell.sageataBlue.hidden=YES;
            cell.sageataGri3.hidden=NO;
            cell.IconRand.hidden=NO;
            [cell.contentView bringSubviewToFront:cell.IconRand];
        } else {
            cell.bluecell.hidden=NO;
            cell.sageataBlue.hidden=NO;
            cell.sageataGri3.hidden=YES;
             cell.IconRand.hidden=NO;
            cell.Altrandalbastru.textColor =  [UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] ;
            cell.Altrandalbastru.text = [NSString stringWithFormat:@"%@", [self.TOATE objectAtIndex:8]];
          //JMOD   cell.IconRand.image = [UIImage imageNamed:@"Icon_Acorda_Calificativ_Blue_144x144.png"];
             cell.IconRand.image = [UIImage imageNamed:@"Icon_Acorda_Calificativ_Face_Blue_144x144.png"];
            [cell.contentView bringSubviewToFront:cell.IconRand];
        }
    }

    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(void)mergilapoze{
    if(self.pozetemporare.count>0) {
        NSLog(@"pozetemporare %@", self.pozetemporare);
        //lalalala
        /*
         pozetemporare (
         {
         original = "http://dev5.activesoft.ro/~csaba/4tilance/attachment.php?id=e4fd70d2944ea691dcaa8e4e1dcb3aa1";
         tb = "http://dev5.activesoft.ro/~csaba/4tilance/attachment.php?id=e4fd70d2944ea691dcaa8e4e1dcb3aa1&cmd=thumb&w=300&h=300";
         },
         {
         original = "http://dev5.activesoft.ro/~csaba/4tilance/attachment.php?id=65ccc5c7c12c46ad7c0f3717a8faa9a2";
         tb = "http://dev5.activesoft.ro/~csaba/4tilance/attachment.php?id=65ccc5c7c12c46ad7c0f3717a8faa9a2&cmd=thumb&w=300&h=300";
         }
         )
         */
        self.pozeprocesate =[[NSMutableArray alloc]init];
        
        for(int i=0;i<pozetemporare.count;i++) {
            NSDictionary *pozamea = [NSDictionary dictionaryWithDictionary:[pozetemporare objectAtIndex:i]];
            if(pozamea[@"original"]) {
                [self addhud];
                NSString *stringurlthumbnail = [NSString stringWithFormat:@"%@", pozamea[@"original"]];
                UIImage *IHAVEIMAGE = [[UIImage alloc]init];
                IHAVEIMAGE = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: stringurlthumbnail]]];
                if(IHAVEIMAGE && IHAVEIMAGE.size.height >0) {
                    if(![self.pozeprocesate containsObject:IHAVEIMAGE]) {
                        [self.pozeprocesate addObject:IHAVEIMAGE];
                        [self removehud];
                    }
                }
            }
            //just in case something goes wrong
            [self removehud];
        }
        
        
        NSLog(@"self.pozeprocesate %@",self.pozeprocesate);
        Galerieslide *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"GalerieslideVC"];
        vc.imagini =[[NSArray alloc]init];
        vc.imagini = self.pozeprocesate;
        [self.navigationController pushViewController:vc animated:NO ];
        
    }
    
    
}
-(IBAction)fapozaaction:(id)sender {
   [self  MERGILAECRANGALERIE]; //pentru ca pe iOS9 alerta de permisii face return imediat am facut o a doua verificare
    
}
-(void)verificaPERMISIIDOI {
    //see
    [self addhud];
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")){
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusAuthorized) {
            // Access has been granted.
            dispatch_async(dispatch_get_main_queue(), ^{
                //Your main thread code goes in here
                NSLog(@"Im on the main thread");
                if(pozele.count >0) {
                    //tabel poze mesaj
                    TabelPozeMesajeVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TabelPozeMesajeVC"];
                    [self.navigationController pushViewController:vc animated:NO ];
                } else {
                    NSLog(@"mergi la fa poze mesaj");
                    pozemesajeviewVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"pozemesajeVC"];
                    [self.navigationController pushViewController:vc animated:NO ];
                }
            });
        }
        else if (status == PHAuthorizationStatusDenied) {
            // Access has been denied.
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                message:@"Verificați setările aplicației și permiteți utilizarea camerei și a galeriei foto"
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
        else if (status == PHAuthorizationStatusNotDetermined) {
            // Access has not been determined.
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) {
                    // Access has been granted.
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //Your main thread code goes in here
                        NSLog(@"Im on the main thread");
                        if(pozele.count >0) {
                            //tabel poze mesaj
                            TabelPozeMesajeVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TabelPozeMesajeVC"];
                            [self.navigationController pushViewController:vc animated:NO ];
                        } else {
                            NSLog(@"mergi la fa poze mesaj");
                            pozemesajeviewVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"pozemesajeVC"];
                            [self.navigationController pushViewController:vc animated:NO ];
                        }
                    });
                }
                else {
                    // Access has been denied.
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                        message:@"Verificați setările aplicației și permiteți utilizarea camerei și a galeriei foto"
                                                                       delegate:nil
                                                              cancelButtonTitle:@"Ok"
                                                              otherButtonTitles:nil];
                    [alertView show];
                }
            }];
        }
        
        else if (status == PHAuthorizationStatusRestricted) {
            // Restricted access - normally won't happen.
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                message:@"Verificați setările aplicației și permiteți utilizarea camerei și a galeriei foto"
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
    } else {
        // sub iOS8
        
        ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
        NSLog(@"status auth %ld",(long)status);
        
        if (status == AVAuthorizationStatusAuthorized || status == AVAuthorizationStatusNotDetermined) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //Your main thread code goes in here
                NSLog(@"Im on the main thread");
                
                if(pozele.count >0) {
                    //tabel poze mesaj
                    TabelPozeMesajeVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TabelPozeMesajeVC"];
                    [self.navigationController pushViewController:vc animated:NO ];
                } else {
                    NSLog(@"mergi la fa poze mesaj");
                    pozemesajeviewVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"pozemesajeVC"];
                    [self.navigationController pushViewController:vc animated:NO ];
                }
            });
        }
        
        if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                message:@"Verificați setările aplicației și permiteți utilizarea camerei și a galeriei foto"
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
    }
    
}
-(void)MERGILAECRANGALERIE{
    
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")){
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusAuthorized) {
            // Access has been granted.
            dispatch_async(dispatch_get_main_queue(), ^{
                //Your main thread code goes in here
                [self verificaPERMISIIDOI];
            });
            
        }
        
        else if (status == PHAuthorizationStatusDenied) {
            // Access has been denied.
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                message:@"Verificați setările aplicației și permiteți utilizarea camerei și a galeriei foto"
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
        
        else if (status == PHAuthorizationStatusNotDetermined) {
            
            // Access has not been determined.
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                
                if (status == PHAuthorizationStatusAuthorized) {
                    // Access has been granted.
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self verificaPERMISIIDOI];
                    });
                }
                
                
                else {
                    // Access has been denied.
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                        message:@"Verificați setările aplicației și permiteți utilizarea camerei și a galeriei foto"
                                                                       delegate:nil
                                                              cancelButtonTitle:@"Ok"
                                                              otherButtonTitles:nil];
                    [alertView show];
                }
            }];
        }
        
        else if (status == PHAuthorizationStatusRestricted) {
            // Restricted access - normally won't happen.
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                message:@"Verificați setările aplicației și permiteți utilizarea camerei și a galeriei foto"
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
        
        
    } else {
        // sub iOS8
        
        ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
        NSLog(@"status auth %ld",(long)status);
        
        if (status == AVAuthorizationStatusAuthorized || status == AVAuthorizationStatusNotDetermined) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //Your main thread code goes in here
                NSLog(@"Im on the main thread");
                
                if(pozele.count >0) {
                    //tabel poze mesaj
                    TabelPozeMesajeVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TabelPozeMesajeVC"];
                    [self.navigationController pushViewController:vc animated:NO ];
                } else {
                    NSLog(@"mergi la fa poze mesaj");
                    pozemesajeviewVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"pozemesajeVC"];
                    [self.navigationController pushViewController:vc animated:NO ];
                }
                
            });
        }
        
        if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                message:@"Verificați setările aplicației și permiteți utilizarea camerei și a galeriei foto"
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
    }
    
}

-(void)gotodetaliuProfil :(NSMutableDictionary*) multedate {
    DetaliuProfil *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetaliuProfilVC"];
    vc.PROFILULMEU =NO;
    vc.DATEPROFIL =[[NSMutableDictionary alloc]init];
    vc._currentPage_toate=1;
    vc.DATEPROFIL =multedate;
    [self.navigationController pushViewController:vc animated:YES ];
    
}
//METODA_GET_MEMBER_PROFILE @"m=get_member_profile&p=" user_id username
-(void)get_member_profile :(NSString *)userid :(NSString *)AUTHTOKEN :(NSString *)tipuserid{ //user_id sau username
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



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"indexpath row sel %i %i",(int)indexPath.section, (int)indexPath.row);
    NSInteger sectiune = indexPath.section;
    NSInteger randselectat = indexPath.row;
    if(sectiune ==1) {
        //inchide mesajele
        NSInteger sectiune =5;
        NSDictionary *d=[[self.TOATE objectAtIndex:sectiune]objectAtIndex:0] ;
        if([d valueForKey:@"SubItems"])
        {
            NSArray *arr=[d valueForKey:@"SubItems"];
            BOOL isTableExpanded=NO;
            for(NSDictionary *subitems in arr )
            {
                //   NSLog(@"subitems jj %@",subitems);
                NSInteger index=[[self.TOATE objectAtIndex:sectiune] indexOfObjectIdenticalTo:subitems];
                isTableExpanded=(index>0 && index!=NSIntegerMax);
                if(isTableExpanded) break;
            }
            
            if(isTableExpanded)
            {
                // [self CollapseRows:arr:sectiune:nil];
                [self CollapseRowsSpecial:arr];
            }
        }
        
        //du-l la ecran vanzator
        NSLog(@"du-l la ecran vanzator");
        NSDictionary *dateuser =[NSDictionary dictionaryWithDictionary:[RANDOFERTANT objectAtIndex:0]];
        NSString *usernamesauid =@"";
        utilitar = [[Utile alloc]init];
        NSString *authtoken=@"";
        BOOL elogat = NO;
        elogat = [utilitar eLogat];
        if(elogat) {
            authtoken = [utilitar AUTHTOKEN];
            //(void)get_member_profile :(NSString *)userid :(NSString *)AUTHTOKEN :(NSString *)tipuserid{ //user_id sau username
            if(dateuser[@"username"]) {
                usernamesauid =[NSString stringWithFormat:@"%@",dateuser[@"username"]];
                [self get_member_profile:usernamesauid :authtoken :@"username"];
            } else if(dateuser[@"user_id"]) {
                usernamesauid =[NSString stringWithFormat:@"%@",dateuser[@"user_id"]];
                [self get_member_profile:usernamesauid :authtoken :@"user_id"];
            }
        }
    }
    else if(sectiune ==5 ) {
        NSDictionary *CORPEXPANDABIL =[[self.TOATE objectAtIndex:sectiune]objectAtIndex:0];
        NSMutableArray *RANDURI = [[NSMutableArray alloc]init];
        if( CORPEXPANDABIL[@"SubItems"])  {  RANDURI=CORPEXPANDABIL[@"SubItems"];
            ////  NSLog(@"randuri speciale %@", RANDURI);
            NSInteger totalRow = RANDURI.count;
            if(randselectat ==totalRow) {
                [self trimitemesaj];
            } else {
                NSLog(@"no action 1");
            }
        }
    }
    else if(sectiune ==7) {
        NSLog(@"anuleaza castigator");
        if(DETALIUOFERTA[@"messageid"]) {
            RIButtonItem *ok = [RIButtonItem item];
            ok.label = @"Da";
            ok.action = ^{
                NSString *ofertacastigatoareid = [NSString stringWithFormat:@"%@", DETALIUOFERTA[@"messageid"]];
                NSString *authtoken=@"";
                BOOL elogat = NO;
                utilitar = [[Utile alloc]init];
                elogat = [utilitar eLogat];
                if(elogat) {
                    authtoken = [utilitar AUTHTOKEN];
                    [self oferta_cancel:ofertacastigatoareid :authtoken];
                }            };
            RIButtonItem *cancelItem = [RIButtonItem item];
            cancelItem.label =@"Nu";
            cancelItem.action = ^{
                //no action ...
            };
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Piese Auto"
                                                                message:@"Sigur vrei sa anulezi castigatorul?"
                                                       cancelButtonItem:cancelItem
                                                       otherButtonItems:ok,nil];
            [alertView show];
        }
    }
    else if(sectiune ==8) {
        BOOL ARECALIFICATIV =NO;
        if(arewinner ==YES ) {
            if( DETALIUOFERTA[@"buyerfeedback"]) {
                NSString *buyerfeed= [NSString stringWithFormat:@"%@",DETALIUOFERTA[@"buyerfeedback"]];
                if(buyerfeed.integerValue ==1) {
                    ARECALIFICATIV =YES;
                }  else {
                    ARECALIFICATIV=NO;
                }
            }
        }

        if(ARECALIFICATIV ==NO) {
            NSLog(@"calificativ");
            EcranAcorda *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"EcranAcordaVC"];
            vc.CE_TIP_E=@"dincerere";
            vc.CALIFICATIV =[[NSMutableDictionary alloc]init];
            vc.CALIFICATIV=DETALIUOFERTA;
            [self.navigationController pushViewController:vc animated:YES ];
        }

    }
    else {
        NSLog(@"no action 0");
    }
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



-(void)viewWillLayoutSubviews{
}
//METODA_CANCEL_WINNING_OFFER
-(void) oferta_cancel :(NSString*)OFERTAID :(NSString*)authtoken {
    NSLog(@"OFERTAID %@", OFERTAID);
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
        NSString *OFERTAIDDETRIMIS= [NSString stringWithFormat:@"%@",OFERTAID];
        [dic2 setObject:OFERTAIDDETRIMIS forKey:@"offer_id"];
        
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic2 options:0 error:&err];
        NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        compus =[NSString stringWithFormat:@"%@%@",METODA_CANCEL_WINNING_OFFER, myString];
        
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
                     AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                     del.afostanulata =YES;
                    
                     [self removehud];
                    NSMutableDictionary *multedate = REZULTAT_NOTIFY_COUNT[@"data"];
                    
                    if(multedate) {
                        NSLog(@"date offer_id cancel %@",multedate);
                        
                         arewinner=NO;
                         afostanulata =YES;
                        [self.LISTASELECT reloadData];
                       
                        
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

-(BOOL)MyStringisEmpty:(NSString *)str
{
    if(str.length==0 || [str isKindOfClass:[NSNull class]] || [str isEqualToString:@""]||[str  isEqualToString:@"NULL"]||[str isEqualToString:@"(null)"]|| [str isEqualToString:@"<null>"] || [str isEqualToString:@"null"] ||str==nil){
        return YES;
    }
    return NO;
}

-(bool)checkDictionary:(NSDictionary *)dict{
    if(dict == nil || [dict class] == [NSNull class] || ![dict isKindOfClass:[NSDictionary class]]){
        return NO;
    }
    return  YES;
}
-(CellDetaliuOferta *) createcell {
    static NSString *CellIdentifier = @"CellDetaliuOferta";
   
    CellDetaliuOferta *cell = [self.LISTASELECT dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (CellDetaliuOferta*)[self.LISTASELECT dequeueReusableCellWithIdentifier:@"CellDetaliuOferta"];
    }
    for (UIView *subview in [cell.contentView subviews]) {
        
        if([subview isKindOfClass:[CustomBadge class]]){
            [subview removeFromSuperview];
        }
    }
    for (UIView *subview in [cell.contentView subviews]) {
        
        if([subview isKindOfClass:[CustomBadge1 class]]){
            [subview removeFromSuperview];
        }
    }
    for (UIImageView *sublayer in cell.contentView.subviews) {
        if([sublayer isKindOfClass:[IMAGINESERVER class]]){
            [sublayer removeFromSuperview];
        }
    }
    for (UILabel *specialtext in cell.contentView.subviews) {
        if([specialtext isKindOfClass:[SpecialText class]]){
            [specialtext removeFromSuperview];
        }
    }
    //vasile
      cell.salvatabifablue.hidden=YES;
    //end vasile
     cell.sageataGri3.hidden=YES;
     cell.bluecell.hidden=YES;
    cell.toptitlurand.constant =-22;
    cell.pozaRow.contentMode =UIViewContentModeScaleAspectFit;
    cell.ultimulrand.hidden=YES;
    cell.expandcollapsecell.userInteractionEnabled=NO;
    //cell.acceptaoferta.hidden=YES;
    cell.acceptaoferta.userInteractionEnabled=NO;
    cell.salveazalapreferate.userInteractionEnabled=NO;
    //cell.salveazalapreferate.hidden=YES;
    cell.randul1.hidden=YES;
    //    cell.catecalificative.hidden=YES;
    //    cell.icontelefon.hidden=YES;
    //    cell.sageatablue.hidden=YES;
    //    cell.stelutacalificative.hidden=YES;
    //    cell.telefonuser.hidden=YES;did
    //    cell.numeofertant.hidden=YES;
    //    cell.titlurandul1.hidden=YES;
    cell.randul2.hidden=YES;
    //randul2,titlurandul2
    
    cell.badgeRow.hidden=YES;
    cell.bifablue.hidden=YES;
    
    cell.cupaverde.hidden=YES;
    cell.elpozaalbastra.hidden=YES;
    cell.eupozagri.hidden=YES;
    cell.expandcollapsecell.hidden=YES;
    cell.fundalmesaj.hidden=YES;
    
    cell.pozaRow.hidden=YES;
    cell.pretoferta.hidden=YES;
    
    cell.tipoferta.hidden=YES;
    cell.TitluRand.hidden=YES;
    cell.verdetop.hidden=YES;
    cell.textmesaj.hidden=YES;
    cell.compunetextmesaj.userInteractionEnabled=NO;
    cell.compunetextmesaj.hidden=YES;
    cell.sageatatrimite.hidden=YES;
    cell.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1];
    //cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.TitluRand.textColor =  [UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] ;
    cell.cercalbastru.hidden=YES;
    
    cell.COMPUNE.hidden=YES;
    cell.TRIMITE.hidden=YES;
    cell.trimitetextmesaj.userInteractionEnabled=NO;
    cell.TRIMITE.userInteractionEnabled=YES;
    [cell.expandcollapsecell setImage:[UIImage imageNamed:@"Arrow_down_blue_72x72.png"] forState:UIControlStateNormal];
    [cell.expandcollapsecell setImage:[UIImage imageNamed:@"Arrow_up_blue_72x72.png"] forState:UIControlStateSelected];
    return cell;
}
-(CellDetaliuOferta *) createcell5 {
    static NSString *CellIdentifier = @"CellDetaliuOferta";
    
    CellDetaliuOferta *cell = [self.LISTASELECT dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (CellDetaliuOferta*)[self.LISTASELECT dequeueReusableCellWithIdentifier:@"CellDetaliuOferta"];
    }
    for (UIView *subview in [cell.contentView subviews]) {
        
        if([subview isKindOfClass:[CustomBadge class]]){
            [subview removeFromSuperview];
        }
    }
    for (UIView *subview in [cell.contentView subviews]) {
        
        if([subview isKindOfClass:[CustomBadge1 class]]){
            [subview removeFromSuperview];
        }
    }
    for (UIImageView *sublayer in cell.contentView.subviews) {
        if([sublayer isKindOfClass:[IMAGINESERVER class]]){
            [sublayer removeFromSuperview];
        }
    }
    for (UILabel *specialtext in cell.contentView.subviews) {
        if([specialtext isKindOfClass:[SpecialText class]]){
            [specialtext removeFromSuperview];
        }
    }
    cell.bluecell.hidden=YES;
    cell.toptitlurand.constant =-22;
    cell.pozaRow.contentMode =UIViewContentModeScaleAspectFit;
    cell.ultimulrand.hidden=YES;
    cell.expandcollapsecell.userInteractionEnabled=NO;
    //cell.acceptaoferta.hidden=YES;
    cell.acceptaoferta.userInteractionEnabled=NO;
    cell.salveazalapreferate.userInteractionEnabled=NO;
    //cell.salveazalapreferate.hidden=YES;
    cell.randul1.hidden=YES;
    //    cell.catecalificative.hidden=YES;
    //    cell.icontelefon.hidden=YES;
    //    cell.sageatablue.hidden=YES;
    //    cell.stelutacalificative.hidden=YES;
    //    cell.telefonuser.hidden=YES;
    //    cell.numeofertant.hidden=YES;
    //    cell.titlurandul1.hidden=YES;
    cell.randul2.hidden=YES;
    //randul2,titlurandul2
    
    cell.badgeRow.hidden=YES;
    cell.bifablue.hidden=YES;
    
    cell.cupaverde.hidden=YES;
    cell.elpozaalbastra.hidden=YES;
    cell.eupozagri.hidden=YES;
    cell.expandcollapsecell.hidden=YES;
    cell.fundalmesaj.hidden=YES;
    
    cell.pozaRow.hidden=YES;
    cell.pretoferta.hidden=YES;
    
    cell.tipoferta.hidden=YES;
    cell.TitluRand.hidden=YES;
    cell.verdetop.hidden=YES;
    cell.textmesaj.hidden=YES;
    cell.compunetextmesaj.userInteractionEnabled=NO;
    cell.compunetextmesaj.hidden=YES;
    cell.sageatatrimite.hidden=YES;
    cell.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1];
    //cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.TitluRand.textColor =  [UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] ;
    cell.cercalbastru.hidden=YES;
    
    cell.COMPUNE.hidden=YES;
    cell.TRIMITE.hidden=YES;
    cell.trimitetextmesaj.userInteractionEnabled=NO;
    cell.TRIMITE.userInteractionEnabled=YES;
    [cell.expandcollapsecell setImage:[UIImage imageNamed:@"Arrow_down_blue_72x72.png"] forState:UIControlStateNormal];
    [cell.expandcollapsecell setImage:[UIImage imageNamed:@"Arrow_up_blue_72x72.png"] forState:UIControlStateSelected];
    return cell;
}
-(CellDetaliuOferta *) createcell6 {
    CellDetaliuOferta *cell = [self createcell];
    cell.ultimulrand.hidden=NO;
    cell.salveazalapreferate.userInteractionEnabled=YES;
    cell.acceptaoferta.userInteractionEnabled=YES;
    cell.acceptaoferta.layer.borderWidth=1.0f;
    cell.acceptaoferta.layer.cornerRadius = 5.0f;
    cell.acceptaoferta.layer.borderColor=[[UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1] CGColor];
    cell.acceptaoferta.backgroundColor=[UIColor colorWithRed:(255/255.0) green:(66/255.0) blue:(0/255.0) alpha:1];
    cell.salveazalapreferate.layer.borderWidth=1.0f;
    cell.salveazalapreferate.layer.cornerRadius = 5.0f;
    cell.salveazalapreferate.layer.borderColor=[[UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] CGColor];
    if(CORPDATE[@"is_prefered"]) {
        NSString *epreferata = [NSString stringWithFormat:@"%@",CORPDATE[@"is_prefered"]];
        NSInteger esaunu = [epreferata integerValue];
        if(esaunu ==0) {
            [cell.salveazalapreferate setTitle:@"Salvează la Preferate" forState:UIControlStateNormal];
             cell.salvatabifablue.hidden=YES;
           // [self afiseazabifa:NO];
        } else if (esaunu ==1) {
            [cell.salveazalapreferate setTitle:@"Salvată la Preferate" forState:UIControlStateNormal];
             cell.salvatabifablue.hidden=NO;
          //   [self afiseazabifa:YES];
        }
    }
    
    return cell;
}


//METODA_OFFER_PREFERED
-(void)offerPrefered  :(NSString *)AUTHTOKEN :(NSMutableDictionary *)OFFERTA_ID :(id)sender {
    NSLog(@"dic oferta %@", OFFERTA_ID);
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    Reachability *internetReach = [Reachability reachabilityForInternetConnection];
    [internetReach startNotifier];
    NetworkStatus netStatus = [internetReach currentReachabilityStatus];
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
        [self addhud];
        NSMutableDictionary *dic2= [[NSMutableDictionary alloc]init];
        NSString *compus =@"";
        __block NSString *eroare = @"";
        //////////
        NSError * err;
        NSString *currentSysVer = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] systemVersion]];
        [dic2 setObject:@"iOS" forKey:@"os"];
        [dic2 setObject:currentSysVer forKey:@"version"];
        [dic2 setObject:@"ro" forKey:@"lang"];
        [dic2 setObject:AUTHTOKEN forKey:@"authtoken"];
        NSString *offerta_id =@"";
        NSString *valoare1sau0 =@"";
        if(OFFERTA_ID[@"valoare1sau0"] && OFFERTA_ID[@"offer_id"]) {
            offerta_id= [NSString stringWithFormat:@"%@",OFFERTA_ID[@"offer_id"]];
            valoare1sau0= [NSString stringWithFormat:@"%@",OFFERTA_ID[@"valoare1sau0"]];
        }
        [dic2 setObject:offerta_id forKey:@"offer_id"];
        [dic2 setObject:valoare1sau0 forKey:@"is_prefered"];
        //is_prefered: 0 sau 1
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic2 options:0 error:&err];
        NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        compus =[NSString stringWithFormat:@"%@%@",METODA_OFFER_PREFERED, myString];
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
                    NSDictionary *multedate = REZULTAT_NOTIFY_COUNT[@"data"];
                    NSLog(@"date adauga la preferate %@",multedate);
                    NSMutableArray *catedate=[[NSMutableArray alloc]init];
                    for(NSString* key in multedate) {
                        [catedate addObject:key];
                        
                    }
                    if(catedate.count ==0) {
                        //     NSLog(@"succes");
                        if([valoare1sau0 isEqualToString:@"1"]) {
                            [button setTitle:@"Salvată la Preferate" forState:UIControlStateNormal];
                            [self afiseazabifa:YES];
                        }
                        if([valoare1sau0 isEqualToString:@"0"]) {
                            [button setTitle:@"Salvează la Preferate" forState:UIControlStateNormal];
                             [self afiseazabifa:NO];
                        }
                    }
                    if(multedate[@"okmsg"]) {
                        NSString *mesajchangeemailserver=[NSString stringWithFormat:@"%@",multedate[@"okmsg"]];
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"PieseAuto"
                                                                            message:mesajchangeemailserver
                                                                           delegate:nil
                                                                  cancelButtonTitle:@"Ok"
                                                                  otherButtonTitles:nil];
                        [alertView show];
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
-(void)afiseazabifa:(BOOL)dasaunu {
    //CellDetaliuOferta
    if([self.TOATE objectAtIndex:6]) {
    NSIndexPath *indexPathreload = [NSIndexPath indexPathForRow:0 inSection:6];
    CellDetaliuOferta* cell = (CellDetaliuOferta*)[self.LISTASELECT cellForRowAtIndexPath:indexPathreload];
        NSLog(@"frame bifa : %@", NSStringFromCGRect(cell.salvatabifablue.frame));
        NSLog(@"hidden : %d", cell.salvatabifablue.hidden);
        NSLog(@"label  : %@", cell.salveazalapreferate.titleLabel.text);
        NSLog(@"other stuff : %@", CORPDATE[@"is_prefered"]);
        cell.salvatabifablue.hidden = ([CORPDATE[@"is_prefered"] intValue] == 1);
        CORPDATE[@"is_prefered"] = [NSNumber numberWithBool:!cell.salvatabifablue.hidden];
        NSLog(@"hidden : %d", cell.salvatabifablue.hidden);
         NSLog(@"other stuff 2 : %@", CORPDATE[@"is_prefered"]);
        [cell setNeedsDisplay];
        [cell setNeedsLayout];
        
        //vasile
//        [self.LISTASELECT beginUpdates];
//        [self.LISTASELECT reloadRowsAtIndexPaths:@[indexPathreload] withRowAnimation:UITableViewRowAnimationNone];
//        [self.LISTASELECT endUpdates];
        //end vasile
    }
}
-(void)trimitemesaj{
    NSLog(@"verifica mesaj");
    NSArray *cells = [self.LISTASELECT visibleCells];
    BOOL ok=NO;
    NSString *textmesajdetrimis =@"";

    for(UIView *view in cells){
        if([view isMemberOfClass:[CellDetaliuOferta class]]){
            CellDetaliuOferta *cell = (CellDetaliuOferta *) view;
            if(cell.tag == 666) {
                UITextView *tf = (UITextView *)[cell compunetextmesaj];
                ///     [tf resignFirstResponder];
                NSLog(@"tf.text %@",tf.text);
                if( ![self MyStringisEmpty:[NSString stringWithFormat:@"%@",tf.text]] && ![tf.text isEqualToString:@"Mesaj către vânzător"]) {
                    textmesajdetrimis =[NSString stringWithFormat:@"%@",tf.text];
                    ok=YES;
                }
            }

        }
    }
    if(ok ==YES) {
        NSMutableDictionary *DICTIONAR_MESAJ_ADD = [[NSMutableDictionary alloc]init];
        NSString *replyid =@"";
        replyid =  lastmessageid;
        [DICTIONAR_MESAJ_ADD setObject:replyid forKey:@"replyid"];
        [DICTIONAR_MESAJ_ADD setObject:textmesajdetrimis forKey:@"message"];
        utilitar = [[Utile alloc]init];
        NSString *authtoken=@"";
        BOOL elogat = NO;
        elogat = [utilitar eLogat];
        if(elogat) {
            authtoken = [utilitar AUTHTOKEN];
            NSMutableArray *images= [[NSMutableArray alloc]init];
            images = self.pozele;
            AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            if(del.ARRAYASSETURIMESAJ.count >0) {
                images = del.ARRAYASSETURIMESAJ;
                
            }
            NSLog(@"poze ver %@",pozele );
            [self comment_add:DICTIONAR_MESAJ_ADD :images :authtoken];
        }
        
        
        
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                            message:@"Completati mesajul"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
    
}
/*
 "comment_add"
 PARAMETRII:
 - validate_only: dry-run daca este thruthy (la fel ca la cerere_add)
 - cerere_id SAU replyid
 - message: continut comentariu
 replyid tb. sa fie ultimul id de comentariu intr-o discutie care nu a fost postat de user-ul logat
 ...sau replyid este id-ul ofertei, oferta fiind un caz particular de comentariu (cererea ofertei tb. sa apartina user-ului logat)
 fisierele uploadate prin post multipart/form-data sunt adaugete la comentariu (optional) la fel ca la cerere_add
 in cazul in care nu sunt trimise poze, "comment_add" poate fi apelat direct fara dry-run (la fel ca la cerere_add)
 am adaugat comment_max_images=8 la metoda "init"
 */
//////METODA_COMMENT_ADD
-(BOOL)sendMesajcuPOZE:DICTIONAR_CERERE_ADD :(NSMutableArray*) POZEMESAJ :(NSString*)AUTHTOKEN {
    __block BOOL ATRIMIS = NO;
    Reachability *internetReach = [Reachability reachabilityForInternetConnection];
    [internetReach startNotifier];
    NetworkStatus netStatus = [internetReach currentReachabilityStatus];
    BOOL maideparte =NO;
    switch (netStatus)
    {
        case NotReachable:
        {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Eroare" message:@"Telefonul tău nu este conectat la internet. Te rugăm să încerci mai târziu" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertView show];
            [MBProgressHUD hideAllHUDsForView:self.navigationController.visibleViewController.view animated:YES];
            
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
        dic2= DICTIONAR_CERERE_ADD;
        [dic2 setObject:@"iOS" forKey:@"os"];
        [dic2 setObject:currentSysVer forKey:@"version"]; //  vers iOS
        [dic2 setObject:@"ro" forKey:@"lang"];
        [dic2 setObject:AUTHTOKEN forKey:@"authtoken"];
        
        NSMutableArray *images=[[NSMutableArray alloc]init];
        NSMutableArray *idspoze=[[NSMutableArray alloc]init]; //iduri poze la repostare
        
        for(int i=0;i<POZEMESAJ.count;i++) {
            if( [[POZEMESAJ objectAtIndex:i]isKindOfClass:[NSDictionary class]] && [[POZEMESAJ objectAtIndex:i]respondsToSelector:@selector(allKeys)]) {
                NSDictionary *pozeexistente = [POZEMESAJ objectAtIndex:i];
                if(pozeexistente[@"id"]) {
                    NSString *idpozaexistenta = [NSString stringWithFormat:@"%@", pozeexistente[@"id"]];
                    [idspoze addObject:idpozaexistenta];
                }
            }
        }
        for(int i=0;i<POZEMESAJ.count;i++) {
            if( [[POZEMESAJ objectAtIndex:i]isKindOfClass:[UIImage class]]) {
                UIImage *POZANOUA = [POZEMESAJ objectAtIndex:i];
                [images addObject:POZANOUA];
            }
        }
        
        NSLog(@"pozele  mesaj %@", images);
        ///no need for ids
        if(idspoze.count>0) {
            [dic2 setValue:idspoze forKey:@"image_ids"];
        }
        [dic2 setValue:@"0" forKey:@"validate_only"];
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic2 options:0 error:&err];
        NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        compus =[NSString stringWithFormat:@"%@", myString];
        
        NSString *lineEnd=@"\r\n";
        NSString *twoHyphens=@"--";
        NSString *boundary=@"*****";
        NSMutableData *postBody = [NSMutableData data];
        
        NSLog(@"DICTIONAR CERERE %@",dic2);
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://%@",base_url]]];
        [request setHTTPMethod:@"POST"];
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
        
        [postBody appendData:[[NSString stringWithFormat:@"%@%@%@", twoHyphens,boundary,lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"m\"%@",  lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@",  lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"comment_add"] dataUsingEncoding:NSUTF8StringEncoding]]; //metoda e comment_add
        [postBody appendData:[[NSString stringWithFormat:@"%@",  lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@%@%@", twoHyphens,boundary,lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [postBody appendData:[[NSString stringWithFormat:@"%@%@%@", twoHyphens,boundary,lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"p\"%@",  lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@",  lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[compus dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@",  lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@%@%@", twoHyphens,boundary,lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
        
        //images
        for(int i=0; i<images.count; i++) {
            long NUMEFISIERTIMESTAMP = (long)NSDate.date.timeIntervalSince1970;
            NSString *userfile = [NSString stringWithFormat:@"%lu.jpg",NUMEFISIERTIMESTAMP];
            UIImage *eachImage  = [images objectAtIndex:i];
            NSData *imageData = UIImageJPEGRepresentation(eachImage,0.8);
            if(imageData ) {
                [postBody appendData:[[NSString stringWithFormat:@"%@%@%@", twoHyphens,boundary,lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
                [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"images[%i]\"; filename=\"%@\"%@",i,userfile, lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
                [postBody appendData:[[NSString stringWithFormat:@"Content-Type: image/jpeg%@",lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
                [postBody appendData:[[NSString stringWithFormat:@"Content-Transfer-Encoding: binary%@",lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
                [postBody appendData:[[NSString stringWithFormat:@"%@",  lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
                [postBody appendData:[NSData dataWithData:imageData]];
                [postBody appendData:[[NSString stringWithFormat:@"%@",  lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
                [postBody appendData:[[NSString stringWithFormat:@"%@%@%@", twoHyphens,boundary,lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
                
            } else {
                NSLog(@"no image");
            }
        }
        
        //last line close bound.
        [postBody appendData:[[NSString stringWithFormat:@"%@%@%@", twoHyphens,boundary,lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"postBody=%@", [[NSString alloc] initWithData:postBody encoding:NSASCIIStringEncoding]);
        
        [request setHTTPBody:postBody];
        NSLog(@"my strin %@", compus);
        AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        op.securityPolicy = [self customSecurityPolicy];
        op.responseSerializer = [AFJSONResponseSerializer serializer];
        [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSMutableDictionary *DictionarErori= [[NSMutableDictionary alloc]init];
            NSDictionary *REZULTAT_CERERE_ADD = responseObject;
            NSLog(@"resp 2 %@",responseObject);
            
            if(REZULTAT_CERERE_ADD[@"errors"]) {
                [self removehud];
                NSMutableArray *erori = [[NSMutableArray alloc]init];
                if(REZULTAT_CERERE_ADD[@"errors"]) {
                    DictionarErori = REZULTAT_CERERE_ADD[@"errors"];
                    for(id cheie in [DictionarErori allKeys]) {
                        NSLog(@"dds %@",[DictionarErori valueForKey:cheie]);
                        [erori addObject:[NSString stringWithFormat:@"%@",[DictionarErori valueForKey:cheie]]];
                    }
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
                }   else  if(  REZULTAT_CERERE_ADD[@"data"]) {
                    [self removehud];
                    NSDictionary *multedate = REZULTAT_CERERE_ADD[@"data"];
                    NSLog(@"date ADD MESAJ %@",multedate);
                    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                    pozele = [[NSMutableArray alloc]init];
                    del.POZEMESAJ = [[NSMutableArray alloc]init];
                    del.ARRAYASSETURIMESAJ = [[NSMutableArray alloc]init];
                    del.TEXTMESAJTEMPORAR=@"Mesaj către vânzător";
                    NSArray *cells = [self.LISTASELECT visibleCells];
                    for(UIView *view in cells){
                        if([view isMemberOfClass:[CellDetaliuOferta class]]){
                            CellDetaliuOferta *cell = (CellDetaliuOferta *) view;
                            UITextView *tf = (UITextView *)[cell compunetextmesaj];
                            [tf resignFirstResponder];
                        }
                    }
                    [self get_comments : [NSString stringWithFormat:@"%@",DETALIUOFERTA[@"messageid"]] :@"ofertaid" :AUTHTOKEN];
                    
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
            [self get_comments : [NSString stringWithFormat:@"%@",DETALIUOFERTA[@"messageid"]] :@"ofertaid" :AUTHTOKEN];
        }];
        [self removehud];
        
        [[NSOperationQueue mainQueue] addOperation:op];
    }
    return ATRIMIS;
    
    
}


-(BOOL)comment_add :(NSMutableDictionary *) DICTIONAR_MESAJ_ADD :(NSMutableArray*) POZEMESAJ :(NSString*)AUTHTOKEN {
    __block BOOL ATRIMIS = NO;
    Reachability *internetReach = [Reachability reachabilityForInternetConnection];
    [internetReach startNotifier];
    NetworkStatus netStatus = [internetReach currentReachabilityStatus];
    BOOL maideparte =NO;
    switch (netStatus)
    {
        case NotReachable:
        {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Eroare" message:@"Telefonul tău nu este conectat la internet. Te rugăm să încerci mai târziu" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertView show];
            [MBProgressHUD hideAllHUDsForView:self.navigationController.visibleViewController.view animated:YES];
            
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
        dic2= DICTIONAR_MESAJ_ADD;
        [dic2 setObject:@"iOS" forKey:@"os"];
        [dic2 setObject:currentSysVer forKey:@"version"]; //  vers iOS
        [dic2 setObject:@"ro" forKey:@"lang"];
        [dic2 setObject:AUTHTOKEN forKey:@"authtoken"];
        if(DICTIONAR_MESAJ_ADD[@"replyid"]) {
            NSString *oldcerereid = [NSString stringWithFormat:@"%@",DICTIONAR_MESAJ_ADD[@"replyid"]];
            [dic2 setValue:oldcerereid forKey:@"replyid"];
        }
        if(DICTIONAR_MESAJ_ADD[@"message"]) {
            NSString *message = [NSString stringWithFormat:@"%@",DICTIONAR_MESAJ_ADD[@"message"]];
            [dic2 setValue:message forKey:@"message"];
        }
        NSMutableArray *images=[[NSMutableArray alloc]init];
        images = pozele;
        //FOR IMAGES just end empty
        
        /*
         Metoda "cerere_add" are un parametru nou "validate_only" (0 sau 1) pt. dry run.
         Daca user-ul nu are poze, aplicatia poate sa trimita "cerere_add" cu validate_only = 0
         Daca are poze, trimite "cerere_add" fara poze cu validate_only = 1 dupa care, daca nu sunt "errors", trimite "cerere_add" cu "images[]" (multipart/form-data) si cu validate_only = 0
         am modificat, cerere_add returneaza:
         "images": [
         { "original":"http://...", "tb": "http://..." },
         ...
         ]
         */
        if(images.count>0) {
            // validate_only"
            [dic2 setValue:@"1" forKey:@"validate_only"];
        } else {
            [dic2 setValue:@"0" forKey:@"validate_only"];
        }
        NSLog(@"DICTIONAR CERERE %@",dic2);
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic2 options:0 error:&err];
        NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        compus =[NSString stringWithFormat:@"%@%@",METODA_COMMENT_ADD, myString];
        
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
            NSMutableDictionary *DictionarErori= [[NSMutableDictionary alloc]init];
            NSDictionary *REZULTAT_MESAJ_ADD = responseObject;
            if(REZULTAT_MESAJ_ADD[@"errors"]) {
                NSMutableArray *erori = [[NSMutableArray alloc]init];
                if(REZULTAT_MESAJ_ADD[@"errors"]) {
                    [self removehud];
                    DictionarErori = REZULTAT_MESAJ_ADD[@"errors"];
                    for(id cheie in [DictionarErori allKeys]) {
                        NSLog(@"dds %@",[DictionarErori valueForKey:cheie]);
                        [erori addObject:[NSString stringWithFormat:@"%@",[DictionarErori valueForKey:cheie]]];
                    }
                    
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
                }   else  if(  REZULTAT_MESAJ_ADD[@"data"]) {
                    [self removehud];
                    NSDictionary *multedate = REZULTAT_MESAJ_ADD[@"data"];
                    NSLog(@"date mesaj raspuns %@",multedate);
                    if(images.count>0) {
                        [self  sendMesajcuPOZE:dic2 :images :AUTHTOKEN];
                        
                    } else {
                        [self removehud];
                        NSLog(@"gata si mesaj fara poze jjjj");
                        AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                        pozele = [[NSMutableArray alloc]init];
                        del.POZEMESAJ = [[NSMutableArray alloc]init];
                        del.ARRAYASSETURIMESAJ = [[NSMutableArray alloc]init];
                        del.TEXTMESAJTEMPORAR=@"Mesaj către vânzător";
                        NSArray *cells = [self.LISTASELECT visibleCells];
                        for(UIView *view in cells){
                            if([view isMemberOfClass:[CellDetaliuOferta class]]){
                                CellDetaliuOferta *cell = (CellDetaliuOferta *) view;
                                UITextView *tf = (UITextView *)[cell compunetextmesaj];
                                [tf resignFirstResponder];
                            }
                        }
                        [self get_comments : [NSString stringWithFormat:@"%@",DETALIUOFERTA[@"messageid"]] :@"ofertaid" :AUTHTOKEN];
                        
                    }
                    ATRIMIS =YES;
                }
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [self removehud];
            [self get_comments : [NSString stringWithFormat:@"%@",DETALIUOFERTA[@"messageid"]] :@"ofertaid" :AUTHTOKEN];
        }];
        [[NSOperationQueue mainQueue] addOperation:op];
    }
    return ATRIMIS;
}

-(void)get_comments :(NSString*)CERERESAUOFERTAID :(NSString*)TIP :(NSString*)authtoken {
    Reachability *internetReach = [Reachability reachabilityForInternetConnection];
    [internetReach startNotifier];
    NetworkStatus netStatus = [internetReach currentReachabilityStatus];
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
        [self addhud];
        NSMutableDictionary *dic2= [[NSMutableDictionary alloc]init];
        NSString *compus =@"";
        __block NSString *eroare = @"";
        NSError * err;
        NSString *currentSysVer = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] systemVersion]];
        [dic2 setObject:@"iOS" forKey:@"os"];
        [dic2 setObject:currentSysVer forKey:@"version"]; //  vers iOS
        [dic2 setObject:@"ro" forKey:@"lang"];
        [dic2 setObject:authtoken forKey:@"authtoken"];
        if([TIP isEqualToString:@"cerereid"]) {
            [dic2 setObject:CERERESAUOFERTAID forKey:@"cerere_id"];
        } else  if([TIP isEqualToString:@"ofertaid"]) {
            [dic2 setObject:CERERESAUOFERTAID forKey:@"offer_id"];
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
                    [self removehud];
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
                    NSMutableDictionary *multedate = [NSMutableDictionary dictionaryWithDictionary:REZULTAT_NOTIFY_COUNT[@"data"]];
                    [self removehud];
                    NSLog(@"date comentarii %@",multedate);
                    if([TIP isEqualToString:@"cerereid"]) {
                        [self REFRESH_MESAJE:multedate :@"cerereid"];
                    } else  if([TIP isEqualToString:@"ofertaid"]) {
                        [self REFRESH_MESAJE:multedate :@"ofertaid"];
                    }
                }
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [self removehud];
        }];
        [[NSOperationQueue mainQueue] addOperation:op];
    }
    [self removehud];
}
-(void)REFRESH_MESAJE :(NSMutableDictionary *) comentarii :(NSString *)tip {
    NSLog(@"comen %@",comentarii);
    NSMutableArray *MESAJEREXP = [[NSMutableArray alloc]init];
    NSMutableArray *MESAJELEALTORA = [[NSMutableArray alloc]init];
    NSString *comments_count=@"";
    NSString *comments_unread_count=@"";
    if(comentarii[@"comments_count"]) comments_count = [NSString stringWithFormat:@"%@",comentarii[@"comments_count"]];
    if(comentarii[@"comments_unread_count"]) comments_unread_count = [NSString stringWithFormat:@"%@",comentarii[@"comments_unread_count"]];
    if( comentarii[@"comments"]) {
        NSMutableArray *itemuriexpandabile =[[NSMutableArray alloc]init];
        itemuriexpandabile = [NSMutableArray arrayWithArray: [comentarii[@"comments"]mutableCopy]];
        if( itemuriexpandabile.count>0) {
            //acum parcurge aria si  stabileste lastmessageid
            for(int i=0;i< itemuriexpandabile.count;i++) {
                NSDictionary *dictmesaj = [NSDictionary dictionaryWithDictionary:[itemuriexpandabile objectAtIndex:i]];
                NSMutableDictionary *perfectsense =[NSMutableDictionary dictionaryWithDictionary:dictmesaj];
                if(dictmesaj[@"is_myself"]) {
                    NSString *eusender =[NSString stringWithFormat:@"%@",dictmesaj[@"is_myself"]];
                    NSInteger z=[eusender integerValue];
                    if(z==0) {
                        //ADD IN ARRAY
                        [MESAJELEALTORA addObject:dictmesaj];
                    }
                }
                if(dictmesaj[@"images"]) {
                    NSArray *imagini = [NSArray arrayWithArray:dictmesaj[@"images"]];
                    if(imagini.count >0) {
                        NSDictionary *imagine = [imagini objectAtIndex:0];
                        if(imagine[@"tb"]) {
                            UIImage *IHAVEIMAGE = [[UIImage alloc]init];
                            NSString *stringurlthumbnail = [NSString stringWithFormat:@"%@", imagine[@"tb"]];
                            IHAVEIMAGE = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: stringurlthumbnail]]];
                            if(IHAVEIMAGE && IHAVEIMAGE.size.height >0) {
                                [perfectsense setObject:IHAVEIMAGE forKey:@"imaginea0"];
                                [itemuriexpandabile replaceObjectAtIndex:i withObject:perfectsense];
                            }
                        }
                    }
                }
            }
        }
        //ATENTIE ! aici se insereaza intotdeauna 2 randuri goale text mesaj + buton de trimite mesaj
        NSDictionary *trimitemesaj =@{@"special" : @"1"};
        NSDictionary *trimitemesajaltul =@{@"specialrand" : @"2"};
        NSDictionary *nusuntmesaje =@{@"Momentan nu sunt mesaje" : @"0"};
        [itemuriexpandabile addObject:nusuntmesaje];
        [itemuriexpandabile addObject:trimitemesaj];
        [itemuriexpandabile addObject:trimitemesajaltul];
        NSMutableDictionary *CORPEXPANDABIL = [[NSMutableDictionary alloc]init];
        NSString *name =@"Mesaje";
        [CORPEXPANDABIL setObject:name forKey:@"label_name"];
        [CORPEXPANDABIL setObject:comments_count forKey:@"comments_count"];
        [CORPEXPANDABIL setObject:comments_unread_count forKey:@"comments_unread_count"];
        [CORPEXPANDABIL setObject:itemuriexpandabile forKey:@"SubItems"];
        MESAJEREXP =[NSMutableArray arrayWithArray:[NSArray arrayWithObjects:CORPEXPANDABIL, nil]];
        NSLog(@"MESAJEREXP %@",MESAJEREXP);
    }
    
    NSLog(@"MESAJELEALTORA %@",MESAJELEALTORA);
    if(MESAJELEALTORA.count >0) {
        NSDictionary *ULTIMULMESAJDELAALTII = [NSDictionary dictionaryWithDictionary:[MESAJELEALTORA lastObject]];
        if(ULTIMULMESAJDELAALTII[@"messageid"]) {
            NSString *lastmesajid =[NSString stringWithFormat:@"%@",ULTIMULMESAJDELAALTII[@"messageid"]];
            lastmessageid =lastmesajid;
        }
    }
    [self.TOATE replaceObjectAtIndex:5 withObject:MESAJEREXP];
    NSIndexSet *section =  [NSIndexSet indexSetWithIndex:5];
    [self.LISTASELECT beginUpdates];
    [self.LISTASELECT reloadSections:section withRowAnimation:UITableViewRowAnimationNone];
    [self.LISTASELECT endUpdates];
    [self.LISTASELECT reloadData];
    
}


- (void) textViewDidChange:(UITextView *)textView
{

    AppDelegate * del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    del.TEXTMESAJTEMPORAR = textView.text;

    UITextPosition* pos = textView.endOfDocument;
    CGRect currentRect = [textView caretRectForPosition:pos];
    
    if (currentRect.origin.y != previousRect.origin.y){
        CGFloat fixedWidth = textView.frame.size.width;
        CGSize newSize = [textView sizeThatFits:(CGSizeMake(fixedWidth, MAXFLOAT))];
        [self heightOfTextView:textView Withwheight:newSize.height];
    }
    previousRect = currentRect;
    
}



-(void)heightOfTextView:(UITextView *)textView Withwheight:(CGFloat)height{
    textViewHeight = height +16;
    [UIView setAnimationsEnabled:NO];
     [self.LISTASELECT beginUpdates];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:5]; // sa urce peste keyboard
//    [self.LISTASELECT scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    [self.LISTASELECT reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self.LISTASELECT endUpdates];
    [UIView setAnimationsEnabled:YES];
}

- (void)scrollToCursorForTextView: (UITextView*)textView {
    
    CGRect cursorRect = [textView caretRectForPosition:textView.selectedTextRange.start];
    
    cursorRect = [self.LISTASELECT convertRect:cursorRect fromView:textView];
    
    if (![self rectVisible:cursorRect]) {
        cursorRect.size.height += 8; // To add some space underneath the cursor
        [self.LISTASELECT scrollRectToVisible:cursorRect animated:YES];
    }
}

- (BOOL)rectVisible: (CGRect)rect {
    CGRect visibleRect;
    visibleRect.origin = self.LISTASELECT.contentOffset;
    visibleRect.origin.y += self.LISTASELECT.contentInset.top;
    visibleRect.size = self.LISTASELECT.bounds.size;
    visibleRect.size.height -= self.LISTASELECT.contentInset.top + self.LISTASELECT.contentInset.bottom;
    
    return CGRectContainsRect(visibleRect, rect);
}

@end

//- (void)textViewDidEndEditing:(UITextView *)textView
//{
//    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    NSMutableArray *RANDURI = [[NSMutableArray alloc]init];
//    NSDictionary *CORPEXPANDABIL =[NSDictionary dictionaryWithDictionary: [[self.TOATE objectAtIndex:5]objectAtIndex:0]];
//    if( CORPEXPANDABIL[@"SubItems"]) {  RANDURI=[NSMutableArray arrayWithArray:CORPEXPANDABIL[@"SubItems"]];
//    }
//    NSInteger ipx=0;
//    NSInteger totalRow = RANDURI.count;
//    ipx = totalRow-1;
//    NSIndexPath *indexPathreload = [NSIndexPath indexPathForRow:ipx inSection:5];
//    CellDetaliuOferta *updateCell = (CellDetaliuOferta *)[self.LISTASELECT cellForRowAtIndexPath:indexPathreload];
//    if ([updateCell.compunetextmesaj.text isEqualToString:@""]) {
//        updateCell.compunetextmesaj.text =  @"Mesaj către vânzător";
//        updateCell.compunetextmesaj.textColor = [UIColor lightGrayColor]; //optional
//     } else  {
//        updateCell.compunetextmesaj.textColor = [UIColor blackColor];
//    }
//    del.TEXTMESAJTEMPORAR =updateCell.compunetextmesaj.text;
//    [updateCell.compunetextmesaj resignFirstResponder];
//}

