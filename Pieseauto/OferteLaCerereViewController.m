//
//  OferteLaCerereViewController.m
//  Pieseauto
//
//  Created by Ioan Ungureanu on 05/04/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//
#import "utile.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"
#import "OferteLaCerereViewController.h"
#import "CellListaOferteRow.h"
#import "TutorialHomeViewController.h"
#import <CoreText/CoreText.h>
#import "SetariViewController.h"
#import "UIImageView+WebCache.h" //sdwebimage
#import "Reachability.h"
#import "DetaliuOfertaViewController.h"
#import "CerereExistentaViewController.h"
#import "butoncustomback.h"

static NSString *PE_PAGINA = @"20";
@interface OferteLaCerereViewController(){
    NSMutableArray* Cells_Array;
}
@end

@implementation OferteLaCerereViewController
@synthesize  LISTASELECT,SEGCNTRL,TOATE,PREFERATE,btniconpreferate;
@synthesize HEADERCERERE,numecerere,pozacerere,sageatablue,idcerere,nuaipreferate,CORPDATE,DETALIUCERERE;
@synthesize _currentPage,_currentPagePreferate,numarpagini,numarpaginipreferate,comentariicerere,DETALIUOFERTA,dynamicHEADLEFT, E_DIN_DETALIU_CERERE,masinacerere,dynamicINALTIMETITLUCERERE,dynamicINALTIMEMASINACERERE,dynamicINALTIMEHEADER;
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
-(void)perfecttimeforback{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)viewWillAppear:(BOOL)animated {
    self.E_DIN_DETALIU_CERERE = E_DIN_DETALIU_CERERE;
    NSLog(@"E_DIN_DETALIU_CERERE %i",E_DIN_DETALIU_CERERE);
    
    self.title = @"Oferte la cererea:";
    //clean other left
    
    NSLog(@"oferte la cerere");
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    del.TEXTMESAJTEMPORAR=@"Mesaj către vânzător";
    del.ARRAYASSETURI=[[NSMutableArray alloc]init];
    del.ARRAYASSETURIMESAJ=[[NSMutableArray alloc]init];
    del.POZEMESAJ=[[NSMutableArray alloc]init];
    [SEGCNTRL addTarget:self action:@selector(schimbaSegment) forControlEvents:UIControlEventValueChanged];
    self.comentariicerere=[[NSMutableDictionary alloc]init];
    self.DETALIUOFERTA=[[NSMutableDictionary alloc]init];
    [self.SEGCNTRL setSelectedSegmentIndex:0];
    TOATE= [[NSMutableArray alloc]init];
    PREFERATE= [[NSMutableArray alloc]init];
    
    LISTASELECT.delegate =self;
    LISTASELECT.dataSource =self;
    LISTASELECT.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 1)];
    LISTASELECT.tableFooterView.backgroundColor=[UIColor blackColor];
    LISTASELECT.separatorColor = [UIColor clearColor];
    
    self.CORPDATE =CORPDATE;
    _currentPage =1;
    _currentPagePreferate =1;
    numarpagini=0;
    numarpaginipreferate =0;
    if([self checkDictionary:CORPDATE]) {
        if(CORPDATE[@"pagina_curenta_trimisa"]) {
            _currentPage =(int)[CORPDATE[@"pagina_curenta_trimisa"]integerValue]; //se va face ++ btw
            NSLog(@"_currentpg %i", _currentPage);
        }
        if(CORPDATE[@"pagina_curenta_preferate"]) {
            _currentPagePreferate =(int)[CORPDATE[@"pagina_curenta_preferate"]integerValue]; //se va face ++ btw
            NSLog(@"_currentPagePreferate %i", _currentPagePreferate);
        }
        
        if(CORPDATE[@"count_all"]) {
            int  round =0;
            int  cateintotal =[CORPDATE[@"count_all"] intValue];
            double originalFloat =(double)cateintotal/ PE_PAGINA.intValue;
            NSLog(@"originalFloat %f / %i ** %i %f", originalFloat,PE_PAGINA.intValue,[CORPDATE[@"count_all"] intValue],(double)cateintotal/ PE_PAGINA.intValue );
            if(originalFloat - (int)originalFloat > 0) {
                originalFloat += 1;
                round = (int)originalFloat;
            } else {
                round = (int)originalFloat;
            }
            NSLog(@"round dmc %i", round);
            numarpagini =round;
        }
        if(CORPDATE[@"count_prefered_only"]) {
            int  round =0;
            int  catepreferate =[CORPDATE[@"count_prefered_only"] intValue];
            double originalFloat =(double)catepreferate/ PE_PAGINA.intValue;
            NSLog(@"originalFloat %f / %i ** %i %f", originalFloat,PE_PAGINA.intValue,[CORPDATE[@"count_prefered_only"] intValue],(double)catepreferate/ PE_PAGINA.intValue );
            if(originalFloat - (int)originalFloat > 0) {
                originalFloat += 1;
                round = (int)originalFloat;
            } else {
                round = (int)originalFloat;
            }
            NSLog(@"round dmc preferate %i", round);
            numarpaginipreferate =round;
        }
        self.dynamicHEADLEFT.constant =-53;
        //dictionar detaliu cerere
        if([self checkDictionary:CORPDATE[@"cerere"]]) {
            DETALIUCERERE =CORPDATE[@"cerere"];
            if(DETALIUCERERE[@"images"]) {
                
                NSArray *imagini = [NSArray arrayWithArray:DETALIUCERERE[@"images"]];
                if(imagini.count >0) {
                    NSDictionary *imagine = [imagini objectAtIndex:0];
                    if(imagine[@"tb"]) {
                        NSString *stringurlthumbnail = [NSString stringWithFormat:@"%@", imagine[@"tb"]];
                        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
                            [self.pozacerere sd_setImageWithURL:[NSURL URLWithString:stringurlthumbnail]
                                               placeholderImage:nil
                                                      completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                          //  ... completion code here ...
                                                          if(image) {
                                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                                  self.pozacerere.image = image;
                                                                  self.dynamicHEADLEFT.constant =8;
                                                              });
                                                              
                                                          } else {
                                                              self.pozacerere.image = nil;
                                                              self.dynamicHEADLEFT.constant =-53;
                                                          }
                                                      }];
                        });
                    }
                    
                }
            }
            double inaltimerand1 =0; //label titlu cerere
            double inaltimerand2 =0; //label masina an etc.
            /* title, marca_id, model_id, talon_an_fabricatie, motorizare, talon_tip_varianta, talon_nr_identificare */
            NSString *TITLUCERERE =@"";
            NSString *PRODUCATORAUTODEF =@"";
            NSString *MARCAAUTODEF =@"";
            NSString *ANMASINA = @"";
            //JCOMMENT           NSString *VARIANTA = @"";
            //                   NSString *MOTORIZARE =@"";
            //                   NSString *SERIESASIU =@"";
            NSString *titlucompus =@"";
            NSString *PRODUCATORAUTONAME =@"";
            NSString *MARCAAUTONAME =@"";
            idcerere =@"";
            NSMutableArray *dateetichetacerere = [[NSMutableArray alloc]init];
            self.dynamicINALTIMETITLUCERERE.constant =30;
            //////// dynamicINALTIMETITLUCERERE,dynamicINALTIMEMASINACERERE,dynamicINALTIMEHEADER
            if(DETALIUCERERE[@"title"]) {
                TITLUCERERE = [NSString stringWithFormat:@"%@",DETALIUCERERE[@"title"]];
                if(![self MyStringisEmpty:TITLUCERERE]) {
                    //  [dateetichetacerere addObject:TITLUCERERE];
                    int margine = self.dynamicHEADLEFT.constant;
                    
                    CGFloat widthWithInsetsApplied =0;
                    if(margine ==-53) {
                        widthWithInsetsApplied = self.view.frame.size.width- 10;
                        
                    } else {
                        widthWithInsetsApplied = self.view.frame.size.width- 53;
                        
                    }
                    self.numecerere.text = TITLUCERERE;
                    self.numecerere.verticalAlignment =TTTAttributedLabelVerticalAlignmentTop;
                    CGSize textSize = [TITLUCERERE boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18]} context:nil].size;
                    
                    UIFont *tester = [UIFont boldSystemFontOfSize:18];
                    double numberOfLines = textSize.height /tester.pointSize;
                    if(numberOfLines >=2) {
                        inaltimerand1 = 46;
                        self.numecerere.numberOfLines =2;
                    } else {
                        inaltimerand1 = 26;
                        self.numecerere.numberOfLines =1;
                    }
                    
                    self.dynamicINALTIMETITLUCERERE.constant =inaltimerand1;
                    
                }
                
            }
            
            if(DETALIUCERERE[@"marca_id"]){
                PRODUCATORAUTODEF = [NSString stringWithFormat:@"%@",DETALIUCERERE[@"marca_id"]];
                NSDictionary *PRODbaza = [DataMasterProcessor getProducator:PRODUCATORAUTODEF];
                if(PRODbaza && PRODbaza[@"name"]) {
                    PRODUCATORAUTONAME = [NSString stringWithFormat:@"%@",PRODbaza[@"name"]];
                    if(![self MyStringisEmpty:PRODUCATORAUTONAME]) {
                        [dateetichetacerere addObject:PRODUCATORAUTONAME];
                    }
                }
            }
            if(DETALIUCERERE[@"model_id"]){
                MARCAAUTODEF = [NSString stringWithFormat:@"%@",DETALIUCERERE[@"model_id"]];
                NSDictionary *MARCAbaza = [DataMasterProcessor getMarcaAuto:MARCAAUTODEF];
                if(MARCAbaza && MARCAbaza[@"name"]) {
                    MARCAAUTONAME = [NSString stringWithFormat:@"%@",MARCAbaza[@"name"]];
                    if(![self MyStringisEmpty:MARCAAUTONAME]) {
                        [dateetichetacerere addObject:MARCAAUTONAME];
                    }
                }
            }
            if(DETALIUCERERE[@"talon_an_fabricatie"]) {
                ANMASINA = [NSString stringWithFormat:@"%@",DETALIUCERERE[@"talon_an_fabricatie"]];
                if(![self MyStringisEmpty:ANMASINA]) {
                    [dateetichetacerere addObject:ANMASINA];
                }
            }
            //jcomment out            if(DETALIUCERERE[@"motorizare"]) {
            //                MOTORIZARE = [NSString stringWithFormat:@"%@",DETALIUCERERE[@"motorizare"]];
            //                if(![self MyStringisEmpty:MOTORIZARE]) {
            //                    [dateetichetacerere addObject:MOTORIZARE];
            //                }
            //            }
            //            if(DETALIUCERERE[@"talon_tip_varianta"]) {
            //                VARIANTA=[NSString stringWithFormat:@"%@",DETALIUCERERE[@"talon_tip_varianta"]];
            //                if(![self MyStringisEmpty:VARIANTA]) {
            //                    [dateetichetacerere addObject:VARIANTA];
            //                }
            //            }
            //            if(DETALIUCERERE[@"talon_nr_identificare"]) {
            //                SERIESASIU = [NSString stringWithFormat:@"%@",DETALIUCERERE[@"talon_nr_identificare"]];
            //                if(![self MyStringisEmpty:SERIESASIU]) {
            //                    [dateetichetacerere addObject:SERIESASIU];
            //                }
            //            }
            titlucompus = [NSString stringWithFormat:@"%@", [dateetichetacerere componentsJoinedByString:@" "]];
            
            self.masinacerere.text = titlucompus;
            self.masinacerere.verticalAlignment =TTTAttributedLabelVerticalAlignmentTop;
            int margine = self.dynamicHEADLEFT.constant;
            CGFloat widthWithInsetsApplied =0;
            if(margine ==-53) {
                widthWithInsetsApplied = self.view.frame.size.width- 10;
                
            } else {
                widthWithInsetsApplied = self.view.frame.size.width- 53;
                
            }
            
            CGSize textSize = [titlucompus boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18]} context:nil].size;
            UIFont *tester = [UIFont boldSystemFontOfSize:18];
            double numberOfLines = textSize.height /tester.pointSize;
            if(numberOfLines >=2) {
                inaltimerand2 = 46;
                self.masinacerere.numberOfLines =2;
            } else {
                inaltimerand2 = 26;
                self.masinacerere.numberOfLines =1;
            }
            self.dynamicINALTIMEMASINACERERE.constant =inaltimerand2;
            self.dynamicINALTIMEHEADER.constant = inaltimerand1 + inaltimerand2; //43 minim cand are doar cate 1 rand de text pe cele 2 labels
            NSLog(@"hrw %f  hde %f  cws %f",inaltimerand1,inaltimerand2, self.dynamicINALTIMEHEADER.constant  );
            
            /////j   dynamicINALTIMEMASINACERERE
        }
        
        //id cerere
        if(DETALIUCERERE[@"id"]) {
            idcerere =[NSString stringWithFormat:@"%@", DETALIUCERERE[@"id"]];
        }
        if(CORPDATE[@"items"]) {
            self.TOATE = [NSMutableArray arrayWithArray:CORPDATE[@"items"]];
            NSLog(@"self.toate %@", self.TOATE);
        }
        //si cam atat la did  load -> vezi metoda de update oferte in launchreload
    }
    // self.navigationController.navigationBar.clipsToBounds = YES;
    
    // Do any additional setup after loading the view, typically from a nib.
    //
    [self removehud];
    if(![self MyStringisEmpty:idcerere]) {
        _currentPagePreferate =1;
        
        NSString *pagina = [NSString stringWithFormat:@"%i", _currentPagePreferate];
        utilitar = [[Utile alloc]init];
        NSString *authtoken=@"";
        BOOL elogat = NO;
        elogat = [utilitar eLogat];
        if(elogat) {
            authtoken = [utilitar AUTHTOKEN];
            // -(void) list_offers_per_cerere :(NSString *)AUTHTOKEN :(NSString *)PAGE :(NSString *)PER_PAGE :(NSString *)cerere_id :(NSString *)prefered_only :(NSString*)cerere_details :(NSString*)tip{ //tip e toate sau preferate
            [self list_offers_per_cerere:authtoken :pagina :PE_PAGINA :idcerere  :@"1" :@"0" :@"preferate"]; //prima oara in load ia si preferate dupa la scroll pe table view aduce mai multe se incremeneaza pagina curenta vezi launchReload
        }
    }
    //round dmc preferate  "count_prefered_only" = 1;
    NSLog(@"corp DATE %@", CORPDATE);
    NSString *textsegment1 =@"";
    if(CORPDATE[@"count_prefered_only"]){
        NSString *catepreferate= [NSString stringWithFormat:@"%@",CORPDATE[@"count_prefered_only"]];
        textsegment1 = [NSString stringWithFormat:@"Preferate (%@)",catepreferate];
    } else {
        textsegment1 = [NSString stringWithFormat:@"Preferate (%i)",(int)PREFERATE.count];
    }
    NSString *textsegment0 = [NSString stringWithFormat:@"Toate (%i)", (int)TOATE.count];
    
    [self.SEGCNTRL setTitle:textsegment0 forSegmentAtIndex:0];
    [self.SEGCNTRL setTitle:textsegment1 forSegmentAtIndex:1];
    
    btniconpreferate = [[UIButton alloc]init];
    [btniconpreferate setBackgroundImage:[UIImage imageNamed:@"Icon_Preferata_Blue_144x144.png"] forState:UIControlStateNormal];
    [btniconpreferate setBackgroundImage:[UIImage imageNamed:@"Icon_Preferata_Alba_144x144.png"] forState:UIControlStateHighlighted];
    
    CGRect desiredframe =CGRectMake(self.view.frame.size.width/2 +2,6, 15, 15);
    btniconpreferate.frame = desiredframe;
    [self.SEGCNTRL addSubview:btniconpreferate];
    [self.SEGCNTRL bringSubviewToFront:btniconpreferate];
    UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(vezidetaliucerere)];
    [singleTap setNumberOfTapsRequired:1];
    [HEADERCERERE setUserInteractionEnabled:YES];
    [HEADERCERERE addGestureRecognizer:singleTap];
    nuaipreferate.numberOfLines =0;
    [self aratalbelnuaipreferate];
    
    [self.navigationController setNavigationBarHidden:NO]; self.navigationItem.leftBarButtonItem=nil;
    
    self.navigationController.navigationItem.hidesBackButton = YES;
    
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
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    

}
-(void)aratalbelnuaipreferate {
    if(self.SEGCNTRL.selectedSegmentIndex ==1) {
       if(self.PREFERATE.count ==0) {
            nuaipreferate.text=@"Nu ai marcat nicio ofertă ca preferată";
            nuaipreferate.hidden=NO;
        } else {
            nuaipreferate.hidden=YES;
        }
    } else {
        if(self.TOATE.count ==0) {
            nuaipreferate.text=@"Momentan nu sunt oferte";
            nuaipreferate.hidden=NO;
        } else {
            nuaipreferate.hidden=YES;
        }
    }
}


-(void)vezidetaliucerere{
    if(E_DIN_DETALIU_CERERE ==YES ) {
        [self perfecttimeforback];
    } else {
    NSLog(@"id cerere de trimis la detaliu %@ ---- %@",idcerere,CORPDATE);
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    del.POZECERERE=[[NSMutableArray alloc]init];
    del.ARRAYASSETURI=[[NSMutableArray alloc]init];
    del.ARRAYASSETURIEXTERNE=[[NSMutableArray alloc]init];
    del.cererepiesa =[[NSMutableDictionary alloc]init];
    
   
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
    if(DETALIUCERERE[@"id"]) idcerere =[NSString stringWithFormat:@"%@", DETALIUCERERE[@"id"]];
    if(DETALIUCERERE[@"localitate_id"]) LOCALITATEID =[NSString stringWithFormat:@"%@", DETALIUCERERE[@"localitate_id"]];
    if(DETALIUCERERE[@"judet_id"]) JUDETID =[NSString stringWithFormat:@"%@", DETALIUCERERE[@"judet_id"]];
    if(DETALIUCERERE[@"want_new"]) IS_NEW =[NSString stringWithFormat:@"%@", DETALIUCERERE[@"want_new"]];
    if(DETALIUCERERE[@"want_second"]) IS_SECOND =[NSString stringWithFormat:@"%@", DETALIUCERERE[@"want_second"]];
    if(DETALIUCERERE[@"remake_id"]) REMAKE_ID =[NSString stringWithFormat:@"%@", DETALIUCERERE[@"remake_id"]];
    IDCERERE = idcerere;
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
    [cererepiesa setObject:CORPDATE forKey:@"CEREREFULLINFO"]; //avem nevoie si de corpul cererii
       del.reposteazacerere =NO;
    if(DETALIUCERERE[@"images"]) {
        del.ARRAYASSETURI = [[NSMutableArray alloc]init];
        del.ARRAYASSETURI = [NSMutableArray arrayWithArray:DETALIUCERERE[@"images"]];
        NSLog(@"del.pozecer %@", del.ARRAYASSETURI);
        del.POZECERERE = del.ARRAYASSETURI;
    }
    del.cererepiesa =cererepiesa;
    NSString *authtoken=@"";
    BOOL elogat = NO;
    elogat = [utilitar eLogat];
    if(elogat) {
        authtoken = [utilitar AUTHTOKEN];
        [self get_comments:IDCERERE :@"cerereid" :authtoken]; //adu si comentarii  []comments
    }
    }
}
-(void)image:(UIImage *)image
finishedSavingWithError:(NSError *)error
 contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    } else {
        NSLog(@"fiin");
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
-(NSMutableArray*)update_list_offers :(NSMutableArray *)get_list_offers :(NSString *)status {
    NSMutableArray *lista_cereri = get_list_offers;
    
    if([status isEqualToString:@"toate"]) {
        for(NSDictionary *itemnou in lista_cereri) {
            if(![self.TOATE containsObject:itemnou]) {
                [self.TOATE addObject:itemnou];
            }
        }
            [self removehud];
    }
    if([status isEqualToString:@"preferate"]) {
        for(NSDictionary *itemnou in lista_cereri) {
            if(![self.PREFERATE containsObject:itemnou]) {
                [self.PREFERATE addObject:itemnou];
            }
        }
            [self removehud];

    }
    [self.LISTASELECT setNeedsLayout];
    [self.LISTASELECT setNeedsDisplay];
  
    [self removehud];
    return lista_cereri;
}

-(void)viewDidAppear:(BOOL)animated {
     [self.LISTASELECT reloadData];
     [self removehud];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   }


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int numarranduri =0;
    if(self.SEGCNTRL.selectedSegmentIndex ==0) {
        NSDictionary *sectionsirows = [self.TOATE objectAtIndex:section];
        NSArray *sectionToate = [NSArray arrayWithArray:[sectionsirows objectForKey:@"items"]];
        numarranduri =(int)[sectionToate count];
    } else   if(self.SEGCNTRL.selectedSegmentIndex ==1) {
        NSDictionary *sectionsirows = [self.PREFERATE objectAtIndex:section];
        NSArray *sectionPreferate =  [NSArray arrayWithArray:[sectionsirows objectForKey:@"items"]];
        numarranduri =(int)[sectionPreferate count];
    }
    NSLog(@"numarranduri %i",numarranduri);
    return numarranduri;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int inaltimerand = 35;
      NSDictionary *cerererow = [[NSDictionary alloc]init];
    if(self.SEGCNTRL.selectedSegmentIndex ==0) {
        cerererow = [self.TOATE objectAtIndex:indexPath.section];
    } else if(self.SEGCNTRL.selectedSegmentIndex ==1) {
        cerererow =  [self.PREFERATE objectAtIndex:indexPath.section];
    }
  
    NSLog(@"indexpath section %ld",(long)indexPath.section);
    if(self.SEGCNTRL.selectedSegmentIndex ==0) {
      
        NSLog(@"cerererowcerererow %@",cerererow);
        NSInteger verificawinner =0;
       
        if(cerererow[@"winner"]) {
            NSString *checkitnow = [NSString stringWithFormat:@"%@", cerererow[@"winner"]];
            verificawinner =checkitnow.integerValue;
            NSLog(@"cerere row verifica %li", (long)verificawinner);
        }
         NSString *C_titlu =@"";
        
        double inaltimepoza =0;
        double LEFTPOZAOFERTA=15;
        if(cerererow[@"items"]) {
            NSArray *itemoferta= cerererow[@"items"];
           NSDictionary *detaliuoferta  = [itemoferta objectAtIndex:indexPath.row];
            NSLog(@"detaliuofertadetaliuoferta%@",detaliuoferta);
       if(detaliuoferta[@"description"]) C_titlu = [NSString stringWithFormat:@"%@",detaliuoferta[@"description"]];
        NSLog(@"thiw %@", C_titlu);
        if(cerererow[@"images"] ) {
            NSArray *imagini = [NSArray arrayWithArray:cerererow[@"images"]];
            if(imagini.count >0) {
                NSDictionary *imagine = [imagini objectAtIndex:0];
                if(imagine[@"tb"]) {
                    inaltimepoza =40;
                    LEFTPOZAOFERTA =45;
                }
            }
        }
        
        CGFloat widthWithInsetsApplied = self.view.frame.size.width - LEFTPOZAOFERTA;
        CGSize textSize = [C_titlu boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
        UIFont *tester = [UIFont systemFontOfSize:18];
        double numberOfLines = textSize.height /tester.pointSize;
        NSLog(@"textssss %f",textSize.height );
        if(verificawinner ==1) {
            if(indexPath.row ==0 ) {
            if(numberOfLines >2) {
                inaltimerand = 125;
            } else  {
                if( inaltimepoza ==0) {
                    inaltimerand = 100;
                } else {
                    inaltimerand = 125;
                }
            }
            }
            else {
                if(numberOfLines >2) {
                    inaltimerand = 110;
                } else  {
                    if( inaltimepoza ==0) {
                        inaltimerand = 80;
                    } else {
                        inaltimerand = 90;
                    }
                }
            }
        }     else {
            if(numberOfLines >2) {
                inaltimerand = 110;
            } else  {
                if( inaltimepoza ==0) {
                    inaltimerand = 80;
                } else {
                    inaltimerand = 90;
                }
            }
        }
        }
    }
    else if(self.SEGCNTRL.selectedSegmentIndex ==1) {
      
        NSInteger verificawinner =0;
        if(cerererow[@"winner"]) {
            NSString *checkitnow = [NSString stringWithFormat:@"%@", cerererow[@"winner"]];
            verificawinner =checkitnow.integerValue;
            NSLog(@"cerere row verifica %li", (long)verificawinner);
        }
        NSString *C_titlu =@"";
        
        double inaltimepoza =0;
        double LEFTPOZAOFERTA=15;
        if(cerererow[@"description"]) C_titlu = [NSString stringWithFormat:@"%@",cerererow[@"description"]];
        if(cerererow[@"images"] ) {
            NSArray *imagini = [NSArray arrayWithArray:cerererow[@"images"]];
            if(imagini.count >0) {
                NSDictionary *imagine = [imagini objectAtIndex:0];
                if(imagine[@"tb"]) {
                    inaltimepoza =40;
                    LEFTPOZAOFERTA =45;
                }
            }
        }
        
        C_titlu = [NSString stringWithFormat:@"%@",cerererow[@"description"]];
        CGFloat widthWithInsetsApplied = self.view.frame.size.width - LEFTPOZAOFERTA;
        CGSize textSize = [C_titlu boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
        UIFont *tester = [UIFont systemFontOfSize:18];
        double numberOfLines = textSize.height /tester.pointSize;
        if(verificawinner ==1) {
            if(indexPath.row ==0 ) {
                if(numberOfLines >2) {
                    inaltimerand = 125;
                } else  {
                    if( inaltimepoza ==0) {
                        inaltimerand = 100;
                    } else {
                        inaltimerand = 125;
                    }
                }
            }
            else {
                if(numberOfLines >2) {
                    inaltimerand = 110;
                } else  {
                    if( inaltimepoza ==0) {
                        inaltimerand = 70;
                    } else {
                        inaltimerand = 90;
                    }
                }
                
                
            }
        }     else {
            if(numberOfLines >2) {
                inaltimerand = 90;
            } else  {
                if( inaltimepoza ==0) {
                    inaltimerand = 70;
                } else {
                    inaltimerand = 90;
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
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"";
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
    
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Background color
    view.tintColor = [UIColor darkGrayColor];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // return 1;
    NSInteger NRSECTIUNI =0;
    if(self.SEGCNTRL.selectedSegmentIndex ==0) {
        NRSECTIUNI = self.TOATE.count; //
    } else   if(self.SEGCNTRL.selectedSegmentIndex ==1) {
        NRSECTIUNI = self.PREFERATE.count;
    }
    NSLog(@"NRSECTIUNI %li %@",(long)NRSECTIUNI,self.PREFERATE);
    return NRSECTIUNI;
}
-(void)launchReload {
    //  pagina curenta _currentPage
    //  pagina curenta rezolvate  _currentPageRezolvate
    // increase page
    if(self.SEGCNTRL.selectedSegmentIndex ==0) {
        if(_currentPage < numarpagini) {
            _currentPage ++;
            NSString *pagina = [NSString stringWithFormat:@"%i", _currentPage];
            utilitar = [[Utile alloc]init];
            NSString *authtoken=@"";
            BOOL elogat = NO;
            elogat = [utilitar eLogat];
            if(elogat) {
                authtoken = [utilitar AUTHTOKEN];
                //  -(void) list_offers_per_cerere :(NSString *)AUTHTOKEN :(NSString *)PAGE :(NSString *)PER_PAGE :(NSString *)cerere_id :(NSString *)prefered_only :(NSString*)cerere_details :(NSString*)tip{ //tip e toate sau preferate
                [self list_offers_per_cerere:authtoken :pagina :PE_PAGINA :idcerere  :@"0" :@"0" :@"toate"]; // 0 -> toate , 0 pentru ca a tras detalii cerere, @"toate
            }
        }
    }
    else  if(self.SEGCNTRL.selectedSegmentIndex ==1) {
        if(_currentPagePreferate < numarpaginipreferate) {
            _currentPagePreferate ++;
            NSString *pagina = [NSString stringWithFormat:@"%i", _currentPagePreferate];
            
            utilitar = [[Utile alloc]init];
            NSString *authtoken=@"";
            BOOL elogat = NO;
            elogat = [utilitar eLogat];
            if(elogat) {
                authtoken = [utilitar AUTHTOKEN];
                // -(void) list_offers_per_cerere :(NSString *)AUTHTOKEN :(NSString *)PAGE :(NSString *)PER_PAGE :(NSString *)cerere_id :(NSString *)prefered_only :(NSString*)cerere_details :(NSString*)tip{ //tip e toate sau preferate
                [self list_offers_per_cerere:authtoken :pagina :PE_PAGINA :idcerere  :@"1" :@"0" :@"preferate"];// 1 -> doar preferate , 0 pentru ca a tras detalii cerere , @"preferate"
            }
        }
    }
}

-(void)schimbaSegment{
    NSArray *cells = [self.LISTASELECT visibleCells];
    for(UIView *view in cells){
        if([view isMemberOfClass:[CellListaOferteRow class]]){
            CellListaOferteRow *cell = (CellListaOferteRow *) view;
            if ([cell.contentView subviews]){
                for (UIView *subview in [cell.contentView subviews]) {
                    if([subview isKindOfClass:[CustomBadge class]]){
                        [subview removeFromSuperview];
                    }
                }
            }
        }
    }
    if(self.SEGCNTRL.selectedSegmentIndex ==1) {
        [btniconpreferate setHighlighted:YES];
        
    } else {
        [btniconpreferate setHighlighted:NO];
        
    }
    [self aratalbelnuaipreferate];
    [self.LISTASELECT setContentOffset:CGPointZero animated:NO];
    [self.LISTASELECT reloadData];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *ofertaROW =[[NSDictionary alloc]init];
    static NSString *CellIdentifier = @"CellListaOferteRow";
    CellListaOferteRow *cell = [self.LISTASELECT dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (CellListaOferteRow*)[self.LISTASELECT dequeueReusableCellWithIdentifier:@"CellListaOferteRow"];
    }
    for (UIView *subview in [cell.contentView subviews]) {
        if([subview isKindOfClass:[CustomBadge class]]){
            [subview removeFromSuperview];
        }
    }
    
    cell.sageatagri.hidden =NO;
    cell.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1];
    cell.pozaRow.hidden =YES;
    cell.pozaRow.contentMode =UIViewContentModeScaleAspectFit;
    cell.TitluRand.textColor =  [UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] ;
    cell.favoritagri.hidden=YES;
    cell.cupaverde.hidden =YES;
    cell.verdetop.hidden=YES;
    cell.sageatablue.hidden=YES;
    cell.TitluRand.hidden =NO;
    cell.tipoferta.hidden=YES;
    cell.dynamiccellLEFT.constant =6;
    cell.TitluRand.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;

    if(self.SEGCNTRL.selectedSegmentIndex ==0) {
        ofertaROW = [self.TOATE objectAtIndex:indexPath.section];
    } else if(self.SEGCNTRL.selectedSegmentIndex ==1) {
        ofertaROW =  [self.PREFERATE objectAtIndex:indexPath.section];
    }
    NSLog(@"ofertaROW %@ index.path %li",ofertaROW,(long)indexPath.section);
    
    /*
     ofertaROW {
     images =     (
     );
     "is_prefered" = 1;
     "is_viewed" = 1;
     items =     (
     {
     "currency_id" = 41;
     "currency_name" = RON;
     description = "Piesa (ex: Bar\U0103";
     id = 1254767;
     price = 444;
     um = "buc.";
     }
     );
     messageid = 1826655;
     "new_sh" = 1;
     username = bogdanpsc;
     winner = 0;
     }
     
     */
   cell.dynamiccellLEFT.constant =0;
    NSInteger ipx =indexPath.row;
    NSInteger verificawinner =0;
    if(ofertaROW[@"winner"]) {
        NSString *checkitnow = [NSString stringWithFormat:@"%@", ofertaROW[@"winner"]];
        verificawinner =checkitnow.integerValue;
    }
   // jNSLog(@"de verificat %@ siii %li", ofertaROW,(long)verificawinner);
    if(ofertaROW[@"items"]) {
        NSMutableArray *RANDURI=[NSMutableArray arrayWithArray:ofertaROW[@"items"]];
        NSLog(@"itemurile  %@", RANDURI);
        NSString *C_tipnousecond=@"";
        NSDictionary *la0 = [RANDURI objectAtIndex:ipx]; //fiecare sectiune din tabel e practic un rand, asa ca intotdeauna dictionarul va sta la 0
        NSString *C_titlu = [NSString stringWithFormat:@"%@",la0[@"description"]];
        cell.TitluRand.font =[UIFont boldSystemFontOfSize: 18];
        cell.TitluRand.text = C_titlu;
        cell.TitluRand.numberOfLines = 2;
      
        cell.tipoferta.hidden=NO;
        if(ofertaROW[@"new_sh"]) {
            NSString *valoaretipnousecond= [NSString stringWithFormat:@"%@",ofertaROW[@"new_sh"]];
            if(valoaretipnousecond.integerValue ==1) {
                C_tipnousecond =@"Piesă nouă:";
            }
            if(valoaretipnousecond.integerValue ==2) {
                C_tipnousecond =@"Piesă second:";
            }
        }
        cell.tipoferta.text=C_tipnousecond;
        
        NSString *C_leisaualtavaluta =@"";
        NSString *C_pret=@"";
        NSString *C_um =@"";
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
        [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize: 18] range:bigRange];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:mediumRange];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:smallRange];
        cell.pretoferta.attributedText=attributedString;
        [cell.pretoferta sizeToFit];
        
        if(ofertaROW[@"winner"] && verificawinner==1 ){
            if(ipx ==0) {
                NSLog(@"adi:) ");
                cell.verdetop.hidden=NO;
                cell.cupaverde.hidden =NO;
                cell.toptitlurand.constant = 32;
                cell.toppoza.constant = 32;
                cell.favoritagri.hidden=YES;
                cell.cercalbastru.hidden=YES;
                cell.contentView.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(194/255.0f) alpha:1];
            } else {
                cell.contentView.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(194/255.0f) alpha:1];
            }
        }
        else {
            if(ofertaROW[@"is_viewed"]){
                NSInteger verificaisviewed =0;
                NSString *checkitnow = [NSString stringWithFormat:@"%@", ofertaROW[@"is_viewed"]];
                verificaisviewed = checkitnow.integerValue;
                if(verificaisviewed ==1){
                    cell.cercalbastru.hidden=YES;
                } else {
                    cell.cercalbastru.hidden=NO;
                }
            }
            if(ofertaROW[@"is_prefered"]) {
                NSInteger verificaisprefered =0;
                NSString *checkitnow = [NSString stringWithFormat:@"%@", ofertaROW[@"is_prefered"]];
                verificaisprefered = checkitnow.integerValue;
                if(verificaisprefered ==0){
                    cell.favoritagri.hidden=YES;
                } else {
                    cell.favoritagri.hidden=NO;
                    cell.cercalbastru.hidden=YES;
                }
            }
           
            cell.verdetop.hidden=YES;
            cell.toptitlurand.constant = 4;
            cell.toppoza.constant = 4;
            cell.cupaverde.hidden =YES;
            cell.contentView.backgroundColor = [UIColor whiteColor];
        }
        
        cell.pozaRow.image = nil;
        
        NSLog(@"000000000");
        if(ofertaROW[@"images"] ) {
            NSArray *imagini = [NSArray arrayWithArray:ofertaROW[@"images"]];
            if(imagini.count >0) {
                NSDictionary *imagine = [imagini objectAtIndex:0];
                if(imagine[@"tb"]) {
                    NSString *stringurlthumbnail = [NSString stringWithFormat:@"%@", imagine[@"tb"]];
                   //sdweb is laggy in iOS8 asa ca main  totusi : hmz...
                   
                   dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
                   [cell.pozaRow sd_setImageWithURL:[NSURL URLWithString:stringurlthumbnail]
                                                              placeholderImage:nil
                                                                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                                         //  ... completion code here ...
                                                                         if(image) {
                                                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                                                 CellListaOferteRow *updateCell = (CellListaOferteRow *)[self.LISTASELECT cellForRowAtIndexPath:indexPath];
                                                                                 if (updateCell) {
                                                                                     updateCell.pozaRow.image = image;
                                                                                 updateCell.pozaRow.hidden =NO;
                                                                                 cell.dynamiccellLEFT.constant =63;
                                                                                 } else {
                                                                                   cell.dynamiccellLEFT.constant =0;
                                                                                 }
                                                                                 });
                                                                            
                                                                         }
                                                                     }];
                   });
                }
           
            }else {
                NSLog(@"inainte %f", cell.TitluRand.frame.origin.x);
                cell.dynamiccellLEFT.constant =0; // fara poza
                NSLog(@"dupa %f", cell.TitluRand.frame.origin.x);
            }
        }
        
        
        //      if( ipx ==0 && RANDURI.count ==1) {
        //           cell.sageatagri.hidden =NO;
        //
        //      } else  if( RANDURI.count ==1 ) {
        //           cell.sageatagri.hidden =NO;
        //
        //      } else
        NSLog(@"ipx row %li", (long)ipx);
        
        if(indexPath.row ==RANDURI.count-1  &&  RANDURI.count >0) { //e ultimul row si ii trebuie sageata
            cell.sageatagri.hidden =NO;
            cell.pozaRow.hidden =YES;
            cell.dynamiccellLEFT.constant =0;
// s-au stabilit mai sus conditiile
// cell.cercalbastru.hidden=YES;
// cell.favoritagri.hidden=YES;
        }
        else {
            cell.sageatagri.hidden =YES;
            cell.pozaRow.hidden =YES;
            cell.dynamiccellLEFT.constant =0;
//            cell.cercalbastru.hidden=YES;
//            cell.favoritagri.hidden=YES;
//            e intermediar fara poza, sageata, buline
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(self.SEGCNTRL.selectedSegmentIndex ==0) {
            if (indexPath.row == [self.TOATE count] - 1)
            {
                [self launchReload];
            }
        }
        if(self.SEGCNTRL.selectedSegmentIndex ==1) {
            if (indexPath.row == [self.PREFERATE count] - 1)
            {
                [self launchReload];
            }
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // [LISTASELECT cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *cerererow =[[NSMutableDictionary alloc]init];
    NSInteger ipx = indexPath.section;
    if(self.SEGCNTRL.selectedSegmentIndex ==0) {
        cerererow = [NSMutableDictionary dictionaryWithDictionary:[self.TOATE objectAtIndex:indexPath.section]];
        NSMutableDictionary *notificarerow =[[NSMutableDictionary alloc]init];
        notificarerow = [NSMutableDictionary dictionaryWithDictionary:cerererow];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"notificarerow %@",notificarerow);
            [notificarerow setValue:@"1" forKey:@"is_viewed"];
            NSMutableArray *copie = [self.TOATE mutableCopy];
            [copie replaceObjectAtIndex:ipx withObject:notificarerow];
            self.TOATE = copie;
           [self.LISTASELECT reloadData];
        });

        
    } else   if(self.SEGCNTRL.selectedSegmentIndex ==1) {
        cerererow =  [NSMutableDictionary dictionaryWithDictionary:[self.PREFERATE objectAtIndex:indexPath.section]];
        NSMutableDictionary *notificarerow =[[NSMutableDictionary alloc]init];
        notificarerow = [NSMutableDictionary dictionaryWithDictionary:cerererow];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"notificarerow %@",notificarerow);
            [notificarerow setValue:@"1" forKey:@"is_viewed"];
            NSMutableArray *copie = [self.PREFERATE mutableCopy];
            [copie replaceObjectAtIndex:ipx withObject:notificarerow];
            self.PREFERATE = copie;
            [self.LISTASELECT reloadData];
        });
    }
   
  
    
    NSString *ofertaid = [NSString stringWithFormat:@"%@",cerererow[@"messageid"]];
    if(cerererow)
    utilitar = [[Utile alloc]init];
    NSString *authtoken=@"";
    BOOL elogat = NO;
    elogat = [utilitar eLogat];
    if(elogat) {
        authtoken = [utilitar AUTHTOKEN];
        [self getOffer:ofertaid :authtoken];
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

-(bool)checkDictionary:(NSDictionary *)dict{
    if(dict == nil || [dict class] == [NSNull class] || ![dict isKindOfClass:[NSDictionary class]]){
        return NO;
    }
    return  YES;
}



//METODE

//METODA_LIST_OFFERS
-(void) list_offers_per_cerere :(NSString *)AUTHTOKEN :(NSString *)PAGE :(NSString *)PER_PAGE :(NSString *)cerere_id :(NSString *)prefered_only :(NSString*)cerere_details :
(NSString*)tip{ //tip e toate sau preferate
    
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
                    NSLog(@"date oferte raspuns %@",multedate);
                    
                    if([tip isEqualToString:@"toate"]) {
                        if(multedate[@"count_all"] ) {
                             NSString *textsegment0 = [NSString stringWithFormat:@"Toate (%@)", multedate[@"count_all"]];
                              [self.SEGCNTRL setTitle:textsegment0 forSegmentAtIndex:0];
                        }
                         if(multedate[@"count_prefered_only"] ) {
                        NSString *textsegment1  = [NSString stringWithFormat:@"Preferate (%@)",multedate[@"count_prefered_only"]];
                                  [self.SEGCNTRL setTitle:textsegment1 forSegmentAtIndex:1];
                         }
                        if(multedate[@"items"]) {
                            NSMutableArray *toateofertele =[NSMutableArray arrayWithArray: multedate[@"items"]];
                            if(toateofertele.count >0) {
                                NSLog(@"date toate ofertele %@",toateofertele);
                                [self update_list_offers:toateofertele:@"toate"];
                            } else {
                                [self removehud];
                            }
                        }
                    } else    if([tip isEqualToString:@"preferate"]) {
                        if(multedate[@"count_all"] ) {
                            NSString *textsegment0 = [NSString stringWithFormat:@"Toate (%@)", multedate[@"count_all"]];
                            [self.SEGCNTRL setTitle:textsegment0 forSegmentAtIndex:0];
                        }
                        if(multedate[@"count_prefered_only"] ) {
                            NSString *textsegment1  = [NSString stringWithFormat:@"Preferate (%@)",multedate[@"count_prefered_only"]];
                            [self.SEGCNTRL setTitle:textsegment1 forSegmentAtIndex:1];
                        }
                        if(multedate[@"items"]) {
                            NSMutableArray *toateofertele =[NSMutableArray arrayWithArray: multedate[@"items"]];
                            
                            if(toateofertele.count >0) {
                                NSLog(@"date toate ofertele preferate %@",toateofertele);
                                
                                [self update_list_offers:toateofertele:@"preferate"];
                            } else {
                                [self removehud];
                            }
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
        NSString *currentSysVer = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] systemVersion]];
        [dic2 setObject:@"iOS" forKey:@"os"];
        [dic2 setObject:currentSysVer forKey:@"version"]; //  vers iOS
        [dic2 setObject:@"ro" forKey:@"lang"];
        [dic2 setObject:authtoken forKey:@"authtoken"];
        [dic2 setObject:ID_OFERTA forKey:@"offer_id"];
      //////  [dic2 setObject:@"1" forKey:@"is_viewed"];
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
                    self.DETALIUOFERTA = multedate;
                    [self removehud];
                    DetaliuOfertaViewController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"DetaliuOfertaVC"];
                    vc.CORPDATE = self.DETALIUOFERTA;
                    [self.navigationController pushViewController:vc animated:NO];
                }
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self removehud];
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
-(void)get_comments :(NSString*)CERERESAUOFERTAID :(NSString*)TIP :(NSString*)authtoken {
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
                    NSLog(@"date comentarii %@",multedate);
                    if([TIP isEqualToString:@"cerereid"]) {
                        self.comentariicerere =multedate;
                        CerereExistentaViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CerereExistentaViewVC"];
                        vc.intrebaridelaaltii = [[NSMutableDictionary alloc]init];
                        vc.intrebaridelaaltii = self.comentariicerere;
                        NSLog(@"self.comentariicerere%@",self.comentariicerere);
                        [self.navigationController pushViewController:vc animated:YES ];
                        } else  if([TIP isEqualToString:@"ofertaid"]) {
                        self.comentariicerere =multedate;
                        [self removehud];
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
/*
 
 //    if(ipx==0 ) { // este primul row si ii trebuie buline si poza eventual si winner
 //                    NSIndexPath *myindexPath =[NSIndexPath indexPathForRow:0 inSection:0];
 //                if( indexPath ==myindexPath){
 //                    if(self.SEGCNTRL.selectedSegmentIndex ==0) {
 //                        ofertacastigatoare =  [self.TOATE objectAtIndex:myindexPath.section];
 //                        if(ofertacastigatoare[@"winner"] && [ofertacastigatoare[@"winner"]integerValue]==0) {
 //                            cell.verdetop.hidden=NO;
 //                            cell.cupaverde.hidden =NO;
 //                        } else {
 //                            cell.verdetop.hidden=YES;
 //                            NSLog(@"inainte %f",cell.toptitlurand.constant );
 //                            cell.toptitlurand.constant = -22;
 //                             NSLog(@"dupa %f",cell.toptitlurand.constant );
 //                            cell.cupaverde.hidden =YES;
 //                        }
 //                    } else   if(self.SEGCNTRL.selectedSegmentIndex ==1) {
 //                        ofertacastigatoare =  [self.PREFERATE objectAtIndex:indexPath.section];
 //                        if(ofertacastigatoare[@"winner"] && [ofertacastigatoare[@"winner"]integerValue]==0) {
 //                            cell.verdetop.hidden=NO;
 //                             cell.cupaverde.hidden =NO;
 //                        } else {
 //                            cell.verdetop.hidden=YES;
 //                            cell.toptitlurand.constant = -22;
 //                            cell.cupaverde.hidden =YES;
 //                        }
 //                    }
 //nu uita  aici e pus de test sa se vada cell pt castigatoare ar trebui sa vina intotdeauna prima de la server */

/*
 
 //
 //                    if(detaliupoza[@"tb"]) {
 //                        NSString *calepozaserver = [NSString stringWithFormat:@"%@",detaliupoza[@"tb"]];
 //                        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
 //                            NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL: [NSURL URLWithString:calepozaserver] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
 //                                if (data) {
 //                                    UIImage *image = [UIImage imageWithData:data];
 //                                    if (image) {
 //                                        dispatch_async(dispatch_get_main_queue(), ^{
 //                                            CellCerereExistenta *updateCell = (CellCerereExistenta *)[self.LISTASELECT cellForRowAtIndexPath:indexPath];
 //                                            if (updateCell)
 //                                                updateCell.PozaOferta.image = image;
 //                                            updateCell.PozaOferta.hidden =NO;
 //                                            updateCell.LEFTPOZAOFERTA.constant = 45;
 //                                        });
 //
 //                                    }
 //                                }
 //                            }];
 //                            [task resume];
 //                        });
 //                    }

 */
/*
 {
 cerere =     {
 "date_added" = 1460120729;
 "date_start" = 1460120729;
 description = "";
 "group_id" = 342682;
 id = 342682;
 images =         (
 {
 id = 7293064;
 original = "http://dev5.activesoft.ro/~csaba/4tilance/attachment.php?id=2a05b5cb2f976d01e2e25d2effa561fa";
 tb = "http://dev5.activesoft.ro/~csaba/4tilance/attachment.php?id=2a05b5cb2f976d01e2e25d2effa561fa&cmd=thumb&w=148&h=111";
 }
 );
 "is_cancelled" = 0;
 "is_deleted" = 0;
 "is_solved" = 0;
 "judet_id" = 6;
 "localitate_id" = 450;
 marca = "Alfa-Romeo";
 "marca_id" = 2;
 model = Crosswagon;
 "model_id" = 27;
 motorizare = "2.4TDI";
 "nr_offers" = 5;
 "nr_unread_offers" = 4;
 "remake_id" = 0;
 "talon_an_fabricatie" = 1983;
 "talon_nr_identificare" = SDWTDAF24651WRN;
 "talon_tip_varianta" = "5 usi";
 title = "Bara spate cromata";
 "user_id" = 1198327;
 "want_new" = 1;
 "want_second" = 1;
 "winner_id" = 0;
 };
 "count_all" = 5;
 "count_prefered_only" = 0;
 items =     (
 {
 images =             (
 {
 original = "http://dev5.activesoft.ro/~csaba/4tilance/attachment.php?id=d7dd51de6d6dc3d5e7f320caaaa9580b";
 tb = "http://dev5.activesoft.ro/~csaba/4tilance/attachment.php?id=d7dd51de6d6dc3d5e7f320caaaa9580b&cmd=thumb&w=148&h=111";
 },
 {
 original = "http://dev5.activesoft.ro/~csaba/4tilance/attachment.php?id=3521d0e19bab2c391d91faa71a9d0ad3";
 tb = "http://dev5.activesoft.ro/~csaba/4tilance/attachment.php?id=3521d0e19bab2c391d91faa71a9d0ad3&cmd=thumb&w=148&h=111";
 }
 );
 "is_prefered" = 0;
 "is_viewed" = 0;
 items =             (
 {
 "currency_id" = 14;
 "currency_name" = EUR;
 description = "esa (ex: Bar\U0103 fa\U0163\U0103 Dacia Logan ro\U015fie f\U0103r";
 id = 1254783;
 price = 123;
 um = "buc.";
 }
 );
 messageid = 1826672;
 username = bogdanpsc;
 winner = 0;
 },
 {
 images =             (
 {
 original = "http://dev5.activesoft.ro/~csaba/4tilance/attachment.php?id=07acc4f5b3c9df8b78936e0ca6c42fd4";
 tb = "http://dev5.activesoft.ro/~csaba/4tilance/attachment.php?id=07acc4f5b3c9df8b78936e0ca6c42fd4&cmd=thumb&w=148&h=111";
 },
 {
 original = "http://dev5.activesoft.ro/~csaba/4tilance/attachment.php?id=061bc6fa6fa64825c0d4e28df3d3a327";
 tb = "http://dev5.activesoft.ro/~csaba/4tilance/attachment.php?id=061bc6fa6fa64825c0d4e28df3d3a327&cmd=thumb&w=148&h=111";
 },
 {
 original = "http://dev5.activesoft.ro/~csaba/4tilance/attachment.php?id=d418955af33191f0cc92b5ad0d7298b1";
 tb = "http://dev5.activesoft.ro/~csaba/4tilance/attachment.php?id=d418955af33191f0cc92b5ad0d7298b1&cmd=thumb&w=148&h=111";
 }
 );
 "is_prefered" = 0;
 "is_viewed" = 0;
 items =             (
 {
 "currency_id" = 41;
 "currency_name" = RON;
 description = "a\U0163\U0103 Dacia Logan ro\U015fie f\U0103r\U0103 z";
 id = 1254782;
 price = 333;
 um = "buc.";
 }
 );
 messageid = 1826671;
 username = bogdanpsc;
 winner = 0;
 },
 {
 images =             (
 );
 "is_prefered" = 0;
 "is_viewed" = 0;
 items =             (
 {
 "currency_id" = 41;
 "currency_name" = RON;
 description = "Bar\U0103 fa\U0163\U0103 Dacia Logan ro\U015fie f\U0103r\U0103 zg\U00e2rieturi";
 id = 1254769;
 price = 123;
 um = "buc.";
 }
 );
 messageid = 1826657;
 username = bogdanpsc;
 winner = 0;
 },
 {
 images =             (
 );
 "is_prefered" = 0;
 "is_viewed" = 0;
 items =             (
 {
 "currency_id" = 41;
 "currency_name" = RON;
 description = "Bar\U0103 fa\U0163\U0103 Dacia Logan ro\U015fie f\U0103r\U0103 z";
 id = 1254768;
 price = 342;
 um = "buc.";
 }
 );
 messageid = 1826656;
 username = bogdanpsc;
 winner = 0;
 },
 {
 images =             (
 );
 "is_prefered" = 0;
 "is_viewed" = 1;
 items =             (
 {
 "currency_id" = 41;
 "currency_name" = RON;
 description = "Piesa (ex: Bar\U0103";
 id = 1254767;
 price = 444;
 um = "buc.";
 }
 );
 messageid = 1826655;
 username = bogdanpsc;
 winner = 0;
 }
 );
 "pagina_curenta_preferate" = 0;
 "pagina_curenta_trimisa" = 1;
 "total_count" = 5;
 }
 */
//construieste frumos tot necesarul
/*  [cererepiesa setObject:@"lala" forKey:@"TEXTCERERE"];
 [cererepiesa setObject:@"2" forKey:@"PRODUCATORAUTO"];
 //[cererepiesa setObject:@"a10" forKey:@"MARCAAUTO"];
 [cererepiesa setObject:@"" forKey:@"MARCAAUTO"];
 [cererepiesa setObject:@"1" forKey:@"JUDET"];
 [cererepiesa setObject:@"11" forKey:@"LOCALITATE"];
 [cererepiesa setObject:@"2016" forKey:@"ANMASINA"];
 [cererepiesa setObject:@"motorina" forKey:@"VARIANTA"];
 [cererepiesa setObject:@"diesel" forKey:@"MOTORIZARE"];
 [cererepiesa setObject:@"KWXNNNSNNSS KWXNNNSNNSS KWXNNNSNNSS KWXNNNSNNSS KWXNNNSNNSS KWXNNNSNNSS KWXNNNSNNSS KWXNNNSNNSS KWXNNNSNNSS KWXNNNSNNSS KWXNNNSNNSS KWXNNNSNNSS KWXNNNSNNSS KWXNNNSNNSS KWXNNNSNNSS KWXNNNSNNSS" forKey:@"SERIESASIU"];
 [cererepiesa setObject:@"1" forKey:@"IS_NEW"]; // 0 SI 1 NOI
 [cererepiesa setObject:@"1" forKey:@"IS_SECOND"]; // 0 SI 1 SECOND*/

/*   images =         (
 {
 id = 7293064;
 original = "http://dev5.activesoft.ro/~csaba/4tilance/attachment.php?id=2a05b5cb2f976d01e2e25d2effa561fa";
 tb = "http://dev5.activesoft.ro/~csaba/4tilance/attachment.php?id=2a05b5cb2f976d01e2e25d2effa561fa&cmd=thumb&w=148&h=111";
 }
 );*/
/* ce avem pe aici (
 "<UIImage: 0x7fb86de44cf0>, {1024, 683}",
 "<UIImage: 0x7fb86df0fb60>, {1024, 683}",
 "<UIImage: 0x7fb86dca7ef0>, {512, 768}"
 )
 12:18 si
 12:18 self.POZEALESE (
 "27BCEBFB-6F0B-4ABF-8B03-6BF76112E540/L0/001",
 "A2D90D1E-CB41-4E6E-A2AB-592EEC3F2536/L0/001",
 "088C645B-F344-47C3-8037-4CEEF26C644A/L0/001"
 )*/
//  NSArray *pozedelaserver = [[NSArray alloc]init];

