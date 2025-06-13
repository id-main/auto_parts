//
//  EcranFormularComanda.m
//  Pieseauto
//
//  Created by Ioan Ungureanu on 30/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//
#import "utile.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"
#import "EcranFormularComanda.h"
#import "CellFormularComanda.h"
#import "TutorialHomeViewController.h"
#import <CoreText/CoreText.h>
#import "chooseview.h"
#import "choose4view.h"
#import "EcranAdresaViewController.h"
#import "Reachability.h"
#import "EcranComandaTrimisaViewController.h"
#import "butoncustomback.h"

@interface EcranFormularComanda(){
    NSMutableArray* Cells_Array;
}
@end

@implementation EcranFormularComanda
@synthesize  LISTASELECT,titluriCAMPURI,dinmodificari,detaliuoferta,METODEDEPLATA,salveazadateprofil,METODELIVRARE,STRINGOBSERVATII;
double cellheightmodificatcomanda =70; // !important

-(void)viewDidAppear:(BOOL)animated {
 

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
    
    self.title = @"Formular comandă";
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
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSLog(@"ecran formular comanda");
    self.detaliuoferta =detaliuoferta;
    NSLog(@"detaliuoferta %@",detaliuoferta);
    self.titluriCAMPURI =[[NSMutableArray alloc]init];
    NSDictionary *userd = [[NSDictionary alloc]init];
    if([del.CLONADATEUSER objectForKey:@"U_authtoken"] && ![self MyStringisEmpty:[NSString stringWithFormat:@"%@",[del.CLONADATEUSER objectForKey:@"U_authtoken"]]]) {
        userd =[NSDictionary dictionaryWithDictionary: del.CLONADATEUSER];
        NSLog(@"avem date acum %@", userd);
    } else {
        userd = [DataMasterProcessor getLOGEDACCOUNT];
        del.CLONADATEUSER = [NSMutableDictionary dictionaryWithDictionary:userd];
    }
    del.modificariDateComanda=YES;
    
    NSString *U_prenume=@"";
    NSString *U_nume=@"";
    //  NSString *U_telefon=@"";
    NSString *U_judet=@"";
    NSString *U_localitate=@"";
    NSString *U_cod_postal=@"";
    NSString *U_adresa=@"";
    
    NSString *JUDETNAME = @"";
    NSString *LOCALITATENAME = @"";
    
    if(![self MyStringisEmpty:[NSString stringWithFormat:@"%@",userd[@"U_prenume"]]])        U_prenume=  [NSString stringWithFormat:@"%@",userd[@"U_prenume"]];
    if(![self MyStringisEmpty:[NSString stringWithFormat:@"%@",userd[@"U_nume"]]])           U_nume=  [NSString stringWithFormat:@"%@",userd[@"U_nume"]];
    //   if(![self MyStringisEmpty:[NSString stringWithFormat:@"%@",userd[@"U_telefon"]]])        U_telefon=  [NSString stringWithFormat:@"%@",userd[@"U_telefon"]];
    if(![self MyStringisEmpty:[NSString stringWithFormat:@"%@",userd[@"U_judet"]]])          U_judet=  [NSString stringWithFormat:@"%@",userd[@"U_judet"]];
    if(![self MyStringisEmpty:[NSString stringWithFormat:@"%@",userd[@"U_localitate"]]])     U_localitate=  [NSString stringWithFormat:@"%@",userd[@"U_localitate"]];
    if(![self MyStringisEmpty:[NSString stringWithFormat:@"%@",userd[@"U_cod_postal"]]])     U_cod_postal=  [NSString stringWithFormat:@"%@",userd[@"U_cod_postal"]];
    if(![self MyStringisEmpty:[NSString stringWithFormat:@"%@",userd[@"U_adresa"]]])         U_adresa=  [NSString stringWithFormat:@"%@",userd[@"U_adresa"]];
    
    NSDictionary *judbaza = [DataMasterProcessor getJudet:U_judet];
    if(judbaza && judbaza[@"name"]) {
        JUDETNAME = [NSString stringWithFormat:@"%@",judbaza[@"name"]];
    }
    NSString *LOCALITATE = [NSString stringWithFormat:@"%@",U_localitate];
    
    NSDictionary *LOCALITATEselectata = [DataMasterProcessor getLocalitate:LOCALITATE];
    
    if(LOCALITATEselectata && LOCALITATEselectata[@"name"]) {
        LOCALITATENAME = [NSString stringWithFormat:@"%@",LOCALITATEselectata[@"name"]];
    }
    
    self.RANDURIOFERTA=[[NSMutableArray alloc]init];
    
    if(self.detaliuoferta[@"items"]) {
        self.RANDURIOFERTA =[NSMutableArray arrayWithArray:self.detaliuoferta[@"items"]];
    }
    
    
    
    /* shipping =         {
     "ship_courier_price" = 0;
     "ship_free_shipping" = 0;
     "ship_generic_shipping" = "";
     "ship_handling_time" = 1;
     "ship_method_courier" = 0;
     "ship_method_local_delivery" = 1;
     "ship_method_posta" = 0;
     "ship_posta_free_shipping" = 0;
     "ship_posta_price" = 0;
     };
     */
    /*
     payment =         (
     {
     id = 8;
     name = Ramburs;
     title = "_plata_ramburs";
     },
     {
     id = 4;
     name = "La livrare";
     title = "_money_order";
     },
     {
     id = 6;
     name = "Transfer Bancar";
     title = "_transfer_bancar";
     },
     {
     id = 7;
     name = "Card Bancar";
     title = "_card_credit";
     }
     );     */
    
    //sectiuni pentru ca avem iar mai multe rows pe diferite nivele.
    
    
    NSArray *dateclientarray = @[@"Date client",U_prenume,U_nume];
    
    //  NSArray *telefonarray = @[@"Telefon",U_telefon];
    
    NSArray *adresalivrarearray = @[@"Adresa de livrare",JUDETNAME,LOCALITATENAME,U_cod_postal,U_adresa];
    NSArray *observatiiearray = @[@"Observații suplimentare",@""];
    
    NSArray *ultimulrow = @[@""];
    
    NSString *modlivrare=@"";
    // NSString *costlivrare =@"";
    //    if(self.detaliuoferta[@"offer_extra_info"][@"shipping"]) {
    //        NSDictionary *modalitatepretlivrare = [NSDictionary dictionaryWithDictionary:self.detaliuoferta[@"offer_extra_info"][@"shipping"]];
    //        if(modalitatepretlivrare[@"ship_courier_price"]) costlivrare = [NSString stringWithFormat:@"%@",modalitatepretlivrare[@"ship_courier_price"]];
    //        if(modalitatepretlivrare[@"ship_method_courier"]) modlivrare = [NSString stringWithFormat:@"%@",modalitatepretlivrare[@"ship_method_courier"]];
    //    }
    /*
     shipping =     (
     {
     name = "Ridicare personal\U0103";
     type = "local_delivery";
     }
     */
    
    self.METODELIVRARE =METODELIVRARE;
    NSLog(@"METODELIVRARE %@",METODELIVRARE);
    // test it first [del.MODPLATATEMPORAR setObject:@"toatemetodele" forKey:@"name"];
    if(del.MODLIVRARETEMPORAR && ![self MyStringisEmpty:[NSString stringWithFormat:@"%@", del.MODLIVRARETEMPORAR[@"name"]]]) {
        modlivrare =[NSString stringWithFormat:@"%@",del.MODLIVRARETEMPORAR[@"name"]];
    } else {
        if(self.METODELIVRARE.count ==1) {
            NSDictionary *modLIVRARE = [NSDictionary dictionaryWithDictionary:[self.METODELIVRARE objectAtIndex:0]];
            del.MODLIVRARETEMPORAR =[NSMutableDictionary dictionaryWithDictionary:modLIVRARE];
            if(modLIVRARE[@"name"]) {
                modlivrare =[NSString stringWithFormat:@"%@",modLIVRARE[@"name"]];
            }
        }
    }
    NSArray *modlivrarearray = @[@"Modalitate și cost livrare",modlivrare];
    
    // NSString *modplata=@"";
    /*  self.METODEDEPLATA =[[NSMutableArray alloc]init];
     NSMutableArray *modalitatedeplata = [[NSMutableArray alloc]init];
     if(self.detaliuoferta[@"offer_extra_info"][@"payment"]) {
     modalitatedeplata = [NSMutableArray arrayWithArray:self.detaliuoferta[@"offer_extra_info"][@"payment"]];
     self.METODEDEPLATA=modalitatedeplata;
     }
     */
    //test it first [del.MODPLATATEMPORAR setObject:@"toatemetodele" forKey:@"name"];
    /*   if(del.MODPLATATEMPORAR && ![self MyStringisEmpty:[NSString stringWithFormat:@"%@", del.MODPLATATEMPORAR[@"name"]]]) {
     modplata =[NSString stringWithFormat:@"%@",del.MODPLATATEMPORAR[@"name"]];
     } else {
     if(modalitatedeplata.count ==1) {
     NSDictionary *modpayment = [NSDictionary dictionaryWithDictionary:[modalitatedeplata objectAtIndex:0]];
     del.MODPLATATEMPORAR =[NSMutableDictionary dictionaryWithDictionary:modpayment];
     if(modpayment[@"name"]) {
     modplata =[NSString stringWithFormat:@"%@",modpayment[@"name"]];
     }
     }
     }
     NSArray *modplataarray = @[@"Modalitate de plată",modplata];
     */
    self.titluriCAMPURI = [[NSArray alloc]init];
    //telefonarray modplataarray
    self.titluriCAMPURI =@[self.RANDURIOFERTA,modlivrarearray,dateclientarray,adresalivrarearray,observatiiearray,ultimulrow];
    LISTASELECT.delegate =self;
    LISTASELECT.dataSource =self;
    LISTASELECT.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    //  self.navigationController.delegate =self;
    [LISTASELECT reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    salveazadateprofil=YES;
    self.title = @"Formular comandă";
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets;
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize.height), 0.0);
    } else {
        contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize.width), 0.0);
    }
    self.LISTASELECT.contentInset = contentInsets;
    self.LISTASELECT.scrollIndicatorInsets = contentInsets;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:4]; // sa urce peste keyboard
    [self.LISTASELECT scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
- (void)keyboardWillHide:(NSNotification *)notification
{
    self.LISTASELECT.contentInset = UIEdgeInsetsMake(0, 0, 0, 0) ; //are nav bar
    NSIndexPath *pathToLastRow = [NSIndexPath indexPathForRow:0 inSection:4];
    [self.LISTASELECT scrollToRowAtIndexPath:pathToLastRow
                            atScrollPosition:UITableViewScrollPositionTop
                                    animated:NO];
}
//- (void)keyboardWillHide:(NSNotification *)notification
//{
//
//    self.LISTASELECT.contentInset = UIEdgeInsetsMake(self.navigationController.navigationBar.frame.size.height, 0, 0, 0) ; //are nav bar
//    self.LISTASELECT.scrollIndicatorInsets = UIEdgeInsetsMake(self.navigationController.navigationBar.frame.size.height, 0 , 0, 0) ;
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:3];
//    [self.LISTASELECT scrollToRowAtIndexPath:indexPath
//                            atScrollPosition:UITableViewScrollPositionTop
//                                    animated:NO];
//}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [[self.titluriCAMPURI objectAtIndex:section]count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    int hforr =0;
    
    if([indexPath section]== 0){
       // hforr = 110;
        NSInteger ipx = indexPath.row;
        NSArray *itemuri = [NSArray arrayWithArray:[self.titluriCAMPURI objectAtIndex:0]]; //randuri oferta
        NSDictionary *delucru = [itemuri objectAtIndex:ipx];
        NSString *TITLUOFERTA = [NSString stringWithFormat:@"%@", delucru[@"description"]];
        CGFloat widthWithInsetsApplied = self.view.frame.size.width -20;
        CGSize textSize = [TITLUOFERTA boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16]} context:nil].size;
        double inaltimerand= textSize.height;
        UIFont *tester = [UIFont boldSystemFontOfSize:16];
        double numberOfLines = textSize.height /tester.pointSize;
        if(numberOfLines <2) {
            inaltimerand = 44;
            hforr = inaltimerand +50 ; //pentru ca are si pret
        } else {
            hforr = inaltimerand+70;
        }

    }
    if(indexPath.section == 1  ) { //label metoda livrare
        if(indexPath.row == 0){
            hforr = 42;
        } else {
            hforr = 40;
        }
    }
    
    if( indexPath.section == 2 ) { //label nume prenume
        if(indexPath.row == 0){
            hforr = 42;
        } else {
            hforr = 40;
        }
    }
    if(indexPath.section == 3) {
        if(indexPath.row == 0){
            hforr = 42;
        } else  if(indexPath.row == 4){//label adresa mai inalt... mai multe linii etcv dymanic adresa
       ///////     hforr = 110;
            NSInteger ipx = indexPath.row;
            NSArray *itemuri = [NSArray arrayWithArray:[self.titluriCAMPURI objectAtIndex:3]];
            NSString *adresalabel =@"Adresa:";
            NSString *verificatext =[NSString stringWithFormat:@"%@",[itemuri objectAtIndex:ipx]];
          
            NSString *ADRESAlabelsitext= [NSString stringWithFormat:@"%@ %@",adresalabel, verificatext];
            CGFloat widthWithInsetsApplied = self.view.frame.size.width -15;
            CGSize textSize = [ADRESAlabelsitext boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16]} context:nil].size;
            double inaltimerand= textSize.height;
            UIFont *tester = [UIFont boldSystemFontOfSize:16];
            double numberOfLines = textSize.height /tester.pointSize;
            if(numberOfLines <2) {
                hforr = 80; // pentru ca are si label de salveaza la
            } else {
               hforr = inaltimerand+140;
            }

        } else {
            hforr = 40;
        }
    }
    if(indexPath.section == 4) { //text suplimentar (optional)
        if(indexPath.row == 0){
            hforr = 42;
        }  else {
           // hforr = 110; //dynamic textview height
            hforr =cellheightmodificatcomanda;
        }
    }
    if(indexPath.section == 5) {
        hforr = 96;
    }
    return hforr;
    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
//    
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//    }
}
-(void)viewDidLayoutSubviews
{
    if ([self.LISTASELECT respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.LISTASELECT setSeparatorInset:UIEdgeInsetsZero];
    }
//    
//    if ([self.LISTASELECT respondsToSelector:@selector(setLayoutMargins:)]) {
//        [self.LISTASELECT setLayoutMargins:UIEdgeInsetsZero];
//    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //  return 1;
    return self.titluriCAMPURI.count;
}
-(IBAction)MODIFICARE_CAMPURI:(id)sender {
    UITapGestureRecognizer *gesture = (UITapGestureRecognizer *) sender;
    NSLog(@"Tag = %ld", (long)gesture.view.tag);
    int ipx = (int)gesture.view.tag;
    NSLog(@"si ipx %i", ipx);
}
-(IBAction)debifeaza:(id)sender {
    UIButton* button = (UIButton*) [(UIGestureRecognizer *)sender view];
    button.selected = !button.selected;
    //= ipx+100;
    if(button.selected) { salveazadateprofil =YES;} else {
        salveazadateprofil =NO;
    }
    NSLog(@"bifa tag %li %i",(long)button.tag,salveazadateprofil);
    
}
-(void)mergiBack {
    //intotdeauna la ecranul principal pentru ca aici ajunge numai dupa ce a facut cerere completa
    TutorialHomeViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TutorialHomeVC"];
    [self.navigationController pushViewController:vc animated:NO ];
}
-(IBAction)trimiteComandaAction:(id)sender {
    NSLog(@"verifica tot");
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    utilitar = [[Utile alloc]init];
    NSString *authtoken=@"";
    BOOL elogat = NO;
    elogat = [utilitar eLogat];
    if(elogat) {
        authtoken = [utilitar AUTHTOKEN];
    }
    NSLog(@"SAVE PROFILE %@",del.CLONADATEUSER);
    NSMutableDictionary *VERIFICAUSER=del.CLONADATEUSER;
    NSString *U_prenume =@"";
    NSString *U_nume =@"";
    //   NSString *U_telefon =@"";
    NSString *U_judet =@"";
    NSString *U_localitate =@"";
    NSString *U_cod_postal =@"";
    NSString *U_adresa =@"";
    NSString *modlivrare =@"";
    NSString *tiplivrare =@"";
    BOOL ok=NO;
    if([VERIFICAUSER  objectForKey:@"U_prenume"])  U_prenume= [NSString stringWithFormat:@"%@",[VERIFICAUSER  objectForKey:@"U_prenume"]];
    if([VERIFICAUSER  objectForKey:@"U_nume"])  U_nume= [NSString stringWithFormat:@"%@",[VERIFICAUSER  objectForKey:@"U_nume"]];
    //// if([VERIFICAUSER  objectForKey:@"U_telefon"])   U_telefon= [NSString stringWithFormat:@"%@",[VERIFICAUSER  objectForKey:@"U_telefon"]]; ///txtfld 1
    if([VERIFICAUSER  objectForKey:@"U_judet"])   U_judet=[NSString stringWithFormat:@"%@",[VERIFICAUSER  objectForKey:@"U_judet"]];
    if([VERIFICAUSER  objectForKey:@"U_localitate"]) U_localitate=[NSString stringWithFormat:@"%@",[VERIFICAUSER  objectForKey:@"U_localitate"]]; ///txtfld 2
    if([VERIFICAUSER  objectForKey:@"U_cod_postal"]) U_cod_postal=[NSString stringWithFormat:@"%@",[VERIFICAUSER  objectForKey:@"U_cod_postal"]]; ///txtfld 3
    if([VERIFICAUSER  objectForKey:@"U_adresa"]) U_adresa=[NSString stringWithFormat:@"%@",[VERIFICAUSER  objectForKey:@"U_adresa"]];
    if(del.MODLIVRARETEMPORAR && ![self MyStringisEmpty:[NSString stringWithFormat:@"%@", del.MODLIVRARETEMPORAR[@"name"]]]) {
        modlivrare =[NSString stringWithFormat:@"%@",del.MODLIVRARETEMPORAR[@"name"]];
        tiplivrare =[NSString stringWithFormat:@"%@",del.MODLIVRARETEMPORAR[@"type"]];
    }
    //erori
    NSString *EROARE_U_prenume =@"";
    NSString *EROARE_U_nume =@"";
    ///  NSString *EROARE_U_telefon =@"";
    NSString *EROARE_U_judet =@"";
    NSString *EROARE_U_localitate =@"";
    //   NSString *EROARE_U_cod_postal =@"";
    NSString *EROARE_U_adresa =@"";
    NSString *eroaredate =@"";
    NSString *EROARE_modlivrare=@"";
    
    NSMutableArray *erori = [[NSMutableArray alloc]init];
    if([self MyStringisEmpty:U_prenume] )   {       EROARE_U_prenume =@"prenume";       [erori addObject:EROARE_U_prenume];     }
    if([self MyStringisEmpty:U_nume] )      {       EROARE_U_nume =@"nume";             [erori addObject:EROARE_U_nume];        }
    //   if([self MyStringisEmpty:U_telefon] )   {       EROARE_U_telefon =@"telefon";       [erori addObject:EROARE_U_telefon];     }
    if([self MyStringisEmpty:U_judet] )     {       EROARE_U_judet =@"județ";           [erori addObject:EROARE_U_judet];       }
    if([self MyStringisEmpty:U_localitate] ){       EROARE_U_localitate =@"localitate"; [erori addObject:EROARE_U_localitate];  }
    //  if([self MyStringisEmpty:U_cod_postal] ){       EROARE_U_cod_postal =@"cod poștal"; [erori addObject:EROARE_U_cod_postal];  }
    if([self MyStringisEmpty:U_adresa] )    {       EROARE_U_adresa =@"adresa";         [erori addObject:EROARE_U_adresa];      }
    if([self MyStringisEmpty:modlivrare])   {       EROARE_modlivrare =@"mod livrare";  [erori addObject:EROARE_modlivrare];      }
    
    if([self MyStringisEmpty:U_prenume] ||
       [self MyStringisEmpty:U_nume] ||
       //  [self MyStringisEmpty:U_telefon] ||
       [self MyStringisEmpty:U_judet]  ||
       [self MyStringisEmpty:U_localitate]  ||
       // [self MyStringisEmpty:U_cod_postal]  ||
       [self MyStringisEmpty:U_adresa] ||
       [self MyStringisEmpty:modlivrare]) {
        ok =NO;
    } else {
        ok =YES;
    }
    
    
    if(ok == NO) {
        eroaredate = [NSString stringWithFormat:@"Nu ai completat datele necesare pentru: %@ !", [erori componentsJoinedByString:@" , "]];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                            message:eroaredate
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    } else {
        //     //   if(salveazadateprofil ==YES) {
        //             //SAVE PROFILE
        //            //-(void)editProfiledinConfirmaComanda :(NSString *)AUTHTOKEN :(NSMutableDictionary *)DATEUSER
        //            [self editProfiledinConfirmaComanda:authtoken :VERIFICAUSER];
        //            EcranComandaTrimisaViewController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"EcranComandaTrimisaViewControllerVC2"];
        //
        //            AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        //            del.CLONADATEUSER=[[NSMutableDictionary alloc]init];
        //            del.modificariDateComanda=NO;
        //            self.navigationController.delegate =self;
        //               [self.navigationController setNavigationBarHidden:NO]; self.navigationItem.leftBarButtonItem=nil;
        //            self.title = @"Comandă trimisă";
        //            self.navigationItem.backBarButtonItem =
        //            [[UIBarButtonItem alloc] initWithTitle:@"Home"
        //                                             style:UIBarButtonItemStylePlain
        //                                            target:vc
        //                                            action: @selector(mergiBack)];
        //            [self.navigationController pushViewController:vc animated:YES ];
        //        } else {
        
        //set_winning_offer
        //     -(void)setwinningoffer :(NSString *)AUTHTOKEN :(NSMutableDictionary *)DATEUSER :(NSMutableDictionary*)DATECOMANDA{
        NSMutableDictionary *DATECOMANDA =[[NSMutableDictionary alloc]init];
        /*
         - offer_id
         - first_name
         - last_name
         - localitate_id
         - address
         - zip_code
         - save_to_profile: 0 sau 1
         - shipping_type: valoarea din "get_order_form" la shipping[...].type  (ex: local_delivery, courier sau posta)
         - alte_obs: string, optional
         */
        NSString *offer_id =@"";
        NSString *alte_obs =@"";
        NSArray *cells = [self.LISTASELECT visibleCells];
        for(UIView *view in cells){
            if([view isMemberOfClass:[CellFormularComanda class]]){
                CellFormularComanda *cell = (CellFormularComanda *) view;
                UITextView *tf = (UITextView *)[cell textObservatii];
                NSString *textobs = tf.text;
                if(![tf.text isEqualToString:@"Poți adăuga informații suplimentare"] && ![self MyStringisEmpty:textobs]) {
                    alte_obs = [NSString stringWithFormat:@"%@",tf.text];
                    
                }
            }
        }
        [DATECOMANDA setObject:alte_obs forKey:@"alte_obs"];
        if (detaliuoferta[@"messageid"]) offer_id = [NSString stringWithFormat:@"%@",detaliuoferta[@"messageid"]];
        [DATECOMANDA setObject:offer_id forKey:@"offer_id"];
        [DATECOMANDA setObject:tiplivrare forKey:@"shipping_type"];
        
        [self setwinningoffer:authtoken :VERIFICAUSER :DATECOMANDA];
        
        
        
        
        // }
    }
}

//1.
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
-(void)doneWithNumberPad {
    NSInteger ipx=1;
    NSIndexPath *indexPathreload = [NSIndexPath indexPathForRow:ipx inSection:4];
    CellFormularComanda *updateCell = (CellFormularComanda *)[self.LISTASELECT cellForRowAtIndexPath:indexPathreload];
    if ([updateCell.textObservatii.text isEqualToString:@""]) {
        updateCell.textObservatii.text =  @"Poți adăuga informații suplimentare";
        updateCell.textObservatii.textColor = [UIColor lightGrayColor]; //optional
    } else {
        updateCell.textObservatii.textColor = [UIColor blackColor];
    }
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    del.STRINGOBSERVATII =updateCell.textObservatii.text;
    [updateCell.textObservatii resignFirstResponder];
  //  [self.view endEditing:YES];
}
-(void)textViewDidChange:(UITextView *)textView
{
    NSInteger ipx=1;
    NSIndexPath *indexPathreload = [NSIndexPath indexPathForRow:ipx inSection:4];
    CellFormularComanda *updateCell = (CellFormularComanda *)[self.LISTASELECT cellForRowAtIndexPath:indexPathreload];
    if ([updateCell.textObservatii.text isEqualToString:@""]) {
        updateCell.textObservatii.text =  @"Poți adăuga informații suplimentare";
        updateCell.textObservatii.textColor = [UIColor lightGrayColor]; //optional
        [updateCell.textObservatii resignFirstResponder];
    } else {
        updateCell.textObservatii.textColor = [UIColor blackColor];
    }
    NSLog(@"Dilip : %@",textView.text);
    CGFloat widthWithInsetsApplied = self.view.frame.size.width-20;
    CGSize textSize = [textView.text boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    double inaltimerand= textSize.height;
    updateCell.dynamicheightTEXTVIEW.constant = inaltimerand+25;
    cellheightmodificatcomanda = inaltimerand+35;
    [self.LISTASELECT beginUpdates];
    [updateCell setNeedsLayout];
    [updateCell layoutIfNeeded];
    [self.LISTASELECT endUpdates];
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    del.STRINGOBSERVATII =updateCell.textObservatii.text;
    
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    NSInteger ipx=1;
    NSIndexPath *indexPathreload = [NSIndexPath indexPathForRow:ipx inSection:4];
    CellFormularComanda *updateCell = (CellFormularComanda *)[self.LISTASELECT cellForRowAtIndexPath:indexPathreload];
    if ([updateCell.textObservatii.text isEqualToString: @"Poți adăuga informații suplimentare"]) {
        updateCell.textObservatii.text = @"";
        updateCell.textObservatii.textColor = [UIColor blackColor];
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int ipx = (int)indexPath.row;
    
    static NSString *CellIdentifier = @"CellFormularComanda";
    CellFormularComanda *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (CellFormularComanda*)[tableView dequeueReusableCellWithIdentifier:@"CellFormularComanda"];
    }
    cell.DATEOFERTA.hidden=YES;
    cell.RANDNORMAL.hidden=YES;
    cell.RANDADRESA.hidden=YES;
    cell.OBSERVATIICOMANDA.hidden=YES;
    cell.UTLIMULRAND.hidden=YES;
    cell.labelSalveaza.numberOfLines =0;
    cell.labelSalveaza.verticalAlignment =TTTAttributedLabelVerticalAlignmentTop;
    cell.tag =ipx+10;
    cell.imgModifica.tag =ipx+10;
    cell.labelModifica.tag =ipx+10;
    cell.TitluRand.hidden =NO;
    cell.LIVRARELABEL.hidden=YES;
    cell.heightlabelAdresa.constant =0;
    cell.textObservatii.delegate =self;
    NSInteger indexsection =[indexPath section];
    switch (indexsection) {
            ////////////// ITEMURI [PIESE] ALESE
        case 0:  {
            cell.DATEOFERTA.hidden=NO;
            cell.RANDADRESA.hidden=YES;
            cell.RANDNORMAL.hidden=YES;
            cell.OBSERVATIICOMANDA.hidden=YES;
            cell.UTLIMULRAND.hidden=YES;
            NSArray *itemuri = [NSArray arrayWithArray:[self.titluriCAMPURI objectAtIndex:indexsection]]; //randuri oferta
            NSDictionary *delucru = [itemuri objectAtIndex:ipx];
            NSString *TITLUOFERTA = [NSString stringWithFormat:@"%@", delucru[@"description"]];
            CGFloat widthWithInsetsApplied = self.view.frame.size.width -20;
                      CGSize textSize = [TITLUOFERTA boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16]} context:nil].size;
            double inaltimerand= textSize.height;
            UIFont *tester = [UIFont boldSystemFontOfSize:16];
            double numberOfLines = textSize.height /tester.pointSize;
            if(numberOfLines <2) {
                inaltimerand = 40;
                cell.heighttitlurand.constant = inaltimerand;
            } else {
                cell.heighttitlurand.constant = inaltimerand+15;
            }
            cell.TITLUOFERTA.text = TITLUOFERTA;
            cell.TITLUOFERTA.verticalAlignment =TTTAttributedLabelVerticalAlignmentTop;
            cell.TITLUOFERTA.numberOfLines = 0;
            NSString *C_leisaualtavaluta =@"";
            NSString *C_pret=@"";
            NSString *C_um =@"";
            if(delucru[@"currency_id"]) {
                NSString *Curencyid= [NSString stringWithFormat:@"%@",delucru[@"currency_id"]];
                NSDictionary *curencydinbaza = [NSDictionary dictionaryWithDictionary:[DataMasterProcessor getCURRENCY:Curencyid]];
                if(curencydinbaza[@"name"]) {
                    C_leisaualtavaluta= [NSString stringWithFormat:@"%@",curencydinbaza[@"name"]];
                }
            }
            if(delucru[@"price"]) {
                C_pret= [NSString stringWithFormat:@"%@",delucru[@"price"]];
            }
            if(delucru[@"um"]) {
                C_um= [NSString stringWithFormat:@"%@",delucru[@"um"]];
            }
            NSString *compus_pret_um= [NSString stringWithFormat:@"Preț: %@ %@/ %@", C_pret,C_leisaualtavaluta,C_um];
            NSRange bigRange = [compus_pret_um rangeOfString:C_pret];
            NSRange mediumRange = [compus_pret_um rangeOfString:C_leisaualtavaluta];
            NSRange smallRange = [compus_pret_um rangeOfString:C_um];
            NSMutableAttributedString * attributedString= [[NSMutableAttributedString alloc] initWithString:compus_pret_um];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize: 18] range:bigRange];
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:bigRange];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18] range:mediumRange];
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:mediumRange];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:smallRange];
            cell.PRETOFERTA.attributedText=attributedString;
            cell.PRETOFERTA.numberOfLines =1;
            [cell.backgroundView bringSubviewToFront:cell.PRETOFERTA];
            cell.backgroundColor = [UIColor whiteColor];
        }
            break;
            /////////////////// TO DO nu am date formatate complet
            
        case 1:  {
            //            cell.RANDNORMAL.hidden=NO;
            //            cell.DATEOFERTA.hidden=YES;
            //            cell.RANDADRESA.hidden=YES;
            //            cell.OBSERVATIICOMANDA.hidden=YES;
            //            cell.UTLIMULRAND.hidden=YES;
            //            NSArray *itemuri = [NSArray arrayWithArray:[self.titluriCAMPURI objectAtIndex:indexsection]];
            //            if(ipx==0) {
            //                cell.RANDNORMAL.backgroundColor = [UIColor colorWithRed:(240/255.0f) green:(240/255.0f) blue:(240/255.0f) alpha:1];
            //                cell.TitluRand.textColor =  [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:1];
            //                [cell.imgModifica setUserInteractionEnabled:YES];
            //                cell.TitluRand.userInteractionEnabled =NO;
            //                [cell.labelModifica setUserInteractionEnabled:YES];
            //                cell.imgModifica.hidden=NO;
            //                cell.labelModifica.hidden=NO;
            //            } else {
            //                cell.RANDNORMAL.backgroundColor = [UIColor whiteColor];
            //                cell.TitluRand.textColor =  [UIColor darkGrayColor] ;
            //                cell.imgModifica.hidden=YES;
            //                cell.labelModifica.hidden=YES;
            //                [cell.imgModifica setUserInteractionEnabled:NO];
            //                [cell.labelModifica setUserInteractionEnabled:NO];
            //            }
            //            cell.TitluRand.text =[NSString stringWithFormat:@"%@",[itemuri objectAtIndex:ipx]];
            //
            //        }
            cell.DATEOFERTA.hidden=YES;
            cell.RANDADRESA.hidden=YES;
            cell.RANDNORMAL.hidden=NO;
            cell.OBSERVATIICOMANDA.hidden=YES;
            cell.UTLIMULRAND.hidden=YES;
            
            NSArray *itemuri = [NSArray arrayWithArray:[self.titluriCAMPURI objectAtIndex:indexsection]];
            if(ipx==0) {
                cell.RANDNORMAL.backgroundColor = [UIColor colorWithRed:(240/255.0f) green:(240/255.0f) blue:(240/255.0f) alpha:1];
                cell.TitluRand.textColor =  [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:1];
                cell.TitluRand.userInteractionEnabled =NO;
                cell.TitluRand.text =[NSString stringWithFormat:@"%@",[itemuri objectAtIndex:ipx]];
                
                NSString *verificatext =[NSString stringWithFormat:@"%@",[itemuri objectAtIndex:1]]; // nume modalitate plata [a fost aleasa o modalitate unica se afiseaza
                if(![self MyStringisEmpty:verificatext]) {
                    //       cell.TitluRand.text =verificatext;
                    //to do & verify.
                    if(self.METODELIVRARE.count>1) {
                        cell.imgModifica.hidden=NO;
                        cell.labelModifica.hidden=NO;
                        [cell.imgModifica setUserInteractionEnabled:YES];
                        [cell.labelModifica setUserInteractionEnabled:YES];
                    } else {
                        
                        cell.imgModifica.hidden=YES;
                        cell.labelModifica.hidden=YES;
                        [cell.imgModifica setUserInteractionEnabled:NO];
                        [cell.labelModifica setUserInteractionEnabled:NO];
                    }
                } else {
                    // sunt mai multe modalitati de plata, nicuna selectata default ii dam dreptul sa aleaga la apasa Modifica
                    cell.imgModifica.hidden=NO;
                    cell.labelModifica.hidden=NO;
                    [cell.imgModifica setUserInteractionEnabled:YES];
                    [cell.labelModifica setUserInteractionEnabled:YES];
                }
                
            }else {
                cell.LIVRARELABEL.hidden=NO;
                NSString *verificatext =[NSString stringWithFormat:@"%@",[itemuri objectAtIndex:ipx]];
                cell.TitluRand.hidden=YES;
                cell.LIVRARELABEL.text =verificatext;
                cell.LIVRARELABEL.numberOfLines=0;
                cell.RANDNORMAL.backgroundColor = [UIColor whiteColor];
                cell.LIVRARELABEL.textColor =  [UIColor darkGrayColor] ;
                cell.imgModifica.hidden=YES;
                cell.labelModifica.hidden=YES;
                [cell.imgModifica setUserInteractionEnabled:NO];
                [cell.labelModifica setUserInteractionEnabled:NO];
                cell.LIVRARELABEL.text =[NSString stringWithFormat:@"%@",[itemuri objectAtIndex:ipx]];
              //  cell.LIVRARELABEL.textColor = [UIColor colorWithRed:(255/255.0f) green:(102/255.0f) blue:(0/255.0f) alpha:1];
            }
            
            
            
        }
            break;
            ////////////// MODALITATE PLATA
            //        case 2:  {
            //            cell.DATEOFERTA.hidden=YES;
            //            cell.RANDADRESA.hidden=YES;
            //            cell.RANDNORMAL.hidden=NO;
            //            cell.OBSERVATIICOMANDA.hidden=YES;
            //            cell.UTLIMULRAND.hidden=YES;
            //            NSArray *itemuri = [NSArray arrayWithArray:[self.titluriCAMPURI objectAtIndex:indexsection]];
            //            if(ipx==0) {
            //                cell.RANDNORMAL.backgroundColor = [UIColor colorWithRed:(240/255.0f) green:(240/255.0f) blue:(240/255.0f) alpha:1];
            //                cell.TitluRand.textColor =  [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:1];
            //                cell.TitluRand.userInteractionEnabled =NO;
            //                cell.TitluRand.text =[NSString stringWithFormat:@"%@",[itemuri objectAtIndex:ipx]];
            //
            //                NSString *verificatext =[NSString stringWithFormat:@"%@",[itemuri objectAtIndex:1]]; // nume modalitate plata [a fost aleasa o modalitate unica se afiseaza
            //                if(![self MyStringisEmpty:verificatext]) {
            //                    cell.TitluRand.text =verificatext;
            //                //to do & verify.
            //                    if(self.METODEDEPLATA.count>1) {
            //                        cell.imgModifica.hidden=NO;
            //                        cell.labelModifica.hidden=NO;
            //                        [cell.imgModifica setUserInteractionEnabled:YES];
            //                        [cell.labelModifica setUserInteractionEnabled:YES];
            //                    } else {
            //
            //                    cell.imgModifica.hidden=YES;
            //                    cell.labelModifica.hidden=YES;
            //                    [cell.imgModifica setUserInteractionEnabled:NO];
            //                    [cell.labelModifica setUserInteractionEnabled:NO];
            //                    }
            //                } else {
            //                    // sunt mai multe modalitati de plata, nicuna selectata default ii dam dreptul sa aleaga la apasa Modifica
            //                    cell.imgModifica.hidden=NO;
            //                    cell.labelModifica.hidden=NO;
            //                    [cell.imgModifica setUserInteractionEnabled:YES];
            //                    [cell.labelModifica setUserInteractionEnabled:YES];
            //                }
            //
            //            }else {
            //                NSString *verificatext =[NSString stringWithFormat:@"%@",[itemuri objectAtIndex:ipx]];
            //                cell.TitluRand.text =verificatext;
            //                cell.RANDNORMAL.backgroundColor = [UIColor whiteColor];
            //                cell.TitluRand.textColor =  [UIColor darkGrayColor] ;
            //                cell.imgModifica.hidden=YES;
            //                cell.labelModifica.hidden=YES;
            //                [cell.imgModifica setUserInteractionEnabled:NO];
            //                [cell.labelModifica setUserInteractionEnabled:NO];
            //            }
            //
            //            cell.TitluRand.text =[NSString stringWithFormat:@"%@",[itemuri objectAtIndex:ipx]];
            //
            //        }
            // break;
            ////////////// PRENUME NUME
        case 2:  {
            cell.DATEOFERTA.hidden=YES;
            cell.RANDADRESA.hidden=YES;
            cell.RANDNORMAL.hidden=NO;
            cell.OBSERVATIICOMANDA.hidden=YES;
            cell.UTLIMULRAND.hidden=YES;
            NSArray *itemuri = [NSArray arrayWithArray:[self.titluriCAMPURI objectAtIndex:indexsection]];
            if(ipx==0) {
                cell.RANDNORMAL.backgroundColor = [UIColor colorWithRed:(240/255.0f) green:(240/255.0f) blue:(240/255.0f) alpha:1];
                cell.TitluRand.textColor =  [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:1];
                [cell.imgModifica setUserInteractionEnabled:NO];
                cell.TitluRand.userInteractionEnabled =NO;
                [cell.labelModifica setUserInteractionEnabled:NO];
                cell.imgModifica.hidden=NO;
                cell.labelModifica.hidden=NO;
                cell.TitluRand.text =[NSString stringWithFormat:@"%@",[itemuri objectAtIndex:ipx]];
            } else {
                cell.RANDNORMAL.backgroundColor = [UIColor whiteColor];
                cell.TitluRand.textColor =  [UIColor darkGrayColor] ;
                cell.imgModifica.hidden=YES;
                cell.labelModifica.hidden=YES;
                NSString *prenumelabel =@"";
                if(ipx==1) {
                    prenumelabel = @"Prenume:";
                }
                if(ipx==2) {
                    prenumelabel = @"Nume:";
                }
                NSString *prenumetext = [NSString stringWithFormat:@"%@",[itemuri objectAtIndex:ipx]];
                NSString *PRENUMElabelsitext= [NSString stringWithFormat:@"%@ %@",prenumelabel, prenumetext];
                NSRange bigRange = [PRENUMElabelsitext rangeOfString:prenumelabel];
                NSRange mediumRange = [PRENUMElabelsitext rangeOfString:prenumetext];
                
                NSMutableAttributedString * attributedString= [[NSMutableAttributedString alloc] initWithString:PRENUMElabelsitext];
                [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19] range:bigRange];
                [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:bigRange];
                [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:19] range:mediumRange];
                [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:mediumRange];
                cell.TitluRand.attributedText =attributedString;
            }
        }
            break;
            ////////////// TELEFON
            
            //        case 4:  {
            //            cell.DATEOFERTA.hidden=YES;
            //            cell.RANDADRESA.hidden=YES;
            //            cell.RANDNORMAL.hidden=NO;
            //            cell.OBSERVATIICOMANDA.hidden=YES;
            //            cell.UTLIMULRAND.hidden=YES;
            //            NSArray *itemuri = [NSArray arrayWithArray:[self.titluriCAMPURI objectAtIndex:indexsection]];
            //            if(ipx==0) {
            //                cell.RANDNORMAL.backgroundColor = [UIColor colorWithRed:(240/255.0f) green:(240/255.0f) blue:(240/255.0f) alpha:1];
            //                cell.TitluRand.textColor =  [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:1];
            //                cell.TitluRand.userInteractionEnabled =NO;
            //                cell.imgModifica.hidden=NO;
            //                cell.labelModifica.hidden=NO;
            //                [cell.imgModifica setUserInteractionEnabled:YES];
            //                [cell.labelModifica setUserInteractionEnabled:YES];
            //            }else {
            //                NSString *verificatext =[NSString stringWithFormat:@"%@",[itemuri objectAtIndex:ipx]];
            //                cell.TitluRand.text =verificatext;
            //                cell.RANDNORMAL.backgroundColor = [UIColor whiteColor];
            //                cell.TitluRand.textColor =  [UIColor darkGrayColor] ;
            //                cell.imgModifica.hidden=YES;
            //                cell.labelModifica.hidden=YES;
            //                [cell.imgModifica setUserInteractionEnabled:NO];
            //                [cell.labelModifica setUserInteractionEnabled:NO];
            //            }
            //            cell.TitluRand.text =[NSString stringWithFormat:@"%@",[itemuri objectAtIndex:ipx]];
            //
            //        }
            //break;
            ////////////// ADRESA LIVRARE
        case 3:  {
            cell.DATEOFERTA.hidden=YES;
            cell.RANDADRESA.hidden=YES;
            cell.RANDNORMAL.hidden=YES;
            cell.OBSERVATIICOMANDA.hidden=YES;
            cell.UTLIMULRAND.hidden=YES;
            cell.heightlabelAdresa.constant =25;
            NSArray *itemuri = [NSArray arrayWithArray:[self.titluriCAMPURI objectAtIndex:indexsection]];
            if(ipx==0) {
                cell.DATEOFERTA.hidden=YES;
                cell.RANDADRESA.hidden=YES;
                cell.RANDNORMAL.hidden=NO;
                cell.RANDNORMAL.backgroundColor = [UIColor colorWithRed:(240/255.0f) green:(240/255.0f) blue:(240/255.0f) alpha:1];
                cell.TitluRand.textColor =  [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:1];
                cell.TitluRand.userInteractionEnabled =NO;
                cell.imgModifica.hidden=NO;
                cell.labelModifica.hidden=NO;
                [cell.imgModifica setUserInteractionEnabled:YES];
                [cell.labelModifica setUserInteractionEnabled:YES];
                cell.TitluRand.text =[NSString stringWithFormat:@"%@",[itemuri objectAtIndex:ipx]];
                
            } else if(ipx==4) {
                cell.DATEOFERTA.hidden=YES;
                cell.RANDNORMAL.hidden=YES;
                cell.RANDADRESA.hidden=NO;
                [cell.btnSalveaza setImage:[UIImage imageNamed:@"Checkbox_unchecked_blue_72x72.png"] forState:UIControlStateNormal];
                [cell.btnSalveaza setImage:[UIImage imageNamed:@"Checkbox_checked_blue_72x72.png"] forState:UIControlStateSelected];
                UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(debifeaza:)];
                [singleTap setNumberOfTapsRequired:1];
                [cell.btnSalveaza  setUserInteractionEnabled:YES];
                [cell.btnSalveaza  addGestureRecognizer:singleTap];
                if( salveazadateprofil==YES) {
                    cell.btnSalveaza.selected=YES;
                } else {
                    cell.btnSalveaza.selected=NO;
                }
                cell.contentView.backgroundColor =[UIColor whiteColor];
                cell.btnSalveaza.tag = ipx+100;
                NSString *adresalabel =@"Adresa:";
                NSString *verificatext =[NSString stringWithFormat:@"%@",[itemuri objectAtIndex:ipx]];
                NSString *ADRESAlabelsitext= [NSString stringWithFormat:@"%@ %@",adresalabel, verificatext];
                NSRange bigRange = [ADRESAlabelsitext rangeOfString:adresalabel];
                NSRange mediumRange = [ADRESAlabelsitext rangeOfString:verificatext];
                
                NSMutableAttributedString * attributedString= [[NSMutableAttributedString alloc] initWithString:ADRESAlabelsitext];
                [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19] range:bigRange];
                [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:bigRange];
                [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:19] range:mediumRange];
                [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:mediumRange];
                cell.TitluAdresa.verticalAlignment =TTTAttributedLabelVerticalAlignmentTop;
                cell.TitluAdresa.numberOfLines = 0;
                cell.TitluAdresa.attributedText =attributedString;
                CGFloat widthWithInsetsApplied = self.view.frame.size.width -15;
                CGSize textSize = [ADRESAlabelsitext boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16]} context:nil].size;
                double inaltimerand= textSize.height;
                UIFont *tester = [UIFont boldSystemFontOfSize:16];
                double numberOfLines = textSize.height /tester.pointSize;
                if(numberOfLines <2) {
                    inaltimerand = 40;
                    cell.heightlabelAdresa.constant = inaltimerand;
                } else {
                    cell.heightlabelAdresa.constant = inaltimerand+72;
                }
             
                cell.RANDADRESA.backgroundColor = [UIColor whiteColor];
                cell.imgModifica.hidden=YES;
                cell.labelModifica.hidden=YES;
                [cell.imgModifica setUserInteractionEnabled:NO];
                [cell.labelModifica setUserInteractionEnabled:NO];
            }
            else {
                cell.DATEOFERTA.hidden=YES;
                cell.RANDADRESA.hidden=YES;
                cell.RANDNORMAL.hidden=NO;
                NSString *verificatext =[NSString stringWithFormat:@"%@",[itemuri objectAtIndex:ipx]];
                NSString *adresalabel =@"";
                cell.TitluRand.numberOfLines =0;
                if(ipx==1) {
                    adresalabel = @"Județ:";
                }
                if(ipx==2) {
                    adresalabel = @"Localitate:";
                }
                if(ipx==3) {
                    adresalabel = @"Cod Poștal:";
                }
                NSString *ADRESAlabelsitext= [NSString stringWithFormat:@"%@ %@",adresalabel, verificatext];
                NSRange bigRange = [ADRESAlabelsitext rangeOfString:adresalabel];
                NSRange mediumRange = [ADRESAlabelsitext rangeOfString:verificatext];
                
                NSMutableAttributedString * attributedString= [[NSMutableAttributedString alloc] initWithString:ADRESAlabelsitext];
                [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19] range:bigRange];
                [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:bigRange];
                [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:19] range:mediumRange];
                [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:mediumRange];
                cell.TitluRand.attributedText =attributedString;
                cell.RANDNORMAL.backgroundColor = [UIColor whiteColor];
                cell.TitluRand.textColor =  [UIColor darkGrayColor] ;
                cell.imgModifica.hidden=YES;
                cell.labelModifica.hidden=YES;
                [cell.imgModifica setUserInteractionEnabled:NO];
                [cell.labelModifica setUserInteractionEnabled:NO];
            }
        }
            break;
            ////////////// OBSERVATII SUPLIMENTARE
        case 4:  {
            cell.DATEOFERTA.hidden=YES;
            cell.RANDADRESA.hidden=YES;
            cell.RANDNORMAL.hidden=NO;
            cell.OBSERVATIICOMANDA.hidden=YES;
            cell.UTLIMULRAND.hidden=YES;
            NSArray *itemuri = [NSArray arrayWithArray:[self.titluriCAMPURI objectAtIndex:indexsection]];
            if(ipx==0) {
                cell.RANDNORMAL.backgroundColor = [UIColor colorWithRed:(240/255.0f) green:(240/255.0f) blue:(240/255.0f) alpha:1];
                cell.TitluRand.textColor =  [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:1];
                cell.TitluRand.userInteractionEnabled =NO;
                NSString *verificatext =[NSString stringWithFormat:@"%@",[itemuri objectAtIndex:ipx]];
                cell.TitluRand.text =verificatext;
                cell.TitluRand.font =[UIFont systemFontOfSize:15];
                cell.imgModifica.hidden=YES;
                cell.labelModifica.hidden=YES;
                [cell.imgModifica setUserInteractionEnabled:NO];
                [cell.labelModifica setUserInteractionEnabled:NO];
            }else {
                cell.OBSERVATIICOMANDA.hidden=NO;
                cell.OBSERVATIICOMANDA.backgroundColor = [UIColor whiteColor];
                //                NSString *verificatext =[NSString stringWithFormat:@"%@",[itemuri objectAtIndex:ipx]];
                //                cell.textObservatii.text =verificatext;
                //   cell.textObservatii.textColor =  [UIColor darkGrayColor] ;
                cell.imgModifica.hidden=YES;
                cell.labelModifica.hidden=YES;
                [cell.imgModifica setUserInteractionEnabled:NO];
                [cell.labelModifica setUserInteractionEnabled:NO];
                [cell.textObservatii setScrollEnabled:NO];
                
                AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                
                if( ![self MyStringisEmpty:[NSString stringWithFormat:@"%@",del.STRINGOBSERVATII]] && ![del.STRINGOBSERVATII isEqualToString:@"Poți adăuga informații suplimentare"]) {
                    cell.textObservatii.textColor = [UIColor blackColor];
                    cell.textObservatii.text =del.STRINGOBSERVATII;
                } else {
                    cell.textObservatii.textColor = [UIColor lightGrayColor];
                    cell.textObservatii.text =@"Poți adăuga informații suplimentare";
                    
                }

                
                 UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
                numberToolbar.barStyle = UIBarStyleBlackTranslucent;
                numberToolbar.items = [NSArray arrayWithObjects:
                                       [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                                       nil];
                [numberToolbar sizeToFit];
                cell.textObservatii.inputAccessoryView = numberToolbar;
               /// cellheightmodificatcomanda =
                CGFloat widthWithInsetsApplied = self.view.frame.size.width -20;
                CGSize textSize = [cell.textObservatii.text boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
                double inaltimerand= textSize.height;
                cell.dynamicheightTEXTVIEW.constant = inaltimerand+25;
                cellheightmodificatcomanda = inaltimerand+35;
            }
        }
            break;
        case 5:  {
            ////////////// ULTIMUL RAND
            cell.DATEOFERTA.hidden=YES;
            cell.RANDADRESA.hidden=YES;
            cell.RANDNORMAL.hidden=YES;
            cell.OBSERVATIICOMANDA.hidden=YES;
            cell.UTLIMULRAND.hidden=NO;
        }
            break;
        default:
            break;
    }
    
    
    
    
    // if ([indexPath section]== 0) {
    
    
    
    
    //    if (indexPath.row % 2 && ipx>0) {
    //        cell.backgroundColor = [UIColor whiteColor];
    //        cell.TitluRand.textColor =  [UIColor darkGrayColor] ;
    //        cell.imgModifica.hidden=YES;
    //        cell.labelModifica.hidden=YES;
    //    }else {
    //       cell.backgroundColor = [UIColor colorWithRed:(240/255.0f) green:(240/255.0f) blue:(240/255.0f) alpha:1];
    //     //   UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(MODIFICARE_CAMPURI:)];
    //     //   [singleTap setNumberOfTapsRequired:1];
    //        cell.TitluRand.textColor =  [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:1];
    //        [cell.imgModifica setUserInteractionEnabled:NO];
    //        cell.TitluRand.userInteractionEnabled =NO;
    //       // [cell.imgModifica addGestureRecognizer:singleTap];
    //        [cell.labelModifica setUserInteractionEnabled:NO];
    //       // [cell.labelModifica addGestureRecognizer:singleTap];
    //        cell.imgModifica.hidden=NO;
    //        cell.labelModifica.hidden=NO;
    //    }
    //
    //  par impar ...
    //  BOOL isOdd = ipx % 2;  // if it is divisible by 2, this will be 0. if it isn't, it is 1
    
    //   cell.TitluRand.text =[NSString stringWithFormat:@"%@",[self.titluriCAMPURI objectAtIndex:ipx]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // [LISTASELECT cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int ipx = (int)indexPath.row;
    NSLog(@"ipx %i", ipx);
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    del.modificariDateComanda=YES;
    //   CellChooseLogin *CELL = (CellChooseLogin *)[LISTASELECT cellForRowAtIndexPath:indexPath];
    
    //
    //    if ([indexPath section]== 2) {
    //        switch (ipx) {
    //            case 0:  {
    //                //metode plata
    //                if(self.METODEDEPLATA.count ==1) {
    //                 //nothing
    //                } else {
    //                NSLog(@"Preferinte metoda plata");
    //                chooseview *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Choose1VC"];
    //                vc.data =[[NSArray alloc]init];
    //                vc.data =[NSArray arrayWithArray:self.METODEDEPLATA];
    //                    NSLog(@"Metodadeplata %@",self.METODEDEPLATA);
    //                vc.CE_TIP_E = @"Metodadeplata";
    //                [self.navigationController pushViewController:vc animated:YES ];
    //                }
    //            }
    //                break;
    //            default:
    //                break;
    //        }
    //    }
    
    
    if ([indexPath section]== 1) {
        switch (ipx) {
            case 0:  {
                //metode plata
                if(self.METODELIVRARE.count ==1) {
                    //nothing
                } else {
                    NSLog(@"Preferinte metoda plata");
                    chooseview *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Choose1VC"];
                    vc.data =[[NSArray alloc]init];
                    vc.data =[NSArray arrayWithArray:self.METODELIVRARE];
                    NSLog(@"Metodalivrare %@",self.METODELIVRARE);
                    vc.CE_TIP_E = @"Metodalivrare";
                    [self.navigationController pushViewController:vc animated:YES ];
                }
            }
                break;
            default:
                break;
        }
    }
    
    if ([indexPath section]== 2) {
        switch (ipx) {
            case 0:  {
                //prenume nume
                NSLog(@"Prenume și Nume");
                choose4view *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Choose4VC"];
                vc.CE_TIP_E =@"prenumenume";// chose 5 maybe to keep clear.
                [self.navigationController pushViewController:vc animated:YES ];
                
            }
                break;
            default:
                break;
        }
    }
    //    if ([indexPath section]== 4) {
    //        switch (ipx) {
    //            case 0:  {
    //                //telefon
    //                NSLog(@"Telefon");
    //                choose4view *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Choose4VC"];
    //                vc.CE_TIP_E =@"telefon";// chose 5 maybe to keep clear.
    //                self.navigationItem.backBarButtonItem =
    //                [[UIBarButtonItem alloc] initWithTitle:@"Înapoi"
    //                                                 style:UIBarButtonItemStylePlain
    //                                                target:nil
    //                                                action:nil];
    //                [self.navigationController pushViewController:vc animated:YES ];
    //                break;
    //
    //
    //            }
    //                break;
    //            default:
    //                break;
    //        }
    //    }
    //  self.RANDURIOFERTA,modlivrarearray,dateclientarray,adresalivrarearray,observatiiearray,ultimulrow
    if ([indexPath section]== 3) {
        switch (ipx) {
            case 0:  {
                //adresa
                NSLog(@"Adresa");
                EcranAdresaViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"EcranAdresaVC"];
                vc.CE_TIP_E =@"adresa";
                [self.navigationController pushViewController:vc animated:YES ];
            }
                break;
            default:
                break;
        }
    }
    //        case 6: {
    
    //            break;
    //
    //        }
    //        case 8: {
    //            NSLog(@"Parola mod");
    //            choose4view *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Choose4VC"];
    //            vc.CE_TIP_E = @"modificareparola";
    //            [self.navigationController pushViewController:vc animated:YES ];
    //            break;
    //        }
    //        case 10: {
    //
    //            NSLog(@"Preferințe notificări");
    //            chooseview *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Choose1VC"];
    //            vc.data =[[NSArray alloc]init];
    //            vc.data =@[@"Vreau să primesc notificări...",@"În aplicație",@"Pe e-mail",@"În aplicație și pe e-mail",@""];
    //            vc.CE_TIP_E = @"Preferintenotificari";
    //            [self.navigationController pushViewController:vc animated:YES ];
    //            break;
    //        }
    
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

-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
}
//METODA_SET_WINNING_OFFER
-(void)setwinningoffer :(NSString *)AUTHTOKEN :(NSMutableDictionary *)DATEUSER :(NSMutableDictionary*)DATECOMANDA{
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary *userd=del.CLONADATEUSER;
    
    
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
        
        NSString *U_prenume =@"";
        NSString *U_nume =@"";
        ///     NSString *U_telefon =@"";
        NSString *U_judet =@"";
        NSString *U_localitate =@"";
        NSString *U_cod_postal =@"";
        NSString *U_adresa =@"";
        NSString *alte_obs =@"";
        NSString *shipping_type =@"";
        NSString *offer_id=@"";
        /*
         - offer_id
         - first_name
         - last_name
         - localitate_id
         - address
         - zip_code
         - save_to_profile: 0 sau 1
         - shipping_type: valoarea din "get_order_form" la shipping[...].type  (ex: local_delivery, courier sau posta)
         - alte_obs: string, optional
         */
        if(self.salveazadateprofil==YES ) {
            [dic2 setObject:@"1" forKey:@"save_to_profile"];
        } else {
            [dic2 setObject:@"0" forKey:@"save_to_profile"];
        }
        if(DATEUSER[@"U_prenume"] && DATEUSER[@"U_nume"]) {
            U_prenume= [NSString stringWithFormat:@"%@",[DATEUSER  objectForKey:@"U_prenume"]];
            U_nume= [NSString stringWithFormat:@"%@",[DATEUSER  objectForKey:@"U_nume"]];
            [dic2 setObject:U_prenume forKey:@"first_name"];
            [dic2 setObject:U_nume forKey:@"last_name"];
        }
        //        if(DATEUSER[@"U_telefon"]) {
        //            U_telefon= [NSString stringWithFormat:@"%@",[DATEUSER  objectForKey:@"U_telefon"]];
        //            [dic2 setObject:U_telefon forKey:@"phone1"];
        //        }
        if(DATEUSER[@"U_judet"]) {
            U_judet=[NSString stringWithFormat:@"%@",[DATEUSER  objectForKey:@"U_judet"]];
        }
        if(DATEUSER[@"U_localitate"]) {
            U_localitate=[NSString stringWithFormat:@"%@",[DATEUSER  objectForKey:@"U_localitate"]];
            [dic2 setObject:U_localitate forKey:@"localitate_id"];
        }
        if(DATEUSER[@"U_cod_postal"]) {
            U_cod_postal=[NSString stringWithFormat:@"%@",[DATEUSER  objectForKey:@"U_cod_postal"]];
            [dic2 setObject:U_cod_postal forKey:@"zip_code"];
        }
        if(DATEUSER[@"U_adresa"]) {
            U_adresa=[NSString stringWithFormat:@"%@",[DATEUSER  objectForKey:@"U_adresa"]];
            [dic2 setObject:U_adresa forKey:@"address"];
        }
        if(DATECOMANDA[@"alte_obs"]) {
            alte_obs=[NSString stringWithFormat:@"%@",[DATECOMANDA  objectForKey:@"alte_obs"]];
            [dic2 setObject:alte_obs forKey:@"alte_obs"];
        }
        if(DATECOMANDA[@"offer_id"]) {
            offer_id=[NSString stringWithFormat:@"%@",[DATECOMANDA  objectForKey:@"offer_id"]];
            [dic2 setObject:offer_id forKey:@"offer_id"];
        }
        if(DATECOMANDA[@"shipping_type"]) {
            shipping_type=[NSString stringWithFormat:@"%@",[DATECOMANDA  objectForKey:@"shipping_type"]];
            [dic2 setObject:shipping_type forKey:@"shipping_type"];
        }
        /*
         [DATECOMANDA setObject:alte_obs forKey:@"alte_obs"];
         if (detaliuoferta[@"messageid"]) offer_id = [NSString stringWithFormat:@"%@",detaliuoferta[@"messageid"]];
         [DATECOMANDA setObject:offer_id forKey:@"offer_id"];
         [DATECOMANDA setObject:tiplivrare forKey:@"shipping_type"];
         */
        
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic2 options:0 error:&err];
        NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        compus =[NSString stringWithFormat:@"%@%@",METODA_SET_WINNING_OFFER, myString];
        
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
                    NSLog(@"date EDIT  /SEND  PROFILE DIN CERERE COMANDA raspuns %@",multedate);
                    NSMutableArray *raspuns = [[NSMutableArray alloc]init];
                    for (NSString *key in multedate) {
                        [raspuns addObject:key];
                    }
                    if(raspuns.count ==0) {
                        NSLog(@"succes");
                        NSMutableDictionary *modat = [NSMutableDictionary dictionaryWithDictionary:userd];
                        NSString *U_prenume_mod= [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"first_name"]];
                        NSString *U_nume_mod= [NSString stringWithFormat:@"%@",[dic2  objectForKey:@"last_name"]];
                        //  NSString *U_telefon_mod= [NSString stringWithFormat:@"%@",[dic2  objectForKey:@"phone1"]];
                        NSString *U_judet_mod = U_judet;
                        NSString *U_localitate_mod = [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"localitate_id"]];
                        NSString *U_codpostal_mod = [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"zip_code"]];
                        NSString *U_adresa_mod = [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"address"]];
                        
                        [modat setObject:U_prenume_mod forKey:@"U_prenume"];
                        [modat setObject:U_nume_mod forKey:@"U_nume"];
                        //  [modat setObject:U_telefon_mod forKey:@"U_telefon"];
                        [modat setObject:U_judet_mod forKey:@"U_judet"];
                        [modat setObject:U_localitate_mod forKey:@"U_localitate"];
                        [modat setObject:U_codpostal_mod forKey:@"U_cod_postal"];
                        [modat setObject:U_adresa_mod forKey:@"U_adresa"];
                        [DataMasterProcessor updateUsers:modat];
                        AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                        del.CLONADATEUSER=[[NSMutableDictionary alloc]init];
                        del.modificariDateComanda=NO;
                        del.MODLIVRARETEMPORAR =[[NSMutableDictionary alloc]init];
                        del.STRINGOBSERVATII=@"Poți adăuga informații suplimentare";
                        EcranComandaTrimisaViewController *vc =  [self.storyboard instantiateViewControllerWithIdentifier:@"EcranComandaTrimisaViewControllerVC2"];
                        [self.navigationController pushViewController:vc animated:YES ];
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

@end
/*
 
 //METODA_EDIT_PROFILE
 -(void)editProfiledinConfirmaComanda :(NSString *)AUTHTOKEN :(NSMutableDictionary *)DATEUSER{
 AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
 NSMutableDictionary *userd=del.CLONADATEUSER;
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
 
 NSString *U_prenume =@"";
 NSString *U_nume =@"";
 ///     NSString *U_telefon =@"";
 NSString *U_judet =@"";
 NSString *U_localitate =@"";
 NSString *U_cod_postal =@"";
 NSString *U_adresa =@"";
 
 if(DATEUSER[@"U_prenume"] && DATEUSER[@"U_nume"]) {
 U_prenume= [NSString stringWithFormat:@"%@",[DATEUSER  objectForKey:@"U_prenume"]];
 U_nume= [NSString stringWithFormat:@"%@",[DATEUSER  objectForKey:@"U_nume"]];
 [dic2 setObject:U_prenume forKey:@"first_name"];
 [dic2 setObject:U_nume forKey:@"last_name"];
 }
 //        if(DATEUSER[@"U_telefon"]) {
 //            U_telefon= [NSString stringWithFormat:@"%@",[DATEUSER  objectForKey:@"U_telefon"]];
 //            [dic2 setObject:U_telefon forKey:@"phone1"];
 //        }
 if(DATEUSER[@"U_judet"]) {
 U_judet=[NSString stringWithFormat:@"%@",[DATEUSER  objectForKey:@"U_judet"]];
 }
 if(DATEUSER[@"U_localitate"]) {
 U_localitate=[NSString stringWithFormat:@"%@",[DATEUSER  objectForKey:@"U_localitate"]];
 [dic2 setObject:U_localitate forKey:@"localitate_id"];
 }
 if(DATEUSER[@"U_cod_postal"]) {
 U_cod_postal=[NSString stringWithFormat:@"%@",[DATEUSER  objectForKey:@"U_cod_postal"]];
 [dic2 setObject:U_cod_postal forKey:@"zip_code"];
 }
 if(DATEUSER[@"U_adresa"]) {
 U_adresa=[NSString stringWithFormat:@"%@",[DATEUSER  objectForKey:@"U_adresa"]];
 [dic2 setObject:U_adresa forKey:@"address"];
 }
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
 NSLog(@"date EDIT  /SEND  PROFILE DIN CERERE COMANDA raspuns %@",multedate);
 NSMutableArray *raspuns = [[NSMutableArray alloc]init];
 for (NSString *key in multedate) {
 [raspuns addObject:key];
 }
 if(raspuns.count ==0) {
 NSLog(@"succes");
 NSMutableDictionary *modat = [NSMutableDictionary dictionaryWithDictionary:userd];
 NSString *U_prenume_mod= [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"first_name"]];
 NSString *U_nume_mod= [NSString stringWithFormat:@"%@",[dic2  objectForKey:@"last_name"]];
 //  NSString *U_telefon_mod= [NSString stringWithFormat:@"%@",[dic2  objectForKey:@"phone1"]];
 NSString *U_judet_mod = U_judet;
 NSString *U_localitate_mod = [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"localitate_id"]];
 NSString *U_codpostal_mod = [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"zip_code"]];
 NSString *U_adresa_mod = [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"address"]];
 
 [modat setObject:U_prenume_mod forKey:@"U_prenume"];
 [modat setObject:U_nume_mod forKey:@"U_nume"];
 //  [modat setObject:U_telefon_mod forKey:@"U_telefon"];
 [modat setObject:U_judet_mod forKey:@"U_judet"];
 [modat setObject:U_localitate_mod forKey:@"U_localitate"];
 [modat setObject:U_codpostal_mod forKey:@"U_cod_postal"];
 [modat setObject:U_adresa_mod forKey:@"U_adresa"];
 [DataMasterProcessor updateUsers:modat];
 //     [self.navigationController popViewControllerAnimated:YES];
 
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
 
 
 
 */

