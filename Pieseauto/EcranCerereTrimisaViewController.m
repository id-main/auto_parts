//
//  ListaMasiniUserViewController.m
//  Pieseauto
//
//  Created by Ioan Ungureanu on 25/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//
#import "utile.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"
#import "EcranCerereTrimisaViewController.h"
#import "CellMasinileMeleRow.h"
#import "TutorialHomeViewController.h"
#import <CoreText/CoreText.h>
#import "choseLoginview.h"
#import "ContulMeuViewController.h"
#import "DataMasterProcessor.h"
#import "ListaMasiniUserViewController.h"
#import "CerereNouaViewController.h"
#import "WebViewController.h"
#import "chooseview.h"
#import "CererileMeleViewController.h"
#import "butoncustomback.h"

@interface EcranCerereTrimisaViewController(){
 
}
@end

@implementation EcranCerereTrimisaViewController
@synthesize  titlurilables; //  titluriCAMPURI
@synthesize catemagazine; //
@synthesize setarinotificarioferte;
@synthesize pretpiesesimilare;
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
-(IBAction)cereofertaacumAction:(id)sender {
    CerereNouaViewController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"CerereNouaViewVC"];
    //  [self presentViewController:vc animated:YES completion:nil];
    [self.navigationController pushViewController:vc animated:NO];
    NSLog(@"ecran home select");
    NSLog(@"gata screen");
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    utilitar = [[Utile alloc]init];
    switch (item.tag) {
        case 0:
        {
            NSLog(@"la 0"); // Adauga cerere noua
            //getCars
            NSString *authtoken=@"";
            BOOL elogat = NO;
            elogat = [utilitar eLogat];
            if(elogat) {
                authtoken = [utilitar AUTHTOKEN];
                NSMutableArray *cars = [[NSMutableArray alloc]init];
                NSDictionary *userulmeu= [DataMasterProcessor getLOGEDACCOUNT];
                NSString *userid = [NSString stringWithFormat:@"%@", userulmeu[@"U_userid"]];
                cars = [DataMasterProcessor getCars:userid];
                if(cars.count >0) {
                    //du-l la tabel cu masini adaugate anterior
                    ListaMasiniUserViewController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"ListaMasiniUserVC"];
                    vc.titluriCAMPURI =cars;
                    //   vc.titluriCAMPURI =@[@"a", @"b",@"c",@"d"];
                    [self.navigationController pushViewController:vc animated:NO];
                } else {
                    //adauga cerere noua
                    [self cereofertaacumAction:nil];
                }
                
            } else {
                // cerere noua
                [self cereofertaacumAction:nil];
            }
        }
            break;
        case 1: //cererile mele
        {
            NSLog(@"la 1");
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
            break;        }
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

-(void)viewWillAppear:(BOOL)animated {
    NSLog(@"felicitari");
    self.titlurilables = titlurilables;
    NSLog(@"titluri labels %@", titlurilables);
     self.title = @"Cerere trimisă";
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
    [ceva addTarget:self action:@selector(mergiBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *inapoibtn =[[UIBarButtonItem alloc] initWithCustomView:ceva];
    self.navigationItem.leftBarButtonItem = inapoibtn;
    [self barajosmadeit];
    
}

-(void)mergiBack {
 //intotdeauna la ecranul principal pentru ca aici ajunge numai dupa ce a facut cerere completa
    TutorialHomeViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TutorialHomeVC"];
    [self.navigationController pushViewController:vc animated:NO ];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
       [self.navigationController setNavigationBarHidden:NO]; self.navigationItem.leftBarButtonItem=nil;
 
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated {
   
 
    //urlPiesesimilare
    
    if(self.titlurilables[@"url_similar_products"]) {
        self.urlPiesesimilare = [NSString stringWithFormat:@"%@",self.titlurilables[@"url_similar_products"]];
    } else {
        self.urlPiesesimilare =@"";
    }
    NSString *parcuriauto =@"";
    NSString *persoane =@"";
    NSString *magazine =@"";
    if(self.titlurilables[@"newsletter_count"][@"park"]) parcuriauto = [NSString stringWithFormat:@"\u2022 %@ parcuri de dezmembrări",self.titlurilables[@"newsletter_count"][@"park"]];
    if(self.titlurilables[@"newsletter_count"][@"person"]) persoane = [NSString stringWithFormat:@"\u2022 %@ vânzători particulari",self.titlurilables[@"newsletter_count"][@"person"]];
    if(self.titlurilables[@"newsletter_count"][@"shop"]) magazine = [NSString stringWithFormat:@"\u2022 %@ magazine de piese",self.titlurilables[@"newsletter_count"][@"shop"]];
    
    NSString *afosttrimis = @"Cererea ta a fost trimisă la:";
    NSString *stringulmeu = [NSString stringWithFormat:@"\n%@ \n%@ \n%@", magazine,parcuriauto,persoane];
    NSString *tevomnotifica = @"\n\nte vom notifica de îndată ce \nprimești oferte";
    
    NSString *textulMeu = [NSString stringWithFormat:@"%@ %@ %@",afosttrimis,stringulmeu,tevomnotifica];
    
    NSRange bigRange = [textulMeu rangeOfString:afosttrimis];
    NSRange mediumRange = [textulMeu rangeOfString:stringulmeu];
    NSRange smallRange = [textulMeu rangeOfString:tevomnotifica];
    
    NSMutableAttributedString * attributedString= [[NSMutableAttributedString alloc] initWithString:textulMeu];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize: 21] range:bigRange];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19] range:mediumRange];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:smallRange];
    // [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] range:blueRange];
    
    catemagazine.textAlignment = NSTextAlignmentCenter;
    catemagazine.attributedText=attributedString;
 
     UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setarinotificarioferteAction)];
    [setarinotificarioferte addGestureRecognizer:tap];
    setarinotificarioferte.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pretpiesesimilareAction)];
    [pretpiesesimilare addGestureRecognizer:tap2];
    pretpiesesimilare.userInteractionEnabled = YES;
  
        [self.barajos setNeedsLayout];
        [self.barajos layoutIfNeeded];
        
  
}

-(void)setarinotificarioferteAction{
    //il ducem la ecran setari
    NSLog(@"la setari");
    chooseview *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Choose1VC"];
    vc.data =[[NSArray alloc]init];
    vc.data =@[@"Vreau să primesc notificări...",@"În aplicație",@"Pe e-mail",@"În aplicație și pe e-mail",@""];
    vc.CE_TIP_E = @"Preferintenotificari";
    [self.navigationController pushViewController:vc animated:YES ];
    
}
-(void)pretpiesesimilareAction{
    //webview cu url
    if(![self MyStringisEmpty:self.urlPiesesimilare]){
          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.urlPiesesimilare]];
//          NSLog(@"la web %@", self.urlPiesesimilare);
//           //intotdeauna la ecranul principal pentru ca aici ajunge numai dupa ce a facut cerere completa
//            WebViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewVC"];
//            vc.urlPiesesimilare= self.urlPiesesimilare;
//            vc.title = @"Piese similare";
//            [self.navigationController pushViewController:vc animated:NO ];
   }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)barajosmadeit {
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
    [self.barajos setNeedsLayout];
    [self.barajos setNeedsDisplay];
}


-(void)viewWillLayoutSubviews{
   
}
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
-(BOOL)MyStringisEmpty:(NSString *)str
{
    if(str.length==0 || [str isKindOfClass:[NSNull class]] || [str isEqualToString:@""]||[str  isEqualToString:@"NULL"]||[str isEqualToString:@"(null)"]|| [str isEqualToString:@"<null>"] || [str isEqualToString:@"null"] ||str==nil){
        return YES;
    }
    return NO;
}



@end


