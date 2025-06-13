//
//  TutorialHomeViewController.m
//  Pieseauto
//
//  Created by Ioan Ungureanu on 23/02/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//

#import "TutorialHomeViewController.h"
#import <CoreText/CoreText.h>
#import "AppDelegate.h"
#import "choseLoginview.h"
#import "ContulMeuViewController.h"
#import "DataMasterProcessor.h"
#import "ListaMasiniUserViewController.h"
#import "CererileMeleViewController.h"
#import "WebViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "butoncustomback.h"

@interface TutorialHomeViewController ()

@end

@implementation TutorialHomeViewController
@synthesize  splashscreen, aminteles, numaiafisa,ceriofertatext,tutorialafisat,viewgri,barajos,cereofertaacum,bararosietext,aflamaimulte,cursorportocaliu,continutbararosiesicursor;

-(void)viewWillAppear:(BOOL)animated {
    AppDelegate * del = (AppDelegate *)[[UIApplication sharedApplication] delegate]; //del.aafisatTutorial
    /* //////////// e cazul in care da back din cerere noua si a complet ceva date fara sa trimita cererea //////////// */
    del.cererepiesa =[[NSMutableDictionary alloc]init];
    del.POZECERERE =[[NSMutableArray alloc]init];
    del.ARRAYASSETURI=[[NSMutableArray alloc]init];
    /* //////////// */
    [self.navigationController setNavigationBarHidden:YES];
    //NSLog(@"del.aafisatTutorial %i",del.aafisatTutorial);
    if(!  del.aafisatTutorial ) {
        NSUserDefaults* prefs=[NSUserDefaults standardUserDefaults];
        if(![prefs boolForKey:@"numaiafisa"]){
            [prefs setBool:YES forKey:@"numaiafisa"];
            [prefs synchronize];
            viewgri.hidden =NO;
            tutorialafisat.hidden =NO;
           ///// self.view.backgroundColor = [UIColor darkGrayColor];
            [viewgri setBackgroundColor:[[UIColor clearColor] colorWithAlphaComponent:0.5]];
         //   viewgri.frame = self.view.frame;
            [self.view bringSubviewToFront:viewgri];
            del.aafisatTutorial = YES;
        } else {
           //// self.viewgri.backgroundColor = [UIColor whiteColor];
            viewgri.hidden =YES;
            tutorialafisat.hidden =YES;
            del.aafisatTutorial = YES;
            self.view.backgroundColor = [UIColor whiteColor];
        }
    }else {
        self.viewgri.backgroundColor = [UIColor whiteColor];
        viewgri.hidden =    YES;
        tutorialafisat.hidden =YES;
        self.view.backgroundColor = [UIColor whiteColor];
        del.aafisatTutorial = YES;
    }
    aminteles.layer.borderWidth=1.0f;
    aminteles.layer.cornerRadius = 5.0f;
    aminteles.layer.borderColor=[[UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] CGColor];
    cereofertaacum.layer.borderWidth=1.0f;
    cereofertaacum.layer.cornerRadius = 5.0f;
    cereofertaacum.layer.borderColor=[[UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1] CGColor];
    cereofertaacum.backgroundColor=[UIColor colorWithRed:(255/255.0) green:(66/255.0) blue:(0/255.0) alpha:1];
    
    [numaiafisa setImage:[UIImage imageNamed:@"Checkbox_unchecked_blue_72x72.png"] forState:UIControlStateNormal];
    [numaiafisa setImage:[UIImage imageNamed:@"Checkbox_checked_blue_72x72.png"] forState:UIControlStateSelected];
    numaiafisa.selected=YES;
        UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cereofertaacumAction:)];
    [singleTap setNumberOfTapsRequired:1];

    
   //animate a fake cursor
     cursorportocaliu.backgroundColor =[UIColor colorWithRed:255/255.0f green:102/255.0f blue:0/255.0f alpha:1];
    [continutbararosiesicursor setUserInteractionEnabled:YES];
    [continutbararosiesicursor addGestureRecognizer:singleTap];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [animation setFromValue:[NSNumber numberWithFloat:1.0]];
    [animation setToValue:[NSNumber numberWithFloat:0.0]];
    [animation setDuration:0.4f];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionLinear]];
    [animation setAutoreverses:YES];
    [animation setRepeatCount:HUGE_VALF];
    [[cursorportocaliu layer] addAnimation:animation forKey:@"opacity"];
  // force crash with Crashlytics
   /* UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(20, 50, 100, 30);
    [button setTitle:@"Crash" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(crashButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];*/

    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    /* JMOD */
    for(UIButton *view in  self.navigationController.navigationBar.subviews) {
        if([view isKindOfClass:[butoncustomback class]]){
            [view removeFromSuperview];
        }
    }
    
}
-(void)perfecttimeforback {
    [self.navigationController popViewControllerAnimated:NO];
}

//- (IBAction)crashButtonTapped:(id)sender {
//    [[Crashlytics sharedInstance] crash];
//}

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
                //else contul meu
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
-(BOOL)MyStringisEmpty:(NSString *)str
{
    if(str.length==0 || [str isKindOfClass:[NSNull class]] || [str isEqualToString:@""]||[str  isEqualToString:@"NULL"]||[str isEqualToString:@"(null)"]|| [str isEqualToString:@"<null>"] || [str isEqualToString:@"null"] ||str==nil || str == (id)[NSNull null] || [str isEqualToString:@""]){
        return YES;
    }
    return NO;
}
-(IBAction)afiseazamiamulte:(id)sender {
    NSUserDefaults* prefs=[NSUserDefaults standardUserDefaults];
    if([prefs objectForKey:@"url_tutorial"]) {
        NSString *url_tutorial = [NSString stringWithFormat:@"%@",[prefs objectForKey:@"url_tutorial"]];
        if(![self MyStringisEmpty:url_tutorial])
        {
            NSString *usertutorialspecialios = [NSString stringWithFormat:@"%@&os=ios",url_tutorial];
            WebViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewVC"];
            vc.urlPiesesimilare = usertutorialspecialios;
            vc.dinhelp=YES;
            vc.mWebView.scalesPageToFit = NO;
            vc.title=@"Află mai multe";
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
-(void)barajosmadeit {
    utilitar = [[Utile alloc]init];
    NSString *authtoken=@"";
    BOOL elogat = NO;
    elogat = [utilitar eLogat];
    if(elogat) {
         authtoken = [utilitar AUTHTOKEN];
  //      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       [utilitar getnotify_count:authtoken];
 //   });
    }

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
        }        if(i==2) {
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
- (void)viewDidLoad {
    [super viewDidLoad];
       //   self.view.backgroundColor = [UIColor colorWithRed:82.0f green:82.0f blue:82.0f alpha:1];
    
    UITapGestureRecognizer *singleTapafla =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(afiseazamiamulte:)];
    [singleTapafla setNumberOfTapsRequired:1];
    aflamaimulte.userInteractionEnabled=YES;
    [aflamaimulte  addGestureRecognizer:singleTapafla];
    
      ceriofertatext.verticalAlignment =TTTAttributedLabelVerticalAlignmentTop;
    // Do any additional setup after loading the view, typically from a nib.
    
      // splashscreen.userInteractionEnabled =YES;
    // [splashscreen addGestureRecognizer:singleTap];
    // NSString *ICONCAUTAT  =@"check";
    // -(NSString *)CodDictionarIcons :(NSString *) numeicon
    // utilitar=[[Utile alloc] init];
    // NSString *codgasit = [utilitar CodDictionarIcons:ICONCAUTAT];
    // NSLog(@"CodDictionarIcons %@", codgasit);
    

    //    NSString *textbararosietext = self.bararosietext.text;
    //    [bararosietext setText:textbararosietext afterInheritingLabelAttributesAndConfiguringWithBlock:^(NSMutableAttributedString *mutableAttributedString) {
    //        NSRange COLORRange = [[mutableAttributedString string] rangeOfString:@"|" options:NSCaseInsensitiveSearch];
    //        [mutableAttributedString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[UIColor orangeColor].CGColor range:COLORRange];
    //        return mutableAttributedString;
    //    }];
    
//    NSString *stringulmeu = @"Ceri ofertă pentru piesă\n\n2. Vei primi oferte de preț (piese noi și din dezmembrări)3. Tu alegi oferta\ncâștigătoare";
//    
//    
//    [ceriofertatext setText:stringulmeu afterInheritingLabelAttributesAndConfiguringWithBlock:^(NSMutableAttributedString *mutableAttributedString) {
//        //font helvetica with bold and italic
//        UIFont *boldSystemFont = [UIFont fontWithName:@"Helvetica-Bold" size:18];
//        CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);
//        NSRange boldRange = [[mutableAttributedString string] rangeOfString:@"1." options:NSCaseInsensitiveSearch];
//        [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:boldRange];
//        NSRange boldRange2 = [[mutableAttributedString string] rangeOfString:@"2." options:NSCaseInsensitiveSearch];
//        [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:boldRange2];
//        NSRange boldRange3 = [[mutableAttributedString string] rangeOfString:@"3." options:NSCaseInsensitiveSearch];
//        [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:boldRange3];
//        // not safe ///   CFRelease(font);
//        return mutableAttributedString;
//    }];
//    self.navigationItem.backBarButtonItem =
//    [[UIBarButtonItem alloc] initWithTitle:@"Înapoi"
//                                     style:UIBarButtonItemStylePlain
//                                    target:nil
//                                    action:nil];
//
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//// ACTIUNI BUTOANE
//// ******** nu mai afisa
-(IBAction)amintelesAction:(id)sender {
    tutorialafisat.hidden =YES;
    /*  aminteles.userInteractionEnabled =NO;
     numaiafisa.userInteractionEnabled=NO;*/
    AppDelegate * del = (AppDelegate *)[[UIApplication sharedApplication] delegate]; //del.aafisatTutorial
    del.aafisatTutorial =YES;
    viewgri.hidden =YES;
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"  self.view.backgroundColor %@",  self.view.backgroundColor );
    [self.view setNeedsDisplay];
}
//cere oferta
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


-(void)viewWillLayoutSubviews{
    [self barajosmadeit];
    
}
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
-(IBAction)numaiafisaAction:(id)sender {
    UIButton* button = (UIButton*)sender;
    button.selected = !button.selected;
    NSLog(@"bifa");
    NSLog(@"ecran3");
    if( button.selected) {
        [[NSUserDefaults standardUserDefaults] setBool:YES  forKey:@"numaiafisa"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        NSUserDefaults* prefs=[NSUserDefaults standardUserDefaults];
        [prefs setBool:NO forKey:@"numaiafisa"];
        [prefs synchronize];
    }
}


@end
