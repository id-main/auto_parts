//
//  CerereNouaViewController.m
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
#import "CerereNouaViewController.h"
#import "TutorialHomeViewController.h"
#import "chooseview.h"
#import <CoreText/CoreText.h>
#import "pozeviewVC.h"
#import "TabelPozeCerereVC.h"
#import "choseLoginview.h"
#import "EcranCerereTrimisaViewController.h"
#import "Reachability.h"
#import "UIAlertView+Blocks.h"
//@import Photos iOS 8
#import <Photos/PHPhotoLibrary.h>
#import <Photos/PHImageManager.h>
#import <Photos/PHAsset.h>
#import <Photos/PHFetchResult.h>
#import <Photos/PHFetchOptions.h>
//@import Photos;
//iOS7
#import <AssetsLibrary/AssetsLibrary.h>
#import "butoncustomback.h"



#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
float _initialTVHeight =0;
float _MYkeyboardheight =0;
@interface CerereNouaViewController(){
    NSMutableArray* array;
}
@end

@implementation CerereNouaViewController
@synthesize  ceriofertatext,LISTASELECT,CERERE,piesenoisausecond,pozele,primadata, eineditare,precompletarejudet;
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
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    NSIndexPath *indexPathreload = [NSIndexPath indexPathForRow:0 inSection:0];
    CellHome *updateCell = (CellHome *)[self.LISTASELECT cellForRowAtIndexPath:indexPathreload];
    if ([updateCell.texteditabil.text isEqualToString:@""]) {
        updateCell.texteneeditabil.hidden=NO;
        AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSMutableDictionary *CERERE1 =[[NSMutableDictionary alloc]init];
        CERERE1 = [del.cererepiesa mutableCopy];
        NSString *TEXTCERERE1 = [NSString stringWithFormat:@"%@",updateCell.texteditabil.text];
        [CERERE1 setObject:TEXTCERERE1  forKey:@"TEXTCERERE"];
        CERERE =CERERE1;
        del.cererepiesa = CERERE1;
    } else {
        AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSMutableDictionary *CERERE1 =[[NSMutableDictionary alloc]init];
        CERERE1 = [del.cererepiesa mutableCopy];
        NSString *TEXTCERERE1 = [NSString stringWithFormat:@"%@",updateCell.texteditabil.text];
        [CERERE1 setObject:TEXTCERERE1  forKey:@"TEXTCERERE"];
        del.cererepiesa = CERERE1;
        CERERE =CERERE1;
        updateCell.texteneeditabil.hidden=YES;
    }
    
    [updateCell.texteditabil resignFirstResponder];
    return YES;
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    NSIndexPath *indexPathreload = [NSIndexPath indexPathForRow:0 inSection:0];
    CellHome *updateCell = (CellHome *)[self.LISTASELECT cellForRowAtIndexPath:indexPathreload];
    if(![self MyStringisEmpty:updateCell.texteditabil.text]) {
        updateCell.texteneeditabil.hidden=YES;
    } else {
        updateCell.texteneeditabil.hidden=NO;
    }
    updateCell.texteditabil.textColor = [UIColor blackColor]; //optional
    //  }
    //[texteditabil becomeFirstResponder];
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    //  Make the textView visible in-case the keyboard has covered it
    //      [texteditabil setSelectedRange:NSMakeRange(0, texteditabil.text.length)];
    //  [texteditabil setText:@""];
    NSLog(@"shrau");
    NSIndexPath *indexPathreload = [NSIndexPath indexPathForRow:0 inSection:0];
    CellHome *updateCell = (CellHome *)[self.LISTASELECT cellForRowAtIndexPath:indexPathreload];
    updateCell.texteditabil.selectedRange = NSMakeRange(0, 0);
    return YES;
}



- (void)textViewDidEndEditing:(UITextView *)textView
{
    NSIndexPath *indexPathreload = [NSIndexPath indexPathForRow:0 inSection:0];
    CellHome *updateCell = (CellHome *)[self.LISTASELECT cellForRowAtIndexPath:indexPathreload];
    if(![self MyStringisEmpty:updateCell.texteditabil.text]) {
        updateCell.texteneeditabil.hidden=YES;
        AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSMutableDictionary *CERERE1 =[[NSMutableDictionary alloc]init];
        CERERE1 = [del.cererepiesa mutableCopy];
        NSString *TEXTCERERE1 = [NSString stringWithFormat:@"%@",updateCell.texteditabil.text];
        [CERERE1 setObject:TEXTCERERE1  forKey:@"TEXTCERERE"];
        del.cererepiesa = CERERE1;
        CERERE =CERERE1;
    } else {
        AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSMutableDictionary *CERERE1 =[[NSMutableDictionary alloc]init];
        CERERE1 = [del.cererepiesa mutableCopy];
        NSString *TEXTCERERE1 = [NSString stringWithFormat:@"%@",updateCell.texteditabil.text];
        [CERERE1 setObject:TEXTCERERE1  forKey:@"TEXTCERERE"];
        del.cererepiesa = CERERE1;
        CERERE =CERERE1;
        updateCell.texteneeditabil.hidden=NO;
        updateCell.texteditabil.textColor =[UIColor colorWithRed:255/255.0f green:102/255.0f blue:0/255.0f alpha:1];
    }
    [updateCell.texteditabil resignFirstResponder];
    
}

- (void) textViewDidChange:(UITextView *)textView
{
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSIndexPath *indexPathreload = [NSIndexPath indexPathForRow:0 inSection:0];
    CellHome *updateCell = (CellHome *)[self.LISTASELECT cellForRowAtIndexPath:indexPathreload];
    
    NSMutableDictionary *CERERE1 =[[NSMutableDictionary alloc]init];
    CERERE1 = [del.cererepiesa mutableCopy];
    //   NSLog(@"did cha %@", textView.text);
    if ([updateCell.texteditabil.text isEqualToString:@""]) {
        updateCell.texteneeditabil.hidden=NO;
        NSString *TEXTCERERE1 = [NSString stringWithFormat:@"%@",updateCell.texteditabil.text];
        [CERERE1 setObject:TEXTCERERE1  forKey:@"TEXTCERERE"];
    } else {
        NSString *TEXTCERERE1 = [NSString stringWithFormat:@"%@",updateCell.texteditabil.text];
        [CERERE1 setObject:TEXTCERERE1  forKey:@"TEXTCERERE"];
        updateCell.texteneeditabil.hidden=YES;
    }
//   NSLog(@" self.view.frame.size.width %f", self.view.frame.size.width);
//     CGFloat widthWithInsetsApplied = self.view.frame.size.width-50;
//    //schimbat font in 17
//     CGSize textSize = [updateCell.texteditabil.text boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
//     double heightrow= textSize.height+22;
//  NSLog(@"heightrow specx %f",heightrow);
//    UITextPosition *position = textView.endOfDocument;
//    CGRect currectRect       = [textView caretRectForPosition:position];
//    
//    if(currectRect.origin.x == 0)
//    {
        CGFloat fixedWidth = updateCell.texteditabil.frame.size.width;
        CGSize newSize = [updateCell.texteditabil sizeThatFits:(CGSizeMake(fixedWidth, MAXFLOAT))];
   
    [self.LISTASELECT beginUpdates];
    if(newSize.height < 40) {
        updateCell.dynamicheighttexteditabil.constant =65;
    } else {
        updateCell.dynamicheighttexteditabil.constant =newSize.height+35;
    }
    [updateCell setNeedsLayout];
     del.cererepiesa = CERERE1;
     CERERE =CERERE1;
    [self.LISTASELECT endUpdates];
//    } else {
//        CGFloat fixedWidth = textView.frame.size.width;
//        CGSize newSize = [updateCell.texteditabil sizeThatFits:(CGSizeMake(fixedWidth, MAXFLOAT))];
//        
//        [self.LISTASELECT beginUpdates];
//        if(newSize.height < 40) {
//            updateCell.dynamicheighttexteditabil.constant =55;
//        } else {
//            updateCell.dynamicheighttexteditabil.constant =newSize.height+35;
//        }
//        [updateCell setNeedsLayout];
//        del.cererepiesa = CERERE1;
//        CERERE =CERERE1;
//        [self.LISTASELECT endUpdates];
//    }
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    eineditare =YES;
    _initialTVHeight = self.LISTASELECT.frame.size.height;
    CGRect initialFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect convertedFrame = [self.view convertRect:initialFrame fromView:nil];
    CGRect tvFrame = self.LISTASELECT.frame;
    tvFrame.size.height = convertedFrame.origin.y;
    _MYkeyboardheight = convertedFrame.origin.y;
    [self.LISTASELECT setFrame:tvFrame];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.LISTASELECT setNeedsDisplay];
    });
    
    
}
- (void)keyboardWillHide:(NSNotification *)notification
{
    eineditare =NO;
    CGRect tvFrame = self.LISTASELECT.frame;
    tvFrame.size.height = _initialTVHeight;
    [UIView beginAnimations:@"TableViewDown" context:NULL];
    [UIView setAnimationDuration:0.3f];
    self.LISTASELECT.frame = tvFrame;
    [UIView commitAnimations];
    _MYkeyboardheight =0;
    dispatch_async(dispatch_get_main_queue(), ^{
        NSArray *cells = [self.LISTASELECT visibleCells];
        for(UIView *view in cells){
            if([view isMemberOfClass:[CellHome class]]){
                CellHome *cell = (CellHome *) view;
                UITextView *tf = (UITextView *)[cell texteditabil];
                if(tf.hidden ==NO) {
                    if ([tf.text isEqualToString:@""]) {
                        AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                        NSMutableDictionary *CEREREx =[[NSMutableDictionary alloc]init];
                        CEREREx = [del.cererepiesa mutableCopy];
                        NSString *TEXTCERERE = [NSString stringWithFormat:@"%@",tf.text];
                        [CEREREx setObject:TEXTCERERE  forKey:@"TEXTCERERE"];
                        del.cererepiesa = CEREREx;
                    } else {
                        AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                        NSMutableDictionary *CEREREx =[[NSMutableDictionary alloc]init];
                        CEREREx = [del.cererepiesa mutableCopy];
                        NSString *TEXTCERERE = [NSString stringWithFormat:@"%@",tf.text];
                        [CEREREx setObject:TEXTCERERE  forKey:@"TEXTCERERE"];
                        del.cererepiesa = CEREREx;
                        
                    }
                }
                break;
            }
        }
        [self.LISTASELECT setNeedsDisplay];
    });
    
}


-(void)viewDidAppear:(BOOL)animated {
    // la register sau login
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(del.vinedincerere ) {
        del.vinedincerere =NO;
    }
    //a venit din reg sau login fa send la cerere
    if( del.inapoilacereredinlogin) {
        [self trimiteCEREREA];
    }
}
-(void)perfecttimeforback{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)viewWillAppear:(BOOL)animated {
    [self removehud];
    self.title = @"Cere ofertă piese";
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
    CERERE =[[NSMutableDictionary alloc]init];
    CERERE = [del.cererepiesa mutableCopy];
    ///////  NSLog(@"after mod %@",CERERE);
    //precompleteaza camp judet si localitate daca userul e logat *** feature request
      self.pozele = [[NSMutableArray alloc]init];
    pozele = del.POZECERERE;
    NSLog(@"pozelepozelepozelepozelepozele%@", pozele);
    /*
     NSMutableDictionary *CERERE = [del.cererepiesa copy];
     
     [CERERE setObject:@"" forKey:@"TEXTCERERE"];
     [CERERE setObject:@"" forKey:@"PRODUCATORAUTO"];
     [CERERE setObject:@"" forKey:@"MARCAAUTO"];
     [CERERE setObject:@"" forKey:@"JUDET"];
     [CERERE setObject:@"" forKey:@"LOCALITATE"];
     [CERERE setObject:@"" forKey:@"ANMASINA"];
     [CERERE setObject:@"" forKey:@"VARIANTA"];
     [CERERE setObject:@"" forKey:@"MOTORIZARE"];
     [CERERE setObject:@"" forKey:@"SERIESASIU"];
     [CERERE setObject:@"" forKey:@"PIESENOISECOND"];
     */
    
    
    self.titluri =@[@"Ce piesă auto cauți?",@"Mașina", @"Piesă nouă sau second?",@"Zona de livrare",@""];
    self.subtitluri= [[NSArray alloc]init];
    self.subtitluri = @[@"",@"Alege marca și modelul mașinii",@"Vrei piesă nouă sau second hand?",@"Alege județul și localitatea de livrare",@"",@""];
    self.piesenoisausecond =@[@"",@"Piese noi",@"Piese second",@"Piese noi și second",@""];
    [LISTASELECT reloadData];
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"atraspoze" object:nil];
    
}
-(void)testare{
    NSLog(@"back btn clear all datas");
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    [LISTASELECT setDelegate:self];
    [LISTASELECT setDataSource:self];
    LISTASELECT.scrollEnabled = YES;
    LISTASELECT.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    UIEdgeInsets inset = UIEdgeInsetsMake(0, 0, 0, 0);
    LISTASELECT.contentInset = inset;
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    // Do any additional setup after loading the view, typically from a nib.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5; //pentru ca ultimul rand va fi unul gol doar pentru scroll
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger ceva =indexPath.row;
    double cellHeightcustom =55;
    if(ceva ==0) {
        NSString *TEXTCERERE = [NSString stringWithFormat:@"%@",CERERE[@"TEXTCERERE"]];
        CGFloat widthWithInsetsApplied = self.view.frame.size.width-69; //test on 4
        ////   NSLog(@"check this out %@",TEXTCERERE);
        BOOL Egol  = [self MyStringisEmpty:TEXTCERERE];
        if(!Egol) {
            CGSize textSize = [TEXTCERERE boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
            double  heightrow= textSize.height ;
            cellHeightcustom =heightrow +85; // maybe
            
        } else {
            NSString *needitabil  =@"Exemplu: Bară față roșie Renault Megane 2014";
            CGSize textSize = [needitabil boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
            double heightrow= textSize.height;
          NSLog(@"heightrow specx %f",heightrow);
            cellHeightcustom =heightrow +85;
         }
    }
    if(ceva ==1) {
        NSString *PRODUCATORAUTODEF = @"";
        NSString *MARCAAUTODEF= @"";
        NSString *ANMASINA = @"";
        NSString *VARIANTA = @"";
        NSString *MOTORIZARE = @"";
        NSString *SERIESASIU = @"";
        NSString *PRODUCATORAUTO = @"";
        NSString *MARCAAUTO =@"";
        
        if(CERERE[@"PRODUCATORAUTO"]) PRODUCATORAUTODEF = [NSString stringWithFormat:@"%@",CERERE[@"PRODUCATORAUTO"]];
        if(CERERE[@"MARCAAUTO"]) MARCAAUTODEF = [NSString stringWithFormat:@"%@",CERERE[@"MARCAAUTO"]];
        if(CERERE[@"ANMASINA"]) ANMASINA = [NSString stringWithFormat:@"%@",CERERE[@"ANMASINA"]];
        if(CERERE[@"VARIANTA"]) VARIANTA = [NSString stringWithFormat:@"%@",CERERE[@"VARIANTA"]];
        if(CERERE[@"MOTORIZARE"]) MOTORIZARE = [NSString stringWithFormat:@"%@",CERERE[@"MOTORIZARE"]];
        if(CERERE[@"SERIESASIU"])SERIESASIU = [NSString stringWithFormat:@"%@",CERERE[@"SERIESASIU"]];
        NSDictionary *producatorbaza = [DataMasterProcessor getProducator:PRODUCATORAUTODEF];
        if(producatorbaza && producatorbaza[@"name"]) {
            PRODUCATORAUTO = [NSString stringWithFormat:@"%@",producatorbaza[@"name"]];
        }
        NSDictionary *marcaautobaza = [DataMasterProcessor getMarcaAuto:MARCAAUTODEF];
        ///// JNSLog(@"marca baza %@", marcaautobaza);
        if(marcaautobaza && marcaautobaza[@"name"]) {
            MARCAAUTO = [NSString stringWithFormat:@"%@",marcaautobaza[@"name"]];
        }
        BOOL Egol =YES;
        Egol  = [self MyStringisEmpty:PRODUCATORAUTO];
        Egol  = [self MyStringisEmpty:ANMASINA];
        Egol  = [self MyStringisEmpty:MARCAAUTO];
        Egol  = [self MyStringisEmpty:VARIANTA];
        Egol  = [self MyStringisEmpty:MOTORIZARE];
        NSString *ceva =@"";
        if(!Egol) {
            BOOL egol1= [self MyStringisEmpty:SERIESASIU];
            if(!egol1) {
                ceva = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ șasiu %@", PRODUCATORAUTO,MARCAAUTO,ANMASINA,VARIANTA,MOTORIZARE,SERIESASIU];
            } else {
                ceva = [NSString stringWithFormat:@"%@ %@ %@ %@ %@", PRODUCATORAUTO,MARCAAUTO,ANMASINA,VARIANTA,MOTORIZARE];
            }
        } else {
            ceva = [NSString stringWithFormat:@"%@",[self.subtitluri objectAtIndex:indexPath.row]];
            
        }
        double heightrow =0;
        CGFloat widthWithInsetsApplied = self.view.frame.size.width-54;
        
        CGSize textSize = [ceva boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
        heightrow= textSize.height +65;
        cellHeightcustom =heightrow;
        //cellHeightcustom =135;
        
    }
    if( ceva ==2) {
        NSString *PIESENOI = [NSString stringWithFormat:@"%@",CERERE[@"IS_NEW"]];
        NSString *PIESESECOND = [NSString stringWithFormat:@"%@",CERERE[@"IS_SECOND"]];
        NSString *piesenoisecond =@"";
        
        BOOL Egol =YES;
        Egol = [self MyStringisEmpty:PIESENOI];
        Egol = [self MyStringisEmpty:PIESESECOND];
        if(!Egol) {
            int valoareNOI = PIESENOI.intValue;
            // "is_new": 0 sau 1, "is_second": 0 sau 1} si daca sunt si si se trimit ambele cu 1
            int valoareSECOND = PIESESECOND.intValue;
            //hardcoding ancient items ...
            if( valoareNOI ==1 && valoareSECOND ==1 ){
                piesenoisecond =@"Vreau oferte de piese noi și second";
                
            } else if( valoareNOI ==1 && valoareSECOND ==0){
                piesenoisecond =@"Vreau oferte de piese noi";
                
            } else if( valoareNOI ==0 && valoareSECOND ==1){
                piesenoisecond =@"Vreau oferte de piese second";
                
            } else if( valoareNOI ==0 && valoareSECOND ==0){ // caz in care nu a bifat nimic
                piesenoisecond =[self.subtitluri objectAtIndex:indexPath.row];
            }
            
        } else {
            piesenoisecond =[NSString stringWithFormat:@"%@",[self.subtitluri objectAtIndex:indexPath.row]];
            
        }
        double heightrow =0;
        CGFloat widthWithInsetsApplied = self.view.frame.size.width-54;
        
        CGSize textSize = [piesenoisecond boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
        heightrow= textSize.height +65;
        cellHeightcustom =heightrow;
        
    }
    
    if(ceva ==3) {
        //  cellHeightcustom =96;
        NSString *JUDETNAME = @"";
        NSString *LOCALITATENAME = @"";
        if(CERERE[@"JUDET"]) {
            NSString *JUDET = [NSString stringWithFormat:@"%@",CERERE[@"JUDET"]];
            if(![self MyStringisEmpty:JUDET]) {
                NSDictionary *judbaza = [DataMasterProcessor getJudet:JUDET];
                if(judbaza && judbaza[@"name"]) {
                    JUDETNAME = [NSString stringWithFormat:@"%@",judbaza[@"name"]];
                }
            }
        }
        if(CERERE[@"LOCALITATE"]) {
            NSString *LOCALITATE = [NSString stringWithFormat:@"%@",CERERE[@"LOCALITATE"]];
            if(![self MyStringisEmpty:LOCALITATE]) {
                NSDictionary *LOCALITATEselectata = [DataMasterProcessor getLocalitate:LOCALITATE];
                
                if(LOCALITATEselectata && LOCALITATEselectata[@"name"]) {
                    LOCALITATENAME = [NSString stringWithFormat:@"%@",LOCALITATEselectata[@"name"]];
                }
            }
        }
        NSString *locjudet = @"";
        BOOL Egol =YES;
        /// NSLog(@"after mode %@ %@",CERERE[@"JUDET"],CERERE[@"LOCALITATE"]);
        Egol=[self MyStringisEmpty:JUDETNAME];
        Egol=[self MyStringisEmpty:LOCALITATENAME];
        if(!Egol){
            locjudet = [NSString stringWithFormat:@"%@, Jud. %@", LOCALITATENAME, JUDETNAME];
        } else {
            locjudet =[NSString stringWithFormat:@"%@",[self.subtitluri objectAtIndex:indexPath.row]];
            
        }
        double heightrow =0;
        CGFloat widthWithInsetsApplied = self.view.frame.size.width-54;
        
        CGSize textSize = [locjudet boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
        heightrow= textSize.height +65;
        cellHeightcustom =heightrow;
        
        
    }
    if(ceva ==4) { cellHeightcustom =140; }
    return cellHeightcustom;
    //  return UITableViewAutomaticDimension;
}




#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(void)focusfirstfieldDINTABEL{
    NSArray *cells = [self.LISTASELECT visibleCells];
    for(UIView *view in cells){
        if([view isMemberOfClass:[CellHome class]]){
            CellHome *cell = (CellHome *) view;
            UITextView *tf = (UITextView *)[cell texteditabil];
            if(tf.hidden ==NO) {
                //     [tf becomeFirstResponder];
                [tf performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0];
            }
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CERERE =[[NSMutableDictionary alloc]init];
    CERERE = [del.cererepiesa mutableCopy];
    
    ////////  NSLog(@"after mod %@",CERERE);
    static NSString *CellIdentifier = @"CellHomeCustom";
    CellHome *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (CellHome*)[tableView dequeueReusableCellWithIdentifier:@"CellHomeCustom"];
    }
    int ipx = (int)indexPath.row;
    cell.ALEGE.userInteractionEnabled =NO;
    cell.CEREACUM.userInteractionEnabled =NO;
    //  cell.TitluRand.verticalAlignment=TTTAttributedLabelVerticalAlignmentTop;
    //  cell.SubtitluRand.verticalAlignment=TTTAttributedLabelVerticalAlignmentTop;
    cell.texteneeditabil.hidden=YES;
    cell.RANDSECUNDAR.hidden=YES;
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    cell.TitluRand.text =[self.titluri objectAtIndex:indexPath.row];
      // dynamicheightsybtitlurand,dynamicheighttexteditabil
    switch (ipx) {
        case 0:
        {
           
            UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fapozaAction:)];
            [singleTap setNumberOfTapsRequired:1];
            [cell.fapoza setUserInteractionEnabled:YES];
            [cell.fapoza addGestureRecognizer:singleTap];
            cell.fapoza.selected =NO;
            cell.texteditabil.delegate =self;
            cell.texteditabil.contentInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
            cell.texteditabil.scrollEnabled=NO;
            cell.GriRand.hidden=YES;
            
            //////// [cell loadObjectCell];
            
            if(del.reposteazacerere ==YES && del.ARRAYASSETURIEXTERNE.count>0 ) {
                NSLog(@"ce avem externe  %@ %@",del.ARRAYASSETURIEXTERNE,[del.ARRAYASSETURIEXTERNE class]);
                //NSDict sau Uimage
                if( [[del.ARRAYASSETURIEXTERNE objectAtIndex:0]isKindOfClass:[NSDictionary class]] && [[del.ARRAYASSETURIEXTERNE objectAtIndex:0]respondsToSelector:@selector(allKeys)]) {
                    NSDictionary *detaliupoza =[del.ARRAYASSETURIEXTERNE objectAtIndex:0];
                    
                    if(detaliupoza[@"tb"]) {
                        NSString *calepozaserver = [NSString stringWithFormat:@"%@",detaliupoza[@"tb"]];
                        //sdweb is laggy in iOS8 asa ca :
                        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
                            NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL: [NSURL URLWithString:calepozaserver] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                if (data) {
                                    UIImage *image = [UIImage imageWithData:data];
                                    if (image) {
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            CellHome *updateCell = (CellHome *)[self.LISTASELECT cellForRowAtIndexPath:indexPath];
                                            if (updateCell) {
                                                updateCell.fapoza.hidden =NO;
                                                [updateCell.fapoza.imageView setContentMode:UIViewContentModeScaleAspectFill];
                                                [updateCell.fapoza setImage:image forState:UIControlStateNormal];
                                                [updateCell.fapoza setImage:image forState:UIControlStateSelected];
                                            }
                                        });
                                        
                                    }
                                }
                            }];
                            [task resume];
                        });
                        //
                        //
                        //
                        //
                        //
                        //
                        //             UIImage * imagineda;
                        //                                  NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:calepozaserver]];
                        //                                  imagineda = [UIImage imageWithData:data];
                        //                                  if(imagineda && imagineda.size.height !=0){
                        //           UIImage *thumbpoza1 = imagineda;
                        //          [cell.fapoza.imageView setContentMode:UIViewContentModeScaleAspectFill];
                        //          [cell.fapoza setImage:thumbpoza1 forState:UIControlStateNormal];
                        //          [cell.fapoza setImage:thumbpoza1 forState:UIControlStateSelected];
                        //          }
                    }
                } else if ([[del.ARRAYASSETURIEXTERNE objectAtIndex:0]isKindOfClass:[UIImage class]]) {
                    UIImage *detaliupoza =[del.ARRAYASSETURIEXTERNE objectAtIndex:0];
                    [cell.fapoza.imageView setContentMode:UIViewContentModeScaleAspectFill];
                    [cell.fapoza setImage:detaliupoza forState:UIControlStateNormal];
                    [cell.fapoza setImage:detaliupoza forState:UIControlStateSelected];
                    
                } else {
                    [cell.fapoza setImage:[UIImage imageNamed:@"Icon_Camera_LightGrey_144x144.png"] forState:UIControlStateNormal];
                    [cell.fapoza setImage:[UIImage imageNamed:@"Icon_Camera_BlueJ_144x144.png"] forState:UIControlStateSelected];
                }
            } else if(pozele.count >0) {
                if( [[del.ARRAYASSETURI objectAtIndex:0]isKindOfClass:[NSDictionary class]] && [[del.ARRAYASSETURI objectAtIndex:0]respondsToSelector:@selector(allKeys)]) {
                    NSDictionary *detaliupoza =[del.ARRAYASSETURI objectAtIndex:0];
                    
                    if(detaliupoza[@"tb"]) {
                        NSString *calepozaserver = [NSString stringWithFormat:@"%@",detaliupoza[@"tb"]];
                        //                  UIImage * imagineda;
                        //                  NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:calepozaserver]];
                        //                  imagineda = [UIImage imageWithData:data];
                        //                   if(imagineda && imagineda.size.height !=0){
                        //                      UIImage *thumbpoza1 = imagineda;
                        //                      [cell.fapoza.imageView setContentMode:UIViewContentModeScaleAspectFill];
                        //                      [cell.fapoza setImage:thumbpoza1 forState:UIControlStateNormal];
                        //                      [cell.fapoza setImage:thumbpoza1 forState:UIControlStateSelected];
                        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
                            NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL: [NSURL URLWithString:calepozaserver] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                if (data) {
                                    UIImage *image = [UIImage imageWithData:data];
                                    if (image) {
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            CellHome *updateCell = (CellHome *)[self.LISTASELECT cellForRowAtIndexPath:indexPath];
                                            if (updateCell) {
                                                updateCell.fapoza.hidden =NO;
                                                [updateCell.fapoza.imageView setContentMode:UIViewContentModeScaleAspectFill];
                                                [updateCell.fapoza setImage:image forState:UIControlStateNormal];
                                                [updateCell.fapoza setImage:image forState:UIControlStateSelected];
                                            }
                                        });
                                        
                                    }
                                }
                            }];
                            [task resume];
                        });
                        
                        //                  }
                    }
                } else if ([[del.ARRAYASSETURI objectAtIndex:0]isKindOfClass:[UIImage class]]) {
                    ////////  NSLog(@"ce avem pe aici %@",del.ARRAYASSETURI);
                    UIImage *thumbpoza1 = [del.ARRAYASSETURI objectAtIndex:0];
                    [cell.fapoza.imageView setContentMode:UIViewContentModeScaleAspectFill];
                    [cell.fapoza setImage:thumbpoza1 forState:UIControlStateNormal];
                    [cell.fapoza setImage:thumbpoza1 forState:UIControlStateSelected];
                }else {
                    [cell.fapoza setImage:[UIImage imageNamed:@"Icon_Camera_LightGrey_144x144.png"] forState:UIControlStateNormal];
                    [cell.fapoza setImage:[UIImage imageNamed:@"Icon_Camera_BlueJ_144x144.png"] forState:UIControlStateSelected];
                }
            } else {
                [cell.fapoza setImage:[UIImage imageNamed:@"Icon_Camera_LightGrey_144x144.png"] forState:UIControlStateNormal];
                [cell.fapoza setImage:[UIImage imageNamed:@"Icon_Camera_BlueJ_144x144.png"] forState:UIControlStateSelected];
            }

            
            
            
            cell.GriRand.hidden=NO;
            cell.RANDSECUNDAR.hidden=YES;
            NSString *TEXTCERERE = [NSString stringWithFormat:@"%@",CERERE[@"TEXTCERERE"]];
            /////  NSLog(@"check this out %@",TEXTCERERE);
            BOOL Egol  = [self MyStringisEmpty:TEXTCERERE];
            if(!Egol) {
                cell.texteditabil.text = TEXTCERERE;
                cell.texteneeditabil.hidden=YES;
                cell.texteditabil.textColor = [UIColor colorWithRed:(255/255.0) green:(64/255.0) blue:(0/255.0) alpha:1];
                
            } else {
                // cell.texteditabil.text =@"Exemplu: Bară față roșie Renault Megane 2014";
                cell.texteditabil.text =@"";
                cell.texteneeditabil.hidden=NO;
                cell.texteditabil.textColor = [UIColor colorWithRed:(64/255.0) green:(64/255.0) blue:(64/255.0) alpha:1];
            }
            [cell.contentView bringSubviewToFront:cell.texteditabil];
            
            cell.texteditabil.hidden =NO;
            
            cell.sageata.hidden =YES;
            cell.ALEGE.hidden =YES;
            cell.CEREACUM.hidden =YES;
            cell.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1];
            cell.fapoza.hidden =NO;
            cell.SubtitluRand.text =[self.subtitluri objectAtIndex:indexPath.row];
            if(primadata ==NO) {
                //  [self focusfirstfieldDINTABEL];
                [cell.texteditabil becomeFirstResponder];
                eineditare =YES;
                primadata =YES;
                          }
            double heightrow =0;
             CGFloat widthWithInsetsApplied = self.view.frame.size.width-69;
            if(!Egol && ![cell.texteditabil.text isEqualToString:@"Exemplu: Bară față roșie Renault Megane 2014"]) {
                CGSize textSize = [TEXTCERERE boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
                heightrow= textSize.height +35;
                cell.dynamicheighttexteditabil.constant=heightrow;
            } else {
                CGFloat widthWithInsetsApplied = self.view.frame.size.width-69;
                CGSize textSize = [cell.texteneeditabil.text boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
                heightrow= textSize.height +35;
                cell.dynamicheighttexteditabil.constant=heightrow;
            }
        }
            break;
        case 1:
        {
            cell.sageata.hidden =NO;
            cell.RANDSECUNDAR.hidden=NO;
            cell.GriRand.hidden=NO;
            NSString *ceva =@"";
            NSString *PRODUCATORAUTODEF = @"";
            NSString *MARCAAUTODEF= @"";
            NSString *ANMASINA = @"";
            NSString *VARIANTA = @"";
            NSString *MOTORIZARE = @"";
            NSString *SERIESASIU = @"";
            NSString *PRODUCATORAUTO = @"";
            NSString *MARCAAUTO =@"";
            
            if(CERERE[@"PRODUCATORAUTO"]) PRODUCATORAUTODEF = [NSString stringWithFormat:@"%@",CERERE[@"PRODUCATORAUTO"]];
            if(CERERE[@"MARCAAUTO"]) MARCAAUTODEF = [NSString stringWithFormat:@"%@",CERERE[@"MARCAAUTO"]];
            if(CERERE[@"ANMASINA"]) ANMASINA = [NSString stringWithFormat:@"%@",CERERE[@"ANMASINA"]];
            if(CERERE[@"VARIANTA"]) VARIANTA = [NSString stringWithFormat:@"%@",CERERE[@"VARIANTA"]];
            if(CERERE[@"MOTORIZARE"]) MOTORIZARE = [NSString stringWithFormat:@"%@",CERERE[@"MOTORIZARE"]];
            if(CERERE[@"SERIESASIU"])SERIESASIU = [NSString stringWithFormat:@"%@",CERERE[@"SERIESASIU"]];
            NSDictionary *producatorbaza = [DataMasterProcessor getProducator:PRODUCATORAUTODEF];
            if(producatorbaza && producatorbaza[@"name"]) {
                PRODUCATORAUTO = [NSString stringWithFormat:@"%@",producatorbaza[@"name"]];
            }
            NSDictionary *marcaautobaza = [DataMasterProcessor getMarcaAuto:MARCAAUTODEF];
            //  jNSLog(@"marca baza %@", marcaautobaza);
            if(marcaautobaza && marcaautobaza[@"name"]) {
                MARCAAUTO = [NSString stringWithFormat:@"%@",marcaautobaza[@"name"]];
            }
            BOOL Egol =YES;
            Egol  = [self MyStringisEmpty:PRODUCATORAUTO];
            Egol  = [self MyStringisEmpty:ANMASINA];
            Egol  = [self MyStringisEmpty:MARCAAUTO];
            Egol  = [self MyStringisEmpty:VARIANTA];
            Egol  = [self MyStringisEmpty:MOTORIZARE];
            
            if(!Egol) {
                BOOL egol1= [self MyStringisEmpty:SERIESASIU];
                if(!egol1) {
                    ceva = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ șasiu %@", PRODUCATORAUTO,MARCAAUTO,ANMASINA,VARIANTA,MOTORIZARE,SERIESASIU];
                } else {
                    ceva = [NSString stringWithFormat:@"%@ %@ %@ %@ %@", PRODUCATORAUTO,MARCAAUTO,ANMASINA,VARIANTA,MOTORIZARE];
                }
                cell.SubtitluRand.textColor = [UIColor colorWithRed:(255/255.0) green:(64/255.0) blue:(0/255.0) alpha:1];
                cell.ALEGE.text =@"Modifică";
            } else {
                ceva = [NSString stringWithFormat:@"%@",[self.subtitluri objectAtIndex:indexPath.row]];
                //   cell.SubtitluRand.textColor = [UIColor colorWithRed:(64/255.0) green:(64/255.0) blue:(64/255.0) alpha:1];
                cell.SubtitluRand.textColor=[UIColor colorWithRed:(168/255.0) green:(168/255.0) blue:(168/255.0) alpha:1];
                cell.ALEGE.text =@"Alege";
            }
            cell.texteditabil.hidden =YES;
            cell.CEREACUM.hidden =YES;
            cell.ALEGE.hidden =NO;
            cell.fapoza.hidden =YES;
            cell.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1];
            cell.SubtitluRand.text =ceva;
            double heightrow =0;
            CGFloat widthWithInsetsApplied = self.view.frame.size.width-54;
            
            CGSize textSize = [ceva boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
            heightrow= textSize.height +15;
            cell.dynamicheightsybtitlurand.constant=heightrow;
            
            
        } break;
        case 2:
        {
            cell.sageata.hidden =NO;
            cell.RANDSECUNDAR.hidden=NO;
            cell.GriRand.hidden=NO;
            NSString *PIESENOI = [NSString stringWithFormat:@"%@",CERERE[@"IS_NEW"]];
            NSString *PIESESECOND = [NSString stringWithFormat:@"%@",CERERE[@"IS_SECOND"]];
            NSString *piesenoisecond =@"";
            
            BOOL Egol =YES;
            Egol = [self MyStringisEmpty:PIESENOI];
            Egol = [self MyStringisEmpty:PIESESECOND];
            if(!Egol) {
                NSInteger valoareNOI = PIESENOI.integerValue;
                // "is_new": 0 sau 1, "is_second": 0 sau 1} si daca sunt si si se trimit ambele cu 1
                NSInteger valoareSECOND = PIESESECOND.integerValue;
                //hardcoding ancient items ...
                //////  cell.SubtitluRand.textColor = [UIColor colorWithRed:(255/255.0) green:(64/255.0) blue:(0/255.0) alpha:1];
                cell.ALEGE.text =@"Modifică";
                if( valoareNOI ==1 && valoareSECOND ==1 ){
                    piesenoisecond =@"Vreau oferte de piese noi și second";
                    cell.SubtitluRand.textColor = [UIColor colorWithRed:(255/255.0) green:(64/255.0) blue:(0/255.0) alpha:1];
                    
                } else if( valoareNOI ==1 && valoareSECOND ==0){
                    piesenoisecond =@"Vreau oferte de piese noi";
                    cell.SubtitluRand.textColor = [UIColor colorWithRed:(255/255.0) green:(64/255.0) blue:(0/255.0) alpha:1];
                    
                } else if( valoareNOI ==0 && valoareSECOND ==1){
                    piesenoisecond =@"Vreau oferte de piese second";
                    cell.SubtitluRand.textColor = [UIColor colorWithRed:(255/255.0) green:(64/255.0) blue:(0/255.0) alpha:1];
                    
                } else if( valoareNOI ==0 && valoareSECOND ==0){ // caz in care nu a bifat nimic
                    piesenoisecond =[self.subtitluri objectAtIndex:indexPath.row];
                    cell.SubtitluRand.textColor = [UIColor colorWithRed:(255/255.0) green:(64/255.0) blue:(0/255.0) alpha:1];
                    cell.ALEGE.text =@"Alege";
                }
                
            }else {
                piesenoisecond =[NSString stringWithFormat:@"%@",[self.subtitluri objectAtIndex:indexPath.row]];
                //j cell.SubtitluRand.textColor = [UIColor colorWithRed:(64/255.0) green:(64/255.0) blue:(64/255.0) alpha:1];
                cell.SubtitluRand.textColor=[UIColor colorWithRed:(168/255.0) green:(168/255.0) blue:(168/255.0) alpha:1];
                cell.ALEGE.text =@"Alege";
            }
            cell.SubtitluRand.text = piesenoisecond;
            double heightrow =0;
            CGFloat widthWithInsetsApplied = self.view.frame.size.width-54;
            
            CGSize textSize = [piesenoisecond boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
            heightrow= textSize.height +15;
            cell.dynamicheightsybtitlurand.constant=heightrow;
            
            
            cell.texteditabil.hidden =YES;
            cell.CEREACUM.hidden =YES;
            cell.ALEGE.hidden =NO;
            cell.fapoza.hidden =YES;
            cell.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1];
            
        }
            break;
        case 3:
        {
            cell.sageata.hidden =NO;
            cell.RANDSECUNDAR.hidden=NO;
            cell.GriRand.hidden=NO;
            if(precompletarejudet ==NO) {
                //now do the magic s-a cerut ca sa se precompleteze campuri judet localitate cu ce are in profil logat
                     AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                    utilitar=[[Utile alloc] init];
                    BOOL eLogat = [utilitar eLogat];
                    if(eLogat) {
                        NSDictionary *userlogat = [DataMasterProcessor getLOGEDACCOUNT];
                        NSLog(@"**userlogat %@",userlogat);
                        if(userlogat[@"U_judet"]) {
                            NSString *judet = [NSString stringWithFormat:@"%@",userlogat[@"U_judet"]];
                            if(![self MyStringisEmpty:judet]) {
                                [CERERE setObject:judet forKey:@"JUDET"];
                                del.cererepiesa =CERERE;
                            }
                        }
                        if(userlogat[@"U_localitate"]) {
                            NSString *localitate = [NSString stringWithFormat:@"%@",userlogat[@"U_localitate"]];
                            if(![self MyStringisEmpty:localitate]) {
                                [CERERE setObject:localitate forKey:@"LOCALITATE"];
                                del.cererepiesa =CERERE;
                            }
                        }
                    }
                  precompletarejudet =YES;

            }
         
           
            NSString *JUDET = [NSString stringWithFormat:@"%@",CERERE[@"JUDET"]];
            NSString *JUDETNAME = @"";
            if(![self MyStringisEmpty:JUDET]) {
                
                NSDictionary *judbaza = [DataMasterProcessor getJudet:JUDET];
                if(judbaza && judbaza[@"name"]) {
                    JUDETNAME = [NSString stringWithFormat:@"%@",judbaza[@"name"]];
                }
            }
            
            NSString *LOCALITATE = [NSString stringWithFormat:@"%@",CERERE[@"LOCALITATE"]];
            NSString *LOCALITATENAME = @"";
            if(![self MyStringisEmpty:LOCALITATE]) {
                NSDictionary *LOCALITATEselectata = [DataMasterProcessor getLocalitate:LOCALITATE];
                
                if(LOCALITATEselectata && LOCALITATEselectata[@"name"]) {
                    LOCALITATENAME = [NSString stringWithFormat:@"%@",LOCALITATEselectata[@"name"]];
                }
            }
            
            NSString *locjudet = @"";
            BOOL Egol =YES;
            // NSLog(@"after mode %@ %@",CERERE[@"JUDET"],CERERE[@"LOCALITATE"]);
            Egol=[self MyStringisEmpty:JUDETNAME];
            Egol=[self MyStringisEmpty:LOCALITATENAME];
            if(!Egol){
                locjudet = [NSString stringWithFormat:@"%@, Jud. %@", LOCALITATENAME, JUDETNAME];
                cell.SubtitluRand.textColor = [UIColor colorWithRed:(255/255.0) green:(64/255.0) blue:(0/255.0) alpha:1];
                cell.ALEGE.text =@"Modifică";
            } else {
                locjudet =[NSString stringWithFormat:@"%@",[self.subtitluri objectAtIndex:indexPath.row]];
                // cell.SubtitluRand.textColor = [UIColor colorWithRed:(64/255.0) green:(64/255.0) blue:(64/255.0) alpha:1];
                cell.SubtitluRand.textColor=[UIColor colorWithRed:(168/255.0) green:(168/255.0) blue:(168/255.0) alpha:1];
                cell.ALEGE.text =@"Alege";
            }
               
            cell.SubtitluRand.text = locjudet;
              
            double heightrow =0;
            CGFloat widthWithInsetsApplied = self.view.frame.size.width-54;
            
            CGSize textSize = [locjudet boundingRectWithSize:CGSizeMake(widthWithInsetsApplied, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
            heightrow= textSize.height +15;
            cell.dynamicheightsybtitlurand.constant=heightrow;
            
            cell.texteditabil.hidden =YES;
            cell.CEREACUM.hidden =YES;
            cell.ALEGE.hidden =NO;
            cell.fapoza.hidden =YES;
            cell.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1];
           
            
        }
            break;
        case 4:
        {
            cell.GriRand.hidden=YES;
            cell.RANDSECUNDAR.hidden=YES;
            cell.texteditabil.hidden =YES;
            cell.sageata.hidden =YES;
            cell.CEREACUM.hidden =NO;
            cell.ALEGE.hidden =YES;
            cell.SubtitluRand.hidden =YES;
            //cell.backgroundColor = [UIColor colorWithRed:(239/255.0f) green:(239/255.0f) blue:(239/255.0f) alpha:1];
            cell.CEREACUM.layer.borderWidth=1.0f;
            cell.CEREACUM.layer.cornerRadius = 5.0f;
            cell.CEREACUM.layer.borderColor=[[UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1] CGColor];
            cell.CEREACUM.backgroundColor=[UIColor colorWithRed:(255/255.0) green:(66/255.0) blue:(0/255.0) alpha:1];
            cell.fapoza.hidden =YES;
            cell.selectionStyle= UITableViewCellSelectionStyleNone;
            
          //  cell.SubtitluRand.text =[self.subtitluri objectAtIndex:indexPath.row];
        }
            break;
        default:
            break;
    }
//    if(ipx ==4) {
//       cell.RANDSECUNDAR.hidden=YES;
//        cell.TitluRand.hidden=YES;
//        cell.GriRand.hidden=YES;
//        cell.texteditabil.hidden =YES;
//        cell.CEREACUM.hidden =NO;
//        cell.ALEGE.hidden =YES;
//        cell.SubtitluRand.hidden =YES;
//        cell.backgroundColor = [UIColor colorWithRed:(239/255.0f) green:(239/255.0f) blue:(239/255.0f) alpha:1];
//        cell.fapoza.hidden=YES;
//    } else {
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.TitluRand.text =[self.titluri objectAtIndex:indexPath.row];
//    }
//    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int ipx = (int)indexPath.row;
    switch (ipx) {
        case 0: {
            NSLog(@"nimic");
        }
            break;
        case 1: {
            NSLog(@"nimic 1");
            chooseview *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Choose1VC"];
            vc.CE_TIP_E = @"Producatori";
            vc.data =[[NSArray alloc]init];
            vc.data = [DataMasterProcessor getProducatori];
            [self.navigationController pushViewController:vc animated:YES ];
            
        }
            break;
        case 2: {
            NSLog(@"la piese noi sau second ");
            //piesenoisausecond
            NSLog(@"la judete ");
            chooseview *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Choose1VC"];
            vc.CE_TIP_E = @"Piesenoisecond";
            vc.data =[[NSArray alloc]init];
            vc.data = self.piesenoisausecond;
            [self.navigationController pushViewController:vc animated:YES ];
        }
            break;
        case 3: {
            NSLog(@"la judete ");
            chooseview *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Choose1VC"];
            vc.CE_TIP_E = @"Judete";
            vc.data =[[NSArray alloc]init];
            vc.data = [DataMasterProcessor getJudete];
            [self.navigationController pushViewController:vc animated:YES ];
        }
            break;
        case 4: {
            NSLog(@"nimic 4"); //aici verific daca a ales model etc. daca nu -> alert
            [self trimiteCEREREA];
        }
            break;
            
        default:
            break;
    }
    
}
-(void)trimiteCEREREA {
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CERERE =[[NSMutableDictionary alloc]init];
    CERERE = [del.cererepiesa mutableCopy];
    
    /*
     [CERERE setObject:@"" forKey:@"TEXTCERERE"];
     [CERERE setObject:@"" forKey:@"PRODUCATORAUTO"];
     [CERERE setObject:@"" forKey:@"MARCAAUTO"];
     [CERERE setObject:@"" forKey:@"JUDET"];
     [CERERE setObject:@"" forKey:@"LOCALITATE"];
     [CERERE setObject:@"" forKey:@"ANMASINA"];
     [CERERE setObject:@"" forKey:@"VARIANTA"];
     [CERERE setObject:@"" forKey:@"MOTORIZARE"];
     [CERERE setObject:@"" forKey:@"SERIESASIU"];
     [CERERE setObject:@"" forKey:@"PIESENOISECOND"];
     */
    NSString *C_producator_id =@"";
    NSString *C_model_id =@"";
    NSString *C_talon_tip_varianta =@"";
    NSString *C_talon_an_fabricatie =@"";
    NSString *C_motorizare =@"";
    NSString *C_talon_nr_identificare =@"";
    NSString *C_title =@"";
    NSString *C_want_new =@"";
    NSString *C_want_second =@"";
    NSString *C_localitate_id=@"";
    
    NSString *eroaretitlu=@"";
    NSString *eroaremasina=@"";
    NSString *eroarepiesanouasausecond=@"";
    NSString *eroarezonadelivrare=@"";
    NSString *eroaredate=@"";
    NSMutableArray *erori = [[NSMutableArray alloc]init];
    
    BOOL ok=NO;
    if([CERERE  objectForKey:@"PRODUCATORAUTO"])  C_producator_id= [NSString stringWithFormat:@"%@",[CERERE  objectForKey:@"PRODUCATORAUTO"]];
    if([CERERE  objectForKey:@"MARCAAUTO"])  C_model_id= [NSString stringWithFormat:@"%@",[CERERE  objectForKey:@"MARCAAUTO"]];
    if([CERERE  objectForKey:@"VARIANTA"])   C_talon_tip_varianta= [NSString stringWithFormat:@"%@",[CERERE  objectForKey:@"VARIANTA"]]; ///txtfld 1
    if([CERERE  objectForKey:@"ANMASINA"])   C_talon_an_fabricatie=[NSString stringWithFormat:@"%@",[CERERE  objectForKey:@"ANMASINA"]];
    if([CERERE  objectForKey:@"MOTORIZARE"]) C_motorizare=[NSString stringWithFormat:@"%@",[CERERE  objectForKey:@"MOTORIZARE"]]; ///txtfld 2
    if([CERERE  objectForKey:@"SERIESASIU"]) C_talon_nr_identificare=[NSString stringWithFormat:@"%@",[CERERE  objectForKey:@"SERIESASIU"]]; ///txtfld 3
    if([CERERE  objectForKey:@"TEXTCERERE"]) C_title=[NSString stringWithFormat:@"%@",[CERERE  objectForKey:@"TEXTCERERE"]];
    if([CERERE  objectForKey:@"IS_NEW"])     C_want_new=[NSString stringWithFormat:@"%@",[CERERE  objectForKey:@"IS_NEW"]];
    if([CERERE  objectForKey:@"IS_SECOND"])  C_want_second=[NSString stringWithFormat:@"%@",[CERERE  objectForKey:@"IS_SECOND"]];
    if([CERERE  objectForKey:@"LOCALITATE"]) C_localitate_id=[NSString stringWithFormat:@"%@",[CERERE  objectForKey:@"LOCALITATE"]];
    // old_cerere_id
    /*   NSLog(@" ai  C_model_id %lu C_talon_tip_varianta %lu C_talon_an_fabricatie %lu C_motorizare %lu C_talon_nr_identificare %lu C_title %lu C_want_new %lu C_want_second %lu C_localitate_id%lu",C_model_id.length,C_talon_tip_varianta.length,C_talon_an_fabricatie.length,C_motorizare.length,C_talon_nr_identificare.length,C_title.length, C_want_new.length,C_want_second.length,(unsigned long)C_localitate_id.length);*/
    if([self MyStringisEmpty:C_title]) {
        eroaretitlu =@"piesa cautată";
        [erori addObject:eroaretitlu];
    }
    
    if([self MyStringisEmpty:C_model_id] ||
       [self MyStringisEmpty:C_talon_tip_varianta] ||
       [self MyStringisEmpty:C_talon_an_fabricatie] ||
       [self MyStringisEmpty:C_motorizare] ) {
        eroaremasina=@"mașină";
        [erori addObject:eroaremasina];
    }
    
    if([self MyStringisEmpty:C_want_new] || [self MyStringisEmpty:C_want_second]){
        eroarepiesanouasausecond=@"piesă nouă sau second";
        [erori addObject:eroarepiesanouasausecond];
    }
    if([self MyStringisEmpty:C_localitate_id]) {
        eroarezonadelivrare=@"zona de livrare";
        [erori addObject:eroarezonadelivrare];
    }
    eroaredate = [NSString stringWithFormat:@"Nu ai completat datele necesare pentru: %@ !", [erori componentsJoinedByString:@","]];
    
    if(![self MyStringisEmpty:C_model_id] &&
       ![self MyStringisEmpty:C_talon_tip_varianta]  &&
       ![self MyStringisEmpty:C_talon_an_fabricatie] &&
       ![self MyStringisEmpty:C_motorizare] &&
       ![self MyStringisEmpty:C_talon_tip_varianta] &&
       ![self MyStringisEmpty:C_title] &&
       ![self MyStringisEmpty:C_want_new] &&
       ![self MyStringisEmpty:C_want_second] &&
       ![self MyStringisEmpty:C_localitate_id]
       ) ok =YES;
    if(!ok) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                            message:eroaredate
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    } else {
        //compune cererea
        NSMutableDictionary *corpcerere = [[NSMutableDictionary alloc]init];
        [corpcerere setObject:C_producator_id forKey:@"producator_id"];
        [corpcerere setObject:C_model_id forKey:@"model_id"];
        [corpcerere setObject:C_talon_tip_varianta forKey:@"talon_tip_varianta"];
        [corpcerere setObject:C_talon_an_fabricatie forKey:@"talon_an_fabricatie"];
        [corpcerere setObject:C_motorizare forKey:@"motorizare"];
        [corpcerere setObject:C_talon_nr_identificare forKey:@"talon_nr_identificare"];
        
        NSMutableArray *grup =[[NSMutableArray alloc]init];
        NSMutableDictionary *grupcerere = [[NSMutableDictionary alloc]init];
        [grupcerere setObject:C_title forKey:@"title"];
        //optionale ->
        [grupcerere setObject:@"" forKey:@"description"];
        [grupcerere setObject:@"" forKey:@"cod"];
        [grupcerere setObject:@"" forKey:@"max_price"];
        [grupcerere setObject:@"" forKey:@"max_price_currency"];
        [grup addObject:grupcerere];
        // <- end optionale
        //  [corpcerere setObject:grupcerere forKey:@"group"];
        [corpcerere setObject:grup forKey:@"group"];
        [corpcerere setObject:C_want_new forKey:@"want_new"];
        [corpcerere setObject:C_want_second forKey:@"want_second"];
        [corpcerere setObject:C_localitate_id forKey:@"localitate_id"];
        NSString *REMAKE_ID;
        NSString *OLD_CERERE_ID;
        if(del.reposteazacerere ==YES) {
            if(CERERE[@"id"])  { OLD_CERERE_ID =[NSString stringWithFormat:@"%@", CERERE[@"id"]];
                [corpcerere setObject:OLD_CERERE_ID forKey:@"old_cerere_id"];
            }
            if(CERERE[@"remake"])  { REMAKE_ID =[NSString stringWithFormat:@"%@", CERERE[@"remake_id"]];
                [corpcerere setObject:REMAKE_ID forKey:@"remake_id"];
            }
            
        }
        
        
        utilitar=[[Utile alloc] init];
        AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        del.vinedincerere =YES;
        del.inapoilacereredinlogin =NO;
        BOOL eLogat = [utilitar eLogat];
        
        
        if(!eLogat) {
            NSLog(@"Alerttaaaa ");
            RIButtonItem *ok = [RIButtonItem item];
            ok.label = @"Login";
            ok.action = ^{
                // contul meu
                choseLoginview *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"ChooseLoginVC"];
                [self.navigationController pushViewController:vc animated:NO];
                
            };
            
            RIButtonItem *cancelItem = [RIButtonItem item];
            cancelItem.label =@"Renunță";
            cancelItem.action = ^{
                
            };
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Piese Auto"
                                                                message:@"Pentru a realiza această acțiune trebuie să fii logat"
                                                       cancelButtonItem:cancelItem
                                                       otherButtonItems:ok,nil];
            [alertView show];
        } else {
            
            NSString *AUTHTOKEN =[utilitar AUTHTOKEN];
            [self cerere_add :corpcerere :  del.ARRAYASSETURI :AUTHTOKEN];
        }
        
    }
    
    
}
-(void)mergiBack {
    //intotdeauna la ecranul principal pentru ca aici ajunge numai dupa ce a facut cerere completa
    TutorialHomeViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TutorialHomeVC"];
    [self.navigationController pushViewController:vc animated:NO ];
}



-(void)addhud{
    [MBProgressHUD showHUDAddedTo:self.navigationController.visibleViewController.view animated:YES];
}
-(void)removehud{
    [MBProgressHUD hideAllHUDsForView:self.navigationController.visibleViewController.view animated:YES];
}
-(IBAction)fapozaAction:(id)sender{
    UIButton* btn = (UIButton*) [(UIGestureRecognizer *)sender view];
    btn.selected =! btn.selected;
    [self  MERGILAECRANGALERIE]; //pentru ca pe iOS9 alerta de permisii face return imediat am facut o a doua verificare
}
-(void)verificaPERMISIIDOI {
    //see
    [self addhud];
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")){
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusAuthorized) {
            // Access has been granted.
            dispatch_async(dispatch_get_main_queue(), ^{
                //Your main thread code goes in here
                NSLog(@"Im on the main thread");
                if(pozele.count >0) {
                    //tabel poze cerere
                    TabelPozeCerereVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TabelPozeCerereVC"];
                    [self.navigationController pushViewController:vc animated:NO ];
                } else {
                    pozeviewVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"pozeVC"];
                    [self.navigationController pushViewController:vc animated:NO ];
                }
            });
        }
        else if (status == PHAuthorizationStatusDenied) {
            // Access has been denied.
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                message:@"Verificați setările aplicației și permiteți utilizarea camerei și a galeriei foto"
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
        else if (status == PHAuthorizationStatusNotDetermined) {
            // Access has not been determined.
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) {
                    // Access has been granted.
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //Your main thread code goes in here
                        NSLog(@"Im on the main thread");
                        
                        if(pozele.count >0) {
                            //tabel poze cerere
                            TabelPozeCerereVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TabelPozeCerereVC"];
                            [self.navigationController pushViewController:vc animated:NO ];
                        } else {
                            pozeviewVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"pozeVC"];
                            [self.navigationController pushViewController:vc animated:NO ];
                        }
                    });
                }
                else {
                    // Access has been denied.
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                        message:@"Verificați setările aplicației și permiteți utilizarea camerei și a galeriei foto"
                                                                       delegate:nil
                                                              cancelButtonTitle:@"Ok"
                                                              otherButtonTitles:nil];
                    [alertView show];
                }
            }];
        }
        
        else if (status == PHAuthorizationStatusRestricted) {
            // Restricted access - normally won't happen.
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                message:@"Verificați setările aplicației și permiteți utilizarea camerei și a galeriei foto"
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
    } else {
        // sub iOS8
        
        ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
        NSLog(@"status auth %ld",(long)status);
        
        if (status == AVAuthorizationStatusAuthorized || status == AVAuthorizationStatusNotDetermined) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //Your main thread code goes in here
                NSLog(@"Im on the main thread");
                
                if(pozele.count >0) {
                    //tabel poze cerere
                    TabelPozeCerereVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TabelPozeCerereVC"];
                    [self.navigationController pushViewController:vc animated:NO ];
                } else {
                    pozeviewVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"pozeVC"];
                    [self.navigationController pushViewController:vc animated:NO ];
                }
            });
        }
        
        if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                message:@"Verificați setările aplicației și permiteți utilizarea camerei și a galeriei foto"
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
    }
    
}
-(void)MERGILAECRANGALERIE{
    
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")){
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        
        if (status == PHAuthorizationStatusAuthorized) {
            // Access has been granted.
            dispatch_async(dispatch_get_main_queue(), ^{
                //Your main thread code goes in here
                [self verificaPERMISIIDOI];
            });
            
        }
        
        else if (status == PHAuthorizationStatusDenied) {
            // Access has been denied.
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                message:@"Verificați setările aplicației și permiteți utilizarea camerei și a galeriei foto"
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
        
        else if (status == PHAuthorizationStatusNotDetermined) {
            
            // Access has not been determined.
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                
                if (status == PHAuthorizationStatusAuthorized) {
                    // Access has been granted.
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self verificaPERMISIIDOI];
                    });
                }
                
                
                else {
                    // Access has been denied.
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                        message:@"Verificați setările aplicației și permiteți utilizarea camerei și a galeriei foto"
                                                                       delegate:nil
                                                              cancelButtonTitle:@"Ok"
                                                              otherButtonTitles:nil];
                    [alertView show];
                }
            }];
        }
        
        else if (status == PHAuthorizationStatusRestricted) {
            // Restricted access - normally won't happen.
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                message:@"Verificați setările aplicației și permiteți utilizarea camerei și a galeriei foto"
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
        
        
    } else {
        // sub iOS8
        
        ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
        NSLog(@"status auth %ld",(long)status);
        
        if (status == AVAuthorizationStatusAuthorized || status == AVAuthorizationStatusNotDetermined) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //Your main thread code goes in here
                NSLog(@"Im on the main thread");
                
                if(pozele.count >0) {
                    //tabel poze cerere
                    TabelPozeCerereVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TabelPozeCerereVC"];
                    [self.navigationController pushViewController:vc animated:NO ];
                } else {
                    pozeviewVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"pozeVC"];
                    [self.navigationController pushViewController:vc animated:NO ];
                }
            });
        }
        
        if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                message:@"Verificați setările aplicației și permiteți utilizarea camerei și a galeriei foto"
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    _initialTVHeight = self.LISTASELECT.frame.size.height;
    CGRect tvFrame = self.LISTASELECT.frame;
    if(_MYkeyboardheight >0) {
        tvFrame.size.height = _MYkeyboardheight;
        [self.LISTASELECT setFrame:tvFrame];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.LISTASELECT setNeedsDisplay];
            [self.view layoutIfNeeded];
        });
    }
}
-(void)viewWillLayoutSubviews{
    
}

-(BOOL)MyStringisEmpty:(NSString *)str
{
    if(str.length==0 || [str isKindOfClass:[NSNull class]] || [str isEqualToString:@""]||[str  isEqualToString:@"NULL"]||[str isEqualToString:@"(null)"]|| [str isEqualToString:@"<null>"] || [str isEqualToString:@"null"] ||str==nil || str == (id)[NSNull null] || [str isEqualToString:@""]){
        return YES;
    }
    return NO;
}
//1
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

-(BOOL)sendCererecuPOZE:DICTIONAR_CERERE_ADD :(NSMutableArray*) POZECERERE :(NSString*)AUTHTOKEN {
    __block BOOL ATRIMIS = NO;
    Reachability *internetReach = [Reachability reachabilityForInternetConnection];
    [internetReach startNotifier];
    NetworkStatus netStatus = [internetReach currentReachabilityStatus];
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
        dic2= DICTIONAR_CERERE_ADD;
        [dic2 setObject:@"iOS" forKey:@"os"];
        [dic2 setObject:currentSysVer forKey:@"version"]; //  vers iOS
        [dic2 setObject:@"ro" forKey:@"lang"];
        [dic2 setObject:AUTHTOKEN forKey:@"authtoken"];
        
        NSMutableArray *images=[[NSMutableArray alloc]init];
        NSMutableArray *idspoze=[[NSMutableArray alloc]init]; //iduri poze la repostare
        
        for(int i=0;i<POZECERERE.count;i++) {
            if( [[POZECERERE objectAtIndex:i]isKindOfClass:[NSDictionary class]] && [[POZECERERE objectAtIndex:i]respondsToSelector:@selector(allKeys)]) {
                NSDictionary *pozeexistente = [POZECERERE objectAtIndex:i];
                if(pozeexistente[@"id"]) {
                    NSString *idpozaexistenta = [NSString stringWithFormat:@"%@", pozeexistente[@"id"]];
                    [idspoze addObject:idpozaexistenta];
                }
            }
        }
        for(int i=0;i<POZECERERE.count;i++) {
            if( [[POZECERERE objectAtIndex:i]isKindOfClass:[UIImage class]]) {
                UIImage *POZANOUA = [POZECERERE objectAtIndex:i];
                [images addObject:POZANOUA];
            }
        }
        
        NSLog(@"pozele %@", images);
        
        if(idspoze.count>0) {
            [dic2 setValue:idspoze forKey:@"image_ids"];
        }
        [dic2 setValue:@"0" forKey:@"validate_only"];
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic2 options:0 error:&err];
        NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        compus =[NSString stringWithFormat:@"%@", myString];
        
        NSString *lineEnd=@"\r\n";
        NSString *twoHyphens=@"--";
        NSString *boundary=@"*****";
        NSMutableData *postBody = [NSMutableData data];
        
        NSLog(@"DICTIONAR CERERE %@",dic2);
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://%@",base_url]]];
        [request setHTTPMethod:@"POST"];
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
        
        [postBody appendData:[[NSString stringWithFormat:@"%@%@%@", twoHyphens,boundary,lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"m\"%@",  lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@",  lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"cerere_add"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@",  lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@%@%@", twoHyphens,boundary,lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
        //p
        [postBody appendData:[[NSString stringWithFormat:@"%@%@%@", twoHyphens,boundary,lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"p\"%@",  lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@",  lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[compus dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@",  lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@%@%@", twoHyphens,boundary,lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
        
        //images
        for(int i=0; i<images.count; i++) {
            long NUMEFISIERTIMESTAMP = (long)NSDate.date.timeIntervalSince1970;
            NSString *userfile = [NSString stringWithFormat:@"%lu.jpg",NUMEFISIERTIMESTAMP];
            UIImage *eachImage  = [images objectAtIndex:i];
            NSData *imageData = UIImageJPEGRepresentation(eachImage,0.8);
            if(imageData ) {
                [postBody appendData:[[NSString stringWithFormat:@"%@%@%@", twoHyphens,boundary,lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
                [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"images[%i]\"; filename=\"%@\"%@",i,userfile, lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
                [postBody appendData:[[NSString stringWithFormat:@"Content-Type: image/jpeg%@",lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
                [postBody appendData:[[NSString stringWithFormat:@"Content-Transfer-Encoding: binary%@",lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
                [postBody appendData:[[NSString stringWithFormat:@"%@",  lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
                [postBody appendData:[NSData dataWithData:imageData]];
                [postBody appendData:[[NSString stringWithFormat:@"%@",  lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
                [postBody appendData:[[NSString stringWithFormat:@"%@%@%@", twoHyphens,boundary,lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
                
            } else {
                NSLog(@"no image");
            }
        }
        
        //last line close bound.
        [postBody appendData:[[NSString stringWithFormat:@"%@%@%@", twoHyphens,boundary,lineEnd] dataUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"postBody=%@", [[NSString alloc] initWithData:postBody encoding:NSASCIIStringEncoding]);
        
        [request setHTTPBody:postBody];
        NSLog(@"my strin %@", compus);
        AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        op.securityPolicy = [self customSecurityPolicy];
        op.responseSerializer = [AFJSONResponseSerializer serializer];
        //    op.responseSerializer = [AFCompoundResponseSerializer serializer];
        // This will make the AFJSONResponseSerializer accept any content type
        op.responseSerializer.acceptableContentTypes = nil;
        [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"responseObjectresponseObject classs%@", NSStringFromClass([responseObject class]));
            NSMutableDictionary *DictionarErori= [[NSMutableDictionary alloc]init];
            NSDictionary *REZULTAT_CERERE_ADD = responseObject;
            NSLog(@"resp 2 %@",responseObject);
            
            if(REZULTAT_CERERE_ADD[@"errors"]) {
                NSMutableArray *erori = [[NSMutableArray alloc]init];
                if(REZULTAT_CERERE_ADD[@"errors"]) {
                    DictionarErori = REZULTAT_CERERE_ADD[@"errors"];
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
                }   else  if(  REZULTAT_CERERE_ADD[@"data"]) {
                    /*
                     "cerere_id" = 342553;
                     images =     (
                     );
                     "newsletter_count" =     {
                     park = 162;
                     person = 214;
                     shop = 96;
                     };
                     "url_similar_products" = "http://dev5.activesoft.ro/~csaba/4tilance/piese-auto-alfa-romeo/8c/";
                     */
                    
                    NSDictionary *multedate = REZULTAT_CERERE_ADD[@"data"];
                    NSLog(@"date cerere raspuns POZ %@",multedate);
                   /*JMOD nu se mai salveaza masina in db
                    NSDictionary *userlogat = [DataMasterProcessor getLOGEDACCOUNT];
                    NSString *userid =[NSString stringWithFormat:@"%@",userlogat[@"U_userid"]];
                    BOOL ok =[DataMasterProcessor insertUsers_cars:DICTIONAR_CERERE_ADD :userid ];
                    NSLog(@"a pus masina in db %i", ok);
                    */
                    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                    del.cererepiesa =[[NSMutableDictionary alloc]init];
                    del.POZECERERE = [[NSMutableArray alloc]init];
                    del.ARRAYASSETURI = [[NSMutableArray alloc]init];
                    del.ARRAYASSETURIEXTERNE = [[NSMutableArray alloc]init];
                    del.reposteazacerere=NO;
                    ATRIMIS =YES;
                    [self.navigationController setNavigationBarHidden:NO];
                    self.navigationItem.leftBarButtonItem=nil;
                    [self removehud];
                    EcranCerereTrimisaViewController *vc =  [self.storyboard instantiateViewControllerWithIdentifier:@"EcranCerereTrimisaVC"];
                    vc.titlurilables = multedate;
                    [self.navigationController pushViewController:vc animated:YES ];
                    
                    
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
    return ATRIMIS;
    
    
}

-(BOOL)cerere_add :(NSMutableDictionary *) DICTIONAR_CERERE_ADD :(NSMutableArray*) POZECERERE :(NSString*)AUTHTOKEN {
    __block BOOL ATRIMIS = NO;
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
        AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSMutableDictionary *dic2= [[NSMutableDictionary alloc]init];
        NSString *compus =@"";
        __block NSString *eroare = @"";
        //////////
        NSError * err;
        // __block BOOL logatcusucces =NO;
        NSString *currentSysVer = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] systemVersion]];
        dic2= DICTIONAR_CERERE_ADD;
        [dic2 setObject:@"iOS" forKey:@"os"];
        [dic2 setObject:currentSysVer forKey:@"version"]; //  vers iOS
        [dic2 setObject:@"ro" forKey:@"lang"];
        [dic2 setObject:AUTHTOKEN forKey:@"authtoken"];
        
        if(DICTIONAR_CERERE_ADD[@"old_cerere_id"]) {
            NSString *oldcerereid = [NSString stringWithFormat:@"%@",DICTIONAR_CERERE_ADD[@"old_cerere_id"]];
            [dic2 setValue:oldcerereid forKey:@"old_cerere_id"];
        }
        // [corpcerere setObject:OLD_CERERE_ID forKey:@"old_cerere_id"];
        
        NSString *REMAKE_ID =@"";
        if(DICTIONAR_CERERE_ADD[@"remake"])  {
            REMAKE_ID =[NSString stringWithFormat:@"%@", CERERE[@"remake"]];
            [dic2 setObject:REMAKE_ID forKey:@"remake_id"];
        }
        
        
        
        NSMutableArray *images=[[NSMutableArray alloc]init];
        images = del.ARRAYASSETURI;
        //FOR IMAGES just end empyy
        
        /*
         Metoda "cerere_add" are un parametru nou "validate_only" (0 sau 1) pt. dry run.
         Daca user-ul nu are poze, aplicatia poate sa trimita "cerere_add" cu validate_only = 0
         Daca are poze, trimite "cerere_add" fara poze cu validate_only = 1 dupa care, daca nu sunt "errors", trimite "cerere_add" cu "images[]" (multipart/form-data) si cu validate_only = 0
         am modificat, cerere_add returneaza:
         "images": [
         { "original":"http://...", "tb": "http://..." },
         ...
         ]
         */
        if(images.count>0) {
            // validate_only"
            [dic2 setValue:@"1" forKey:@"validate_only"];
        } else {
            [dic2 setValue:@"0" forKey:@"validate_only"];
        }
        NSLog(@"DICTIONAR CERERE %@",dic2);
        
        //  NSDictionary *params = @{@"email": @"ioan.ungureanu@activesoft.ro", @"password": @"wHdspd4DVAc"};
        //  my strin m=login&p={"password":"wHdspd4DVAc","email":"ioan.ungureanu@activesoft.ro"}
        
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic2 options:0 error:&err];
        NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        compus =[NSString stringWithFormat:@"%@%@",METODA_CERERE_ADD, myString];
        
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
        [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            //////////
            //   images =@[@""];
            //    [dic setObject:images forKey:@"images"]; //  poze urmeaza
            NSMutableDictionary *DictionarErori= [[NSMutableDictionary alloc]init];
            NSDictionary *REZULTAT_CERERE_ADD = responseObject;
            if(REZULTAT_CERERE_ADD[@"errors"]) {
                NSMutableArray *erori = [[NSMutableArray alloc]init];
                if(REZULTAT_CERERE_ADD[@"errors"]) {
                    DictionarErori = REZULTAT_CERERE_ADD[@"errors"];
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
                }   else  if(  REZULTAT_CERERE_ADD[@"data"]) {
                    [self removehud];
                    /*
                     "cerere_id" = 342553;
                     images =     (
                     );
                     "newsletter_count" =     {
                     park = 162;
                     person = 214;
                     shop = 96;
                     };
                     "url_similar_products" = "http://dev5.activesoft.ro/~csaba/4tilance/piese-auto-alfa-romeo/8c/";
                     */
                    
                    NSDictionary *multedate = REZULTAT_CERERE_ADD[@"data"];
                    NSLog(@"date cerere raspuns %@",multedate);
                    if(images.count>0) {
                        
                        [self  sendCererecuPOZE:dic2 :images :AUTHTOKEN];
                    } else {
                        /*finalizeaza cererea cu datele
                         {
                         "cerere_id" = 342561;
                         images =     (
                         );
                         "newsletter_count" =     {
                         park = 162;
                         person = 214;
                         shop = 96;
                         };
                         "url_similar_products" = "http://dev5.activesoft.ro/~csaba/4tilance/piese-auto-aro/10-2/";
                         */
                        
                        //  BOOL ok =[DataMasterProcessor insertUsers_cars:DICTIONAR_CERERE_ADD :AUTHTOKEN ];
                      /*JMOD nu se mai salveaza masina in db
                        NSDictionary *userlogat = [DataMasterProcessor getLOGEDACCOUNT];
                        NSString *userid =[NSString stringWithFormat:@"%@",userlogat[@"U_userid"]];
                        BOOL ok =[DataMasterProcessor insertUsers_cars:DICTIONAR_CERERE_ADD :userid ];
                        NSLog(@"a pus masina in db  1 %i", ok);
                       */
                        AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                        del.cererepiesa =[[NSMutableDictionary alloc]init];
                        del.POZECERERE = [[NSMutableArray alloc]init];
                        del.ARRAYASSETURI = [[NSMutableArray alloc]init];
                        del.ARRAYASSETURIEXTERNE = [[NSMutableArray alloc]init];
                        del.reposteazacerere=NO;
                        [self.navigationController setNavigationBarHidden:NO]; self.navigationItem.leftBarButtonItem=nil;
                        [self removehud];
                        EcranCerereTrimisaViewController *vc =  [self.storyboard instantiateViewControllerWithIdentifier:@"EcranCerereTrimisaVC"];
                        vc.titlurilables = multedate;
                        [self.navigationController pushViewController:vc animated:YES ];
                        
                        
                    }
                    ATRIMIS =YES;
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
    return ATRIMIS;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}
@end

