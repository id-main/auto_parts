//
//  EcranComandaTrimisaViewController.m
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
#import "EcranComandaTrimisaViewController.h"
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

@interface EcranComandaTrimisaViewController(){
 
}
@end

@implementation EcranComandaTrimisaViewController
@synthesize felicitari; //  titluriCAMPURI
@synthesize suporttehnic; //
@synthesize telefonafisat;
@synthesize orar;
@synthesize barajos;
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

 -(void) perfecttimeforback{
     NSMutableArray *allViewControllers = [NSMutableArray arrayWithArray:[self.navigationController viewControllers]];
     for (UIViewController *aViewController in allViewControllers) {
         if ([aViewController isKindOfClass:[TutorialHomeViewController class]]) {
             [self.navigationController popToViewController:aViewController animated:NO];
         }
     }
 }
-(void)viewWillAppear:(BOOL)animated {
        NSLog(@"COMANDA TRIMISA");
           [self.navigationController setNavigationBarHidden:NO]; self.navigationItem.leftBarButtonItem=nil;
        self.title = @"Comandă trimisă";
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
    [self barajosmadeit];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    NSString *primulrand = @"\n\nFelicitări, comanda ta \na fost trimisă.";
    NSString *aldoilearand = @"\n\n\nVei fi contactat în scurt timp\nde către vânzător";
    NSString *textulMeu = [NSString stringWithFormat:@"%@ %@",primulrand,aldoilearand];
    
    NSRange bigRange = [textulMeu rangeOfString:primulrand];
    NSRange mediumRange = [textulMeu rangeOfString:aldoilearand];
    
    NSMutableAttributedString * attributedString= [[NSMutableAttributedString alloc] initWithString:textulMeu];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize: 21] range:bigRange];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19] range:mediumRange];
    
    self.felicitari.textAlignment = NSTextAlignmentCenter;
    self.felicitari.attributedText=attributedString;
    
//    NSString *textsuporttehnic=@"Pentru suport tehnic aplicație și\nasistență clienți:";
//    self.suporttehnic.textAlignment = NSTextAlignmentCenter;
//    self.suporttehnic.text =textsuporttehnic;
//    
//    NSString *texttelefonafisat =@"0723 456 789";
//    self.telefonafisat.text = texttelefonafisat;
//    NSString *textorar =@"Luni-Vineri: 9-18h";
//    self.orar.text = textorar;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(suna)];
    [telefonafisat addGestureRecognizer:tap];
    telefonafisat.userInteractionEnabled = YES;
    
    
    // Do any additional setup after loading the view, typically from a nib.
}



-(void)suna{
    //il ducem la ecran setari
    NSLog(@"suna acum");
    
    
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
   
}

-(void)viewWillLayoutSubviews{
  
}
-(void)viewDidAppear:(BOOL)animated {
    [self.barajos setNeedsLayout];
    [self.barajos layoutIfNeeded];
    
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


