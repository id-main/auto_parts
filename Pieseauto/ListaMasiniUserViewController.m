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
#import "ListaMasiniUserViewController.h"
#import "CellMasinileMeleRow.h"
#import "TutorialHomeViewController.h"
#import <CoreText/CoreText.h>
#import "butoncustomback.h"

@interface ListaMasiniUserViewController(){
    NSMutableArray* Cells_Array;
}
@end

@implementation ListaMasiniUserViewController
@synthesize  LISTASELECT,titluriCAMPURI;
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
  //  [self.navigationController popViewControllerAnimated:NO];
    utilitar=[[Utile alloc] init];
    [utilitar mergiLaMainViewVC];
}

-(void)viewWillAppear:(BOOL)animated {
    NSLog(@"masinile mele");
    self.title = @"Preselecție mașină";
    self.titluriCAMPURI =titluriCAMPURI;
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
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    LISTASELECT.delegate =self;
    LISTASELECT.dataSource =self;
    LISTASELECT.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
   
  
  
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self titluriCAMPURI].count +2; // 1 label sus si 1 jos
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger ipx = indexPath.row;
    NSInteger totalRow = [self titluriCAMPURI].count +2;
    double inaltimerand =55;
    if(ipx ==0) {
        inaltimerand = 55;
    } else  if(indexPath.row == totalRow-1){
    inaltimerand = 55;
    } else {
      NSDictionary *celldict = [self.titluriCAMPURI objectAtIndex:ipx-1]; //pt ca 0 de intotdeauna label
        NSString *PRODUCATORAUTODEF =@"";
        NSString *MARCAAUTODEF =@"";
        NSString *ANMASINA = @"";
        NSString *VARIANTA = @"";
        NSString *MOTORIZARE =@"";
        if(celldict[@"C_model_id"]) MARCAAUTODEF = [NSString stringWithFormat:@"%@",celldict[@"C_model_id"]];
        if(celldict[@"C_producator_id"])      PRODUCATORAUTODEF = [NSString stringWithFormat:@"%@",celldict[@"C_producator_id"]];
        if(celldict[@"C_talon_an_fabricatie"])    ANMASINA = [NSString stringWithFormat:@"%@",celldict[@"C_talon_an_fabricatie"]];
        if(celldict[@"C_talon_tip_varianta"]) VARIANTA = [NSString stringWithFormat:@"%@",celldict[@"C_talon_tip_varianta"]];
        if(celldict[@"C_motorizare"]) MOTORIZARE = [NSString stringWithFormat:@"%@",celldict[@"C_motorizare"]];

        NSString *PRODUCATORAUTO = @"";
        NSString *MARCAAUTO =@"";
        if(![self MyStringisEmpty:PRODUCATORAUTODEF]) {
        NSDictionary *producatorbaza = [DataMasterProcessor getProducator:PRODUCATORAUTODEF];
        if(producatorbaza && producatorbaza[@"name"]) {
            PRODUCATORAUTO = [NSString stringWithFormat:@"%@",producatorbaza[@"name"]];
        }
        }
          if(![self MyStringisEmpty:MARCAAUTODEF]) {
        NSDictionary *marcaautobaza = [DataMasterProcessor getMarcaAuto:MARCAAUTODEF];
     ///////   NSLog(@"marca baza %@", marcaautobaza);
        if(marcaautobaza && marcaautobaza[@"name"]) {
            MARCAAUTO = [NSString stringWithFormat:@"%@",marcaautobaza[@"name"]];
        }
        }
        
        NSString *compus = [NSString stringWithFormat:@"%@ %@ %@ %@ %@", PRODUCATORAUTO, MARCAAUTO, ANMASINA, VARIANTA, MOTORIZARE];
        CGFloat widthWithInsetsApplied = self.view.frame.size.width -58;
        CGSize textSize = [compus boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
        inaltimerand= textSize.height +25;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger ipx = indexPath.row;

    static NSString *CellIdentifier = @"CellMasinileMeleRow";
    CellMasinileMeleRow *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (CellMasinileMeleRow*)[tableView dequeueReusableCellWithIdentifier:@"CellMasinileMeleRow"];
    }
    cell.sageatagri.hidden=YES;
    cell.sageatablue.hidden=YES;
    cell.TitluRand.hidden =NO;
    cell.TitluRand.numberOfLines=2;
    NSInteger totalRow = [tableView numberOfRowsInSection:indexPath.section];//first get total rows in that section by current indexPath.
   
    if(indexPath.row == totalRow -1){
    //this is the last row in section.
     NSString *textrow = @"Altă mașină";
     cell.TitluRand.text =textrow;
     cell.TitluRand.textColor = [UIColor blackColor];
     cell.sageatablue.hidden=NO;
     cell.TitluRand.textColor =  [UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] ;

    } else if(ipx ==0 ) {
     cell.backgroundColor = [UIColor colorWithRed:(240/255.0f) green:(240/255.0f) blue:(240/255.0f) alpha:1];
     cell.TitluRand.textColor = [UIColor blackColor];
     utilitar= [[Utile alloc]init];
     NSString *textrow = @"Alege mașina pentru care cauți piesă";
     cell.TitluRand.text =textrow;
     cell.TitluRand.textAlignment = NSTextAlignmentCenter;
     cell.TitluRand.font = [UIFont boldSystemFontOfSize:19];
    }
    else {
       cell.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1];
       cell.sageatagri.hidden=NO;
        NSDictionary *celldict = [self.titluriCAMPURI objectAtIndex:ipx-1];  //pentru ca 0 e text simplu
        NSLog(@"celldict %@", celldict);
        NSMutableDictionary *CERERE = [[NSMutableDictionary alloc]init];
        /*
         "C_authtoken" = "1248f7g56f8ec0cgyjkcXQUS4zFv6xo-Pm3zE0EpU5k3hWmI14B9Y_duF5s";
         "C_model_id" = 39;
         "C_motorizare" = sdxc;
         "C_producator_id" = 3;
         "C_talon_an_fabricatie" = 1982;
         "C_talon_nr_identificare" = dcv;
         "C_talon_tip_varianta" = ggxhxhh;
         id = "<null>";
         */
        NSString *PRODUCATORAUTODEF =@"";
        NSString *MARCAAUTODEF =@"";
        NSString *ANMASINA = @"";
        NSString *VARIANTA = @"";
        NSString *MOTORIZARE =@"";
     
        if(celldict[@"C_model_id"]) {
           [CERERE setObject:celldict[@"C_model_id"] forKey:@"MARCAAUTO"];
           MARCAAUTODEF = [NSString stringWithFormat:@"%@",CERERE[@"MARCAAUTO"]];
        }
        
        if(celldict[@"C_producator_id"]){
           [CERERE setObject:celldict[@"C_producator_id"] forKey:@"PRODUCATORAUTO"];
           PRODUCATORAUTODEF = [NSString stringWithFormat:@"%@",CERERE[@"PRODUCATORAUTO"]];
        }
        if(celldict[@"C_talon_an_fabricatie"]){
            [CERERE setObject:celldict[@"C_talon_an_fabricatie"] forKey:@"ANMASINA"];
            ANMASINA = [NSString stringWithFormat:@"%@",CERERE[@"ANMASINA"]];
        }
        if(celldict[@"C_talon_tip_varianta"]) {
            [CERERE setObject:celldict[@"C_talon_tip_varianta"] forKey:@"VARIANTA"];
            VARIANTA = [NSString stringWithFormat:@"%@",CERERE[@"VARIANTA"]];
        }
        if(celldict[@"C_motorizare"]) {
            [CERERE setObject:celldict[@"C_motorizare"] forKey:@"MOTORIZARE"];
            MOTORIZARE = [NSString stringWithFormat:@"%@",CERERE[@"MOTORIZARE"]];
        }
            // vezi la did select mai jos toate campurile precompletate
     
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
        
        AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        del.cererepiesa = CERERE;
        NSString *compus = [NSString stringWithFormat:@"%@ %@ %@ %@ %@", PRODUCATORAUTO, MARCAAUTO, ANMASINA, VARIANTA, MOTORIZARE];
        cell.TitluRand.textColor = [UIColor blackColor];
        CGFloat widthWithInsetsApplied = self.view.frame.size.width -58;
        double inaltimerand=0;
        CGSize textSize = [compus boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
        inaltimerand= textSize.height +10;
        cell.dynamictableheightJ.constant = inaltimerand;
        cell.TitluRand.text = compus;
       }
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    return cell;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // [LISTASELECT cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int ipx = (int)indexPath.row;
     NSInteger totalRow = [tableView numberOfRowsInSection:indexPath.section];//first get total rows in that section by current indexPath.
    if(indexPath.row == totalRow -1){
        //this is the last row in section. -> adauga cerere noua
        AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        del.cererepiesa = [[NSMutableDictionary alloc]init];
        del.POZECERERE = [[NSMutableArray alloc]init];
        del.ARRAYASSETURI = [[NSMutableArray alloc]init];
        del.ARRAYASSETURIEXTERNE = [[NSMutableArray alloc]init];
        CerereNouaViewController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"CerereNouaViewVC"];
        [self.navigationController pushViewController:vc animated:YES ];
    } else if(ipx ==0) {
          NSLog(@"nothing to do");
    
    }   else {
        AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSDictionary *celldict = [self.titluriCAMPURI objectAtIndex:ipx-1];
     ///////   NSLog(@"celldict %@", celldict);
        NSMutableDictionary *CERERE = [[NSMutableDictionary alloc]init];
        NSString *PRODUCATORAUTODEF =@"";
        NSString *MARCAAUTODEF =@"";
        NSString *ANMASINA = @"";
        NSString *VARIANTA = @"";
        NSString *MOTORIZARE =@"";
        NSString *SERIESASIU =@"";
        
        if(celldict[@"C_model_id"]) {
            [CERERE setObject:celldict[@"C_model_id"] forKey:@"MARCAAUTO"];
            MARCAAUTODEF = [NSString stringWithFormat:@"%@",CERERE[@"MARCAAUTO"]];
        }
        if(celldict[@"C_producator_id"]){
            [CERERE setObject:celldict[@"C_producator_id"] forKey:@"PRODUCATORAUTO"];
            PRODUCATORAUTODEF = [NSString stringWithFormat:@"%@",CERERE[@"PRODUCATORAUTO"]];
        }
        if(celldict[@"C_talon_an_fabricatie"]){
            [CERERE setObject:celldict[@"C_talon_an_fabricatie"] forKey:@"ANMASINA"];
            ANMASINA = [NSString stringWithFormat:@"%@",CERERE[@"ANMASINA"]];
        }
        if(celldict[@"C_talon_tip_varianta"]) {
            [CERERE setObject:celldict[@"C_talon_tip_varianta"] forKey:@"VARIANTA"];
            VARIANTA = [NSString stringWithFormat:@"%@",CERERE[@"VARIANTA"]];
        }
        if(celldict[@"C_motorizare"]) {
            [CERERE setObject:celldict[@"C_motorizare"] forKey:@"MOTORIZARE"];
            MOTORIZARE = [NSString stringWithFormat:@"%@",CERERE[@"MOTORIZARE"]];
        }
        if(celldict[@"C_talon_nr_identificare"]) {
            [CERERE setObject:celldict[@"C_talon_nr_identificare"] forKey:@"SERIESASIU"];
            SERIESASIU = [NSString stringWithFormat:@"%@",CERERE[@"SERIESASIU"]];
        }
        del.cererepiesa = CERERE;
        del.POZECERERE = [[NSMutableArray alloc]init];
        del.ARRAYASSETURI = [[NSMutableArray alloc]init];
        del.ARRAYASSETURIEXTERNE = [[NSMutableArray alloc]init];
        CerereNouaViewController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"CerereNouaViewVC"];
        [self.navigationController pushViewController:vc animated:YES ];
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



@end


