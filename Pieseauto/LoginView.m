//
//  LoginView.m -> un view cu 2 textfields mail parola
//  Pieseauto
//
//  Created by Ioan Ungureanu on 21/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
#import "utile.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"
#import "LoginView.h"
#import "CellLoginRow.h"
#import "TutorialHomeViewController.h"
#import <CoreText/CoreText.h>
#import "WebViewController.h"
#import "choose4view.h"
#import "Reachability.h"
#import "butoncustomback.h"

@interface LoginView(){
    NSMutableArray* Cells_Array;
}
@end

@implementation LoginView
@synthesize  LISTASELECT,titluriCAMPURI,CE_TIP_E,DEACORD;
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
    NSLog(@"login view");
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

    DEACORD =NO;
    self.titluriCAMPURI =[[NSMutableArray alloc]init];
    
    self.CE_TIP_E = CE_TIP_E;
    if([CE_TIP_E isEqualToString:@"Login"]) {
        self.titluriCAMPURI =@[@"",@"Adresa de e-mail sau utilizator",@"Parola",@"Am uitat parola", @"Login"];
    } else
        if([CE_TIP_E isEqualToString:@"Register"]) {
            self.titluriCAMPURI =@[@"",@"Adresa de e-mail",@"Număr telefon",@"Sunt de acord cu Termenii și condițiile", @"Creează cont"];
    }
    [self removehud];
}
-(void)addhud{
    [MBProgressHUD showHUDAddedTo:self.navigationController.visibleViewController.view animated:YES];
}
-(void)removehud{
    [MBProgressHUD hideAllHUDsForView:self.navigationController.visibleViewController.view animated:YES];
}


-(void)verificaDoLoginSauRegister {
    utilitar=[[Utile alloc] init];
    NSMutableDictionary *EMAILPASSWORD =[[NSMutableDictionary alloc]init]; //login
    NSMutableDictionary *EMAILTELEFON =[[NSMutableDictionary alloc]init]; //register
    BOOL ok =NO;
    BOOL ok2 =NO;
    BOOL ok3 =NO;
    NSString *EMAIL = @"";
    NSString *TELEFON = @"";
    NSString *PASSWORD = @"";
    NSString *eroareEMAILTELEFON =@"";
    NSString *eroareEMAILPASSWORD =@"";
    
    NSArray *cells = [self.LISTASELECT visibleCells];
    NSString *eroareemail= @"Completați câmpul E-mail";
    NSString *eroaretelefon= @"Completați câmpul Telefon!";
    NSString *eroarePAROLA= @"Completați câmpul Parola!";
    for(UIView *view in cells){
        if([view isMemberOfClass:[CellLoginRow class]]){
            CellLoginRow *cell = (CellLoginRow *) view;
            UITextField *tf = (UITextField *)[cell texteditabil];
            if([CE_TIP_E isEqualToString:@"Login"]) {
                if(tf.tag == 11 && ![self MyStringisEmpty:tf.text]  ) {
                    ok =YES;
                    EMAIL = [NSString stringWithFormat:@"%@",tf.text];
                    eroareemail =@"";
                } else  if(tf.tag == 12  && ![self MyStringisEmpty:tf.text] ) {
                    ok2 =YES;
                    PASSWORD = [NSString stringWithFormat:@"%@",tf.text];
                    eroarePAROLA= @"";
                }
            } else  if([CE_TIP_E isEqualToString:@"Register"]) {
                if(tf.tag == 11 && ![self MyStringisEmpty:tf.text] /*&& [self isValidEmail:tf.text] */ ) {
                    ok =YES;
                    EMAIL = [NSString stringWithFormat:@"%@",tf.text];
                    eroareemail =@"";
                } else  if(tf.tag == 12  && ![self MyStringisEmpty:tf.text] /*&& [self isValidPhone:tf.text]*/ ) {
                    ok2 =YES;
                    TELEFON = [NSString stringWithFormat:@"%@",tf.text];
                    eroaretelefon= @"";
                }
            }
        }
    }
    ok3= ok && ok2;
    if(!ok3) {
        if([CE_TIP_E isEqualToString:@"Login"]) {
            eroareEMAILPASSWORD =[NSString stringWithFormat:@"%@ %@", eroareemail, eroarePAROLA];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                message:eroareEMAILPASSWORD
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alertView show];
        } else
            if([CE_TIP_E isEqualToString:@"Register"]) {
                eroareEMAILTELEFON =[NSString stringWithFormat:@"%@ %@", eroareemail, eroaretelefon];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                    message:eroareEMAILTELEFON
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                [alertView show];
            }
        
    } else {
        if([CE_TIP_E isEqualToString:@"Login"]) {
            [EMAILPASSWORD setObject:EMAIL forKey:@"email"];
            [EMAILPASSWORD setObject:PASSWORD forKey:@"password"];
            
            NSLog(@"rmail PASS %@", EMAILPASSWORD);
            [utilitar doLoginOrRegister:@"Login" :EMAILPASSWORD];
        } else
            if([CE_TIP_E isEqualToString:@"Register"]) {
                if(!DEACORD) {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                        message:@"Trebuie sa fii de acord cu termenii și condițiile"
                                                                       delegate:nil
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
                    [alertView show];
                } else {
                    [EMAILTELEFON setObject:EMAIL forKey:@"email"];
                    [EMAILTELEFON setObject:TELEFON forKey:@"tel"];
                    
                    NSLog(@"rmail tel %@", EMAILTELEFON);
                    [utilitar doLoginOrRegister:@"Register" :EMAILTELEFON];
                }
                
            }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    LISTASELECT.delegate =self;
    LISTASELECT.dataSource =self;
    LISTASELECT.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
       [self.navigationController setNavigationBarHidden:NO]; self.navigationItem.leftBarButtonItem=nil;
    self.CE_TIP_E = CE_TIP_E;
    if([CE_TIP_E isEqualToString:@"Login"]) {
        self.title = @"Login";
    } else
        if([CE_TIP_E isEqualToString:@"Register"]) {
            self.title = @"Creează cont";
        }
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger ceva =indexPath.row;
    int cellHeightcustom =0;
    if(ceva ==0) {   cellHeightcustom =14; }
    else if(ceva==3) {
        if([CE_TIP_E isEqualToString:@"Login"]) {
            cellHeightcustom =40;
        } else
            if([CE_TIP_E isEqualToString:@"Register"]) {
                cellHeightcustom =60;
            }
        
    } else {
        cellHeightcustom =46;
    }
    return cellHeightcustom;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int ipx = (int)indexPath.row;
    
    static NSString *CellIdentifier = @"CellLoginRow";
    CellLoginRow *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (CellLoginRow*)[tableView dequeueReusableCellWithIdentifier:@"CellLoginRow"];
    }
    cell.TitluRandlogin.hidden =YES;
    cell.suntDeAcord.hidden=YES;
    cell.suntDeAcord.userInteractionEnabled=NO;
    cell.texteditabil.tag =ipx +10;
    switch (ipx) {
        case 0: {
            cell.backgroundColor = [UIColor colorWithRed:(240/255.0f) green:(240/255.0f) blue:(240/255.0f) alpha:1];
            cell.pozaRow.hidden =YES;
            cell.TitluRand.textColor =  [UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] ;
            cell.TitluRand.text =[NSString stringWithFormat:@"%@",[self.titluriCAMPURI objectAtIndex:ipx]];
            cell.sageatablue.hidden =YES;
            cell.pozaRow.hidden=YES;
            cell.texteditabil.hidden=YES;
            cell.texteditabil.userInteractionEnabled =NO;
            break;
        }
        case 1: {
            cell.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1];
            cell.pozaRow.hidden =YES;
            cell.TitluRand.hidden=YES;
            cell.texteditabil.hidden=NO;
            cell.texteditabil.placeholder =[NSString stringWithFormat:@"%@",[self.titluriCAMPURI objectAtIndex:ipx]];
            cell.sageatablue.hidden =YES;
            cell.pozaRow.hidden=YES;
            cell.texteditabil.userInteractionEnabled =YES;
            cell.texteditabil.textColor =[UIColor darkGrayColor];
            
            cell.texteditabil.delegate =self;
            NSLog(@"DDD %@", cell.texteditabil.text);
            [cell.contentView bringSubviewToFront:cell.texteditabil];
            [cell.texteditabil becomeFirstResponder];
            [cell.texteditabil setKeyboardType:UIKeyboardTypeEmailAddress];
             break;

        }
            
        
        case 2: {
            cell.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1];
            cell.pozaRow.hidden =YES;
            cell.TitluRand.hidden=YES;
            cell.texteditabil.hidden=NO;
            cell.texteditabil.placeholder =[NSString stringWithFormat:@"%@",[self.titluriCAMPURI objectAtIndex:ipx]];
            cell.sageatablue.hidden =YES;
            cell.pozaRow.hidden=YES;
            cell.texteditabil.userInteractionEnabled =YES;
            cell.texteditabil.textColor =[UIColor darkGrayColor];
            
            cell.texteditabil.delegate =self;
            NSLog(@"DDD %@", cell.texteditabil.text);
            [cell.contentView bringSubviewToFront:cell.texteditabil];
            if([CE_TIP_E isEqualToString:@"Login"]) {
            [cell.texteditabil setKeyboardType:UIKeyboardTypeEmailAddress];
            cell.texteditabil.secureTextEntry =YES;
            }else if([CE_TIP_E isEqualToString:@"Register"]) {
            [cell.texteditabil setKeyboardType:UIKeyboardTypePhonePad]; //pentru ca la telefon poate avea + etc
            }
            
            break;
        }
        case 3: {
            cell.backgroundColor = [UIColor colorWithRed:(240/255.0f) green:(240/255.0f) blue:(240/255.0f) alpha:1];
            cell.pozaRow.hidden =YES;
            cell.sageatablue.hidden =YES;
            cell.pozaRow.contentMode =UIViewContentModeScaleAspectFit;
            if([CE_TIP_E isEqualToString:@"Login"]) {
                cell.pozaRow.hidden=NO;
              //////JMOD  cell.pozaRow.image = [UIImage imageNamed:@"Icon_Ajutor_144x144.png"];
                cell.pozaRow.image = [UIImage imageNamed:@"Icon_Am_Uitat_Parola_144x144.png"];
                cell.TitluRand.textColor =  [UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] ;
                cell.TitluRand.text =[NSString stringWithFormat:@"%@",[self.titluriCAMPURI objectAtIndex:ipx]];
            } else
                if([CE_TIP_E isEqualToString:@"Register"]) {
                    NSString * suntdeAc = @"Sunt de acord cu ";
                    NSString * term = @"Termenii și condițiile";
                    NSString *textulMeu = [NSString stringWithFormat:@"%@ %@",suntdeAc,term];
                    NSRange greyRange = [textulMeu rangeOfString:suntdeAc];
                    NSRange blueRange = [textulMeu rangeOfString:term];
                    NSMutableAttributedString * attributedString= [[NSMutableAttributedString alloc] initWithString:textulMeu];
                    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:greyRange];
                    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] range:blueRange];
                    cell.TitluRand.attributedText =attributedString;
                    cell.TitluRand.numberOfLines =0;
                    [cell.TitluRand setFont: [UIFont boldSystemFontOfSize:16]];
                    cell.suntDeAcord.hidden=NO;
                    cell.suntDeAcord.userInteractionEnabled=YES;
                    cell.pozaRow.hidden =YES;
                    cell.suntDeAcord.selected=YES;
                    [cell.suntDeAcord setImage:[UIImage imageNamed:@"Checkbox_unchecked_blue_72x72.png"] forState:UIControlStateNormal];
                    [cell.suntDeAcord setImage:[UIImage imageNamed:@"Checkbox_checked_blue_72x72.png"] forState:UIControlStateSelected];
                    cell.suntDeAcord.imageView.contentMode =UIViewContentModeScaleAspectFit;
                    UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(suntDeAcordAction:)];
                    [singleTap setNumberOfTapsRequired:1];
                    [cell.suntDeAcord addGestureRecognizer:singleTap];
                }
            cell.texteditabil.hidden=YES;
            cell.texteditabil.userInteractionEnabled =NO;
            break;
        }
        case 4: {
            cell.texteditabil.hidden=YES;
            cell.TitluRandlogin.text =[NSString stringWithFormat:@"%@",[self.titluriCAMPURI objectAtIndex:ipx]];
            cell.texteditabil.userInteractionEnabled =NO;
            cell.sageatablue.hidden =NO;
            cell.pozaRow.hidden=YES;
            cell.TitluRand.hidden=YES;
            cell.TitluRandlogin.hidden =NO;
            break;
        }
        default:
            break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(IBAction)suntDeAcordAction:(id)sender {
    UIButton* button = (UIButton*) [(UIGestureRecognizer *)sender view];
    button.selected = !button.selected;
    NSLog(@"bifa");
    NSLog(@"ecran3");
    if( button.selected) {
        DEACORD =YES;
    } else {
        DEACORD =NO;
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // [LISTASELECT cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int ipx = (int)indexPath.row;
    switch (ipx) {
        case 0: {
            NSLog(@"nothing to do");
            break;
        }
        case 1: {
            break;
        }
        case 2: {
            //
            break;
        }
        case 3: {
            if([CE_TIP_E isEqualToString:@"Login"]) {
                NSLog(@"a uitat parola");
                choose4view *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Choose4VC"];
                vc.CE_TIP_E =@"amuitatparola";
                [self.navigationController pushViewController:vc animated:YES ];
            
            } else if([CE_TIP_E isEqualToString:@"Register"]) {
                NSLog(@"termeni si conditii");
                WebViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewVC"];
                vc.title=@"Termeni si condiții";
                AppDelegate * del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                NSUserDefaults *prefs=[NSUserDefaults standardUserDefaults];
                
                
                if(del.URL_terms && ![self MyStringisEmpty:del.URL_terms]) {
                    
                   
                    vc.urlPiesesimilare = [NSString stringWithFormat:@"%@&os=ios",del.URL_terms];
                    vc.mWebView.scalesPageToFit=YES;
                    [self addhud];
                    dispatch_async(dispatch_get_main_queue(), ^{
                    [self.navigationController pushViewController:vc animated:NO ];
                         });
                } else if([prefs objectForKey:@"url_terms"] && ![self MyStringisEmpty:[NSString stringWithFormat:@"%@",[prefs objectForKey:@"url_terms"]]]) {
                    vc.urlPiesesimilare = [NSString stringWithFormat:@"%@&os=ios",[prefs objectForKey:@"url_terms"]];
                    vc.mWebView.scalesPageToFit=YES;
                    [self addhud];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.navigationController pushViewController:vc animated:NO ];
                    });
                } else {
                    NSLog(@"nu avem termeni si conditii");
                }
                
                
            }
            break;
        }
        case 4: {
            //verifica rows si do login sau register
            [self verificaDoLoginSauRegister];
            break;
        }
            
        default:
            break;
    }
}
-(void)inchideTastatura{
    NSArray *cells = [self.LISTASELECT visibleCells];
    for(UIView *view in cells){
        if([view isMemberOfClass:[CellLoginRow class]]){
            CellLoginRow *cell = (CellLoginRow *) view;
            UITextField *tf = (UITextField *)[cell texteditabil];
            [tf resignFirstResponder];
        }
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    switch ((int)textField.tag) {
        case 10:
        {
            NSLog(@"nothing");
            
        }
            break;
        case 11:
        {
            NSLog(@"email");
        }
            break;
        case 12:
        {
            NSLog(@"parola");
            if([CE_TIP_E isEqualToString:@"Login"]) {
            textField.secureTextEntry =YES;
            }
            break;
        }
            
            
        default:
            break;
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

@end


