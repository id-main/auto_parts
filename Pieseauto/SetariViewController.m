//
//  SetariViewController.m
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
#import "SetariViewController.h"
#import "CellContulMeuRow.h"
#import "TutorialHomeViewController.h"
#import <CoreText/CoreText.h>
#import "chooseview.h"
#import "choose4view.h"
#import "EcranAdresaViewController.h"
#import "Reachability.h"
#import "butoncustomback.h"


@interface SetariViewController(){
    NSMutableArray* Cells_Array;
}
@end

@implementation SetariViewController
@synthesize  LISTASELECT,titluriCAMPURI,dinmodificari;

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
    NSLog(@"setariview");
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    del.modificariDateComanda=NO;
    self.titluriCAMPURI =[[NSMutableArray alloc]init];
    utilitar = [[Utile alloc]init];
    NSString *authtoken=@"";
    BOOL elogat = NO;
    elogat = [utilitar eLogat];
    if(elogat) {
        authtoken = [utilitar AUTHTOKEN];
        [utilitar getProfile:authtoken];
    }
    NSDictionary *userd = [DataMasterProcessor getLOGEDACCOUNT];
    NSString *U_username=  [NSString stringWithFormat:@"%@",userd[@"U_username"]];
    NSString *U_preferinte_notificari=  [NSString stringWithFormat:@"%@",userd[@"U_preferinte_notificari"]];
    NSString *U_prenume=  [NSString stringWithFormat:@"%@",userd[@"U_prenume"]];
    NSString *U_nume=  [NSString stringWithFormat:@"%@",userd[@"U_nume"]];
    NSString *U_email=  [NSString stringWithFormat:@"%@",userd[@"U_email"]];
    NSString *U_judet=  [NSString stringWithFormat:@"%@",userd[@"U_judet"]];
    NSLog(@"ce judet are in el%@", U_judet);
    NSString *U_localitate=  [NSString stringWithFormat:@"%@",userd[@"U_localitate"]];
    NSString *U_cod_postal=  [NSString stringWithFormat:@"%@",userd[@"U_cod_postal"]];
    NSString *U_adresa=  [NSString stringWithFormat:@"%@",userd[@"U_adresa"]];
    //    NSString *U_parola=  [NSString stringWithFormat:@"%@",userd[@"U_parola"]];
    del.temporaraddress =[[NSMutableDictionary alloc]init];
    del.temporaraddress=[userd mutableCopy];
    
    NSString *PREFERINTE_NOTIFICARI =@"";
    //1 2 3 -> 1 = În aplicație 2 = Pe e-mail 3=În aplicație și pe e-mail
    if(![self MyStringisEmpty:U_preferinte_notificari]) {
        if([U_preferinte_notificari integerValue]==1 ) {
            PREFERINTE_NOTIFICARI =@"În aplicație";
        }
        if([U_preferinte_notificari integerValue]==2 ) {
            PREFERINTE_NOTIFICARI =@"Pe e-mail";
        }
        if([U_preferinte_notificari integerValue]==3 ) {
            PREFERINTE_NOTIFICARI =@"În aplicație și pe e-mail";
        }
    } else {
        NSLog(@"no prefs for notifs");
    }
    
    
    NSString *usernamesaunumeprenume =@"";
    if(![self MyStringisEmpty:U_prenume] || ![self MyStringisEmpty:U_nume]) {
        usernamesaunumeprenume =  [NSString stringWithFormat:@"%@ %@", U_prenume, U_nume];
    }
    else {
        usernamesaunumeprenume =U_username;
    }
    
    NSString *adresacompleta =@"";
    NSMutableArray *adresacompusa = [[NSMutableArray alloc]init];
    NSString *JUDETNAME = @"";
    NSDictionary *judbaza = [DataMasterProcessor getJudet:U_judet];
    if(judbaza && judbaza[@"name"]) {
        JUDETNAME = [NSString stringWithFormat:@"%@",judbaza[@"name"]];
    }
    NSString *LOCALITATE = [NSString stringWithFormat:@"%@",U_localitate];
    NSString *LOCALITATENAME = @"";
    NSDictionary *LOCALITATEselectata = [DataMasterProcessor getLocalitate:LOCALITATE];
    
    if(LOCALITATEselectata && LOCALITATEselectata[@"name"]) {
        LOCALITATENAME = [NSString stringWithFormat:@"%@",LOCALITATEselectata[@"name"]];
    }
    if(![self MyStringisEmpty:U_adresa]) [adresacompusa addObject:U_adresa];
    if(![self MyStringisEmpty:U_cod_postal]) [adresacompusa addObject:U_cod_postal];
    if(![self MyStringisEmpty:LOCALITATENAME])[adresacompusa addObject:LOCALITATENAME];
    if(![self MyStringisEmpty:JUDETNAME])[adresacompusa addObject:JUDETNAME];
    adresacompleta = [NSString stringWithFormat:@"%@", [adresacompusa componentsJoinedByString:@","]];
    
    NSString *parola = @"\u2022\u2022\u2022\u2022\u2022\u2022";
    //  if(![self MyStringisEmpty:U_parola]) parola =U_parola;
    NSMutableArray *telefoaneuser = [[NSMutableArray alloc]init];
    NSString *nrtelefon=@"";
    NSString *nrtelefon2=@"";
    NSString *nrtelefon3=@"";
    NSString *nrtelefon4=@"";
    
    if(userd[@"U_telefon"])      nrtelefon= [NSString stringWithFormat:@"%@",userd[@"U_telefon"]];
    if(userd[@"U_telefon2"])     nrtelefon2= [NSString stringWithFormat:@"%@",userd[@"U_telefon2"]];
    if(userd[@"U_telefon3"])     nrtelefon3= [NSString stringWithFormat:@"%@",userd[@"U_telefon3"]];
    if(userd[@"U_telefon4"])     nrtelefon4= [NSString stringWithFormat:@"%@",userd[@"U_telefon4"]];
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
    NSLog(@"telefoaneuser %@", telefoaneuser);
    
    self.titluriCAMPURI =@[@"Prenume și Nume",usernamesaunumeprenume,@"E-mail",U_email,@"Telefon",telefoaneuser,@"Adresă",adresacompleta, @"Parola",parola,@"Vreau să primesc notificări",PREFERINTE_NOTIFICARI];
    
 /*  self.titluriCAMPURI =@[@"Prenume și Nume",usernamesaunumeprenume,@"E-mail",U_email,@"Telefon",telefoaneuser,@"Adresă", @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque ornare nibh at enim elementum, nec posuere nunc blandit. Mauris semper pharetra congue. Nam ac neque vel elit bibendum vulputate. Morbi vel elit arcu. Curabitur congue ex et mi euismod mattis. Aliquam consequat risus pretium, ornare orci vestibulum, pellentesque lacus. Maecenas vestibulum ligula libero, sed suscipit nisl rutrum a. Fusce non lectus ligula. In id lorem eget nulla facilisis elementum quis non leo. Praesent convallis leo elit, quis ultrices mi interdum non.",@"Parola",parola,@"Vreau să primesc notificări",PREFERINTE_NOTIFICARI];*/
    LISTASELECT.delegate =self;
    LISTASELECT.dataSource =self;
    LISTASELECT.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [LISTASELECT reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    self.title = @"Setări";
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger cateavem=0;
    if(section ==5) {
        cateavem = [[[self titluriCAMPURI]objectAtIndex:5]count];
    }
    else {
        cateavem=1;
    }
    return cateavem;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if(indexPath.section == 7) { //label adresa mai inalt... mai multe linii etc
        NSLog(@"self.titluriCAMPURI %@",self.titluriCAMPURI);
        NSString *textadresa = [NSString stringWithFormat:@"%@",[self.titluriCAMPURI objectAtIndex:7]];
        CGFloat widthWithInsetsApplied = self.view.frame.size.width-30;
        CGSize textSize = [textadresa boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18]} context:nil].size;
        double heightrow = textSize.height +10;
        return heightrow;
    } else {
        return 46;
    }

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
    // return 1;
    return self.titluriCAMPURI.count;
}
-(IBAction)MODIFICARE_CAMPURI:(id)sender {
    UITapGestureRecognizer *gesture = (UITapGestureRecognizer *) sender;
    NSLog(@"Tag = %ld", (long)gesture.view.tag);
    int ipx = (int)gesture.view.tag;
    NSLog(@"si ipx %i", ipx);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger ipx = indexPath.section;
    
    static NSString *CellIdentifier = @"CellContulMeuRow";
    CellContulMeuRow *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (CellContulMeuRow*)[tableView dequeueReusableCellWithIdentifier:@"CellContulMeuRow"];
    }
    cell.tag =ipx+10;
    cell.imgModifica.tag =ipx+10;
    cell.labelModifica.tag =ipx+10;
    cell.TitluRand.hidden =NO;
    cell.sageatablue.hidden =YES;
    cell.CONTINUTRand.hidden=YES;
    ////NSLog(@"ipx %i", ipx);
    
    [cell.imgModifica setUserInteractionEnabled:NO];
    cell.TitluRand.userInteractionEnabled =NO;
    [cell.labelModifica setUserInteractionEnabled:NO];
    cell.imgModifica.hidden=NO;
    cell.labelModifica.hidden=NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.pozaRow.hidden =YES;
    cell.dynamicheightCONTINUTRAND.constant = 43;
    switch (ipx) {
        case 0: case 2: case 4: case 6: case 8: case 10: {
            cell.TitluRand.textColor =  [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:1];
            cell.CONTINUTRand.hidden=YES;
            cell.TitluRand.hidden=NO;
            cell.TitluRand.text =[NSString stringWithFormat:@"%@",[self.titluriCAMPURI objectAtIndex:ipx]];
            cell.imgModifica.hidden=NO;
            cell.labelModifica.hidden=NO;
            cell.backgroundColor = [UIColor colorWithRed:(240/255.0f) green:(240/255.0f) blue:(240/255.0f) alpha:1];
        } break;
        case 1: case 3: case 9: case 11: {
            cell.TitluRand.textColor =  [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:1];
            cell.CONTINUTRand.hidden=NO;
            cell.TitluRand.hidden=YES;
            cell.CONTINUTRand.text =[NSString stringWithFormat:@"%@",[self.titluriCAMPURI objectAtIndex:ipx]];
            cell.imgModifica.hidden=YES;
            cell.labelModifica.hidden=YES;
            cell.backgroundColor = [UIColor whiteColor];
           
        } break;
        case 5: {
            NSInteger ipxrow = indexPath.row;
            NSMutableArray *telefoane = [NSMutableArray arrayWithArray:[self.titluriCAMPURI objectAtIndex:5]];
            NSLog(@"telefoane %@",telefoane);
            NSString *telefonuser = [NSString stringWithFormat:@"%@", [telefoane objectAtIndex:ipxrow]];
            cell.CONTINUTRand.hidden=NO;
            cell.TitluRand.hidden=YES;
            cell.CONTINUTRand.text =telefonuser;
            cell.imgModifica.hidden=YES;
            cell.labelModifica.hidden=YES;
            cell.backgroundColor =[UIColor whiteColor];
        } break;
        case 7: {
            cell.TitluRand.textColor =  [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:1];
            cell.CONTINUTRand.hidden=NO;
            cell.TitluRand.hidden=YES;
            cell.CONTINUTRand.text =[NSString stringWithFormat:@"%@",[self.titluriCAMPURI objectAtIndex:7]];
            NSLog(@" cell.CONTINUTRand.text %@", cell.CONTINUTRand.text);
            cell.imgModifica.hidden=YES;
            cell.labelModifica.hidden=YES;
            cell.backgroundColor = [UIColor whiteColor];
            NSString *textadresa = [NSString stringWithFormat:@"%@",[self.titluriCAMPURI objectAtIndex:7]];
            CGFloat widthWithInsetsApplied = self.view.frame.size.width-30;
            CGSize textSize = [textadresa boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18]} context:nil].size;
            double heightrow = textSize.height +10;
            cell.dynamicheightCONTINUTRAND.constant = heightrow;
          //  cell.dynamicheightCONTINUTRAND.constant = 43; // in functie de adresa
            
        }
      
    }
    
    
    ///////
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // [LISTASELECT cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger ipx = indexPath.section;
    NSLog(@"ipx %li", (long)ipx);
    //   CellChooseLogin *CELL = (CellChooseLogin *)[LISTASELECT cellForRowAtIndexPath:indexPath];
    switch (ipx) {
        case 0:  {
            //Date personale",@"Preferințe notificări
            NSLog(@"Prenume și Nume");
            choose4view *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Choose4VC"];
            vc.CE_TIP_E =@"prenumenume";// chose 5 maybe to keep clear.
            [self.navigationController pushViewController:vc animated:YES ];
            break;
        }
        case 2: {
            choose4view *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Choose4VC"];
            vc.CE_TIP_E =@"email";// chose 5 maybe to keep clear.
           [self.navigationController pushViewController:vc animated:YES ];
            break;
            
        }
        case 4: {
            choose4view *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Choose4VC"];
            vc.CE_TIP_E =@"telefon";// chose 5 maybe to keep clear.
            [self.navigationController pushViewController:vc animated:YES ];
            break;
            
        }
        case 6: {
            EcranAdresaViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"EcranAdresaVC"];
            vc.CE_TIP_E =@"adresa";
            [self.navigationController pushViewController:vc animated:YES ];
            break;
            
        }
        case 8: {
            NSLog(@"Parola mod");
            choose4view *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Choose4VC"];
            vc.CE_TIP_E = @"modificareparola";
            [self.navigationController pushViewController:vc animated:YES ];
            break;
        }
        case 10: {
            
            NSLog(@"Preferințe notificări");
            chooseview *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Choose1VC"];
            vc.data =[[NSArray alloc]init];
            vc.data =@[@"Vreau să primesc notificări...",@"În aplicație",@"Pe e-mail",@"În aplicație și pe e-mail",@""];
            vc.CE_TIP_E = @"Preferintenotificari";
            [self.navigationController pushViewController:vc animated:YES ];
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

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}



@end


