//
//  chooseview.m
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
#import "choose4view.h"
#import "CellChoose4.h"
#import "TutorialHomeViewController.h"
#import <CoreText/CoreText.h>
#import <QuartzCore/QuartzCore.h>
#import "Reachability.h"
#import "butoncustomback.h"

@interface choose4view(){
    NSMutableArray* Cells_Array;
}
@end

@implementation choose4view
@synthesize  Continua,LISTASELECT,titluriCAMPURI,sageatablue,CE_TIP_E,dynamictableheightJ;
float _initialTVHeightx =0;
float _MYkeyboardheightx =0;
double cellheightmodificat=45;
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
    if([CE_TIP_E isEqualToString:@"anfabricatie"]) {
         titlubuton.text=@"An fabricație";
      }
    if([CE_TIP_E isEqualToString:@"amuitatparola"]) {
     titlubuton.text=@"Înapoi";
    }
    //prenumenume
    if([CE_TIP_E isEqualToString:@"prenumenume"]) {
         titlubuton.text=@"Înapoi";
          }
    if([CE_TIP_E isEqualToString:@"email"]) {
         titlubuton.text=@"Înapoi";
          }
    if([CE_TIP_E isEqualToString:@"telefon"]) {
         titlubuton.text=@"Înapoi";
       
    }
    
    if([self.CE_TIP_E isEqualToString:@"modificareparola"]) {
         titlubuton.text=@"Înapoi";
          }
    
    if([self.CE_TIP_E isEqualToString:@"codpostal"]) {
         titlubuton.text=@"Înapoi";
           }
    
    if([self.CE_TIP_E isEqualToString:@"adresa"]) {
         titlubuton.text=@"Înapoi";
       
    }
    [backcustombutton addSubview:titlubuton];
    [backcustombutton setShowsTouchWhenHighlighted:NO];
    [backcustombutton bringSubviewToFront:btnimg];
    return backcustombutton;
}


- (void)keyboardWillShow:(NSNotification *)notification
{
    _initialTVHeightx = self.LISTASELECT.frame.size.height;
    CGRect initialFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect convertedFrame = [self.view convertRect:initialFrame fromView:nil];
    CGRect tvFrame = self.LISTASELECT.frame;
    tvFrame.size.height = convertedFrame.origin.y;
      _MYkeyboardheightx = convertedFrame.origin.y;
    [self.LISTASELECT setFrame:tvFrame];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.LISTASELECT setNeedsDisplay];
    });
    
    
}
- (void)keyboardWillHide:(NSNotification *)notification
{
   
    CGRect tvFrame = self.LISTASELECT.frame;
    tvFrame.size.height = _initialTVHeightx;
    [UIView beginAnimations:@"TableViewDown" context:NULL];
    [UIView setAnimationDuration:0.3f];
    self.LISTASELECT.frame = tvFrame;
    _MYkeyboardheightx =0;
    [UIView commitAnimations];
      dispatch_async(dispatch_get_main_queue(), ^{
            [self.LISTASELECT setNeedsDisplay];
    });
    
    
}
-(NSArray *)checkCAMPURI {
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary* CERERE =[[NSMutableDictionary alloc]init];
    CERERE = [del.cererepiesa mutableCopy];
    NSString *VARIANTA =@"";
    NSString *MOTORIZARE =@"";
    NSString *SERIESASIU=@"";
   if(CERERE[@"VARIANTA"])    VARIANTA = [NSString stringWithFormat:@"%@",CERERE[@"VARIANTA"]];
   if(CERERE[@"MOTORIZARE"])  MOTORIZARE = [NSString stringWithFormat:@"%@",CERERE[@"MOTORIZARE"]];
   if(CERERE[@"SERIESASIU"])  SERIESASIU = [NSString stringWithFormat:@"%@",CERERE[@"SERIESASIU"]];
     NSArray *campurispeciale = [[NSArray alloc]init];
    campurispeciale =@[@"",VARIANTA,MOTORIZARE,SERIESASIU,@"",@""];
    // self.titluriCAMPURI =@[@"",@"Varianta (ex: Hatchback)",@"Motorizare (ex: 1.9 TDI)",@"Serie șasiu (opțional)",@"",@""];
    return campurispeciale;
}
-(void)viewWillAppear:(BOOL)animated {
    NSLog(@"CHOOSE 4");
    self.CE_TIP_E = CE_TIP_E; // a uitat pass sau varianta etc
    NSDictionary *userd = [DataMasterProcessor getLOGEDACCOUNT];
    NSMutableDictionary *modat = [NSMutableDictionary dictionaryWithDictionary:userd];
    
    if([CE_TIP_E isEqualToString:@"anfabricatie"]) {
        self.titluriCAMPURI =@[@"",@"Varianta (ex: Hatchback)",@"Motorizare (ex: 1.9 TDI)",@"Serie șasiu (opțional)",@"",@""];
        self.Continua.hidden =YES;
        self.Continua.userInteractionEnabled =NO;
        self.sageatablue.hidden =YES;
    }
    if([CE_TIP_E isEqualToString:@"amuitatparola"]) {
        self.titluriCAMPURI =@[@"Introdu adresa de e-mail pe care ai folosit-o la creearea contului:",@"Adresa de e-mail",@"",@"Recupereză parola"];
        self.Continua.hidden =YES;
        self.Continua.userInteractionEnabled =NO;
        self.sageatablue.hidden =YES;
    }
    //prenumenume
    if([CE_TIP_E isEqualToString:@"prenumenume"]) {
        NSString *prenume =@"";
        NSString *nume=@"";
        if(![self MyStringisEmpty:[NSString stringWithFormat:@"%@", modat[@"U_prenume"]]]) {
            prenume =[NSString stringWithFormat:@"%@", modat[@"U_prenume"]];
        }
        if(![self MyStringisEmpty:[NSString stringWithFormat:@"%@", modat[@"U_nume"]]]) {
            nume =[NSString stringWithFormat:@"%@", modat[@"U_nume"]];
        }
        self.titluriCAMPURI =@[@"Prenume",prenume,@"Nume",nume];
        self.Continua.hidden =YES;
        self.Continua.userInteractionEnabled =NO;
        self.sageatablue.hidden =YES;
    }
    if([CE_TIP_E isEqualToString:@"email"]) {
        NSString *email =@"";
        if(![self MyStringisEmpty:[NSString stringWithFormat:@"%@", modat[@"U_email"]]]) {
            email =[NSString stringWithFormat:@"%@", modat[@"U_email"]];
        }
        
        self.titluriCAMPURI =@[@"E-mail",email,@""];
        self.Continua.hidden =YES;
        self.Continua.userInteractionEnabled =NO;
        self.sageatablue.hidden =YES;
    }
    if([CE_TIP_E isEqualToString:@"telefon"]) {
        NSString *nrtelefon=@"";
        NSString *nrtelefon2=@"";
        NSString *nrtelefon3=@"";
        NSString *nrtelefon4=@"";
        /*
         "U_telefon" = 0726744221;
         "U_telefon2" = 0725363253;
         "U_telefon3" = "";
         "U_telefon4" = "";
         */
        //////////    NSString *U_telefon=  [NSString stringWithFormat:@"%@",userd[@"U_telefon"]];
        
        if(userd[@"U_telefon"])      nrtelefon= [NSString stringWithFormat:@"%@",userd[@"U_telefon"]];
        if(userd[@"U_telefon2"])     nrtelefon2= [NSString stringWithFormat:@"%@",userd[@"U_telefon2"]];
        if(userd[@"U_telefon3"])     nrtelefon3= [NSString stringWithFormat:@"%@",userd[@"U_telefon3"]];
        if(userd[@"U_telefon4"])     nrtelefon4= [NSString stringWithFormat:@"%@",userd[@"U_telefon4"]];
        self.titluriCAMPURI =@[@"Telefon 1",nrtelefon,@"Telefon 2",nrtelefon2,@"Telefon 3",nrtelefon3,@"Telefon 4",nrtelefon4];
        self.Continua.hidden =YES;
        self.Continua.userInteractionEnabled =NO;
        self.sageatablue.hidden =YES;
    }
    
    if([self.CE_TIP_E isEqualToString:@"modificareparola"]) {
        //        NSString *parola =@"";
        //         if(![self MyStringisEmpty:[NSString stringWithFormat:@"%@", modat[@"U_parola"]]]) {
        //             parola =[NSString stringWithFormat:@"%@", modat[@"U_parola"]];
        //         }
        // NSString *U_parola=  [NSString stringWithFormat:@"%@",userd[@"U_parola"]];
        self.titluriCAMPURI =@[@"Parola veche",@"",@"Parola nouă",@"",@"Confirmă parola nouă",@""];
        self.Continua.hidden =YES;
        self.Continua.userInteractionEnabled =NO;
        self.sageatablue.hidden =YES;
    }
    
    if([self.CE_TIP_E isEqualToString:@"codpostal"]) {
        NSString *cod_postal =@"";
        if(![self MyStringisEmpty:[NSString stringWithFormat:@"%@", modat[@"U_cod_postal"]]]) {
            cod_postal =[NSString stringWithFormat:@"%@", modat[@"U_cod_postal"]];
        }
        // NSString *U_parola=  [NSString stringWithFormat:@"%@",userd[@"U_parola"]];
        self.titluriCAMPURI =@[@"Cod poștal",cod_postal,@""];
        self.Continua.hidden =YES;
        self.Continua.userInteractionEnabled =NO;
        self.sageatablue.hidden =YES;
    }
    
    if([self.CE_TIP_E isEqualToString:@"adresa"]) {
        NSString *adresa =@"";
        if(![self MyStringisEmpty:[NSString stringWithFormat:@"%@", modat[@"U_adresa"]]]) {
            adresa =[NSString stringWithFormat:@"%@", modat[@"U_adresa"]];
            CGFloat widthWithInsetsApplied = self.view.frame.size.width-25;
            
            CGSize textSize = [adresa boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
            double heightrow= textSize.height+25;
            NSLog(@"heightrow spec %f",heightrow);
            if(textSize.height < 40) {
               heightrow =45;
            }
            cellheightmodificat = heightrow;

        }
        // NSString *U_parola=  [NSString stringWithFormat:@"%@",userd[@"U_parola"]];
        self.titluriCAMPURI =@[@"Adresa (str., nr, bloc ...)",adresa,@""];
     //   cellheightmodificat =
        self.Continua.hidden =YES;
        self.Continua.userInteractionEnabled =NO;
        self.sageatablue.hidden =YES;
    }
    
    LISTASELECT.delegate =self;
    LISTASELECT.dataSource =self;
    //LISTASELECT.layer.borderWidth = 1;
    LISTASELECT.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    // LISTASELECT.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    //dynamictableheightJ
//    if([CE_TIP_E isEqualToString:@"anfabricatie"]|| [CE_TIP_E isEqualToString:@"amuitatparola"] ||[CE_TIP_E isEqualToString:@"prenumenume"] ||[self.CE_TIP_E isEqualToString:@"adresa"]|| [self.CE_TIP_E isEqualToString:@"modificareparola"] ) {
//       // CGFloat height = 292.0f;
//       // dynamictableheightJ.constant = height;
//    }
//    if([CE_TIP_E isEqualToString:@"email"]  || [self.CE_TIP_E isEqualToString:@"codpostal"]) {
//       // CGFloat height = 196.0f;
//       // dynamictableheightJ.constant = height;
//    }
//    if([CE_TIP_E isEqualToString:@"telefon"]) {
//     //   CGFloat height = 520.0f;
//    //    dynamictableheightJ.constant = height;
//    }
//    
    
    //  LISTASELECT.rowHeight = UITableViewAutomaticDimension;
    [LISTASELECT reloadData];
}
//-(void)EnableSauDisableContinuaButton {
//    if(self.POZEALESE.count !=0) {
//        self.navigationItem.rightBarButtonItem.enabled =YES;
//    } else {
//        self.navigationItem.rightBarButtonItem.enabled =NO;
//    }
//}
-(void)ContinuaAction {
    BOOL ok =  [self verificaTextField];
    if(ok ==YES) {
    //scrie valorile in appdel si //
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary* CERERE =[[NSMutableDictionary alloc]init];
    CERERE = [del.cererepiesa mutableCopy];
    utilitar=[[Utile alloc] init];
    
    if([CE_TIP_E isEqualToString:@"anfabricatie"]) {
        NSString *VARIANTA = [NSString stringWithFormat:@"%@",CERERE[@"VARIANTA"]];
        NSString *MOTORIZARE = [NSString stringWithFormat:@"%@",CERERE[@"MOTORIZARE"]];
        NSString *SERIESASIU = [NSString stringWithFormat:@"%@",CERERE[@"SERIESASIU"]];
        NSArray *cells = [self.LISTASELECT visibleCells];
        for(UIView *view in cells){
            if([view isMemberOfClass:[CellChoose4 class]]){
                CellChoose4 *cell = (CellChoose4 *) view;
                UITextField *tf = (UITextField *)[cell texteditabil];
                if(tf.tag == 11 ) {
                    VARIANTA = [NSString stringWithFormat:@"%@",tf.text];
                }
                if(tf.tag == 12 ) {
                    MOTORIZARE = [NSString stringWithFormat:@"%@",tf.text];
                }
                if(tf.tag == 13 ) {
                    SERIESASIU = [NSString stringWithFormat:@"%@",tf.text];
                }
            }
        }
        [CERERE setObject:VARIANTA forKey:@"VARIANTA"];
        [CERERE setObject:MOTORIZARE forKey:@"MOTORIZARE"];
        [CERERE setObject:SERIESASIU forKey:@"SERIESASIU"];
        del.cererepiesa =CERERE;
        [utilitar mergiLaCerereNouaViewVC];
    }
    }
}
//-(BOOL) isValidPhone:(NSString *)checkString {
//    NSLog(@"CHECK tel %@" ,checkString);
//    BOOL  ok=NO;
//    if (checkString.length ==0) {
//        //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
//        //                                                            message:@"Completati numarul de telefon"
//        //                                                           delegate:nil
//        //                                                  cancelButtonTitle:@"Ok"
//        //                                                  otherButtonTitles:nil];
//        //        [alertView show];
//        //
//        ok=NO;
//    } else if (checkString.length !=10) {
//        //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
//        //                                                            message:@"Numarul de telefon trebuie sa aiba 10 cifre"
//        //                                                           delegate:nil
//        //                                                  cancelButtonTitle:@"Ok"
//        //                                                  otherButtonTitles:nil];
//        //        [alertView show];
//        //
//        ok=NO;
//    }
//    else if(checkString.length ==10) {
//        NSString *primelecifretelefon= [[NSString alloc]init];
//        if([checkString substringToIndex:1]) {
//            primelecifretelefon=[checkString substringToIndex:1];
//            if(! [primelecifretelefon isEqualToString:@"0"]) {
//                //                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
//                //                                                                    message:@"Numarul de telefon trebuie sa inceapa cu 0"
//                //                                                                   delegate:nil
//                //                                                          cancelButtonTitle:@"Ok"
//                //                                                          otherButtonTitles:nil];
//                //                [alertView show];
//                ok=NO;
//            }
//            else {
//                BOOL valid;
//                NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
//                NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:checkString];
//                valid = [alphaNums isSupersetOfSet:inStringSet];
//                if (!valid){
//                    //                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
//                    //                                                                        message:@"Numarul de telefon trebuie sa contina numai cifre"
//                    //                                                                       delegate:nil
//                    //                                                              cancelButtonTitle:@"Ok"
//                    //                                                              otherButtonTitles:nil];
//                    //                    [alertView show];
//                    ok=NO;
//                } else {
//                    ok=YES;
//                }
//            }
//        }
//    }
//    return ok;
//    
//}
//
//-(BOOL) isValidEmail:(NSString *)checkString
//{
//    NSLog(@"CHECK email %@" ,checkString);
//    checkString = [checkString lowercaseString];
//    checkString = [[NSString alloc] initWithData:[checkString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES] encoding:NSASCIIStringEncoding];
//    BOOL stricterFilter = YES;
//    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
//    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
//    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
//    return [emailTest evaluateWithObject:checkString];
//}
-(void)gata{
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  
    
    
    utilitar=[[Utile alloc] init];
    NSString *authtoken=@"";
    BOOL elogat = NO;
    elogat = [utilitar eLogat];
    if(elogat) {
        authtoken = [utilitar AUTHTOKEN];
    }
    if([CE_TIP_E isEqualToString:@"prenumenume"]) {
        BOOL ok =NO;
        BOOL ok2 =NO;
        BOOL ok3 =NO;
        NSString *eroareprenume = @"Prenume";
        NSString *eroarenume = @"Nume";
        NSString *prenume = @"";
        NSString *nume = @"";
        NSArray *cells = [self.LISTASELECT visibleCells];
        for(UIView *view in cells){
            if([view isMemberOfClass:[CellChoose4 class]]){
                CellChoose4 *cell = (CellChoose4 *) view;
                UITextField *tf = (UITextField *)[cell texteditabil];
                if(tf.tag == 11 && ![self MyStringisEmpty:[NSString stringWithFormat:@"%@",tf.text]] ) {
                    ok=YES;
                    prenume = [NSString stringWithFormat:@"%@",tf.text];
                    eroareprenume =@"";
                }
                
                if(tf.tag == 13 && ![self MyStringisEmpty:[NSString stringWithFormat:@"%@",tf.text]]) {
                    ok2=YES;
                    nume = [NSString stringWithFormat:@"%@",tf.text];
                    eroarenume =@"";
                }
            }
        }
        NSString *eroaredate = [NSString stringWithFormat:@"Completați câmpurile necesare: %@ %@" ,eroareprenume, eroarenume];
        ok3 = ok && ok2;
        if(ok3) {
            NSLog(@"gata %@ %@", prenume,nume);
            //fa update in db  -> pt user logat
            if(del.modificariDateComanda ==YES) {
                NSDictionary *userd = [NSDictionary dictionaryWithDictionary:del.CLONADATEUSER];
                NSMutableDictionary *modat = [NSMutableDictionary dictionaryWithDictionary:userd];
                [modat setObject:prenume forKey:@"U_prenume"];
                [modat setObject:nume forKey:@"U_nume"];
                del.CLONADATEUSER = modat;
            } else {
            NSDictionary *userd = [DataMasterProcessor getLOGEDACCOUNT];
            NSMutableDictionary *modat = [NSMutableDictionary dictionaryWithDictionary:userd];
            [modat setObject:prenume forKey:@"U_prenume"];
            [modat setObject:nume forKey:@"U_nume"];
            
            [self editProfile:authtoken :modat :@"numeprenume"];
            }
            
        } else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                message:eroaredate
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
    }
    if([CE_TIP_E isEqualToString:@"email"]) {
        BOOL ok =NO;
        NSString *EMAIL = @"";
        NSArray *cells = [self.LISTASELECT visibleCells];
        for(UIView *view in cells){
            if([view isMemberOfClass:[CellChoose4 class]]){
                CellChoose4 *cell = (CellChoose4 *) view;
                UITextField *tf = (UITextField *)[cell texteditabil];
                if(tf.tag == 11  && ![self MyStringisEmpty:[NSString stringWithFormat:@"%@",tf.text]]) {
                    ok=YES;
                    EMAIL = [NSString stringWithFormat:@"%@",tf.text];
                }
            }
        }
        NSString *eroaredate = [NSString stringWithFormat:@"Completați câmpul e-mail"];
        if(ok) {
            [utilitar changeemail:authtoken:EMAIL];
            [self.navigationController popViewControllerAnimated:YES];
            
        } else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                message:eroaredate
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
    }
    if([CE_TIP_E isEqualToString:@"telefon"]) {
        BOOL ok =NO;
        NSString *TELEFON = @"";
        NSString *TELEFON2 = @"";
        NSString *TELEFON3 = @"";
        NSString *TELEFON4 = @"";
        NSArray *cells = [self.LISTASELECT visibleCells];
        for(UIView *view in cells){
            if([view isMemberOfClass:[CellChoose4 class]]){
                CellChoose4 *cell = (CellChoose4 *) view;
                UITextField *tf = (UITextField *)[cell texteditabil];
                if(tf.tag == 11  && ![self MyStringisEmpty:[NSString stringWithFormat:@"%@",tf.text]] /*&& [self isValidPhone:[NSString stringWithFormat:@"%@",tf.text]]*/) {
                    ok=YES;
                    TELEFON = [NSString stringWithFormat:@"%@",tf.text];
                }
                if(tf.tag == 13  && ![self MyStringisEmpty:[NSString stringWithFormat:@"%@",tf.text]]) {
                    TELEFON2 = [NSString stringWithFormat:@"%@",tf.text];
                  
                }
                if(tf.tag == 15  && ![self MyStringisEmpty:[NSString stringWithFormat:@"%@",tf.text]] ) {
                    TELEFON3 = [NSString stringWithFormat:@"%@",tf.text];
                    
                }
                if(tf.tag == 17  && ![self MyStringisEmpty:[NSString stringWithFormat:@"%@",tf.text]] ) {
                    TELEFON4 = [NSString stringWithFormat:@"%@",tf.text];
                   
                }
            }
        }
        NSString *eroaredate = [NSString stringWithFormat:@"Completați câmpul telefon"];
        
        if(ok) {
            NSLog(@"gata %@", TELEFON);
            if(del.modificariDateComanda ==YES) {
                NSDictionary *userd = [NSDictionary dictionaryWithDictionary:del.CLONADATEUSER];
                NSMutableDictionary *modat = [NSMutableDictionary dictionaryWithDictionary:userd];
                [modat setObject:TELEFON forKey:@"U_telefon"];
                [modat setObject:TELEFON2 forKey:@"U_telefon2"];
                [modat setObject:TELEFON3 forKey:@"U_telefon3"];
                [modat setObject:TELEFON4 forKey:@"U_telefon4"];
                del.CLONADATEUSER = modat;
            } else {
            NSDictionary *userd = [DataMasterProcessor getLOGEDACCOUNT];
            NSMutableDictionary *modat = [NSMutableDictionary dictionaryWithDictionary:userd];
            [modat setObject:TELEFON forKey:@"U_telefon"];
            [modat setObject:TELEFON2 forKey:@"U_telefon2"];
            [modat setObject:TELEFON3 forKey:@"U_telefon3"];
            [modat setObject:TELEFON4 forKey:@"U_telefon4"];
            [self editProfile:authtoken :modat :@"telefon"];
            }
            
        } else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                message:eroaredate
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
    }
    if([self.CE_TIP_E isEqualToString:@"modificareparola"]) {
        BOOL ok =NO;
        BOOL ok2 =NO;
        BOOL ok3 =NO;
        BOOL ok4 =NO;
      
        NSString *eroareparolacurenta = @"- Parola veche";
        NSString *eroareparolanoua = @"- Parola nouă";
        NSString *eroareconfirmaparolanoua = @"- Confirmă parola nouă";
        NSString *eroareparolediferite = @"Parola și Confirmă parola nu corespund";
        NSString *PAROLACURENTA = @"";
        NSString *PAROLANOUA = @"";
        NSString *CONFIRMAPAROLANOUA = @"";
        NSArray *cells = [self.LISTASELECT visibleCells];
        for(UIView *view in cells){
            if([view isMemberOfClass:[CellChoose4 class]]){
                CellChoose4 *cell = (CellChoose4 *) view;
                UITextField *tf = (UITextField *)[cell texteditabil];
                if(tf.tag == 11  && ![self MyStringisEmpty:[NSString stringWithFormat:@"%@",tf.text]]) {
                    ok=YES;
                    PAROLACURENTA = [NSString stringWithFormat:@"%@",tf.text];
                    eroareparolacurenta=@"";
                }
                if(tf.tag == 13 && ![self MyStringisEmpty:[NSString stringWithFormat:@"%@",tf.text]]) {
                    ok2=YES;
                    PAROLANOUA = [NSString stringWithFormat:@"%@",tf.text];
                    eroareparolanoua =@"";
                }
                if(tf.tag == 15 && ![self MyStringisEmpty:[NSString stringWithFormat:@"%@",tf.text]]) {
                    ok3=YES;
                    CONFIRMAPAROLANOUA = [NSString stringWithFormat:@"%@",tf.text];
                    eroareconfirmaparolanoua =@"";
                }
                
            }
        }
       
        NSString *eroaredate = [NSString stringWithFormat:@"Câmpurile sunt obligatorii: %@ %@ %@", eroareparolacurenta, eroareparolanoua, eroareconfirmaparolanoua];
        
        ok4 = ok && ok2 && ok3 ;
        if(ok4) {
            if( [PAROLANOUA isEqualToString:CONFIRMAPAROLANOUA]) {
             NSLog(@"gata %@ %@", PAROLACURENTA,PAROLANOUA);
            //fa update in db  -> pt user logat
            NSDictionary *userd = [DataMasterProcessor getLOGEDACCOUNT];
             NSMutableDictionary *modat = [NSMutableDictionary dictionaryWithDictionary:userd];
            [modat setObject:PAROLACURENTA forKey:@"OLDPASSWORD"];
            [modat setObject:PAROLANOUA forKey:@"NEWPASSWORD"];
            [self change_password:authtoken :modat];
                
            } else {
          
              UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                    message:eroareparolediferite
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                 [alertView show];

            }
        } else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                message:eroaredate
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
        
    }
    
    if([self.CE_TIP_E isEqualToString:@"codpostal"]) {
     ////   BOOL ok =NO;
        NSString *codpostal = @"";
        NSArray *cells = [self.LISTASELECT visibleCells];
        for(UIView *view in cells){
            if([view isMemberOfClass:[CellChoose4 class]]){
                CellChoose4 *cell = (CellChoose4 *) view;
                UITextField *tf = (UITextField *)[cell texteditabil];
//                if(tf.tag == 11  && ![self MyStringisEmpty:[NSString stringWithFormat:@"%@",tf.text]]) {
//                    ok=YES;
                if(tf.tag == 11) {
                codpostal = [NSString stringWithFormat:@"%@",tf.text];
                NSLog(@"codpostal zz %@",codpostal);
                NSLog(@"gata %@", codpostal);
                if(del.modificariDateComanda ==YES) {
                    NSDictionary *userd = [NSDictionary dictionaryWithDictionary:del.CLONADATEUSER];
                    NSMutableDictionary *modat = [NSMutableDictionary dictionaryWithDictionary:userd];
                    [modat setObject:codpostal forKey:@"U_cod_postal"];
                    del.CLONADATEUSER = modat;
                } else {
                    NSDictionary *userd = [DataMasterProcessor getLOGEDACCOUNT];
                    NSMutableDictionary *modat = [NSMutableDictionary dictionaryWithDictionary:userd];
                    [modat setObject:codpostal forKey:@"U_cod_postal"];
                    [self editProfile:authtoken :modat :@"codpostal"];
                }
                }

            }
        }
    }
    //    NSString *eroaredate = [NSString stringWithFormat:@"Completați corect câmpul cod poștal"];
    //  if(ok) {
                       //   [self.navigationController popViewControllerAnimated:YES];
//        } else{
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
//                                                                message:eroaredate
//                                                               delegate:nil
//                                                      cancelButtonTitle:@"OK"
//                                                      otherButtonTitles:nil];
//            [alertView show];
//        }
    
    if([self.CE_TIP_E isEqualToString:@"adresa"]) {
        BOOL ok =NO;
        NSString *ADRESA = @"";
        NSArray *cells = [self.LISTASELECT visibleCells];
        for(UIView *view in cells){
            if([view isMemberOfClass:[CellChoose4 class]]){
                CellChoose4 *cell = (CellChoose4 *) view;
                UITextView *tf = (UITextView *)[cell maimulttext];
                if(tf.tag == 11  && ![self MyStringisEmpty:[NSString stringWithFormat:@"%@",tf.text]]) {
                    ok=YES;
                    ADRESA = [NSString stringWithFormat:@"%@",tf.text];
                }
            }
        }
        NSString *eroaredate = [NSString stringWithFormat:@"Completați corect adresa"];
        if(ok) {
            NSLog(@"gata %@", ADRESA);
            if(del.modificariDateComanda ==YES) {
                NSDictionary *userd = [NSDictionary dictionaryWithDictionary:del.CLONADATEUSER];
                NSMutableDictionary *modat = [NSMutableDictionary dictionaryWithDictionary:userd];
                [modat setObject:ADRESA forKey:@"U_adresa"];
                del.CLONADATEUSER = modat;
            } else {
            NSDictionary *userd = [DataMasterProcessor getLOGEDACCOUNT];
            NSMutableDictionary *modat = [NSMutableDictionary dictionaryWithDictionary:userd];
            [modat setObject:ADRESA forKey:@"U_adresa"];
            [self editProfile:authtoken :modat :@"adresa"];
            }
            // [self.navigationController popViewControllerAnimated:YES];
        } else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                message:eroaredate
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
    }
    
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)perfecttimeforback{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
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

    //marci
    if([CE_TIP_E isEqualToString:@"anfabricatie"]) {
        self.title = @"Varianta, Motorizare...";
    }
    if([CE_TIP_E isEqualToString:@"amuitatparola"]) {
        self.title =@"Recuperare parolă";
        //   Continua.titleLabel.text = @"Recupereză parola";
    }
    if([CE_TIP_E isEqualToString:@"prenumenume"]) {
           UIBarButtonItem *butonDreapta = [[UIBarButtonItem alloc] initWithTitle:@"Gata" style:UIBarButtonItemStylePlain target:self action:@selector(gata)];
        
        self.navigationItem.rightBarButtonItem = butonDreapta;
        
        self.title =@"Prenume și Nume";
    }
    if( [CE_TIP_E isEqualToString:@"email"]) {
        UIBarButtonItem *butonDreapta = [[UIBarButtonItem alloc] initWithTitle:@"Gata" style:UIBarButtonItemStylePlain target:self action:@selector(gata)];
        
        self.navigationItem.rightBarButtonItem = butonDreapta;
        
        self.title =@"E-mail";
    }
    if([CE_TIP_E isEqualToString:@"telefon"]) {
  
        UIBarButtonItem *butonDreapta = [[UIBarButtonItem alloc] initWithTitle:@"Gata" style:UIBarButtonItemStylePlain target:self action:@selector(gata)];
        
        self.navigationItem.rightBarButtonItem = butonDreapta;
        
        self.title =@"Telefon";
    }
    if([self.CE_TIP_E isEqualToString:@"modificareparola"]) {
        self.title = @"Modificare parolă";
        UIBarButtonItem *butonDreapta = [[UIBarButtonItem alloc] initWithTitle:@"Gata" style:UIBarButtonItemStylePlain target:self action:@selector(gata)];
        
        self.navigationItem.rightBarButtonItem = butonDreapta;
        
    }
    if([self.CE_TIP_E isEqualToString:@"codpostal"]) {
        self.title = @"Cod poștal";
        UIBarButtonItem *butonDreapta = [[UIBarButtonItem alloc] initWithTitle:@"Gata" style:UIBarButtonItemStylePlain target:self action:@selector(gata)];
        
        self.navigationItem.rightBarButtonItem = butonDreapta;
    }
    if([self.CE_TIP_E isEqualToString:@"adresa"])  {
        self.title = @"Adresa";
        UIBarButtonItem *butonDreapta = [[UIBarButtonItem alloc] initWithTitle:@"Gata" style:UIBarButtonItemStylePlain target:self action:@selector(gata)];
        self.navigationItem.rightBarButtonItem = butonDreapta;
    }
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numarranduri =0;
    if([CE_TIP_E isEqualToString:@"anfabricatie"]) {
        // primul si penultimul sunt goale, gri restul sunt 3 campuri
        numarranduri =6; }
///   self.titluriCAMPURI =@[telefoaneuser,@""];
    if([CE_TIP_E isEqualToString:@"telefon"]) { //4 labels + 4 campuri editabile
        numarranduri = 8;
    }
    if([CE_TIP_E isEqualToString:@"email"]) {
      numarranduri =2;}
    if([self.CE_TIP_E isEqualToString:@"codpostal"] || [self.CE_TIP_E isEqualToString:@"adresa"]) {
        numarranduri =3;}
    if([CE_TIP_E isEqualToString:@"prenumenume"] ||[CE_TIP_E isEqualToString:@"amuitatparola"] ) {
        numarranduri =4;}//1 3 gri 2 camp
    if([self.CE_TIP_E isEqualToString:@"modificareparola"] ) { numarranduri =6;}//pass veche noua confirma_noua
    
    return numarranduri;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int ipx = (int)indexPath.row;
    double heightrow=0;
    if([CE_TIP_E isEqualToString:@"anfabricatie"]) {
        if(ipx==0 || ipx==4) {
            heightrow =5;
        }
        else if(ipx==5) {
         heightrow =55;
        }
        else {
            heightrow =45;
        }
    }
    
    if([CE_TIP_E isEqualToString:@"prenumenume"]||[CE_TIP_E isEqualToString:@"email"] || [self.CE_TIP_E isEqualToString:@"modificareparola"]|| [self.CE_TIP_E isEqualToString:@"codpostal"]) {
        if(ipx==0 ||ipx==2 || ipx==4) {
            heightrow =36;
        } else {
            heightrow =50;
        }
    }
    if([CE_TIP_E isEqualToString:@"amuitatparola"]){
        if(ipx==0) {
            heightrow =60;
        } else if(ipx ==2) {
            heightrow =36;
        } else {
            heightrow =50;
        }
    }
    
    if([self.CE_TIP_E isEqualToString:@"adresa"]) {
        if(ipx==0 ||ipx==2) {
            heightrow =36;
        } else {
          //  heightrow =90; //e textview dinamic height
                   //jj   heightrow =45;
//        NSString *textadresa = [NSString stringWithFormat:@"%@", [self.titluriCAMPURI objectAtIndex:1]];
//                CGFloat widthWithInsetsApplied = self.view.frame.size.width-25;
//                CGSize textSize = [textadresa boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
//            heightrow= textSize.height+25;
//            NSLog(@"heightrow %f",heightrow);
//                if(textSize.height < 40) {
//                   heightrow =45;
//                }
//              }
            heightrow= cellheightmodificat;
        }
    }
    if([self.CE_TIP_E isEqualToString:@"telefon"]) {
       if(indexPath.section % 2) {
            heightrow = 50;
        } else {
            heightrow = 36;
        }
//        if(ipx==0 ||ipx==2) {
//            heightrow =39;
//        } else {
//            heightrow =90; //e textview
//        }
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
    ///////// [self.LISTASELECT reloadData];
    _initialTVHeightx = self.LISTASELECT.frame.size.height;
    CGRect tvFrame = self.LISTASELECT.frame;
    if(_MYkeyboardheightx >0) {
        tvFrame.size.height = _MYkeyboardheightx;
        [self.LISTASELECT setFrame:tvFrame];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.LISTASELECT setNeedsDisplay];
            [self.view layoutIfNeeded];
        });
    }
}
-(BOOL)verificaTextField {
    BOOL ok =NO;
    BOOL ok2 =NO;
    BOOL ok3 =NO;
    NSArray *cells = [self.LISTASELECT visibleCells];
    for(UIView *view in cells){
        if([view isMemberOfClass:[CellChoose4 class]]){
            CellChoose4 *cell = (CellChoose4 *) view;
            UITextField *tf = (UITextField *)[cell texteditabil];
            if(tf.tag == 11 && ![self MyStringisEmpty:tf.text] && tf.text.length >2)  { ok =YES;}
            else  if(tf.tag == 12 && ![self MyStringisEmpty:tf.text] &&tf.text.length >2) { ok2 =YES;}
        }
    }
    ok3 = ok && ok2;
    NSIndexPath *indexPathreload = [NSIndexPath indexPathForRow:5 inSection:0];
    CellChoose4* cell = (CellChoose4*)[self.LISTASELECT cellForRowAtIndexPath:indexPathreload];
    if(ok3==YES) {
        //CELL
            [UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] ;
            cell.continuaBTN.textColor= [UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1];
            cell.sageatabluemare.image = [UIImage imageNamed:@"Arrow_right_blue_72x72.png"];
        } else {
            cell.continuaBTN.textColor= [UIColor lightGrayColor];
            cell.sageatabluemare.image = [UIImage imageNamed:@"Arrow_right_grayedout_72x72.png"];
            
        }

    return ok3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   
    return 1;
}
-(void)textFieldDidChange :(UITextField *)theTextField{
    NSLog( @"text changed: %@", theTextField.text);
    [self verificaTextField];
}

-(void)textViewDidChange:(UITextView *)textView
{
    NSLog(@"Dilip : %@",textView.text);
   // dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        NSIndexPath *indexPathreload = [NSIndexPath indexPathForRow:1 inSection:0];
        CellChoose4 *updateCell = (CellChoose4 *)[self.LISTASELECT cellForRowAtIndexPath:indexPathreload];
      //  UITextView *textViews = updateCell.maimulttext;

    CGFloat widthWithInsetsApplied = self.view.frame.size.width-25;
    CGSize textSize = [textView.text boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        double heightrow= textSize.height+25;
        NSLog(@"heightrow specx %f",heightrow);
       [self.LISTASELECT beginUpdates];
        if(heightrow < 40) {
        updateCell.dynamicTEXTVIEWHEIGHT.constant =45;
        } else {
        updateCell.dynamicTEXTVIEWHEIGHT.constant =heightrow;
        }
       [updateCell setNeedsLayout];
        cellheightmodificat = heightrow;
       [self.LISTASELECT endUpdates];
    
   //});
   
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger ipx = indexPath.row;
    static NSString *CellIdentifier = @"Cell4";
    CellChoose4 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (CellChoose4*)[tableView dequeueReusableCellWithIdentifier:@"Cell4"];
    }
    cell.continuaBTN.hidden=YES;
    cell.sageatabluemare.hidden=YES;
    
    
    cell.sageatagri.hidden =YES;
    cell.titluROW.hidden=YES;
    cell.maimulttext.hidden=YES;
    cell.sageatablue.hidden=YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if([CE_TIP_E isEqualToString:@"anfabricatie"]) {
         [cell.texteditabil addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        if(ipx==0  || ipx==4) {
            cell.texteditabil.hidden =YES;
            cell.backgroundColor = [UIColor colorWithRed:(240/255.0f) green:(240/255.0f) blue:(240/255.0f) alpha:1];
            
        }  else if(ipx==5) {
           
            BOOL ok = [self verificaTextField];
            cell.texteditabil.hidden=YES;
            cell.continuaBTN.hidden=NO;
            cell.sageatabluemare.hidden=NO;
            cell.continuaBTN.textColor =[UIColor lightGrayColor];
            UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ContinuaAction)];
            [singleTap setNumberOfTapsRequired:1];
            [cell  addGestureRecognizer:singleTap];
         //  ContinuaAction
            if(ok ==YES) {
                [UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] ;
            cell.continuaBTN.textColor= [UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1];
            cell.sageatabluemare.image = [UIImage imageNamed:@"Arrow_right_blue_72x72.png"];
            } else {
                cell.continuaBTN.textColor= [UIColor lightGrayColor];
                cell.sageatabluemare.image = [UIImage imageNamed:@"Arrow_right_grayedout_72x72.png"];

            }
        }
        else {
            cell.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1];
            cell.texteditabil.textColor =[UIColor darkGrayColor];
            cell.texteditabil.placeholder = [NSString stringWithFormat:@"%@",[self.titluriCAMPURI  objectAtIndex:indexPath.row]];
            cell.texteditabil.tag =ipx +10;
            cell.texteditabil.delegate =self;
            NSArray *verificatoatecamurileinitiale =[[NSArray alloc]init];
            verificatoatecamurileinitiale = [self checkCAMPURI];
            cell.texteditabil.text = [NSString stringWithFormat:@"%@",[verificatoatecamurileinitiale  objectAtIndex:indexPath.row]];
            NSLog(@"CCC %@", cell.texteditabil.text);
            [cell.contentView bringSubviewToFront:cell.texteditabil];
        }
    }
    if([CE_TIP_E isEqualToString:@"amuitatparola"]) {
        cell.texteditabil.hidden =YES;
        cell.texteditabil.userInteractionEnabled =NO;
        cell.backgroundColor = [UIColor colorWithRed:(240/255.0f) green:(240/255.0f) blue:(240/255.0f) alpha:1];
        cell.titluROW.text =  [NSString stringWithFormat:@"%@",[self.titluriCAMPURI  objectAtIndex:indexPath.row]];
        switch (ipx) {
            case 0: {
                cell.titluROW.hidden=NO;
                cell.titluROW.numberOfLines =0;
            }  break;
                
            case 1: {
                cell.titluROW.hidden=YES;
                cell.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1];
                cell.texteditabil.textColor =[UIColor darkGrayColor];
                cell.texteditabil.placeholder = [NSString stringWithFormat:@"%@",[self.titluriCAMPURI  objectAtIndex:indexPath.row]];
                cell.texteditabil.tag =ipx +10;
                cell.texteditabil.delegate =self;
                cell.texteditabil.hidden =NO;
                cell.texteditabil.userInteractionEnabled =YES;
                NSLog(@"CCC %@", cell.texteditabil.text);
               [cell.contentView bringSubviewToFront:cell.texteditabil];
            }  break;
            case 3: {
                cell.titluROW.hidden=NO;
                cell.titluROW.numberOfLines =1;
                cell.texteditabil.hidden=YES;
                cell.texteditabil.userInteractionEnabled =NO;
                cell.sageatablue.hidden =NO;
                cell.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1];
                cell.titluROW.textColor =  [UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] ;
                
            }  break;
            case 2: {
                cell.titluROW.hidden=YES;
            } break;
                
            default:
                break;
        }
        
    }
    
    ///special telefon
    /*
     {
     nume = "Telefon 1";
     telefon = 0726744221;
     },
     {
     nume = "Telefon 2";
     telefon = 0756124124;
     },
     {
     nume = "Telefon 3";
     telefon = "";
     },
     {
     nume = "Telefon 4";
     telefon = "";
     }

     */
    if([CE_TIP_E isEqualToString:@"telefon"] ) {
        cell.titluROW.hidden=NO;
        if (ipx % 2) {
            cell.backgroundColor = [UIColor whiteColor];
          //  cell.titluROW.textColor =  [UIColor darkGrayColor];
            cell.titluROW.hidden=YES;
            cell.texteditabil.hidden=NO;
            cell.texteditabil.textColor =[UIColor darkGrayColor];
            cell.texteditabil.text = [NSString stringWithFormat:@"%@",[self.titluriCAMPURI  objectAtIndex:indexPath.row]];
            cell.texteditabil.tag =ipx +10;
            cell.texteditabil.delegate =self;
            cell.texteditabil.userInteractionEnabled=YES;
            NSLog(@"SPECIAL CCC %@ %li", cell.texteditabil.text,(long)cell.texteditabil.tag);
            [cell.contentView bringSubviewToFront:cell.texteditabil];
            cell.texteditabil.keyboardType = UIKeyboardTypePhonePad;
            cell.texteditabil.frame=cell.titluROW.frame;
            }else {
            cell.backgroundColor = [UIColor colorWithRed:(240/255.0f) green:(240/255.0f) blue:(240/255.0f) alpha:1];
            cell.titluROW.text =[self.titluriCAMPURI objectAtIndex:ipx];
            cell.titluROW.textColor = [UIColor blackColor];
            cell.texteditabil.hidden =YES;
            cell.texteditabil.userInteractionEnabled =NO;
            cell.titluROW.font =[UIFont boldSystemFontOfSize:18];
            }
       }
   
    if([CE_TIP_E isEqualToString:@"prenumenume"]||[CE_TIP_E isEqualToString:@"email"]|| [self.CE_TIP_E isEqualToString:@"modificareparola"]||[self.CE_TIP_E isEqualToString:@"codpostal"]){
        if(ipx==0 ||ipx==2 || ipx==4) {
            cell.titluROW.hidden=NO;
            //  cell.texteditabil.placeholder = [NSString stringWithFormat:@"%@",[self.titluriCAMPURI  objectAtIndex:indexPath.row]];
            cell.texteditabil.hidden =YES;
            cell.texteditabil.userInteractionEnabled =NO;
            cell.backgroundColor = [UIColor colorWithRed:(240/255.0f) green:(240/255.0f) blue:(240/255.0f) alpha:1];
            cell.titluROW.textColor = [UIColor blackColor];
            cell.titluROW.font =[UIFont boldSystemFontOfSize:18];
            cell.titluROW.text=[NSString stringWithFormat:@"%@",[self.titluriCAMPURI  objectAtIndex:indexPath.row]];
            [cell.contentView bringSubviewToFront:cell.titluROW];
        } else {
            cell.titluROW.hidden=YES;
            cell.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1];
            cell.texteditabil.textColor =[UIColor darkGrayColor];
            cell.texteditabil.text = [NSString stringWithFormat:@"%@",[self.titluriCAMPURI  objectAtIndex:indexPath.row]];
            cell.texteditabil.tag =ipx +10;
            cell.texteditabil.delegate =self;
            NSLog(@"CCC %@", cell.texteditabil.text);
            [cell.contentView bringSubviewToFront:cell.texteditabil];
            
        }
    }
    if([self.CE_TIP_E isEqualToString:@"adresa"]) {
     
        if(ipx==0 ||ipx==2) {
            cell.titluROW.hidden=NO;
            cell.dynamicTEXTVIEWHEIGHT.constant =0;
            //  cell.texteditabil.placeholder = [NSString stringWithFormat:@"%@",[self.titluriCAMPURI  objectAtIndex:indexPath.row]];
            cell.texteditabil.hidden =YES;
            cell.texteditabil.userInteractionEnabled =NO;
            cell.maimulttext.hidden=YES;
            cell.maimulttext.userInteractionEnabled =NO;
            cell.backgroundColor = [UIColor colorWithRed:(240/255.0f) green:(240/255.0f) blue:(240/255.0f) alpha:1];
            cell.titluROW.textColor = [UIColor blackColor];
            cell.titluROW.font =[UIFont boldSystemFontOfSize:18];
            cell.titluROW.text=[NSString stringWithFormat:@"%@",[self.titluriCAMPURI  objectAtIndex:indexPath.row]];
            [cell.contentView bringSubviewToFront:cell.titluROW];
            
        } else {
            cell.titluROW.hidden=YES;
            [cell.maimulttext setScrollEnabled:NO];
            cell.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1];
            cell.texteditabil.hidden =YES;
            cell.texteditabil.userInteractionEnabled =NO;
            cell.maimulttext.hidden=NO;
            cell.maimulttext.userInteractionEnabled =YES;
            cell.maimulttext.textColor =[UIColor darkGrayColor];
            cell.maimulttext.text = [NSString stringWithFormat:@"%@",[self.titluriCAMPURI  objectAtIndex:indexPath.row]];
            cell.maimulttext.tag =ipx +10;
            cell.maimulttext.delegate =self;
            CGFloat widthWithInsetsApplied = self.view.frame.size.width-25;
            
            CGSize textSize = [cell.maimulttext.text boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
            double heightrow= textSize.height+25;
            NSLog(@"heightrow spec %f",heightrow);
            if(textSize.height < 40) {
            cell.dynamicTEXTVIEWHEIGHT.constant =45;
            } else {
                cell.dynamicTEXTVIEWHEIGHT.constant =heightrow;
            }
            cellheightmodificat = heightrow;
            NSLog(@"CCC %@", cell.maimulttext.text);
            [cell.contentView bringSubviewToFront:cell.maimulttext];
            [cell setNeedsLayout];
            
        }
        
    }
    [self focusfirstfieldDINTABEL];
    return cell;
}
// primul camp are focus.
-(void)focusfirstfieldDINTABEL{
    NSArray *cells = [self.LISTASELECT visibleCells];
    for(UIView *view in cells){
        if([self.CE_TIP_E isEqualToString:@"adresa"]) {
            if([view isMemberOfClass:[CellChoose4 class]] ){
                CellChoose4 *cell = (CellChoose4 *) view;
                UITextView *tf = (UITextView *)[cell maimulttext];
                if(tf.hidden ==NO) {
                    [tf becomeFirstResponder];
                    break;
                }
            }
        }
        if([view isMemberOfClass:[CellChoose4 class]] ){
            CellChoose4 *cell = (CellChoose4 *) view;
            UITextField *tf = (UITextField *)[cell texteditabil];
            if(tf.hidden ==NO) {
            [tf becomeFirstResponder];
            break;
            }
        
        }
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // [LISTASELECT cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
    /*
     CREATE TABLE "users" ("U_authtoken" VARCHAR NOT NULL  UNIQUE,
     "U_lastupdate" VARCHAR,
     "U_username" VARCHAR,
     "U_logat" VARCHAR,
     "U_preferinte_notificari" VARCHAR,
     "U_prenume" VARCHAR,
     "U_nume" VARCHAR,
     "U_email" VARCHAR,
     "U_telefon" VARCHAR,
     "U_telefon2" VARCHAR,
     "U_telefon3" VARCHAR,
     "U_telefon4" VARCHAR,
     "U_judet"  VARCHAR,
     "U_localitate"  VARCHAR,
     "U_cod_postal" VARCHAR,
     "U_adresa" VARCHAR,
     "U_parola" VARCHAR
     , "U_userid" VARCHAR)
     */
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int ipx = (int)indexPath.row;
    utilitar=[[Utile alloc] init];
    if([CE_TIP_E isEqualToString:@"amuitatparola"] && ipx ==3) {
        BOOL ok =NO;
        NSString *EMAIL = @"";
        NSArray *cells = [self.LISTASELECT visibleCells];
        for(UIView *view in cells){
            if([view isMemberOfClass:[CellChoose4 class]]){
                CellChoose4 *cell = (CellChoose4 *) view;
                UITextField *tf = (UITextField *)[cell texteditabil];
                if(tf.tag == 11 && ![self MyStringisEmpty:tf.text] /*&& [self isValidEmail:[NSString stringWithFormat:@"%@",tf.text]]*/) {
                    ok=YES;
                    EMAIL = [NSString stringWithFormat:@"%@",tf.text];
                }
            }
        }
        NSString *eroaredate = [NSString stringWithFormat:@"Completați câmpul E-mail"];
        if(ok) {
            NSLog(@"gata %@", EMAIL);
            [utilitar sendforgot_password:EMAIL];
            //   [self.navigationController popViewControllerAnimated:YES];
            
        } else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                message:eroaredate
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
    }
    
    
    /*   int ipx = (int)indexPath.row;
     CellChoose4 *CELL = (CellChoose4 *)[LISTASELECT cellForRowAtIndexPath:indexPath];
     
     if([CE_TIP_E isEqualToString:@"anfabricatie"]) {
     if(ipx==0 ||ipx==4) {
     CELL.texteditabil.hidden =NO;
     } else {
     CELL.texteditabil.hidden =YES;
     }
     }
     if([CE_TIP_E isEqualToString:@"amuitatparola"] ||[CE_TIP_E isEqualToString:@"prenumenume"]) {
     if(ipx==0 ||ipx==2) {
     CELL.texteditabil.hidden =YES;
     } else {
     CELL.texteditabil.hidden =NO;
     }
     }
     */
    NSLog(@"AAA");
}

-(void)inchideTastatura{
    NSArray *cells = [self.LISTASELECT visibleCells];
    for(UIView *view in cells){
        if([view isMemberOfClass:[CellChoose4 class]]){
            CellChoose4 *cell = (CellChoose4 *) view;
            UITextField *tf = (UITextField *)[cell texteditabil];
            [tf resignFirstResponder];
        }
    }
}


/*- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
 NSArray *cells = [self.LISTASELECT visibleCells];
 for(UIView *view in cells){
 if([view isMemberOfClass:[CellChoose4 class]]){
 CellChoose4 *cell = (CellChoose4 *) view;
 UITextField *tf = (UITextField *)[cell texteditabil];
 if(tf.tag == textField.tag) {
 if([tf.text isEqualToString:@"\n"]) {
 [self inchideTastatura];
 return NO;
 }
 }
 }
 }
 
 
 
 return YES;
 
 }*/

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if([self.CE_TIP_E isEqualToString:@"adresa"]) {
        switch ((int)textView.tag) {
            case 11: {
                NSLog(@"adresa");
                [textView resignFirstResponder];
            }
                break;
            default:
                break;
        }
    }
    
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if([CE_TIP_E isEqualToString:@"anfabricatie"]) {
        switch ((int)textField.tag) {
            case 11:
            {
                NSLog(@"varian");
                
            }
                break;
            case 12:
            {
                NSLog(@"motor");
            }
                break;
            case 13:
            {
                NSLog(@"sasiu");
            }
                break;
        }
    }
    if([CE_TIP_E isEqualToString:@"amuitatparola"]) {
        switch ((int)textField.tag) {
            case 11: {
                NSLog(@"parola");
            }
                break;
            default:
                break;
        }
    }
    if([CE_TIP_E isEqualToString:@"prenumenume"]) {
        switch ((int)textField.tag) {
            case 11: {
                NSLog(@"prenume");
            }
                break;
            case 13: {
                NSLog(@"nume");
            }
                break;
            default:
                break;
        }
    }
    if([CE_TIP_E isEqualToString:@"email"]) {
        switch ((int)textField.tag) {
            case 11: {
                NSLog(@"email");
            }
                break;
            default:
                break;
        }
    }
    if([CE_TIP_E isEqualToString:@"telefon"]) {
        switch ((int)textField.tag) {
            case 11: {
                NSLog(@"telefon");
            }
                break;
            case 13: {
                NSLog(@"telefon 2");
            }
                break;
            case 15: {
                NSLog(@"telefon 3");
            }
                break;
            case 17: {
                NSLog(@"telefon 4");
            }
                break;
            default:
                break;
        }
    }
    if([self.CE_TIP_E isEqualToString:@"modificareparola"]) {
        switch ((int)textField.tag) {
            case 11: {
                NSLog(@"parola noua");
            }
                break;
            default:
                break;
        }
    }
    
    if([self.CE_TIP_E isEqualToString:@"codpostal"]) {
        switch ((int)textField.tag) {
            case 11: {
                NSLog(@"cod postal");
            }
                break;
            default:
                break;
        }
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
    //  manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    return manager;
}
//METODA_CHANGE_PASSWORD
/*
 Metoda noua: Change_password  parametrii: - current_password  - new_password Returneaza authtoken nou, la fel ca metodele register sau login
 (authtoken-urile vechi nu vor merge)
 */
-(void)change_password :(NSString *)AUTHTOKEN :(NSMutableDictionary *)OLDANDNEWPASSWORD {
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
        NSString *OLDPASSWORD =@"";
        NSString *NEWPASSWORD =@"";
        if(OLDANDNEWPASSWORD[@"OLDPASSWORD"]) {
            OLDPASSWORD = [NSString stringWithFormat:@"%@",OLDANDNEWPASSWORD[@"OLDPASSWORD"]];
        }
        if(OLDANDNEWPASSWORD[@"NEWPASSWORD"]) {
            NEWPASSWORD = [NSString stringWithFormat:@"%@",OLDANDNEWPASSWORD[@"NEWPASSWORD"]];
        }
        [dic2 setObject:OLDPASSWORD forKey:@"current_password"];
        [dic2 setObject:NEWPASSWORD forKey:@"new_password"];
        
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic2 options:0 error:&err];
        NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        compus =[NSString stringWithFormat:@"%@%@",METODA_CHANGE_PASSWORD, myString];
        
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
                    
                    /*
                     raspuns {
                     authtoken = "1248f7g571e059dgwD2x6vtkkp4BkCuwsozO5oxhi3pyPvYzytzHPAN-pMI";
                     username = ioanungureanu;
                     }
                     */
                    NSDictionary *multedate = REZULTAT_NOTIFY_COUNT[@"data"];
                    NSLog(@"date CHANGE PASSWD raspuns %@",multedate);
                    
                    NSString *authnou =@"";
                    NSString *username =@"";
                    
                    if(multedate[@"authtoken"]) {
                        authnou = [NSString stringWithFormat:@"%@",multedate[@"authtoken"]];
                    }
                    if(multedate[@"username"]) {
                        username = [NSString stringWithFormat:@"%@",multedate[@"username"]];
                    }
                    NSMutableDictionary *userd =[NSMutableDictionary dictionaryWithDictionary:[DataMasterProcessor getLOGEDACCOUNT]];
                    [userd setObject:authnou forKey:@"U_authtoken"];
                    [userd setObject:username forKey:@"U_username"];
                    if(![self MyStringisEmpty:authnou] && ![self MyStringisEmpty:username]) {
                        [DataMasterProcessor schimbaauthtokensiusername:AUTHTOKEN :userd];
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
//METODA_EDIT_PROFILE
-(void)editProfile :(NSString *)AUTHTOKEN :(NSMutableDictionary *)DATEUSER :(NSString *)tip_date{
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
        NSMutableDictionary *datedetrimis = [[NSMutableDictionary alloc]init];
        datedetrimis =DATEUSER;
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
        if([tip_date isEqualToString:@"numeprenume"]) {
            if(DATEUSER[@"U_prenume"] && DATEUSER[@"U_nume"]) {
                NSString *U_prenume=  [NSString stringWithFormat:@"%@",DATEUSER[@"U_prenume"]];
                NSString *U_nume=  [NSString stringWithFormat:@"%@",DATEUSER[@"U_nume"]];
                [dic2 setObject:U_prenume forKey:@"first_name"];
                [dic2 setObject:U_nume forKey:@"last_name"];
            }
        }
        if([tip_date isEqualToString:@"telefon"]) {
             NSString *U_telefon =@"";
             NSString *U_telefon2 =@"";
             NSString *U_telefon3 =@"";
             NSString *U_telefon4 =@"";
            if(DATEUSER[@"U_telefon"]) {
                U_telefon=  [NSString stringWithFormat:@"%@",DATEUSER[@"U_telefon"]];
                [dic2 setObject:U_telefon forKey:@"phone1"];
            }
            if(DATEUSER[@"U_telefon2"]) {
              U_telefon2=  [NSString stringWithFormat:@"%@",DATEUSER[@"U_telefon2"]];
                [dic2 setObject:U_telefon2 forKey:@"phone2"];
            }
            if(DATEUSER[@"U_telefon3"]) {
               U_telefon3=  [NSString stringWithFormat:@"%@",DATEUSER[@"U_telefon3"]];
                [dic2 setObject:U_telefon3 forKey:@"phone3"];
            }
            if(DATEUSER[@"U_telefon4"]) {
               U_telefon4=  [NSString stringWithFormat:@"%@",DATEUSER[@"U_telefon4"]];
                [dic2 setObject:U_telefon4 forKey:@"phone4"];
            }
        }
        if([tip_date isEqualToString:@"codpostal"]) {
            if(DATEUSER[@"U_cod_postal"]) {
                NSString *U_cod_postal=  [NSString stringWithFormat:@"%@",DATEUSER[@"U_cod_postal"]];
                [dic2 setObject:U_cod_postal forKey:@"zip_code"];
                NSLog(@"zipzip %@",U_cod_postal);
            }
        }
        if([tip_date isEqualToString:@"adresa"]) {
            if(DATEUSER[@"U_adresa"]) {
                NSString *U_adresa=  [NSString stringWithFormat:@"%@",DATEUSER[@"U_adresa"]];
                [dic2 setObject:U_adresa forKey:@"address"];
            }
        }
        
        NSDictionary *userd =[DataMasterProcessor getLOGEDACCOUNT];
        
        /*PARAMETRII:  (cel putin una dintre)
         - first_name
         - last_name
         - localitate_id
         - address
         - zip_code
         - phone1
         - notify: 1=app, 2=email, 3=app + email*/
        
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic2 options:0 error:&err];
        NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        compus =[NSString stringWithFormat:@"%@%@",METODA_EDIT_PROFILE, myString];
        
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
                    eroare =   [erori componentsJoinedByString:@" "];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                        message:eroare
                                                                       delegate:nil
                                                              cancelButtonTitle:@"Ok"
                                                              otherButtonTitles:nil];
                    [alertView show];
                }   else  if(  REZULTAT_NOTIFY_COUNT[@"data"]) {
                    NSDictionary *multedate = REZULTAT_NOTIFY_COUNT[@"data"];
                    NSLog(@"date EDIT  /SEND  PROFILE raspuns %@",multedate);
                    NSMutableArray *raspuns = [[NSMutableArray alloc]init];
                    for (NSString *key in multedate) {
                        [raspuns addObject:key];
                    }
                    if(raspuns.count ==0) {
                        NSLog(@"succes");
                        if([tip_date isEqualToString:@"numeprenume"]) {
                            NSMutableDictionary *modat = [NSMutableDictionary dictionaryWithDictionary:userd];
                            NSString *prenume = [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"first_name"]];
                            NSString *nume=  [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"last_name"]];
                            
                            [modat setObject:prenume forKey:@"U_prenume"];
                            [modat setObject:nume forKey:@"U_nume"];
                            [DataMasterProcessor updateUsers:modat];
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                        if([tip_date isEqualToString:@"telefon"]){
                            NSMutableDictionary *modat = [NSMutableDictionary dictionaryWithDictionary:userd];
                            NSString *telefon = [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"phone1"]];
                            [modat setObject:telefon forKey:@"U_telefon"];
                            NSString *telefon2 = [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"phone2"]];
                            [modat setObject:telefon2 forKey:@"U_telefon2"];
                            NSString *telefon3 = [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"phone3"]];
                            [modat setObject:telefon3 forKey:@"U_telefon3"];
                            NSString *telefon4 = [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"phone4"]];
                            [modat setObject:telefon4 forKey:@"U_telefon4"];
                            [DataMasterProcessor updateUsers:modat];
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                        if([tip_date isEqualToString:@"codpostal"]) {
                            NSMutableDictionary *modat = [NSMutableDictionary dictionaryWithDictionary:userd];
                            NSString *U_cod_postal=  [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"zip_code"]];
                            [modat setObject:U_cod_postal forKey:@"U_cod_postal"];
                            [DataMasterProcessor updateUsers:modat];
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                        if([tip_date isEqualToString:@"adresa"]) {
                            NSMutableDictionary *modat = [NSMutableDictionary dictionaryWithDictionary:userd];
                            NSString *U_adresa=  [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"address"]];
                            [modat setObject:U_adresa forKey:@"U_adresa"];
                            [DataMasterProcessor updateUsers:modat];
                            [self.navigationController popViewControllerAnimated:YES];
                        }
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

-(void)viewWillDisappear:(BOOL)animated {
    [[self view] endEditing:YES];
}
@end


