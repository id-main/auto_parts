//
//  CerereExistentaViewController.m
//  Pieseauto
//
//  Created by Ioan Ungureanu on 11/04/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//
#import "utile.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"
#import "CerereExistentaViewController.h"
#import "TutorialHomeViewController.h"
#import "chooseview.h"
#import <CoreText/CoreText.h>
#import "pozeviewVC.h"
#import "TabelPozeCerereVC.h"
#import "choseLoginview.h"
#import "EcranCerereTrimisaViewController.h"
#import "Reachability.h"
#import "CellCerereExistenta.h"
#import "CerereNouaViewController.h"
#import "CustomBadge.h"
#import "EcranMesajeViewController.h"
#import "EcranAcorda.h"
#import "DetaliuOfertaViewController.h"
#import "ListaNotificari.h"
#import "butoncustomback.h"
#import "DetaliuProfil.h"
#import "butoncustomback.h"
#import "OferteLaCerereViewController.h"
#import "Galerieslide.h"
#import "UIAlertView+Blocks.h"


#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
@interface CerereExistentaViewController(){
    NSMutableArray* array;
}
@end
static NSString *PE_PAGINA = @"20";
@implementation CerereExistentaViewController
@synthesize  LISTASELECT,CERERE,piesenoisausecond,pozele,barajos,intrebaridelaaltii,mesajele,DETALIICERERE,AREWINNER,OFERTACASTIGATOARELACERERE;
@synthesize ANULEAZAVIEW,BTN_CONFIRMA,BTN_RENUNTA,TextAIALESSAANULEZI;
@synthesize AFOSTANULATAVIEW,BTN_OK,BTN_REPOSTEAZA,TextAFOSTANULATA,E_ANULATA,stareexpand,ARECALIFICATIV,CE_TIP_E,DICTIONARWINNER,OFERTACASTIGATOARE, MESAJEREX;
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
  //  titlubuton.text=@"Înapoi";
    if([CE_TIP_E isEqualToString:@"dinmesaje"]) {
         titlubuton.text=@"Înapoi";
    } else if  ([CE_TIP_E isEqualToString:@"dinwinner"]) {
          titlubuton.text=@"Cererile mele";
    } else {
         titlubuton.text=@"Înapoi";
    }
    
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
-(void)viewDidAppear:(BOOL)animated {
    // la register sau login
    [self removehud];
}
-(void)viewWillAppear:(BOOL)animated {
   // [self addhud];
     AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(del.afostanulata ==YES) {
        //refresh
        NSLog(@"cerereidofertaanulata %@", CERERE);
        if(CERERE&& CERERE[@"IDCERERE"]) {
    //   -(void) RELOAD_list_offers_per_cerere :(NSString *)AUTHTOKEN :(NSString *)PAGE :(NSString *)PER_PAGE :(NSString *)cerere_id :(NSString *)prefered_only :(NSString*)cerere_details :(NSString*) castigatoare{
            NSString *cerereID= [NSString stringWithFormat:@"%@",CERERE[@"IDCERERE"]];
            NSString *authtoken=@"";
            BOOL elogat = NO;
            utilitar = [[Utile alloc]init];
            elogat = [utilitar eLogat];
            del.afostanulata=NO;
            if(elogat) {
                authtoken = [utilitar AUTHTOKEN];
               [self RELOAD_list_offers_per_cerere:authtoken :@"1" :PE_PAGINA :cerereID  :@"0" :@"1" :@"nu"];
            }
       }
    }else {
        if(del.amscrismesajboss) {
            if(CERERE&& CERERE[@"IDCERERE"]) {
                //   -(void) RELOAD_list_offers_per_cerere :(NSString *)AUTHTOKEN :(NSString *)PAGE :(NSString *)PER_PAGE :(NSString *)cerere_id :(NSString *)prefered_only :(NSString*)cerere_details :(NSString*) castigatoare{
                NSString *cerereID= [NSString stringWithFormat:@"%@",CERERE[@"IDCERERE"]];
                NSString *authtoken=@"";
                BOOL elogat = NO;
                utilitar = [[Utile alloc]init];
                elogat = [utilitar eLogat];
                del.amscrismesajboss=NO;
                if(elogat) {
                    authtoken = [utilitar AUTHTOKEN];
                   // [self RELOAD_list_offers_per_cerere:authtoken :@"1" :PE_PAGINA :cerereID  :@"0" :@"1" :@"nu"];
                    [self get_comments:cerereID :@"cerereid" :authtoken];
                }
            }
        } else{
            [self.LISTASELECT reloadData];
        }
        
    }
    
     [self.navigationController setNavigationBarHidden:NO];
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
                    [self removehud];
                    NSLog(@"date comentarii %@",multedate);
                    if([TIP isEqualToString:@"cerereid"]) {
                        intrebaridelaaltii = [[NSMutableDictionary alloc]init];
                        intrebaridelaaltii = multedate;
                        dispatch_async(dispatch_get_main_queue(), ^{
                           // [self.LISTASELECT reloadData];
                            [self madeinit];
                        });
                        
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


-(void)testare{
    NSLog(@"back btn clear all datas");
}
-(void) perfecttimeforback{
    BOOL agasitecrannotificari=NO;
    NSInteger index = 0;
    UINavigationController *nav=(UINavigationController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController;
    for(int i=0; i< nav.viewControllers.count;i++) {
        UIViewController *view  = [nav.viewControllers objectAtIndex:i];
        NSLog(@"vv %@",view.restorationIdentifier);
        if([view.restorationIdentifier isEqualToString:@"ListaNotificariVC"]) {//se bifeaza use rest.id ca si storyboardid ... avem  nevoie ca sa il ducem acolo dupa push
            NSLog(@"cat e index i %d",i);
            index =i;
            agasitecrannotificari =YES;
            break;
        }
    }
    if(agasitecrannotificari == YES) {
        [nav popToViewController:[[nav viewControllers] objectAtIndex:index] animated:YES];
        
    }  else {
        utilitar = [[Utile alloc]init];
        [utilitar mergiLaMainViewVC];
    }
}
-(void)madeinit {
    
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *ariestareexpand =@[@{@"expand":@"0"}];
    stareexpand= [[NSMutableArray alloc]init];
    stareexpand =[NSMutableArray arrayWithArray:ariestareexpand];
    NSLog(@"stareexpand %@", stareexpand);
    
    DETALIICERERE =[[NSMutableDictionary alloc]init];
    ANULEAZAVIEW.hidden = YES;
    BTN_CONFIRMA.layer.borderWidth=1.0f;
    BTN_CONFIRMA.layer.cornerRadius = 5.0f;
    BTN_CONFIRMA.layer.borderColor=[[UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] CGColor];
    
    BTN_RENUNTA.layer.borderWidth=1.0f;
    BTN_RENUNTA.layer.cornerRadius = 5.0f;
    BTN_RENUNTA.layer.borderColor=[[UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] CGColor];
    
    AFOSTANULATAVIEW.hidden = YES;
    BTN_OK.layer.borderWidth=1.0f;
    BTN_OK.layer.cornerRadius = 5.0f;
    BTN_OK.layer.borderColor=[[UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] CGColor];
    
    BTN_REPOSTEAZA.layer.borderWidth=1.0f;
    BTN_REPOSTEAZA.layer.cornerRadius = 5.0f;
    BTN_REPOSTEAZA.layer.borderColor=[[UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] CGColor];
    
    NSString *text1aiales = @"Ai ales să anulezi cererea de ofertă.";
    NSString *text2aiales = @"\nCererea va fi retrasă din rândul cererilor active și o vei găsi între cererile tale rezolvate. O vei putea reposta mai târziu, așa cum este sau cu modificări.";
    
    TextAIALESSAANULEZI.text=@"";
    NSString *compus_aiales= [NSString stringWithFormat:@"%@%@", text1aiales,text2aiales];
    NSRange bigRange = [compus_aiales rangeOfString:text1aiales];
    NSRange mediumRange = [compus_aiales rangeOfString:text2aiales];
    
    [TextAIALESSAANULEZI setText:compus_aiales afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        UIFont *MEDIUfont =[UIFont boldSystemFontOfSize:16];
        UIFont *SMALLfont =[UIFont boldSystemFontOfSize:14];
        CTFontRef fontunu = CTFontCreateWithName((__bridge CFStringRef)MEDIUfont.fontName, MEDIUfont.pointSize, NULL);
        CTFontRef fontdoi = CTFontCreateWithName((__bridge CFStringRef)SMALLfont.fontName, SMALLfont.pointSize, NULL);
        if (fontunu && fontdoi) {
            [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)fontunu range:bigRange];
            [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[[UIColor darkGrayColor] CGColor] range:bigRange];
            [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)fontunu range:mediumRange];
            [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[[UIColor darkGrayColor] CGColor] range:mediumRange];
            CFRelease(fontunu);
            CFRelease(fontdoi);
        }
        return mutableAttributedString;
    }];
    
    
    
    TextAIALESSAANULEZI.numberOfLines=0;
    
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CERERE =[[NSMutableDictionary alloc]init];
    CERERE = [del.cererepiesa mutableCopy];
    self.intrebaridelaaltii = [NSMutableDictionary dictionaryWithDictionary:intrebaridelaaltii];
    NSLog(@"intrebaridelaaltii %@",intrebaridelaaltii);
    
    self.mesajele= [[NSMutableArray alloc]init];
    NSMutableArray *toatemesajele =[[NSMutableArray alloc]init];
    NSMutableArray *toateultimile =[[NSMutableArray alloc]init];
    
    if(intrebaridelaaltii[@"discussions"]) {
        toatemesajele =intrebaridelaaltii[@"discussions"]; //Discussions este array de discutii.
        //   O discutie este array de comentarii. se va lua ultimul comentariu din fiecare discutie pentru afisare aici
        for(int i=0;i< toatemesajele.count;i++) {
            NSArray *deprelucrat = [toatemesajele objectAtIndex:i];
            for( int y=0; y< deprelucrat.count;y++) {
                NSDictionary *ultimulmesaj= [deprelucrat objectAtIndex:y];
                if(ultimulmesaj[@"is_myself"]) {
                    NSString *ismyne = [NSString stringWithFormat:@"%@",ultimulmesaj[@"is_myself"]];
                    NSInteger esaunu = [ismyne integerValue];
                    if(esaunu ==0) {
                        NSLog(@"da e 0 ");
                        NSMutableArray *arietemporara =[[NSMutableArray alloc]init];
                        //sunt mesaje de la useri asa ca le adaugam in array
                        if(![arietemporara containsObject:ultimulmesaj] ){
                            [arietemporara addObject:ultimulmesaj];
                        }
                        if(![toateultimile containsObject:arietemporara] ){
                            [toateultimile addObject:arietemporara];
                        }
                    }
                }
            }
        }
        NSLog(@"toateultimile %@", toateultimile);
        
        for(int z=0; z<toateultimile.count;z++) {
            NSArray *MULTEOBIECTE = [[NSArray alloc]init];
            MULTEOBIECTE = [toateultimile objectAtIndex:z];
            
            if(![self.mesajele containsObject:[MULTEOBIECTE lastObject]]) {
                [self.mesajele addObject:[MULTEOBIECTE lastObject]];
            }
        }
        
    }
    
    //  self.mesajele = toateultimile;
    NSLog(@"self.mesajele %@", self.mesajele);
    NSLog(@"after mod %@",CERERE);
    
    self.pozele = [[NSMutableArray alloc]init];
    pozele = del.POZECERERE;
    NSLog(@"pozele j%@",pozele);
    NSString *descrierecoments =@"Întrebări de la ofertanți:";
    NSMutableDictionary *questuri = [[NSMutableDictionary alloc]init];
    [questuri setObject:descrierecoments forKey:@"nume"];
    [questuri setObject:self.mesajele forKey:@"SubItems"];
    
    MESAJEREX=  [[NSMutableArray alloc]init];
    [MESAJEREX addObject:questuri];
    
    
    NSMutableArray *cevaoferte = [[NSMutableArray alloc]init];
    AREWINNER =NO;
    
    if(CERERE[@"CEREREFULLINFO"]) {
        DETALIICERERE =[NSMutableDictionary dictionaryWithDictionary:CERERE[@"CEREREFULLINFO"]];
        NSLog(@"DETALIICERERE %@",DETALIICERERE);
        if(DETALIICERERE[@"cerere"][@"is_cancelled"]) {
            NSString *cerereanulata = [NSString stringWithFormat:@"%@",DETALIICERERE[@"cerere"][@"is_cancelled"]];
            if(![self MyStringisEmpty:cerereanulata ]) {
                NSInteger anulata = cerereanulata.integerValue;
                if(anulata ==1) E_ANULATA =YES;
            }
        }
    }
    OFERTACASTIGATOARELACERERE = [[NSMutableDictionary alloc]init];
    //vezi oferte asociate
    OFERTACASTIGATOARE=  [[NSMutableArray alloc]init];
    if(DETALIICERERE[@"items"]) {
        cevaoferte =[NSMutableArray  arrayWithArray:DETALIICERERE[@"items"]];
        if(cevaoferte.count >0) {
            for(int i=0;i<cevaoferte.count;i++) {
                NSDictionary *detaliuoferta = [cevaoferte objectAtIndex:i];
                if(detaliuoferta[@"winner"]){
                    NSString *WINERDASAUNU = [NSString stringWithFormat:@"%@",detaliuoferta[@"winner"]];
                    if(WINERDASAUNU.integerValue ==1) {
                        NSLog(@"WINERDASAUNU %@",WINERDASAUNU);
                        OFERTACASTIGATOARELACERERE = [NSMutableDictionary dictionaryWithDictionary:detaliuoferta];
                        AREWINNER =YES;
                        break;
                    } else {
                        //are oferta castigatoare
                        AREWINNER =NO;
                    }
                }
            }
        }
    }
    NSString *NUMEUSERCASTIGATOR =@"";
    if(AREWINNER ==YES ) {
        NSString *DESCRIERE =@"Oferta câștigătoare";
        NSMutableDictionary *CASTIGATOARE = [[NSMutableDictionary alloc]init];
        [CASTIGATOARE setObject:DESCRIERE forKey:@"nume"];
        [CASTIGATOARE setObject:OFERTACASTIGATOARELACERERE forKey:@"SubItems"];
        
        if(OFERTACASTIGATOARELACERERE[@"username"]) {
            NUMEUSERCASTIGATOR = [NSString stringWithFormat:@"%@",OFERTACASTIGATOARELACERERE[@"username"]];
            NSLog(@"NUMEUSERCASTIGATOR %@",NUMEUSERCASTIGATOR);
        }
        DICTIONARWINNER =[[NSMutableDictionary alloc]init];
        NSLog(@"CASTIGATOARE %@",CASTIGATOARE);
        [OFERTACASTIGATOARE addObject:CASTIGATOARE];
        // self.titluri =@[@"Cerere anulată",@"Planse bord etc",OFERTACASTIGATOARE,MESAJEREX,@"Anulează câștigător",@"Acordă calificativ"];
        //   self.titluri =@[@"Cerere anulată",@"Planse bord etc",OFERTACASTIGATOARE,@"Anulează câștigător",@"Acordă calificativ",MESAJEREX];
        //                            0             1                  2                3                       4                   5                   6
        self.titluri =[NSMutableArray arrayWithArray:@[@"Cerere anulată",@"Planse bord etc",OFERTACASTIGATOARE,DICTIONARWINNER,@"Anulează câștigător",@"Acordă calificativ",MESAJEREX,@""]];
    } else if(E_ANULATA ==YES) {
        self.titluri =[NSMutableArray arrayWithArray:@[@"Cerere anulată",@"Planse bord etc",@""]];
    } else {
        self.titluri =[NSMutableArray arrayWithArray:@[@"Cerere anulată",@"Planse bord etc",MESAJEREX,@""]];
     
    }
    [self removehud];
    NSLog(@"cum arata acum questuri %@", MESAJEREX);
    
    //relist_type" = "" 'readd' - cererea inactiva poate fi repostata cu "cerere_add" + remake_id  (cerere mai veche de 2 saptamani)
    //'reopen' - cererea inactiva poate fi redeschisa cu "cerere_reopen"  -> la lista cereri
    //'' - cererea nu poate fi repostata/redeschisa (ex. este activa sau este veche si a fost repostata deja)
    
    /*
     ex. pe https://marvelapp.com/2511ee4#10393528 butonul sub "OK" va fi "Modifica si reposteaza" pentru relist_type=readd, "Relisteaza cererea" pentru relist_type=reopen si dispare pentru relist_type=""
     
     */
    if(DETALIICERERE[@"cerere"][@"relist_type"]) {
        NSString *relist_type = [NSString stringWithFormat:@"%@",DETALIICERERE[@"cerere"][@"relist_type"]];
        [self pentrubarajos:relist_type];
    } else {
        [self pentrubarajos:@"nuarerelisttype"];
    }
    
    utilitar = [[Utile alloc]init];
    NSString *authtoken=@"";
    BOOL elogat = NO;
    elogat = [utilitar eLogat];
    if(elogat) {
        authtoken = [utilitar AUTHTOKEN];
        //(void)get_member_profile :(NSString *)userid :(NSString *)AUTHTOKEN :(NSString *)tipuserid{ //user_id sau username
        if(![self MyStringisEmpty:NUMEUSERCASTIGATOR]) {
            [self get_member_profile:NUMEUSERCASTIGATOR :authtoken :@"username"];
        }
    }
    
    [LISTASELECT reloadData];
    [self removehud];

}
-(void)mergiback{
    
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.CE_TIP_E =CE_TIP_E; //aici
    [LISTASELECT setDelegate:self];
    [LISTASELECT setDataSource:self];
 
    LISTASELECT.scrollEnabled = YES;
    LISTASELECT.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
       [self.navigationController setNavigationBarHidden:NO]; self.navigationItem.leftBarButtonItem=nil;
    
    self.navigationController.navigationItem.hidesBackButton = YES;
    //clean other left
    for(UIButton *view in  self.navigationController.navigationBar.subviews) {
        if([view isKindOfClass:[butoncustomback class]]){
            [view removeFromSuperview];
        }
    }
    //add new left
      if([CE_TIP_E isEqualToString:@"dinmesaje"]) {
         self.title = @"Detaliu cerere";
        //jjjj
        UIButton *ceva = [self backbtncustom];
        [ceva addTarget:self action:@selector(perfecttimeforback) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *inapoibtn =[[UIBarButtonItem alloc] initWithCustomView:ceva];
        self.navigationItem.leftBarButtonItem = inapoibtn;
 
    } else {
        self.title = @"Detaliu cerere";
        UIButton *ceva = [self backbtncustom];
        [ceva addTarget:self action:@selector(mergiback) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *inapoibtn =[[UIBarButtonItem alloc] initWithCustomView:ceva];
        self.navigationItem.leftBarButtonItem = inapoibtn;
   

    }
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    [self madeinit];
    
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
        NSLog(@"compus life%@",compus);
        
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
                  //  [self gotodetaliuProfil:multedate];
                    DICTIONARWINNER =[[NSMutableDictionary alloc]init];
                    DICTIONARWINNER =[NSMutableDictionary dictionaryWithDictionary:multedate];
                  /////  NSLog(@"DICTIONARWINNER %@",DICTIONARWINNER);
                    self.titluri = [NSMutableArray arrayWithArray:@[@"Cerere anulată",@"Planse bord etc",OFERTACASTIGATOARE,DICTIONARWINNER,@"Anulează câștigător",@"Acordă calificativ",MESAJEREX]];
                    [self.LISTASELECT reloadData];
                    [self removehud];
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
-(void)gotodetaliuProfil :(NSMutableDictionary*) multedate {
    DetaliuProfil *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetaliuProfilVC"];
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


-(void)schimbaicon :(NSInteger) sectiune {
    NSLog(@"sectiunea x %i", (int)sectiune);
    NSInteger nrsectiune = 2;
    if(AREWINNER ==YES) {
        nrsectiune =6;
    }
   if([stareexpand objectAtIndex:0]) {
        NSMutableDictionary *deschimbat = [NSMutableDictionary dictionaryWithDictionary:[stareexpand objectAtIndex:0]];
        if([self checkDictionary:deschimbat]) {
            if(deschimbat[@"expand"]) {
                NSString *valoare = [NSString stringWithFormat:@"%@",deschimbat[@"expand"]];
                NSIndexPath *indexPathreload = [NSIndexPath indexPathForRow:0 inSection:sectiune];
                BOOL eselectat =NO;
                CellCerereExistenta* cell = (CellCerereExistenta*)[self.LISTASELECT cellForRowAtIndexPath:indexPathreload];
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
                [stareexpand replaceObjectAtIndex:0 withObject:deschimbat];
                cell.expandcollapsecell.selected=eselectat;
                [cell setNeedsDisplay];
           }
        }
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows =1;
    if(AREWINNER ==YES) {
       if(section ==6) {
        NSArray *sectionContents = [[self titluri] objectAtIndex:section];
        rows = [sectionContents count];
       }
        if(section ==2) {
            NSArray *dateoferta = [[self titluri] objectAtIndex:section];
            NSDictionary *detaliuoferta = [dateoferta objectAtIndex:0];
            NSDictionary *detaliuofertacastigatoare = [[NSDictionary alloc]init];
            if( detaliuoferta[@"SubItems"]) {
                detaliuofertacastigatoare =  detaliuoferta[@"SubItems"];
                if(detaliuofertacastigatoare[@"items"]) {
                NSArray *caterandurioferte = detaliuofertacastigatoare[@"items"];
                rows = [caterandurioferte count];
                    NSLog(@"cate randuri oferta %li", (long)rows);
        }
      }
    }
   }
    else if(E_ANULATA ==YES) {
        return 1;
    }
    
    else {
    
    
    {
        if(section ==2) {
            NSArray *sectionContents = (NSArray *)[[self titluri] objectAtIndex:section];
            rows = [sectionContents count];
        }
    }
    }
 return rows;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSInteger heisection =1;
    if(AREWINNER ==YES) {
        if(section ==2) {
             heisection = 0;
        }
    } else {
        if(section ==1 ||section ==0 ) {
            heisection = 0;
        }

    }
        
    return heisection;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [UIColor colorWithRed:(232/255.0) green:(232/255.0) blue:(232/255.0) alpha:1];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    double cellHeightcustom =0;
    int cevaX =(int)indexPath.section;
  
    if(cevaX ==0 ) { //ok
        if(E_ANULATA ==YES) { cellHeightcustom = 59; } else {
            cellHeightcustom = 0;
        }
    }
  
    if(cevaX ==1 ) { //ok
      NSInteger ceva =indexPath.row;
      if(ceva ==0) {
          double height1 =0;
          double height2 =0;
       if(CERERE[@"TEXTCERERE"]) {
        NSString *textcerere = [NSString stringWithFormat:@"%@",CERERE[@"TEXTCERERE"]];
//          NSString *textcerere = @"este pur şi simplu o machetă pentru text a industriei tipografice. Lorem Ipsum a fost macheta standard a industriei încă din secolul al XVI-lea, când un tipograf anonim a luat o planşetă de litere şi le-a amestecat pentru a crea o carte demonstrativă pentru literele respective. Nu doar că a supravieţuit timp de cinci secole, dar şi a facut saltul în tipografia electronică practic neschimbată. A fost popularizată în anii '60 odată cu ieşirea colilor Letraset care conţineau pasaje Lorem Ipsum, iar mai recent, prin programele de publicare pentru calculator, ca Aldus PageMaker care includeau versiuni de Lorem Ipsum.";
          CGFloat widthWithInsetsApplied = self.view.frame.size.width-54;
          CGSize textSize = [textcerere boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:19]} context:nil].size;
          height1= textSize.height+5;
         
      }
          NSString *masinatext = @"Mașina: ";
          NSString *PRODUCATORAUTODEF = [NSString stringWithFormat:@"%@",CERERE[@"PRODUCATORAUTO"]];
          NSString *MARCAAUTODEF = [NSString stringWithFormat:@"%@",CERERE[@"MARCAAUTO"]];
          NSString *ANMASINA = [NSString stringWithFormat:@"%@",CERERE[@"ANMASINA"]];
          NSString *VARIANTA = [NSString stringWithFormat:@"%@",CERERE[@"VARIANTA"]];
          NSString *MOTORIZARE = [NSString stringWithFormat:@"%@",CERERE[@"MOTORIZARE"]];
          NSString *SERIESASIU = [NSString stringWithFormat:@"%@",CERERE[@"SERIESASIU"]];
          
          NSString *PRODUCATORAUTO = @"";
          NSString *MARCAAUTO =@"";
          
          NSDictionary *producatorbaza = [DataMasterProcessor getProducator:PRODUCATORAUTODEF];
          if(producatorbaza && producatorbaza[@"name"]) {
              PRODUCATORAUTO = [NSString stringWithFormat:@"%@",producatorbaza[@"name"]];
          }
          NSDictionary *marcaautobaza = [DataMasterProcessor getMarcaAuto:MARCAAUTODEF];
          NSLog(@"marca baza %@", marcaautobaza);
          if(marcaautobaza && marcaautobaza[@"name"]) {
              MARCAAUTO = [NSString stringWithFormat:@"%@",marcaautobaza[@"name"]];
          }
          NSString *compus =@"";
          
          BOOL egol1= [self MyStringisEmpty:SERIESASIU];
          if(!egol1) {
              compus = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ șasiu %@", PRODUCATORAUTO,MARCAAUTO,ANMASINA,VARIANTA,MOTORIZARE,SERIESASIU];
          } else {
              compus = [NSString stringWithFormat:@"%@ %@ %@ %@ %@", PRODUCATORAUTO,MARCAAUTO,ANMASINA,VARIANTA,MOTORIZARE];
          }
         NSString *textulMeu = [NSString stringWithFormat:@"%@ %@",masinatext,compus];
//             NSString *textulMeu = @"este pur şi simplu o machetă pentru text a industriei tipografice. Lorem Ipsum a fost macheta standard a industriei încă din secolul al XVI-lea, când un tipograf anonim a luat o planşetă de litere şi le-a amestecat pentru a crea o carte demonstrativă pentru literele respective. Nu doar că a supravieţuit timp de cinci secole, dar şi a facut saltul în tipografia electronică practic neschimbată. A fost popularizată în anii '60 odată cu ieşirea colilor Letraset care conţineau pasaje Lorem Ipsum, iar mai recent, prin programele de publicare pentru calculator, ca Aldus PageMaker care includeau versiuni de Lorem Ipsum.";
          CGFloat widthWithInsetsApplied = self.view.frame.size.width-24;
          CGSize textSize = [textulMeu boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
          height2= textSize.height+10;
          cellHeightcustom = height1 + height2 +106; //acest 106 vine din labels ce tip piesa si zona livrare care au h static plus cele doua de mai sus care au h dinamic
        }
   }
    
    if(AREWINNER ==YES ) {
      
        if(cevaX ==2 ) { //ok
            NSInteger RowIndex=indexPath.row;
            ///////// NSLog(@"[self.titluri objectAtIndex:2] %@",[self.titluri objectAtIndex:2]);
                NSArray *dateoferta = [NSArray arrayWithArray:[self.titluri objectAtIndex:2]];
                NSDictionary *detaliuoferta = [dateoferta objectAtIndex:0];
                NSDictionary *detaliuofertacastigatoare = [[NSDictionary alloc]init];
                if( detaliuoferta[@"SubItems"]) detaliuofertacastigatoare =  detaliuoferta[@"SubItems"];
                NSArray *item0oferta = [[NSArray alloc]init];
                if(detaliuofertacastigatoare[@"items"]  ) {
                item0oferta =[NSArray arrayWithArray:detaliuofertacastigatoare[@"items"]];
                    NSLog(@"item0oferta %@",item0oferta);
                    /*
                     item0oferta (
                     {
                     "currency_id" = 14;
                     "currency_name" = EUR;
                     description = "Oferta test 1 - piesa 1";
                     id = 1254755;
                     price = 124;
                     um = "buc.";
                     },
                     {
                     "currency_id" = 41;
                     "currency_name" = RON;
                     description = "Oferta test 1 - piesa 2";
                     id = 1254756;
                     price = 999;
                     um = set;
                     }
                     )
                     */
                }
            if(item0oferta.count >0) {
            if(RowIndex == 0){
                    NSDictionary *detaliuoferta =[item0oferta objectAtIndex:RowIndex];
                    double inaltimepoza =0;
                    double LEFTPOZAOFERTA=0;
                    NSArray *pozeoferta = [[NSArray alloc]init];
                    if( detaliuofertacastigatoare[@"images"]) {
                        pozeoferta = detaliuofertacastigatoare[@"images"];
                        if(pozeoferta.count >0) {
                        LEFTPOZAOFERTA =45;
                        inaltimepoza =40;
                        }
                    }
                    NSString *C_titlu = [NSString stringWithFormat:@"%@",detaliuoferta[@"description"]];
                    CGFloat widthWithInsetsApplied = self.view.frame.size.width - LEFTPOZAOFERTA;
                    CGSize textSize = [C_titlu boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17]} context:nil].size;
                    UIFont *tester = [UIFont boldSystemFontOfSize:17];
                    double numberOfLines = textSize.height /tester.pointSize;
                    if(numberOfLines >2) {
                       cellHeightcustom = 125;
                       } else  {
                    if( inaltimepoza ==0) {
                        cellHeightcustom = 100;
                     } else {
                    cellHeightcustom = 125;
                     }
                    }
                
            } else {
            
                NSDictionary *detaliuoferta =[item0oferta objectAtIndex:RowIndex];
                NSLog(@"detaliuofertadetaliuoferta rowindex %@ %li",detaliuoferta,(long)RowIndex);
                NSString *C_titlu = [NSString stringWithFormat:@"%@",detaliuoferta[@"description"]];
               
                CGFloat widthWithInsetsApplied = self.view.frame.size.width-10;
                CGSize textSize = [C_titlu boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17]} context:nil].size;
                UIFont *tester = [UIFont boldSystemFontOfSize:17];
                double numberOfLines = textSize.height /tester.pointSize;
                if(numberOfLines >2) {
                    cellHeightcustom = 90;
                } else  {
                    cellHeightcustom = 70;
                }
             }
           }
        }
    
        //nu uita oferta facuta de
        if(cevaX ==3 ){
            cellHeightcustom =73;
        }
        if(cevaX ==6 ) { //ok
            int ceva =(int)indexPath.row;
            if(ceva ==0) {
                cellHeightcustom =44; // primul rand cu text si badge
            } else {
                cellHeightcustom =73; // cell mesaj
            }
        }
        

    if(cevaX ==4 ||cevaX ==5 ) { cellHeightcustom =55; }
        if(cevaX==7) {
        cellHeightcustom =12;
        }
        
    } else
        if(E_ANULATA ==YES) {
       
        if(cevaX ==2 ) { //ok
            cellHeightcustom =12;
        }
        } else {
       if(cevaX ==2 ) { //ok
            int ceva =(int)indexPath.row;
            if(ceva ==0) {
                cellHeightcustom =44; // primul rand cu text si badge
            } else {
                cellHeightcustom =73; // cell mesaj
            }
        }
         if(cevaX ==3) {
             cellHeightcustom =12;
         }
    
    }
    return cellHeightcustom;
   // return UITableViewAutomaticDimension;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([indexPath section]== 2) {
//        
//       // cell.separatorInset = UIEdgeInsetsMake(0.f, 0.f, 0.f, cell.bounds.size.width);
//    }
//    else {
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
//    }
 }



-(IBAction)vezipozeCERERE{
 
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(del.ARRAYASSETURI) {
        NSArray *imagini = del.ARRAYASSETURI;
         NSLog(@"MERGI LA POZE  %@",del.ARRAYASSETURI);
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



-(void)CollapseRows:(NSArray*)ar :(int)sectiune
{
    for(NSDictionary *dInner in ar )
    {
        NSUInteger indexToRemove=[[self.titluri objectAtIndex:sectiune] indexOfObjectIdenticalTo:dInner];
        NSArray *arInner=[dInner valueForKey:@"SubItems"];
        NSLog(@"arInner %@",arInner);
        if(arInner && [arInner count]>0)
        {
            [self CollapseRows:arInner:sectiune];
        }
        if([[self.titluri objectAtIndex:sectiune] indexOfObjectIdenticalTo:dInner]!=NSNotFound)
        {
            [self.LISTASELECT beginUpdates];
            [[self.titluri objectAtIndex:sectiune] removeObjectIdenticalTo:dInner];
            [self.LISTASELECT deleteRowsAtIndexPaths:[NSArray arrayWithObject:
                                                      [NSIndexPath indexPathForRow:indexToRemove inSection:sectiune]
                                                      ]
                                    withRowAnimation:UITableViewRowAnimationTop];
            
            [self.LISTASELECT endUpdates];
        }
    }
    [self schimbaicon:sectiune];
}

-(IBAction)expandsaustrangerows:(NSIndexPath*)indexPath {
//    UIButton* btn = (UIButton*) [(UIGestureRecognizer *)sender view];
//    /*
//     *** Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'Invalid update: invalid number of rows in section 2.  The number of rows contained in an existing section after the update (2) must be equal to the number of rows contained in that section before the update (2), plus or minus the number of rows inserted or deleted from that section (1 inserted, 0 deleted) and plus or minus the number of rows moved into or out of that section (0 moved in, 0 moved out).'
//    */
//    CGRect buttonFrameInTableView = [btn convertRect:btn.bounds toView:self.LISTASELECT];
//    NSIndexPath *indexPath = [self.LISTASELECT indexPathForRowAtPoint:buttonFrameInTableView.origin];
//    NSLog(@"indexpath %@ %li", indexPath, (long)indexPath.section);
//    
//    
//    
    int sectiune =2;
    if(AREWINNER ==YES) {
        sectiune =6;
    }
//
//    if(btn.alpha==1.0)
//    {
//        btn.selected= !btn.selected;
//    }
//    if(indexPath.section ==sectiune ){
        NSDictionary *d=[[self.titluri objectAtIndex:sectiune]objectAtIndex:0];
        
        NSArray *arr=[d valueForKey:@"SubItems"];
        NSLog(@"SubItems %@",arr);
        if([d valueForKey:@"SubItems"])
        {
            BOOL isTableExpanded=NO;
            for(NSDictionary *subitems in arr )
            {
                NSInteger index=[[self.titluri objectAtIndex:sectiune] indexOfObjectIdenticalTo:subitems];
                isTableExpanded=(index>0 && index!=NSIntegerMax);
                if(isTableExpanded) break;
            }
            
            if(isTableExpanded)
            {
                [self CollapseRows:arr:sectiune];
            }
            else
            {
                NSUInteger count=indexPath.row+1;
                NSMutableArray *arrCells=[NSMutableArray array];
                [self schimbaicon:sectiune];
                for(NSDictionary *dInner in arr )
                {
                    [arrCells addObject:[NSIndexPath indexPathForRow:count inSection:sectiune]];
                    [[self.titluri objectAtIndex:sectiune] insertObject:dInner atIndex:count++];
                }
                [self.LISTASELECT beginUpdates];
                [self.LISTASELECT insertRowsAtIndexPaths:arrCells withRowAnimation:UITableViewRowAnimationTop ];
               
                [self.LISTASELECT endUpdates];
               
            }
        }
   // }
}


#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.titluri count];
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
                  NSLog(@"date DETALIU OFERTA %@",multedate);
                    //dispatch_async(dispatch_get_main_queue(), ^{
                    DetaliuOfertaViewController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"DetaliuOfertaVC"];
                    vc.CORPDATE = multedate;
                    if(CERERE[@"is_cancelled"]) {
                        NSString *cererecanceled= [NSString stringWithFormat:@"%@", CERERE[@"is_cancelled"]];
                        if(cererecanceled.integerValue ==0) {
                            vc.cerereexpirata =NO;
                        }
                        if(cererecanceled.integerValue ==   1) {
                            vc.cerereexpirata =YES;
                        }
                    }
                    [self.navigationController pushViewController:vc animated:NO];
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
             [self removehud];
        }];
        [[NSOperationQueue mainQueue] addOperation:op];
    }
    
    
}
-(void)aratatoate{
    //aici logica e infecta daca are winner // vine din lista cereri si afiseaza dupa lista de oferte ...dar, asta e...
    // [self.navigationController popViewControllerAnimated:YES];
  if( CERERE[@"IDCERERE"]) {
      NSString *cerereID= [NSString stringWithFormat:@"%@",CERERE[@"IDCERERE"]];
      NSString *authtoken=@"";
      BOOL elogat = NO;
      utilitar = [[Utile alloc]init];
      elogat = [utilitar eLogat];
      if(elogat) {
          authtoken = [utilitar AUTHTOKEN];
    
     [self list_offers_per_cerere:authtoken :@"1" :PE_PAGINA :cerereID  :@"0" :@"1" :@"nu"];
      }
  }
}
-(void)veziofertacastigatoare {
//case 2: {
    NSLog(@"detaliu cerere if winner %@", OFERTACASTIGATOARELACERERE );
    
    if(OFERTACASTIGATOARELACERERE[@"messageid"]) {
        ////mergi la det oferta ->
        NSString *ofertacastigatoareid = [NSString stringWithFormat:@"%@", OFERTACASTIGATOARELACERERE[@"messageid"]];
        NSString *authtoken=@"";
        BOOL elogat = NO;
        utilitar = [[Utile alloc]init];
        elogat = [utilitar eLogat];
        if(elogat) {
            authtoken = [utilitar AUTHTOKEN];
            [self getOffer :ofertacastigatoareid :authtoken];
        }
    }
}//              break;


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CERERE =[[NSMutableDictionary alloc]init];
    CERERE = [del.cererepiesa mutableCopy];
    
    
   /////// NSLog(@"after mod %@",CERERE);
    static NSString *CellIdentifier = @"CellCerereExistenta";
    CellCerereExistenta *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (CellCerereExistenta*)[tableView dequeueReusableCellWithIdentifier:@"CellCerereExistenta"];
    }
   if ([cell.contentView subviews]){
        for (UIView *subview in [cell.contentView subviews]) {
            if([subview isKindOfClass:[CustomBadge class]]){
                [subview removeFromSuperview];
            }
        }
    }
    
    NSLog(@"gesture recognizers : %@", cell.PozaCerere.gestureRecognizers);
    
 
    NSInteger ipx = indexPath.row;
    cell.primulcell.hidden=YES;
    cell.bluecell.hidden =YES;
    cell.ofertacastigatoare.hidden=YES;
    cell.discutieuser.hidden=YES;
    cell.expandcollapsecell.hidden=YES;
    cell.randul1.hidden=YES;
    cell.expandcollapsecell.userInteractionEnabled=NO;
    [cell.expandcollapsecell setImage:[UIImage imageNamed:@"Arrow_down_blue_72x72.png"] forState:UIControlStateNormal];
    [cell.expandcollapsecell setImage:[UIImage imageNamed:@"Arrow_up_blue_72x72.png"] forState:UIControlStateSelected];
    cell.numerandanulata.hidden=YES;
    cell.randgrenaanulata.hidden=YES;
    cell.numartoate.hidden=YES;
    cell.sageatablue2.hidden=YES;
    cell.sageataGri3.hidden=YES;
    cell.contentView.backgroundColor = [UIColor whiteColor];

   if ([indexPath section]== 0) {
       NSLog(@"E_A %i",E_ANULATA);
       if(E_ANULATA ==YES) {
       cell.numerandanulata.hidden=NO;
       cell.randgrenaanulata.hidden=NO;
       cell.numerandanulata.text =[NSString stringWithFormat:@"%@", [self.titluri objectAtIndex:0]];
       }
   }
   if ([indexPath section]== 1) {
    cell.primulcell.hidden=NO;
    cell.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1];
    if(pozele.count >0 && del.ARRAYASSETURI.count >0) {
      ////  NSLog(@"ce avem pe aici %@",del.ARRAYASSETURI);
        if( [[del.ARRAYASSETURI objectAtIndex:0]isKindOfClass:[NSDictionary class]] && [[del.ARRAYASSETURI objectAtIndex:0]respondsToSelector:@selector(allKeys)]) {
            NSDictionary *detaliupoza =[del.ARRAYASSETURI objectAtIndex:0];
            if(detaliupoza[@"tb"]) {
                NSString *calepozaserver = [NSString stringWithFormat:@"%@",detaliupoza[@"tb"]];
                //sdweb is laggy in iOS8 asa ca :
                dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
                    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL: [NSURL URLWithString:calepozaserver] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                        if (data) {
                            UIImage *image = [UIImage imageWithData:data];
                            if (image) {
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    CellCerereExistenta *updateCell = (CellCerereExistenta *)[self.LISTASELECT cellForRowAtIndexPath:indexPath];
                                    if (updateCell) {
                                    updateCell.PozaCerere.image = image;
                                    updateCell.PozaCerere.hidden =NO;
                                        UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(vezipozeCERERE)];
                                        [singleTap setNumberOfTapsRequired:1];
                                        [updateCell.PozaCerere  addGestureRecognizer:singleTap];
                                        [updateCell bringSubviewToFront:updateCell.PozaCerere];
                                    }
                                });
                           }
                        }
                    }];
                    [task resume];
                });

            }
        } else if ([[del.ARRAYASSETURI objectAtIndex:0]isKindOfClass:[UIImage class]]) {
            UIImage *detaliupoza =[del.ARRAYASSETURI objectAtIndex:0];
            cell.PozaCerere.image= detaliupoza;
       }
    } else {
    //nu are poza
    }

        if(CERERE[@"TEXTCERERE"]) {
           NSString *textcerere = [NSString stringWithFormat:@"%@",CERERE[@"TEXTCERERE"]];
          //  cell.TitluRand.text =textcerere;
            cell.TitluRand.numberOfLines=0;
            NSLog(@"cell titlurand : %@",cell.TitluRand.text);
             NSRange bigRange = [textcerere rangeOfString:textcerere];
             [cell.TitluRand setText:textcerere afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
                UIFont *MEDIUfont =[UIFont boldSystemFontOfSize:19];
                CTFontRef fontunu = CTFontCreateWithName((__bridge CFStringRef)MEDIUfont.fontName, MEDIUfont.pointSize, NULL);
                if (fontunu ) {
                    [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)fontunu range:bigRange];
                    [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[[UIColor darkGrayColor] CGColor] range:bigRange];
                    CFRelease(fontunu);
                }
                return mutableAttributedString;
            }];
            NSLog(@"cell titlurand : %@",cell.TitluRand.text);
            CGFloat widthWithInsetsApplied = self.view.frame.size.width-54;
            double heightrow =40;
            
                CGSize textSize = [textcerere boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:19]} context:nil].size;
                heightrow= textSize.height +10;
             NSLog(@"myheightrow %f",heightrow);
            if( cell.PozaCerere.image.size.width >0 && heightrow <45) {
                cell.dynamicheightTITLUCERERE.constant=50; //pentru ca poza
           } else {
              cell.dynamicheightTITLUCERERE.constant=heightrow;
          }
        }
 
       
            
       ///////  [cell.TitluRand sizeToFit];
   
       //2.MASINA
       
       
        NSString *masinatext = @"Mașina: ";
        NSString *PRODUCATORAUTODEF = [NSString stringWithFormat:@"%@",CERERE[@"PRODUCATORAUTO"]];
        NSString *MARCAAUTODEF = [NSString stringWithFormat:@"%@",CERERE[@"MARCAAUTO"]];
        NSString *ANMASINA = [NSString stringWithFormat:@"%@",CERERE[@"ANMASINA"]];
        NSString *VARIANTA = [NSString stringWithFormat:@"%@",CERERE[@"VARIANTA"]];
        NSString *MOTORIZARE = [NSString stringWithFormat:@"%@",CERERE[@"MOTORIZARE"]];
        NSString *SERIESASIU = [NSString stringWithFormat:@"%@",CERERE[@"SERIESASIU"]];
        
        NSString *PRODUCATORAUTO = @"";
        NSString *MARCAAUTO =@"";
        
        NSDictionary *producatorbaza = [DataMasterProcessor getProducator:PRODUCATORAUTODEF];
        if(producatorbaza && producatorbaza[@"name"]) {
            PRODUCATORAUTO = [NSString stringWithFormat:@"%@",producatorbaza[@"name"]];
        }
        NSDictionary *marcaautobaza = [DataMasterProcessor getMarcaAuto:MARCAAUTODEF];
        NSLog(@"marca baza %@", marcaautobaza);
        if(marcaautobaza && marcaautobaza[@"name"]) {
            MARCAAUTO = [NSString stringWithFormat:@"%@",marcaautobaza[@"name"]];
        }
        NSString *compus =@"";
        
            BOOL egol1= [self MyStringisEmpty:SERIESASIU];
            if(!egol1) {
         //jmode       compus = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ șasiu %@", PRODUCATORAUTO,MARCAAUTO,ANMASINA,VARIANTA,MOTORIZARE,SERIESASIU];
                   compus = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@", PRODUCATORAUTO,MARCAAUTO,ANMASINA,VARIANTA,MOTORIZARE,SERIESASIU];
            } else {
                compus = [NSString stringWithFormat:@"%@ %@ %@ %@ %@", PRODUCATORAUTO,MARCAAUTO,ANMASINA,VARIANTA,MOTORIZARE];
            }
            cell.DateMasina.textColor = [UIColor darkGrayColor];
        
       NSString *textulMeu = [NSString stringWithFormat:@"%@ %@",masinatext,compus];
              NSRange bigRange = [textulMeu rangeOfString:masinatext];
       NSRange mediumRange = [textulMeu rangeOfString:compus];
       
       //        NSMutableAttributedString * attributedString= [[NSMutableAttributedString alloc] initWithString:textulMeu];
       //        [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize: 18] range:bigRange];
       //        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:bigRange];
       //        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:mediumRange];
       cell.DateMasina.numberOfLines=0;
       ///cell.DateMasina.attributedText = attributedString;
       [cell.DateMasina setText:textulMeu afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
           // Core Text APIs use C functions without a direct bridge to UIFont. See Apple's "Core Text Programming Guide" to learn how to configure string attributes.
           UIFont *DateMasinafont =[UIFont boldSystemFontOfSize:18];
           UIFont *MEDIUfont =[UIFont systemFontOfSize:16];
           CTFontRef fontdoi = CTFontCreateWithName((__bridge CFStringRef)DateMasinafont.fontName, DateMasinafont.pointSize, NULL);
           CTFontRef fontunu = CTFontCreateWithName((__bridge CFStringRef)MEDIUfont.fontName, MEDIUfont.pointSize, NULL);
           if (fontdoi &&fontunu ) {
               [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)fontdoi range:bigRange];
               [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[[UIColor blackColor] CGColor] range:bigRange];
               
               [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)fontunu range:mediumRange];
               [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[[UIColor blackColor] CGColor] range:mediumRange];
               CFRelease(fontdoi);
               CFRelease(fontunu);
           }
           return mutableAttributedString;
       }];
       
    CGFloat widthWithInsetsApplied = self.view.frame.size.width-24;
    double heightrow =40;
    CGSize textSize = [textulMeu boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    heightrow= textSize.height;
    cell.dynamicheightDATEMASINA.constant=heightrow+5;

       //3. TIP NOI SAU SECOND
       NSString *PIESENOI = [NSString stringWithFormat:@"%@",CERERE[@"IS_NEW"]];
       NSString *PIESESECOND = [NSString stringWithFormat:@"%@",CERERE[@"IS_SECOND"]];
       NSString *piesenoisecond =@"";
       int valoareNOI = PIESENOI.intValue;
       int valoareSECOND = PIESESECOND.intValue;
       //hardcoding ancient items ...
      
       if( valoareNOI ==1 && valoareSECOND ==1 ){
           piesenoisecond = @"\u2022 Vreau oferte de piese noi și second";
           
       } else if( valoareNOI ==1 && valoareSECOND ==0){
           piesenoisecond =@"\u2022 Vreau oferte de piese noi";
           
       } else if( valoareNOI ==0 && valoareSECOND ==1){
           piesenoisecond =@"\u2022 Vreau oferte de piese second";
           
       }
       cell.Tipnoisausecond.textColor = [UIColor darkGrayColor];
       NSRange bigRange2 = [piesenoisecond rangeOfString:piesenoisecond];
       //  cell.Tipnoisausecond.text = piesenoisecond;
       [cell.Tipnoisausecond setText:piesenoisecond afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
           UIFont *MEDIUfont =[UIFont systemFontOfSize:16];
           CTFontRef fontunu = CTFontCreateWithName((__bridge CFStringRef)MEDIUfont.fontName, MEDIUfont.pointSize, NULL);
           if (fontunu ) {
               [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)fontunu range:bigRange2];
               [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[[UIColor darkGrayColor] CGColor] range:bigRange2];
               CFRelease(fontunu);
           }
           return mutableAttributedString;
       }];
       
       cell.Tipnoisausecond.numberOfLines = 1;
       //4. ZONA DE LIVRARE
       NSString *JUDET = [NSString stringWithFormat:@"%@",CERERE[@"JUDET"]];
       NSString *JUDETNAME = @"";
       NSDictionary *judbaza = [DataMasterProcessor getJudet:JUDET];
       if(judbaza && judbaza[@"name"]) {
           JUDETNAME = [NSString stringWithFormat:@"%@",judbaza[@"name"]];
       }
       
       NSString *LOCALITATE = [NSString stringWithFormat:@"%@",CERERE[@"LOCALITATE"]];
       NSString *LOCALITATENAME = @"";
       NSDictionary *LOCALITATEselectata = [DataMasterProcessor getLocalitate:LOCALITATE];
       
       if(LOCALITATEselectata && LOCALITATEselectata[@"name"]) {
           LOCALITATENAME = [NSString stringWithFormat:@"%@",LOCALITATEselectata[@"name"]];
       }
       
       NSString *locjudet = @"";
     //jmode  locjudet = [NSString stringWithFormat:@"\u2022 Zona de livrare: %@, Jud. %@", LOCALITATENAME, JUDETNAME];
        locjudet = [NSString stringWithFormat:@"\u2022 Zona de livrare: %@, %@", LOCALITATENAME, JUDETNAME];
       cell.ZonaLivrare.textColor = [UIColor darkGrayColor];
       cell.ZonaLivrare.numberOfLines = 0;
       //  cell.ZonaLivrare.text = locjudet;
       NSRange bigRange3 = [locjudet rangeOfString:locjudet];
      [cell.ZonaLivrare setText:locjudet afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
           UIFont *MEDIUfont =[UIFont systemFontOfSize:16];
           CTFontRef fontunu = CTFontCreateWithName((__bridge CFStringRef)MEDIUfont.fontName, MEDIUfont.pointSize, NULL);
           if (fontunu ) {
               [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)fontunu range:bigRange3];
               [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[[UIColor darkGrayColor] CGColor] range:bigRange3];
               CFRelease(fontunu);
           }
           return mutableAttributedString;
       }];
         [cell.contentView bringSubviewToFront:cell.PozaCerere];
}
  
    
    

    if(AREWINNER ==YES) {
         if([indexPath section]==7) {
            cell.contentView.backgroundColor = [UIColor colorWithRed:(232/255.0) green:(232/255.0) blue:(232/255.0) alpha:1];
        }
          if ([indexPath section]== 6) {
            cell.primulcell.hidden=YES;
            NSDictionary *cellcom=[[self.titluri objectAtIndex:6]objectAtIndex:0] ;
            if(ipx ==0) {
                cell.ofertacastigatoare.hidden=NO;
                //    [questuri setObject:descrierecoments forKey:@"nume"];
                cell.HeadOferta.text = [NSString stringWithFormat:@"%@", cellcom[@"nume"]];
                cell.HeadOferta.textColor =[UIColor blackColor];
                cell.ofertacastigatoare.backgroundColor =[UIColor whiteColor];
                cell.topdetofer.backgroundColor =[UIColor whiteColor];
                
                NSLog(@"cell titlu 1 %@", cell.HeadOferta.text);
                cell.RandGri.hidden=YES;
                cell.TitluOferta.hidden=YES;
                cell.TipOferta.hidden=YES;
                cell.PretOferta.hidden=YES;
                cell.PozaOferta.hidden=YES;
                [cell.HeadOferta sizeToFit];
                CGRect nroferteframe =cell.HeadOferta.frame;
                NSDictionary *comentariile =[NSDictionary dictionaryWithDictionary:self.intrebaridelaaltii];
                UILabel *catetotal = [[UILabel alloc]init];
                if(comentariile[@"comments_count"]) {
                    NSString *catecom = [NSString stringWithFormat:@"%@",comentariile[@"comments_count"]];
                    if(catecom.integerValue >0) {
                        cell.expandcollapsecell.hidden=NO;
                        cell.expandcollapsecell.userInteractionEnabled=YES;
//                        UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(expandsaustrangerows:)];
//                        [singleTap setNumberOfTapsRequired:1];
//                        [cell  addGestureRecognizer:singleTap];
                    }

                    
//                    CGRect framenecesar = CGRectMake(nroferteframe.origin.x+ nroferteframe.size.width +6,cell.HeadOferta.frame.origin.y-1, 25, 25);
//                    catetotal.frame = framenecesar;
//                    catetotal.text = catecom;
//                    catetotal.tag = 999;
//                    NSLog(@"index row : %ld, section : %ld",(long)indexPath.row, (long)indexPath.section);
//                    [cell.contentView addSubview:catetotal];
//                    if(comentariile[@"comments_unread_count"]) {
//                        NSString *catecomentariinecitite = [NSString stringWithFormat:@"%@",comentariile[@"comments_unread_count"]];
//                        if(catecomentariinecitite.integerValue ==0) {
//                            //do nothing
//                        } else {
//                            CGRect framenecesar = CGRectMake(catetotal.frame.origin.x+ catetotal.frame.size.width +5,cell.HeadOferta.frame.origin.y-1, 25, 25);
//                            //   NSString *mybadgenr =@"2";
//                            NSString *mybadgenr = catecomentariinecitite;
//                            CustomBadge *badge1 = [CustomBadge customBadgeWithString:mybadgenr:framenecesar];
//                            badge1.hidden =NO;
//                              NSLog(@"badge index row : %ld, section : %ld",(long)indexPath.row, (long)indexPath.section);
//                            [cell.contentView addSubview:badge1];
//                            
//                        }
//                    }
                    
                    cell.numartoate.hidden = NO;
                    if(catecom){
                       cell.numartoate.text = catecom;
                    } else{
                        cell.numartoate.text = @"";
                    }
                    [cell.numartoate sizeToFit];
                    // [cell.contentView addSubview:catetotal];
                    if(comentariile[@"comments_unread_count"]) {
                        NSString *catecomentariinecitite = [NSString stringWithFormat:@"%@",comentariile[@"comments_unread_count"]];
                        if(catecomentariinecitite.integerValue ==0) {
                            //do nothing
                            [cell.badgenecitite setHidden:YES];
                        } else {
//                            CGRect framenecesar = CGRectMake(cell.numartoate.frame.origin.x+ cell.numartoate.frame.size.width +8,cell.HeadOferta.frame.origin.y-1, 25, 25);
//                            NSString *mybadgenr = catecomentariinecitite;
                            [cell.badgenecitite setHidden:NO];
                            cell.badgenecitite.badgeText = catecomentariinecitite;
//                            cell.badgenecitite.backgroundColor = [UIColor redColor];
                            cell.badgenecitite.tintColor = [UIColor whiteColor];
                            cell.badgenecitite.badgeStyle = [BadgeStyle defaultStyle];
                            cell.badgenecitite.badgeScaleFactor = 1.0f;
                            cell.badgenecitite.badgeCornerRoundness = 0.4;
                            //                            CustomBadge *badge1 = [CustomBadge customBadgeWithString:mybadgenr:framenecesar];
                            //                            badge1.hidden =NO;
                            //                              NSLog(@"badge : %ld, section : %ld",(long)indexPath.row, (long)indexPath.section);
                            //                            [cell.contentView addSubview:badge1];
                            
                        }
                    }

                }
                NSMutableDictionary *deschimbat = [NSMutableDictionary dictionaryWithDictionary:[stareexpand objectAtIndex:0]]; //e un singur dictionar
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
            } else {
                cell.discutieuser.hidden=NO;
                cell.contentView.backgroundColor =[UIColor whiteColor];
                if(cellcom[@"SubItems"]) {
                NSArray *mesajeitems = cellcom[@"SubItems"];
                    if(mesajeitems >0) {
                NSDictionary *mesage = [mesajeitems objectAtIndex:ipx-1]; //pt ca primul rand e nume rand Intrebari de la
                NSString *TitluMesaj=@"";
                NSString *NumePersoanaMesaj=@"";
                if(mesage[@"message"]) TitluMesaj = [NSString stringWithFormat:@"%@",mesage[@"message"]];
                if(mesage[@"username"]) NumePersoanaMesaj = [NSString stringWithFormat:@"%@",mesage[@"username"]];
                cell.TitluMesaj.text =TitluMesaj;
                cell.TitluMesaj.textColor = [UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1];
                cell.NumePersoanaMesaj.text=NumePersoanaMesaj;
               [cell.discutieuser bringSubviewToFront:cell.TitluMesaj];
                NSLog(@"mesaj : %@",mesage);
                if(mesage[@"is_viewed"]) {
                    NSString *is_viewed =  [NSString stringWithFormat:@"%@",mesage[@"is_viewed"]];
                    if(is_viewed.integerValue==0) {
                        cell.roundalbastru.hidden=NO;
                    } else {
                        cell.roundalbastru.hidden=YES;
                    }
                }
                    }
                }
                cell.sageataGri2.hidden=NO;
                NSLog(@"mesaje gg");
            }
        }
        // daca e winner
        
        if ([indexPath section]== 2) {
             cell.contentView.backgroundColor=  [UIColor whiteColor] ;
            
            cell.primulcell.hidden=YES;
            cell.numartoate.hidden=YES;
            cell.sageataGri.hidden=NO;
            
            if(AREWINNER ==YES ) {
                NSLog(@"[self.titluri objectAtIndex:2] %@",[self.titluri objectAtIndex:2]);
                NSArray *dateoferta = [NSArray arrayWithArray:[self.titluri objectAtIndex:2]];
                cell.RandGri.hidden=NO;
                cell.TitluOferta.hidden=NO;
                cell.TipOferta.hidden=NO;
                cell.PretOferta.hidden=NO;
                cell.PozaOferta.hidden=NO;
                
                cell.TitluOferta.verticalAlignment= TTTAttributedLabelVerticalAlignmentTop;
                NSString *C_leisaualtavaluta =@"";
                NSString *C_pret=@"";
                NSString *C_um =@"";
                NSString *C_tipnousecond =@"";
                cell.numartoate.hidden=NO;
                NSString *cateoferteintotal=@"";
                
                if(DETALIICERERE[@"total_count"]) {
                    cateoferteintotal =[NSString stringWithFormat:@"Toate (%@)",DETALIICERERE[@"total_count"]];
                    
                    [cell.badgenecitite setHidden:YES];
                    cell.numartoate.text= cateoferteintotal;
                    //cell.numartoate.textColor =[UIColor blueColor];
                    cell.numartoate.textColor = [UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1];
                    UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(aratatoate)];
                    [singleTap setNumberOfTapsRequired:1];
                    [cell.topdetofer  addGestureRecognizer:singleTap];
                     }
                UITapGestureRecognizer *singleTap2 =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(veziofertacastigatoare)];
                [singleTap2 setNumberOfTapsRequired:1];
                [cell.detofer addGestureRecognizer:singleTap2];
                NSDictionary *detaliuoferta = [dateoferta objectAtIndex:0];
                NSLog(@"jca %@",detaliuoferta);
                cell.ofertacastigatoare.hidden=NO;
                //    [questuri setObject:descrierecoments forKey:@"nume"];
                NSLog(@"cell titlu 1 %@", cell.HeadOferta.text);
                NSDictionary *detaliuofertacastigatoare = [[NSDictionary alloc]init];
                cell.HeadOferta.textColor =[UIColor colorWithRed:(5/255.0) green:(127/255.0) blue:(54/255.0) alpha:1];
                if( detaliuoferta[@"nume"])  cell.HeadOferta.text = [NSString stringWithFormat:@"%@", detaliuoferta[@"nume"]];
                if( detaliuoferta[@"SubItems"]) detaliuofertacastigatoare =  detaliuoferta[@"SubItems"];
                cell.numartoate.hidden=NO;
                double INALTIMEPOZA =0;
                if(ipx==0) {
                    
                  
                    cell.heightHeadOferta.constant =36;
                    cell.heighttitlurand.constant=36;
                    cell.dynamicDETOFERHEIGHT.constant =72;
                    cell.sageatablue2.hidden=NO;
                   NSLog(@"cell titlu 2 %@", cell.HeadOferta.text);
                   NSLog(@"detaliuofertacastigatoare %@", detaliuofertacastigatoare);
                  
                    NSArray *pozeoferta = [[NSArray alloc]init];
                    if( detaliuofertacastigatoare[@"images"])  pozeoferta = detaliuofertacastigatoare[@"images"];
                    if(pozeoferta.count >0 ) {
                        NSLog(@"ce avem pe aici 2 %@",pozeoferta);
                        if( [[pozeoferta objectAtIndex:0]isKindOfClass:[NSDictionary class]] && [[pozeoferta objectAtIndex:0]respondsToSelector:@selector(allKeys)]) {
                            NSDictionary *detaliupoza =[pozeoferta objectAtIndex:0];
                            if(detaliupoza[@"tb"]) {
                                NSString *calepozaserver = [NSString stringWithFormat:@"%@",detaliupoza[@"tb"]];
                                   dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
                                    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL: [NSURL URLWithString:calepozaserver] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                        if (data) {
                                            UIImage *image = [UIImage imageWithData:data];
                                            if (image) {
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    CellCerereExistenta *updateCell = (CellCerereExistenta *)[self.LISTASELECT cellForRowAtIndexPath:indexPath];
                                                    if (updateCell)
                                                        updateCell.PozaOferta.image = image;
                                                    updateCell.PozaOferta.hidden =NO;
                                                    updateCell.LEFTPOZAOFERTA.constant = 45;
                                                  
                                                });
                                            }
                                        }
                                    }];
                                    [task resume];
                                });
                                 INALTIMEPOZA =40;
                                [cell.ofertacastigatoare bringSubviewToFront:cell.PozaOferta];
                            }
                        }else if ([[pozeoferta objectAtIndex:0]isKindOfClass:[UIImage class]]) {
                            UIImage *detaliupoza =[pozeoferta objectAtIndex:0];
                            cell.PozaOferta.image= detaliupoza;
                            cell.LEFTPOZAOFERTA.constant = 45;
                            [cell.ofertacastigatoare bringSubviewToFront:cell.PozaOferta];
                              INALTIMEPOZA =40;
                        }
                    }else {
                        //nu are poza
                        cell.LEFTPOZAOFERTA.constant =0;
                          INALTIMEPOZA =0;
                    }

                } else {
                    cell.heightHeadOferta.constant =0;
                    cell.heighttitlurand.constant=0;
     
                    ////randuri la care nu afisam poza
                    cell.topdetofer.hidden=YES;
                    cell.LEFTPOZAOFERTA.constant =0;
                    cell.HeadOferta.hidden=YES;
                    cell.numartoate.hidden=YES;
                    cell.RandGri.hidden=YES;
                    cell.TitluOferta.hidden=NO;
                    cell.TipOferta.hidden=NO;
                    cell.PretOferta.hidden=NO;
                    cell.PozaOferta.hidden=YES;
                    cell.sageataGri.hidden=NO;
                    cell.heightHeadOferta.constant =0;
                    cell.heighttitlurand.constant=0;
                    cell.sageatablue2.hidden=YES;
                }
                    
              
                //item winner
                NSDictionary *maimultedetaliioferta =[[NSDictionary alloc]init];
              
                if(detaliuofertacastigatoare[@"items"]) {
                NSMutableArray *itemsnumarate = [NSMutableArray arrayWithArray:detaliuofertacastigatoare[@"items"]];
                maimultedetaliioferta= [detaliuofertacastigatoare[@"items"] objectAtIndex:ipx];
                    NSInteger catetitems =itemsnumarate.count;
                    NSLog(@"my ipx and items count %li %li", (long)ipx, (long)catetitems);
                    if(catetitems >1 && ipx != catetitems-1) {
                         cell.sageataGri.hidden=YES;
                    }else if(catetitems >1 && ipx == catetitems-1) { //ultimul rand are sageata
                         cell.sageataGri.hidden=NO;
                    } else {
                          cell.sageataGri.hidden=NO; //primul are cand e doar un item in items
                    }
                if(maimultedetaliioferta[@"description"]) {
                    NSString *titluoferta= [NSString stringWithFormat:@"%@",maimultedetaliioferta[@"description"]];
                    cell.TitluOferta.text=titluoferta;
                    cell.TitluOferta.textColor = [UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1];
                 
                    CGFloat widthWithInsetsApplied = self.view.frame.size.width;
                    widthWithInsetsApplied = self.view.frame.size.width - 24;
                    double inaltimerand=0;
                    CGSize textSize = [titluoferta boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17]} context:nil].size;
                    UIFont *tester = [UIFont systemFontOfSize:17];
                    inaltimerand= textSize.height;
                    double numberOfLines = textSize.height /tester.pointSize;
                    if(numberOfLines >2) {
                     inaltimerand = 42;
                       
                    } else {
                        if(INALTIMEPOZA ==40) {
                             inaltimerand = 42;
                        } else {
                        inaltimerand =20;
                        }
                    }
                    cell.dynamicDETOFERHEIGHT.constant = inaltimerand +35 ;
                    cell.dynamictitluheight.constant = inaltimerand;
                    
                }
                
                if(maimultedetaliioferta[@"currency_id"]) {
                    NSString *Curencyid= [NSString stringWithFormat:@"%@",maimultedetaliioferta[@"currency_id"]];
                    NSDictionary *curencydinbaza = [NSDictionary dictionaryWithDictionary:[DataMasterProcessor getCURRENCY:Curencyid]];
                    if(curencydinbaza[@"name"]) {
                        C_leisaualtavaluta= [NSString stringWithFormat:@"%@",curencydinbaza[@"name"]];
                    }
                }
                if(maimultedetaliioferta[@"price"]) {
                    C_pret= [NSString stringWithFormat:@"%@",maimultedetaliioferta[@"price"]];
                }
                if(maimultedetaliioferta[@"um"]) {
                    C_um= [NSString stringWithFormat:@"%@",maimultedetaliioferta[@"um"]];
                }
                NSString *compus_pret_um= [NSString stringWithFormat:@"%@ %@/ %@", C_pret,C_leisaualtavaluta,C_um];
                NSRange bigRange = [compus_pret_um rangeOfString:C_pret];
                NSRange mediumRange = [compus_pret_um rangeOfString:C_leisaualtavaluta];
                NSRange smallRange = [compus_pret_um rangeOfString:C_um];
                NSMutableAttributedString * attributedString= [[NSMutableAttributedString alloc] initWithString:compus_pret_um];
                [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize: 16] range:bigRange];
                [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:mediumRange];
                [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:smallRange];
                cell.PretOferta.attributedText=attributedString;
                [cell.PretOferta sizeToFit];
                //"new_sh" = 2;
                if(detaliuofertacastigatoare[@"new_sh"]) {
                    NSString *valoaretipnousecond= [NSString stringWithFormat:@"%@",detaliuofertacastigatoare[@"new_sh"]];
                    if(valoaretipnousecond.integerValue ==1) {
                        C_tipnousecond =@"Piesă nouă:";
                    }
                    if(valoaretipnousecond.integerValue ==2) {
                        C_tipnousecond =@"Piesă second:";
                    }
                    cell.TipOferta.text =C_tipnousecond;
                    cell.TipOferta.numberOfLines =1;
                    
                }
                
                
                //               cell.TitluOferta.text=@"oferta la cerere";
                //               cell.TipOferta.text=@"piesa noua";
                //               cell.PretOferta.text=@"30 lei/buc.";
                
                    
                }
            }
        
        }
        
        if ([indexPath section]== 4) {
            cell.bluecell.hidden=NO;
            cell.Altrandalbastru.text = [NSString stringWithFormat:@"%@", [self.titluri objectAtIndex:4]];
            cell.Altrandalbastru.textColor =  [UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] ;
            cell.IconRand.image = [UIImage imageNamed:@"Icon_Anulare_Castigator_144x144.png"];
            ///Icon_Anulare_Castigator_Grayedout_144x144.png
            [cell.contentView bringSubviewToFront:cell.IconRand];
             cell.numartoate.hidden=YES;
            
        }
        if ([indexPath section]== 5) {
           if(AREWINNER ==YES ) {
                if( OFERTACASTIGATOARELACERERE[@"buyerfeedback"]) {
                    NSString *buyerfeed= [NSString stringWithFormat:@"%@",OFERTACASTIGATOARELACERERE[@"buyerfeedback"]];
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
                cell.Altrandalbastru.text = [NSString stringWithFormat:@"%@", [self.titluri objectAtIndex:5]];
                cell.IconRand.image = [UIImage imageNamed:@"Icon_Acorda_Calificativ_Face_Grayedout_144x144.png"];
                cell.IconRand.hidden=NO;
                cell.sageataBlue.hidden=YES;
                cell.sageataGri3.hidden=NO;
                [cell.contentView bringSubviewToFront:cell.IconRand];
                
            } else {
                cell.bluecell.hidden=NO;
                cell.IconRand.hidden=NO;
                cell.sageataBlue.hidden=NO;
                cell.sageataGri3.hidden=YES;
                cell.Altrandalbastru.textColor =  [UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] ;
                cell.Altrandalbastru.text = [NSString stringWithFormat:@"%@", [self.titluri objectAtIndex:5]];
                cell.IconRand.image = [UIImage imageNamed:@"Icon_Acorda_Calificativ_Face_Blue_144x144.png"];
                [cell.contentView bringSubviewToFront:cell.IconRand];
            }
        }
        //nu uita sectiunea 3
        //                            0             1                  2                3                       4                   5                   6
        // self.titluri =@[@"Cerere anulată",@"Planse bord etc",OFERTACASTIGATOARE,DICTIONARWINNER,@"Anulează câștigător",@"Acordă calificativ",MESAJEREX];
 if ([indexPath section]== 3) {
     cell.randul1.hidden=NO;
     cell.catecalificative.hidden=NO;
     [cell.contentView bringSubviewToFront:cell.randul1];
     NSDictionary *dateuser =[NSDictionary dictionaryWithDictionary:DICTIONARWINNER];
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
             NSLog(@"companie %@",companie);
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
 }
        
    } else
        if(E_ANULATA ==YES) {
           if ([indexPath section]== 2) {
               cell.primulcell.hidden=YES;
               cell.bluecell.hidden =YES;
               cell.ofertacastigatoare.hidden=YES;
               cell.discutieuser.hidden=YES;
               cell.expandcollapsecell.hidden=YES;
               cell.randul1.hidden=YES;
                cell.numerandanulata.hidden=YES;
               cell.randgrenaanulata.hidden=YES;
               cell.numartoate.hidden=YES;
               cell.sageatablue2.hidden=YES;
               cell.sageataGri3.hidden=YES;
               cell.contentView.backgroundColor = [UIColor colorWithRed:(232/255.0) green:(232/255.0) blue:(232/255.0) alpha:1];
               NSLog(@"colorrrr %@", cell.contentView.backgroundColor );
           }
        }else {
         if ([indexPath section]== 3) {
             cell.primulcell.hidden=YES;
             cell.bluecell.hidden =YES;
             cell.ofertacastigatoare.hidden=YES;
             cell.discutieuser.hidden=YES;
             cell.expandcollapsecell.hidden=YES;
             cell.randul1.hidden=YES;
             cell.numerandanulata.hidden=YES;
             cell.randgrenaanulata.hidden=YES;
             cell.numartoate.hidden=YES;
             cell.sageatablue2.hidden=YES;
             cell.sageataGri3.hidden=YES;
             ANULEAZAVIEW.hidden=YES;
             AFOSTANULATAVIEW.hidden=YES;
           cell.contentView.backgroundColor = [UIColor colorWithRed:(232/255.0) green:(232/255.0) blue:(232/255.0) alpha:1];
         }
        if ([indexPath section]== 2) {
            cell.primulcell.hidden=YES;
            NSDictionary *cellcom=[[self.titluri objectAtIndex:2]objectAtIndex:0] ;
            if(ipx ==0) {
                cell.ofertacastigatoare.hidden=NO;
                //    [questuri setObject:descrierecoments forKey:@"nume"];
                NSLog(@"numele vietii %@",cellcom[@"nume"]);
                cell.HeadOferta.text = [NSString stringWithFormat:@"%@", cellcom[@"nume"]];
                cell.HeadOferta.textColor =[UIColor blackColor];
                cell.HeadOferta.font =[UIFont boldSystemFontOfSize:17];
                cell.ofertacastigatoare.backgroundColor =[UIColor whiteColor];
                cell.topdetofer.backgroundColor =[UIColor whiteColor];
                NSLog(@"cell titlu 1 %@", cell.HeadOferta.text);
                cell.RandGri.hidden=YES;
                cell.TitluOferta.hidden=YES;
                cell.TipOferta.hidden=YES;
                cell.PretOferta.hidden=YES;
                cell.PozaOferta.hidden=YES;
                cell.HeadOferta.adjustsFontSizeToFitWidth = TRUE;
                [cell.HeadOferta sizeToFit];
                CGRect nroferteframe =cell.HeadOferta.frame;
                NSDictionary *comentariile =[NSDictionary dictionaryWithDictionary:self.intrebaridelaaltii];
                //vasile
               // UILabel *catetotal = [[UILabel alloc]init];
                //catetotal.tag = 999;
                if(comentariile[@"comments_count"]) {
                    NSString *catecom = [NSString stringWithFormat:@"%@",comentariile[@"comments_count"]];
                    if(catecom.integerValue >0) {
                        cell.expandcollapsecell.hidden=NO;
                        cell.expandcollapsecell.userInteractionEnabled=YES;
//                        UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(expandsaustrangerows:)];
//                        [singleTap setNumberOfTapsRequired:1];
//                        [cell  addGestureRecognizer:singleTap];
                    }
                    
                   // CGRect framenecesar = CGRectMake(nroferteframe.origin.x+ nroferteframe.size.width +6,cell.HeadOferta.frame.origin.y-1, 25, 25);
                    //catetotal.frame = framenecesar;
                    cell.numartoate.hidden = NO;
                    cell.numartoate.text = catecom;
                    if(catecom){
                        cell.numartoate.text = catecom;
                    } else{
                        cell.numartoate.text = @"0";
                    }
                    [cell.numartoate sizeToFit];
                   // [cell.contentView addSubview:catetotal];
                    if(comentariile[@"comments_unread_count"]) {
                        NSString *catecomentariinecitite = [NSString stringWithFormat:@"%@",comentariile[@"comments_unread_count"]];
                        if(catecomentariinecitite.integerValue ==0) {
                            //do nothing
                            [cell.badgenecitite setHidden:YES];
                        } else {
                            [cell.badgenecitite setHidden:NO];
                            CGRect framenecesar = CGRectMake(cell.numartoate.frame.origin.x+ cell.numartoate.frame.size.width +8,cell.HeadOferta.frame.origin.y-1, 25, 25);
                            NSString *mybadgenr = catecomentariinecitite;
                            cell.badgenecitite.badgeText = catecomentariinecitite;
//                            cell.badgenecitite.backgroundColor = [UIColor redColor];
                             cell.badgenecitite.tintColor = [UIColor whiteColor];
                             cell.badgenecitite.badgeStyle = [BadgeStyle defaultStyle];
                            cell.badgenecitite.badgeScaleFactor = 1.0f;
                            cell.badgenecitite.badgeCornerRoundness = 0.4;
//                            CustomBadge *badge1 = [CustomBadge customBadgeWithString:mybadgenr:framenecesar];
//                            badge1.hidden =NO;
//                              NSLog(@"badge : %ld, section : %ld",(long)indexPath.row, (long)indexPath.section);
//                            [cell.contentView addSubview:badge1];
                            
                        }
                    }
                }
                //end vasile
                
            } else {
                cell.discutieuser.hidden=NO;
                if(cellcom[@"SubItems"]) {
                    NSArray *mesajeitems = cellcom[@"SubItems"];
                    if(mesajeitems >0) {
                NSDictionary *mesage = [mesajeitems objectAtIndex:ipx-1]; //pt ca primul rand e nume rand Intrebari de la
                NSString *TitluMesaj=@"";
                NSString *NumePersoanaMesaj=@"";
                if(mesage[@"message"]) TitluMesaj = [NSString stringWithFormat:@"%@",mesage[@"message"]];
                if(mesage[@"username"]) NumePersoanaMesaj = [NSString stringWithFormat:@"%@",mesage[@"username"]];
                cell.TitluMesaj.text =TitluMesaj;
                cell.TitluMesaj.textColor = [UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1];
                [cell.discutieuser bringSubviewToFront:cell.TitluMesaj];
                        
                cell.NumePersoanaMesaj.text=NumePersoanaMesaj;
                if(mesage[@"is_viewed"]) {
                    NSString *is_viewed =  [NSString stringWithFormat:@"%@",mesage[@"is_viewed"]];
                    if(is_viewed.integerValue==0) {
                        cell.roundalbastru.hidden=NO;
                    } else {
                        cell.roundalbastru.hidden=YES;
                    }
                }
                    }
                }
                cell.sageataGri2.hidden=NO;
                NSLog(@"mesaje gg");
            }
        }

      
       }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger ipx =indexPath.section;
    NSInteger ROWSELECTAT = indexPath.row;
    /*   self.titluri =@[@"Cerere anulată",@"Planse bord etc",OFERTACASTIGATOARE,MESAJEREX,@"Anulează câștigător",@"Acordă calificativ"];
     } else {
     self.titluri =@[@"Cerere anulată",@"Planse bord etc",MESAJEREX];*/
    NSLog(@"ipx : %ld rowselectat : %ld",(long)ipx,(long)ROWSELECTAT);
if(AREWINNER ==NO ) {
    switch (ipx) {
        case 1: {
            NSLog(@"nimic");
            [self vezipozeCERERE];
        }
            break;
        case 2: {
            NSLog(@"mesaje");
            if(ROWSELECTAT == 0){
                if(E_ANULATA ==YES) {
                    NSLog(@"nothing left");
                } else {
                [self expandsaustrangerows:indexPath];
                }
            } else{
                //gaseste aria care contine mesajul selectat
                NSLog(@"ROWSELECTAT %li",(long)ROWSELECTAT); //vezi ca aria incepe de la 0 deci fa -1
                NSLog(@"crashh %@",self.titluri);
                
                NSMutableDictionary *cellcom=[NSMutableDictionary dictionaryWithDictionary:[[self.titluri objectAtIndex:ipx]objectAtIndex:0]];
                NSLog(@"cellcom %@", cellcom);
                if([self checkDictionary:cellcom] && cellcom[@"SubItems"]) {
                    NSMutableArray *mesajeitems = [NSMutableArray arrayWithArray:cellcom[@"SubItems"]];
                    NSDictionary *mesage = [NSDictionary dictionaryWithDictionary:[mesajeitems objectAtIndex:ROWSELECTAT-1]];
                    if(mesajeitems.count >0) {
                        
                        NSLog(@"mesajeitems : %@",mesajeitems);
                        NSLog(@"mesage : %@", mesage);
                        
                        //    NSMutableDictionary *message = [NSMutableDictionary dictionaryWithDictionary:[mesajeitems objectAtIndex:ROWSELECTAT-1]];
                        NSMutableArray *toatemesajele =[[NSMutableArray alloc]init];
                        NSLog(@"intrebari de la altii : %@",intrebaridelaaltii);
                        if(intrebaridelaaltii[@"discussions"]) {
                            toatemesajele =intrebaridelaaltii[@"discussions"];
                            NSMutableArray * msgArr = [NSMutableArray arrayWithArray:toatemesajele];
                            for(int i=0;i< toatemesajele.count;i++) {
                                NSMutableArray *deprelucrat = [NSMutableArray arrayWithArray:[toatemesajele objectAtIndex:i]];
                                deprelucrat = [NSMutableArray arrayWithArray:[deprelucrat.reverseObjectEnumerator allObjects]];
                                NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSDictionary *dict, NSDictionary *bindings) {
                                    NSNumber *locationID = dict[@"messageid"];
                                    
                                    if([locationID intValue] == [[mesage objectForKey:@"messageid" ] intValue])
                                    {
                                        return YES;
                                    }
                                    return NO;
                                }];
                                NSLog(@"search : %@",[deprelucrat filteredArrayUsingPredicate:predicate]);
                                if([[deprelucrat filteredArrayUsingPredicate:predicate] count]) {
                                    NSLog(@"am gasit array mare %@", deprelucrat);
                                    NSMutableDictionary *lastid = [[NSMutableDictionary alloc] init];
                                    for(NSDictionary * dict in deprelucrat){
                                        if(!([dict[@"is_myself"] boolValue])){
                                            lastid = [NSMutableDictionary dictionaryWithDictionary:dict];
                                            break;
                                        }
                                    }
                                    NSLog(@"lastid : %@",lastid);
                                    if(lastid[@"messageid"]) {
                                        if (![lastid[@"is_viewed"] boolValue]){
                                            NSString *messageid = [NSString stringWithFormat:@"%@",lastid[@"messageid"]];
                                            lastid[@"is_viewed"] = @"1";
                                            mesajeitems[ROWSELECTAT-1] = [lastid copy];
                                            cellcom[@"SubItems"] = mesajeitems;
                                            NSMutableArray * aux = [NSMutableArray arrayWithArray:[self.titluri objectAtIndex:ipx]];
                                            aux[0] = [cellcom copy];
                                            self.titluri[ipx] = [aux copy];
                                            int unread = [intrebaridelaaltii[@"comments_unread_count"] intValue];
                                            unread = unread-1;
                                            intrebaridelaaltii[@"comments_unread_count"] = [NSNumber numberWithInteger:unread];
                                            NSMutableArray * revertback = [NSMutableArray arrayWithArray:[deprelucrat.reverseObjectEnumerator allObjects]];
                                            NSInteger index = [revertback indexOfObject:mesage];
                                            revertback[index] = [lastid copy];
                                            msgArr[i] = [deprelucrat copy];
                                            intrebaridelaaltii[@"discussions"] = msgArr;
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
                                    
                                    
                                    [self addhud];
                                    //fa push la ecran detalii mesaje
                                    [self schimbaicon:ipx];
                                    EcranMesajeViewController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"EcranMesajeViewControllerVC"];
                                    vc.CE_TIP_E=@"dincerere"; //dincerere sau dinnotificari
                                    deprelucrat = [NSMutableArray arrayWithArray:[deprelucrat.reverseObjectEnumerator allObjects]];
                                    [CERERE setObject:deprelucrat forKey:@"discussions"];
                                    vc.CORPDATE =CERERE;
                                    [self.navigationController pushViewController:vc animated:YES];
                                    break;
                                }
                            }
                        }
                    }
                }
            }
            

            }
          break;
        default:
            break;
    }
} else {
         switch (ipx) {
             case 1: {
                 NSLog(@"nimic");
                 break;
             }
             case 2: {
                 NSLog(@"nimic");
//                 if(ROWSELECTAT == 0){
//                     [self aratatoate];
//                 }
             }
                 break;
                
             case 6: {
                 NSLog(@"mesaje");
                 if(ROWSELECTAT == 0){
                     if(E_ANULATA ==YES) {
                         NSLog(@"nothing left");
                     } else {
                         [self expandsaustrangerows:indexPath];
                     }

                 } else{
                     //gaseste aria care contine mesajul selectat
                     NSLog(@"ROWSELECTAT %i",(int)ROWSELECTAT); //vezi ca aria incepe de la 0 deci fa -1
                     NSLog(@"crashh %@",[self.titluri objectAtIndex:ipx]);
                     
                     NSMutableDictionary *cellcom= [NSMutableDictionary dictionaryWithDictionary:[[self.titluri objectAtIndex:ipx]objectAtIndex:0]];
                     //                 NSMutableArray *mesajeitems = [NSMutableArray arrayWithArray:cellcom[@"SubItems"]];
                     //                 NSMutableDictionary *message = [NSMutableDictionary dictionaryWithDictionary:[mesajeitems objectAtIndex:ROWSELECTAT-1]];
                     if([self checkDictionary:cellcom] && cellcom[@"SubItems"]) {
                         NSArray *mesajeitems = cellcom[@"SubItems"];
                         if(mesajeitems.count >0) {
                             NSDictionary *mesage = [mesajeitems objectAtIndex:ROWSELECTAT-1];
                             NSMutableArray *toatemesajele =[[NSMutableArray alloc]init];
                             if(intrebaridelaaltii[@"discussions"]) {
                                 toatemesajele =intrebaridelaaltii[@"discussions"];
                                 for(int i=0;i< toatemesajele.count;i++) {
                                     NSArray *deprelucrat = [toatemesajele objectAtIndex:i];
                                     if([deprelucrat containsObject:mesage]) {
                                         NSLog(@"am gasit array mare %@", deprelucrat);
                                         
                                         NSDictionary *lastid= [deprelucrat lastObject];
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
                                         
                                         
                                         //fa push la ecran detalii mesaje
                                         EcranMesajeViewController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"EcranMesajeViewControllerVC"];
                                         vc.CE_TIP_E=@"dincerere"; //dincerere sau dinnotificari
                                         [CERERE setObject:deprelucrat forKey:@"discussions"];
                                         vc.CORPDATE =CERERE;
                                         [self.navigationController pushViewController:vc animated:YES];
                                         break;
                                     }
                                 }
                             }
                         }
                     }

                 }
                }
                 
                 break;
             case 4: {
                 NSLog(@"anuleaza castigator");
                   if(OFERTACASTIGATOARELACERERE) {
                 RIButtonItem *ok = [RIButtonItem item];
                 ok.label = @"Da";
                 ok.action = ^{
                     NSLog(@"anuleaza castigator %@",OFERTACASTIGATOARELACERERE );
                     NSString *ofertacastigatoareid = [NSString stringWithFormat:@"%@", OFERTACASTIGATOARELACERERE[@"messageid"]];
                     NSString *authtoken=@"";
                     BOOL elogat = NO;
                     utilitar = [[Utile alloc]init];
                     elogat = [utilitar eLogat];
                     if(elogat) {
                         authtoken = [utilitar AUTHTOKEN];
                         [self oferta_cancel:ofertacastigatoareid :authtoken];
                     }
                 };
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
                 break;
             case 5: {
                 if(ARECALIFICATIV ==NO) {
                 NSLog(@"calificativ");
                 EcranAcorda *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"EcranAcordaVC"];
                 vc.CE_TIP_E=@"dincerere";
                 vc.CALIFICATIV =[[NSMutableDictionary alloc]init];
                 vc.CALIFICATIV=OFERTACASTIGATOARELACERERE;
                 [self.navigationController pushViewController:vc animated:YES ];
                 }
             }
                 break;
                 case 3: {
                 [self gotodetaliuProfil:DICTIONARWINNER];
                 }
             default:
                 break;

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
    //  manager.requestSerializer = [AFJSONRequestSerializer serializer];get_co
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    return manager;
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
                    eroare=    [erori componentsJoinedByString:@" "];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                        message:eroare
                                                                       delegate:nil
                                                              cancelButtonTitle:@"Ok"
                                                              otherButtonTitles:nil];
                    [alertView show];
                }   else  if(  REZULTAT_NOTIFY_COUNT[@"data"]) {
                    NSMutableDictionary *multedate = REZULTAT_NOTIFY_COUNT[@"data"];
                    
                    if(multedate) {
                        NSLog(@"date offer_id cancel %@",multedate);
                     ///////// se face remove la randuri pentru ca nu mai exista winner
                    
                        NSString *descrierecoments =@"Întrebări de la ofertanți:";
                        NSMutableDictionary *questuri = [[NSMutableDictionary alloc]init];
                        [questuri setObject:descrierecoments forKey:@"nume"];
                        [questuri setObject:self.mesajele forKey:@"SubItems"];
                         MESAJEREX=  [[NSMutableArray alloc]init];
                        [MESAJEREX addObject:questuri];
                     //   self.titluri =@[@"Cerere anulată",@"Planse bord etc",MESAJEREX];
                         self.titluri =[NSMutableArray arrayWithArray:@[@"Cerere anulată",@"Planse bord etc",MESAJEREX,@""]];
                        AREWINNER=NO;
//                        ANULEAZAVIEW.hidden=YES;
//                        AFOSTANULATAVIEW.hidden=NO;
                     //   E_ANULATA = YES;
                        [self.LISTASELECT reloadData];
                        if(multedate[@"relist_type"]) {
                            NSString *relist_type = [NSString stringWithFormat:@"%@",DETALIICERERE[@"cerere"][@"relist_type"]];
                            [self pentrubarajos:relist_type];
                        } else {
                            [self pentrubarajos: @"nuarerelisttype"];
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
            
        }];
        [[NSOperationQueue mainQueue] addOperation:op];
    }
    
    
}

// METODA_CERERE_CANCEL
-(void) cerere_cancel :(NSString*)CEREREID :(NSString*)authtoken {
    NSLog(@"cererid %@", CEREREID);
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
        NSString *cerereid= [NSString stringWithFormat:@"%@",CEREREID];
       [dic2 setObject:cerereid forKey:@"cerere_id"];
      
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic2 options:0 error:&err];
        NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        compus =[NSString stringWithFormat:@"%@%@",METODA_CERERE_CANCEL, myString];
        
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
                      if(multedate) {
                          [self removehud];
                      NSLog(@"date cerere cancel %@",multedate);
                        for (int i=0;i< self.barajos.items.count;i++) {
                          UITabBarItem *ITEM = self.barajos.items[i];
                            [ITEM setEnabled:FALSE];
                        }
                            ////jjjjj ecran cerere anulata
                            ANULEAZAVIEW.hidden=YES;
                            AFOSTANULATAVIEW.hidden=NO;
                            E_ANULATA =YES;//jjj butoane jos pe tab bar dispare anuleaza ramane ....
                            AREWINNER=NO;
                            [self.LISTASELECT reloadData];
                            
                            if(multedate[@"relist_type"]) {
                                NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithDictionary: DETALIICERERE[@"cerere"]];
                                dict[@"relist_type"] = multedate[@"relist_type"];
                                DETALIICERERE[@"cerere"] = [dict copy];
                                NSString *relist_type = [NSString stringWithFormat:@"%@",DETALIICERERE[@"cerere"][@"relist_type"]];
                                [self pentrubarajos:relist_type];
                            } else {
                                 [self pentrubarajos: @"nuarerelisttype"];
                            }
    
                      
                    }
              }
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self removehud];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)anuleazacerere:(id)sender {
    NSString *authtoken=@"";
    BOOL elogat = NO;
    elogat = [utilitar eLogat];
    if(elogat) {
        authtoken = [utilitar AUTHTOKEN];
        if( CERERE[@"IDCERERE"]) {
            NSString *cerereid= [NSString stringWithFormat:@"%@",CERERE[@"IDCERERE"]];
            [self cerere_cancel:cerereid :authtoken];
        }
    }
}
-(IBAction)inchideanuleaza:(id)sender {
       [self.navigationController setNavigationBarHidden:NO]; self.navigationItem.leftBarButtonItem=nil;
    ANULEAZAVIEW.hidden=YES;
}
-(IBAction)BTN_OK_action:(id)sender {
       [self.navigationController setNavigationBarHidden:NO]; self.navigationItem.leftBarButtonItem=nil;
    ANULEAZAVIEW.hidden=YES;
    AFOSTANULATAVIEW.hidden=YES;
    //
    [self reloadTableISANULATA];
}
-(void) reloadTableISANULATA{
    //NSLog(@"KK JJ");
    [self.LISTASELECT reloadData];
}
-(IBAction)BTN_REPOSTEAZA_action:(id)sender {
       [self.navigationController setNavigationBarHidden:NO]; self.navigationItem.leftBarButtonItem=nil;
    ANULEAZAVIEW.hidden=YES;
    AFOSTANULATAVIEW.hidden=YES;
   // cerere_reopen :(NSString*)CEREREID :(NSString*)authtoken]
    NSString *authtoken=@"";
    BOOL elogat = NO;
    elogat = [utilitar eLogat];
    if(elogat) {
        authtoken = [utilitar AUTHTOKEN];
        if( CERERE[@"IDCERERE"]) {
            NSString *cerereid= [NSString stringWithFormat:@"%@",CERERE[@"IDCERERE"]];
          [self cerere_reopen:cerereid :authtoken];
   
        }
    }
    
    
//    NSLog(@"la modifica si reposteaza");
//    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    NSLog(@"mergi la cerere completata %@", del.cererepiesa);
//    CerereNouaViewController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"CerereNouaViewVC"];
//    del.reposteazacerere =YES;
//    if( pozele.count ) {
//        //   if(CERERE[@"images"]) {
//        del.ARRAYASSETURIEXTERNE = [[NSMutableArray alloc]init];
//        del.ARRAYASSETURIEXTERNE = pozele;
//        NSLog(@"del.pozecer %@", del.ARRAYASSETURIEXTERNE);
//        del.POZECERERE = del.ARRAYASSETURIEXTERNE;
//    }
//      [self.navigationController pushViewController:vc animated:YES ];

    //il duce la reposteaza
}



- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    utilitar = [[Utile alloc]init];
    switch (item.tag) {
        case 0:
        {
            NSLog(@"la 0"); // Adauga cerere noua
            //getCars
            BOOL elogat = NO;
            elogat = [utilitar eLogat];
            if(elogat) {
                    ANULEAZAVIEW.hidden = NO;
                [self.navigationController setNavigationBarHidden:YES];
                ANULEAZAVIEW.frame=[self.view frame];
            }
        }            break;
        case 1: //cererile mele
        {
            
            NSString *REMAKEID = [NSString stringWithFormat:@"%@",CERERE[@"REMAKE_ID"]];
              NSLog(@"la 1 %li",(long)REMAKEID.integerValue);
            if(REMAKEID.integerValue !=0) {
                 NSLog(@"nu poate fi retrimisa");
            }
            else {
            
            NSLog(@"la 1 reposteaza");
            AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            NSLog(@"mergi la cerere completata %@", del.cererepiesa);
            CerereNouaViewController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"CerereNouaViewVC"];
            del.reposteazacerere =YES;
                if(  pozele.count ) {
             //   if(CERERE[@"images"]) {
                del.ARRAYASSETURIEXTERNE = [[NSMutableArray alloc]init];
                del.ARRAYASSETURIEXTERNE = pozele;
                NSLog(@"del.pozecer %@", del.ARRAYASSETURIEXTERNE);
                del.POZECERERE = del.ARRAYASSETURIEXTERNE;
            }
           
           [self.navigationController pushViewController:vc animated:YES ];
           }
            

            break;
        }
               default:
            break;
    }
}

-(void)pentrubarajos :(NSString*) relist_type{
     self.barajos.delegate = self;
     NSArray *imagini = [[NSArray alloc]init];
     NSArray *titluribtn = [[NSArray alloc]init];
    titluribtn=@[@"Anulează cererea",@"Repostează cererea"];
    imagini=@[@"Icon_Anulare_Blue_144x144.png",@"Icon_Reposteaza_144x144.png"];
  
    if([relist_type isEqualToString:@"readd"]){
        BTN_REPOSTEAZA.titleLabel.text =@"Modifică și repostează";
        titluribtn=@[@"Anulează cererea",@"Modifică și repostează"];
        UITabBarItem *ITEM1 = self.barajos.items[1];
        [ITEM1 setEnabled:TRUE];
        BTN_REPOSTEAZA.enabled = TRUE;
        
    } else  if([relist_type isEqualToString:@"reopen"]){
        BTN_REPOSTEAZA.titleLabel.text =@"Relistează cererea";
         titluribtn=@[@"Anulează cererea",@"Relistează cererea"];
        UITabBarItem *ITEM1 = self.barajos.items[1];
        [ITEM1 setEnabled:TRUE];
    } else  if([relist_type isEqualToString:@""]){
           UITabBarItem *ITEM = self.barajos.items[0];
        if(E_ANULATA ==NO) {
        [ITEM setEnabled:TRUE];
        } else {
        [ITEM setEnabled:FALSE];
        }
        UITabBarItem *ITEM1 = self.barajos.items[1];
        [ITEM1 setEnabled:FALSE];
        BTN_REPOSTEAZA.titleLabel.text =@"";
        BTN_REPOSTEAZA.enabled=FALSE;
        BTN_REPOSTEAZA.selected =NO;
        BTN_REPOSTEAZA.hidden=YES;
        BTN_REPOSTEAZA.userInteractionEnabled=FALSE;
    } else if([relist_type isEqualToString:@"nuarerelisttype"]) {
            UITabBarItem *ITEM = self.barajos.items[0];
            [ITEM setEnabled:  TRUE];
            UITabBarItem *ITEM1 = self.barajos.items[1];
            [ITEM1 setEnabled:TRUE];
        }
    if(E_ANULATA ==YES || AREWINNER ==YES) {
        UITabBarItem *ITEM = self.barajos.items[0];
        [ITEM setEnabled:FALSE];
    } else { titluribtn=@[@"Anulează cererea",@"Repostează cererea"];
        UITabBarItem *ITEM = self.barajos.items[0];
        [ITEM setEnabled:TRUE];
    }

    
    ///////////setari finale bara jos
    
    for (int i=0;i< self.barajos.items.count;i++) {
        
        UITabBarItem *ITEM = self.barajos.items[i];
        
            NSShadow *shadow = [[NSShadow alloc] init];
            shadow.shadowColor =  [UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1];
            shadow.shadowOffset = CGSizeMake(0, 0);
       
        
        
        [ITEM setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                      [UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1],NSForegroundColorAttributeName,
                                      shadow,NSShadowAttributeName,
                                      [NSValue valueWithUIOffset:UIOffsetMake(0,0)], NSShadowAttributeName,
                                      [UIFont fontWithName:@"Helvetica" size:16.0], NSFontAttributeName, nil]
                            forState:UIControlStateNormal];
        [ITEM setTitle:titluribtn[i]];
        NSString *numeimagine = [NSString stringWithFormat:@"%@", imagini[i]];
        UIImage *imagine =[UIImage imageNamed:numeimagine];
        [ITEM setImageInsets: UIEdgeInsetsMake(0, 0, 0, 0)];
        ITEM.image = [[UIImage imageNamed:numeimagine] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        ITEM.image = [self imageWithImage:imagine scaledToSize:CGSizeMake(24, 24)]; //APPLE ZICE 30
        ITEM.selectedImage =[self imageWithImage:imagine scaledToSize:CGSizeMake(24, 24)];
        //     [ITEM setBadgeValue:@"2O"];
        
    }
   
        
    
}
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(IBAction)mergila2:(id)sender {
    NSLog(@"ecran2");
}
-(BOOL)MyStringisEmpty:(NSString *)str
{
    if(str.length==0 || [str isKindOfClass:[NSNull class]] || [str isEqualToString:@""]||[str  isEqualToString:@"NULL"]||[str isEqualToString:@"(null)"]|| [str isEqualToString:@"<null>"] || [str isEqualToString:@"null"] ||str==nil || str == (id)[NSNull null] || [str isEqualToString:@""]){
        return YES;
    }
    return NO;
}
//METODA_CERERE_REOPEN @"m=cerere_reopen&p=" // in cazul unei cereri rezolvate cu id cerere
/*
 m=get_profile&p={"authtoken":"1248f7g574d6d46gEmLEtDsvZtctCMm4PohGL9HMJiS_JQOKQQ3trGPPt9k","os":"iOS","lang":"ro","version":"9.2.1"}
 echo 'm=cerere_reopen&p={"cerere_id":"342788","authtoken":"1248f7g574d6d46gEmLEtDsvZtctCMm4PohGL9HMJiS_JQOKQQ3trGPPt9k","os":"iOS","lang":"ro","version":"9.2.1"}' | curl --tlsv1 --cacert ./dev5.activesoft.crt --data @- -- https://dev5.activesoft.ro:277/

 echo 'm=cerere_reopen&p={"cerere_id":"342788","authtoken":"1248f7g574d6d46gEmLEtDsvZtctCMm4PohGL9HMJiS_JQOKQQ3trGPPt9k","os":"iOS","lang":"ro","version":"9.2.1"}' | curl --tlsv1 --cacert ./dev5.activesoft.crt --data @- -- https://dev5.activesoft.ro:277/

 
 */
-(void) cerere_reopen :(NSString*)CEREREID :(NSString*)authtoken {
    NSLog(@"cererid %@", CEREREID);
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
        NSString *cerereid= [NSString stringWithFormat:@"%@",CEREREID];
        [dic2 setObject:cerereid forKey:@"cerere_id"];
        
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic2 options:0 error:&err];
        NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        compus =[NSString stringWithFormat:@"%@%@",METODA_CERERE_REOPEN, myString];
        
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
                    NSMutableDictionary *multedate = REZULTAT_NOTIFY_COUNT[@"data"];
                    if(multedate) {
                        NSLog(@"date cerere reopen %@",multedate);
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
-(void) list_offers_per_cerere :(NSString *)AUTHTOKEN :(NSString *)PAGE :(NSString *)PER_PAGE :(NSString *)cerere_id :(NSString *)prefered_only :(NSString*)cerere_details :(NSString*) castigatoare{
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
        [dic2 setObject:@"iOS" forKey:@"os"];
        [dic2 setObject:currentSysVer forKey:@"version"]; //  vers iOS
        [dic2 setObject:@"ro" forKey:@"lang"];
        [dic2 setObject:AUTHTOKEN forKey:@"authtoken"];
        NSString *ecasgigatoaresaunu= castigatoare;
        if([ecasgigatoaresaunu isEqualToString:@"nu"]) {
            [dic2 setObject:PAGE forKey:@"page"];
            [dic2 setObject:PER_PAGE forKey:@"per_page"];
        }
        
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
                    [self removehud];
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
                    
                    if([ecasgigatoaresaunu isEqualToString:@"nu"]) {
                        //{"errors":{},"data":{"items":[{"id":342551,"title":"Test","nr_offers":0,"nr_unread_offers":0},{"id":342550,"title":"Test","nr_offers":0,"nr_unread_offers":0},{"id":342549,"title":"Test","nr_offers":0,"nr_unread_offers":0}],"total_count":3}}
                        NSDictionary *multedate = REZULTAT_NOTIFY_COUNT[@"data"];
                        NSLog(@"date cerere raspuns %@",multedate);
                        [self removehud];
                        [self mergi_la_oferte:multedate];
                    }
               }
                
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
            //                                                            message:[error localizedDescription]
            //                                                           delegate:nil
            //                                                  cancelButtonTitle:@"Ok"
            //                                                  otherButtonTitles:nil];
            //        [alertView show];
            [self removehud];
            
        }];
        [[NSOperationQueue mainQueue] addOperation:op];
    }
}
-(void) mergi_la_oferte :(NSDictionary*) corpraspuns {
    NSLog(@"spiders %@",corpraspuns);
    [self removehud];
    NSMutableDictionary *DETALIICEREREx = [NSMutableDictionary dictionaryWithDictionary:corpraspuns];
    [DETALIICEREREx setObject:@"1" forKey:@"pagina_curenta_trimisa"];
    [DETALIICEREREx setObject:@"0" forKey:@"pagina_curenta_preferate"];
    OferteLaCerereViewController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"OferteLaCerereVC"];
    vc.E_DIN_DETALIU_CERERE =YES;
    vc.CORPDATE = DETALIICEREREx;
    [self.navigationController pushViewController:vc animated:NO];
}
-(void) RELOAD_list_offers_per_cerere :(NSString *)AUTHTOKEN :(NSString *)PAGE :(NSString *)PER_PAGE :(NSString *)cerere_id :(NSString *)prefered_only :(NSString*)cerere_details :(NSString*) castigatoare{
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
        [dic2 setObject:@"iOS" forKey:@"os"];
        [dic2 setObject:currentSysVer forKey:@"version"];   //  vers iOS
        [dic2 setObject:@"ro" forKey:@"lang"];
        [dic2 setObject:AUTHTOKEN forKey:@"authtoken"];
        NSString *ecasgigatoaresaunu= castigatoare;
        if([ecasgigatoaresaunu isEqualToString:@"nu"]) {
            [dic2 setObject:PAGE forKey:@"page"];
            [dic2 setObject:PER_PAGE forKey:@"per_page"];
        } else {
            [dic2 setObject:@"1" forKey:@"page"];
            [dic2 setObject:@"1" forKey:@"per_page"];
        }
        
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
                    [self removehud];
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
                    //  [self removehud];
//                    if([ecasgigatoaresaunu isEqualToString:@"nu"]) {
//                        //{"errors":{},"data":{"items":[{"id":342551,"title":"Test","nr_offers":0,"nr_unread_offers":0},{"id":342550,"title":"Test","nr_offers":0,"nr_unread_offers":0},{"id":342549,"title":"Test","nr_offers":0,"nr_unread_offers":0}],"total_count":3}}
//                        NSDictionary *multedate = REZULTAT_NOTIFY_COUNT[@"data"];
//                        NSLog(@"date cerere raspuns %@",multedate);
//                        [self removehud];
//                        [self mergi_la_oferte:multedate];
//                    }
//                    if([ecasgigatoaresaunu isEqualToString:@"da"]) {
                        //{"errors":{},"data":{"items":[{"id":342551,"title":"Test","nr_offers":0,"nr_unread_offers":0},{"id":342550,"title":"Test","nr_offers":0,"nr_unread_offers":0},{"id":342549,"title":"Test","nr_offers":0,"nr_unread_offers":0}],"total_count":3}}
                        
                        NSMutableDictionary *multedate = REZULTAT_NOTIFY_COUNT[@"data"];
                        NSLog(@"date speciale cerere raspuns %@",multedate);
                        NSLog(@"vezi cerere");
                        CerereExistentaViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CerereExistentaViewVC"];
                        vc.intrebaridelaaltii = [[NSMutableDictionary alloc]init];
                        vc.intrebaridelaaltii = [NSMutableDictionary dictionaryWithDictionary:multedate[@"cerere"]];
                        vc.CE_TIP_E=@"dinwinner";
                        
                        
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
                        //  NSString *IDCERERE =@"";
                        NSString *LOCALITATEID =@"";
                        NSString *JUDETID =@"";
                        NSString *IS_NEW =@"";
                        NSString *IS_SECOND =@"";
                        NSString *REMAKE_ID =@"0"; //este  id-ul cererii noi, relistate.     In cazul in care o cerere are remake_id > 0, nu mai poate fi relistat.
                        NSMutableDictionary *CORP = [[NSMutableDictionary alloc]init];
                        if(multedate[@"cerere"]) {
                            CORP = multedate[@"cerere"];
                            if(CORP[@"title"])    TITLUCERERE = [NSString stringWithFormat:@"%@",CORP[@"title"]];
                            if(CORP[@"marca_id"]) PRODUCATORAUTODEF = [NSString stringWithFormat:@"%@",CORP[@"marca_id"]];
                            if(CORP[@"model_id"]) MARCAAUTODEF = [NSString stringWithFormat:@"%@",CORP[@"model_id"]];
                            if(CORP[@"talon_an_fabricatie"]) ANMASINA = [NSString stringWithFormat:@"%@",CORP[@"talon_an_fabricatie"]];
                            if(CORP[@"motorizare"]) MOTORIZARE = [NSString stringWithFormat:@"%@",CORP[@"motorizare"]];
                            if(CORP[@"talon_tip_varianta"]) VARIANTA=[NSString stringWithFormat:@"%@",CORP[@"talon_tip_varianta"]];
                            if(CORP[@"talon_nr_identificare"]) SERIESASIU = [NSString stringWithFormat:@"%@",CORP[@"talon_nr_identificare"]];
                            if(CORP[@"localitate_id"]) LOCALITATEID =[NSString stringWithFormat:@"%@", CORP[@"localitate_id"]];
                            if(CORP[@"judet_id"]) JUDETID =[NSString stringWithFormat:@"%@", CORP[@"judet_id"]];
                            if(CORP[@"want_new"]) IS_NEW =[NSString stringWithFormat:@"%@", CORP[@"want_new"]];
                            if(CORP[@"want_second"]) IS_SECOND =[NSString stringWithFormat:@"%@", CORP[@"want_second"]];
                            if(CORP[@"remake_id"]) REMAKE_ID =[NSString stringWithFormat:@"%@", CORP[@"remake_id"]];
                            
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
                            [cererepiesa setObject:cerere_id forKey:@"IDCERERE"];
                            [cererepiesa setObject:multedate forKey:@"CEREREFULLINFO"]; //avem nevoie si de corpul cererii
                            del.reposteazacerere =NO;
                            if(CORP[@"images"]) {
                                del.ARRAYASSETURI = [[NSMutableArray alloc]init];
                                del.ARRAYASSETURI = [NSMutableArray arrayWithArray:CORP[@"images"]];
                                NSLog(@"del.pozecer %@", del.ARRAYASSETURI);
                                del.POZECERERE = del.ARRAYASSETURI;
                            }
                            del.cererepiesa =cererepiesa;
                            CERERE =cererepiesa;
                            [self madeinit];
                        //    [self.navigationController pushViewController:vc animated:YES ];
                          }
                    }
                }
           // }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
            //                                                            message:[error localizedDescription]
            //                                                           delegate:nil
            //                                                  cancelButtonTitle:@"Ok"
            //                                                  otherButtonTitles:nil];
            //        [alertView show];
            [self removehud];
            
        }];
        [[NSOperationQueue mainQueue] addOperation:op];
    }
}
@end
/*
 //     cell.TitluRand.hidden=YES;
 //     cell.DateMasina.hidden=YES;
 //     cell.Tipnoisausecond.hidden=YES;
 //     cell.ZonaLivrare.hidden=YES;
 //     cell.PozaCerere.hidden=YES;
 
 
 //    cell.IconRand.hidden=YES;
 //    cell.Altrandalbastru.hidden=YES;
 //    cell.sageataBlue.hidden=YES;
 
 //    cell.RandGri.hidden=YES;
 //    cell.sageataGri.hidden=YES;
 //    cell.PozaOferta.hidden=YES;
 //    cell.TitluOferta.hidden=YES;
 //    cell.TipOferta.hidden=YES;
 //    cell.PretOferta.hidden=YES;
 //    cell.HeadOferta.hidden=YES;
 //    cell.TitluMesaj.hidden=YES;cell.NumePersoanaMesaj.hidden=YES;cell.roundalbastru.hidden=YES;cell.pozauser.hidden=YES;cell.sageataGri2.hidden=YES;
 
 
 //           {
 //               date = 1462458483;
 //               "date_formatted" = "05 mai 2016, 17:28";
 //               images =                     (
 //               );
 //               "is_myself" = 0;
 //               "is_viewed" = 0;
 //               message = "test intrebare la cerere";
 //               messageid = 1826762;
 //               username = "k*******y";
 //           }
 //
 //           @property(nonatomic, strong) IBOutlet UIView *discutieuser; //icons
 //           @property(nonatomic, strong) IBOutlet UILabel *TitluMesaj; //
 //           @property(nonatomic, strong) IBOutlet UILabel *NumePersoanaMesaj; // de la cine e mesajul
 //           @property(nonatomic, strong) IBOutlet UIImageView *roundalbastru; //icon blue
 //           @property(nonatomic, strong) IBOutlet UIImageView *pozauser; //icon user
 //           @property(nonatomic, strong) IBOutlet UIImageView *sageataGri2; //
 //           @property(nonatomic, strong) IBOutlet UIButton *expandcollapsecell;
 
 
 "comments_count" = 1;
 "comments_unread_count" = 1;
 "date_added" = 1460120729;
 "date_start" = 1460120729;
 description = "";
 discussions =         (
 (
 {
 date = 1462458483;
 "date_formatted" = "05 mai 2016, 17:28";
 images =                     (
 );
 "is_myself" = 0;
 "is_viewed" = 0;
 message = "test intrebare la cerere";
 messageid = 1826762;
 username = "k*******y";
 }
 )
 );
 //    cell.PozaCerere.hidden=NO;
 //    cell.TitluRand.hidden=NO;
 //    cell.DateMasina.hidden=NO;
 //    cell.Tipnoisausecond.hidden=NO;
 //    cell.ZonaLivrare.hidden=NO;
 */



