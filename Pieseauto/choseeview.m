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
#import "chooseview.h"
#import "TutorialHomeViewController.h"
#import "choose4view.h"
#import <CoreText/CoreText.h>
#import "Reachability.h"
#import "butoncustomback.h"
@interface chooseview(){
    NSMutableArray* Cells_Array;
}
@end

@implementation chooseview
@synthesize  LISTASELECT,baracautare,data,CE_TIP_E,searchResults,lastIndexPath,tableoriginy,tippreferinta;
float _initialTVHeighty =0;
float _MYkeyboardheighty =0;
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
   // titlubuton.text=@"Înapoi";
    if([self.CE_TIP_E isEqualToString:@"Producatori"]) {
       titlubuton.text =@"Cere ofertă";
    }
    //modele
    if([self.CE_TIP_E isEqualToString:@"Modele"]) {
        titlubuton.text =@"Marca";
    }
    //Anii
    if([self.CE_TIP_E isEqualToString:@"Anii"]) {
         titlubuton.text =@"Model";
    }
    ///judete
    if([self.CE_TIP_E isEqualToString:@"Judete"]) {
             titlubuton.text =@"Cere ofertă";
    }
    //Localitati
    if([self.CE_TIP_E isEqualToString:@"Localitati"]) {
       titlubuton.text =@"Județ";
    }
    //Piesenoisecond
    if([self.CE_TIP_E isEqualToString:@"Piesenoisecond"]) {
        titlubuton.text =@"Cere ofertă";
    }
     if([self.CE_TIP_E isEqualToString:@"Preferintenotificari"]) {
          titlubuton.text=@"Înapoi";
     }
        
    //judet simplu vine din modifica adresa
    if([self.CE_TIP_E isEqualToString:@"Judetsimplu"]) {
   
        titlubuton.text=@"Înapoi";
     }
    //Localitate simpla vine din modifica adresa
    
    if([self.CE_TIP_E isEqualToString:@"Localitatisimplu"]) {
        titlubuton.text=@"Înapoi";
    }
    //Metoda de plata vine din confirma comanda
    
    if([self.CE_TIP_E isEqualToString:@"Metodadeplata"]) {
         titlubuton.text=@"Înapoi";
     }
    
    if([self.CE_TIP_E isEqualToString:@"Metodalivrare"]) {
        titlubuton.text=@"Înapoi";
    }
    [backcustombutton addSubview:titlubuton];
    [backcustombutton setShowsTouchWhenHighlighted:NO];
    [backcustombutton bringSubviewToFront:btnimg];
    return backcustombutton;
}

-(void)viewWillAppear:(BOOL)animated {
       [self.navigationController setNavigationBarHidden:NO]; self.navigationItem.leftBarButtonItem=nil;
    
    self.navigationController.navigationItem.hidesBackButton = YES;
    //clean other left
    for(UIButton *view in  self.navigationController.navigationBar.subviews) {
        if([view isKindOfClass:[butoncustomback class]]){
            [view removeFromSuperview];
        }
    }
    tippreferinta=0;
    //add new left
    UIButton *ceva = [self backbtncustom];
    [ceva addTarget:self action:@selector(perfecttimeforback) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *inapoibtn =[[UIBarButtonItem alloc] initWithCustomView:ceva];
    self.navigationItem.leftBarButtonItem = inapoibtn;
    NSLog(@"ce tip e %@", CE_TIP_E);
    //marci
    if([self.CE_TIP_E isEqualToString:@"Producatori"]) {
        self.title = @"Marca";
     }
    //modele
    if([self.CE_TIP_E isEqualToString:@"Modele"]) {
        self.title = @"Modelul";
    }
    //Anii
    if([self.CE_TIP_E isEqualToString:@"Anii"]) {
        self.title = @"Anul fabricației";
     }
    ///judete
    if([self.CE_TIP_E isEqualToString:@"Judete"]) {
        self.title = @"Județul";
    }
    //Localitati
    if([self.CE_TIP_E isEqualToString:@"Localitati"]) {
        self.title = @"Localitate";
    }
    //Piesenoisecond
    if([self.CE_TIP_E isEqualToString:@"Piesenoisecond"] || [self.CE_TIP_E isEqualToString:@"Preferintenotificari"]) {
        self.baracautare.hidden =YES;
        isSearching =FALSE;
        CGRect CEVA = CGRectMake(0,0,0,0);
        self.baracautare.frame =CEVA;
        tableoriginy.constant =0;
        for (NSLayoutConstraint *con in self.view.constraints) {
            if (con.firstItem == self.baracautare  && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant = -44;
            }
        }
    }
    
    if([self.CE_TIP_E isEqualToString:@"Piesenoisecond"]) {
        self.title = @"Piesă nouă sau SH";
     }
    if([self.CE_TIP_E isEqualToString:@"Preferintenotificari"]) {
        NSMutableDictionary *userlogat = [NSMutableDictionary dictionaryWithDictionary:[DataMasterProcessor getLOGEDACCOUNT]];
        if([userlogat objectForKey:@"U_preferinte_notificari"]) {
            NSString *prefsselect =[NSString stringWithFormat:@"%@",[userlogat objectForKey:@"U_preferinte_notificari"]];
            tippreferinta = [prefsselect integerValue];
            
        }

        self.title = @"Preferințe notificări";
      }
    
    //judet simplu vine din modifica adresa
    if([self.CE_TIP_E isEqualToString:@"Judetsimplu"]) {
        self.title = @"Județul";
       }
    //Localitate simpla vine din modifica adresa
    
    if([self.CE_TIP_E isEqualToString:@"Localitatisimplu"]) {
        self.title = @"Localitatea";
     }
    
    
    
    //Metoda de plata vine din confirma comanda
    
    if([self.CE_TIP_E isEqualToString:@"Metodadeplata"]) {
        self.baracautare.hidden =YES;
        isSearching =FALSE;
        CGRect CEVA = CGRectMake(0,0,0,0);
        self.baracautare.frame =CEVA;
        tableoriginy.constant =0;
        for (NSLayoutConstraint *con in self.view.constraints) {
            if (con.firstItem == self.baracautare  && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant = -44;
            }
        }
           self.title = @"Metoda de plată";
     }
    
    if([self.CE_TIP_E isEqualToString:@"Metodalivrare"]) {
        self.baracautare.hidden =YES;
        isSearching =FALSE;
        CGRect CEVA = CGRectMake(0,0,0,0);
        self.baracautare.frame =CEVA;
        tableoriginy.constant =0;
        for (NSLayoutConstraint *con in self.view.constraints) {
            if (con.firstItem == self.baracautare  && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant = -44;
            }
        }
        self.title = @"Metoda de livrare";
     }
    

    NSLog(@"CHOOSE");
    isSearching = FALSE;
    self.data = data;
    searchResults = self.data;
    baracautare.showsCancelButton = NO;
    baracautare.delegate = self;
    UIView* view=baracautare.subviews[0];
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *cancelButton = (UIButton*)subView;
            [cancelButton setTitle:@"Anulați" forState:UIControlStateNormal];
        }
    }
    Cells_Array = [[NSMutableArray alloc]init];
    self.CE_TIP_E = CE_TIP_E;
  //  NSLog(@"data chose %@ %@",data, CE_TIP_E);
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.baracautare resignFirstResponder];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    _initialTVHeighty = self.LISTASELECT.frame.size.height;
    CGRect initialFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect convertedFrame = [self.view convertRect:initialFrame fromView:nil];
    CGRect tvFrame = self.LISTASELECT.frame;
    tvFrame.size.height = convertedFrame.origin.y;
    _MYkeyboardheighty= convertedFrame.origin.y;
    [self.LISTASELECT setFrame:tvFrame];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.LISTASELECT setNeedsDisplay];
    });
    
    
}
- (void)keyboardWillHide:(NSNotification *)notification
{
       CGRect tvFrame = self.LISTASELECT.frame;
    tvFrame.size.height = _initialTVHeighty;
     _MYkeyboardheighty =0;
    [UIView beginAnimations:@"TableViewDown" context:NULL];
    [UIView setAnimationDuration:0.3f];
    self.LISTASELECT.frame = tvFrame;
    [UIView commitAnimations];
   
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.LISTASELECT setNeedsDisplay];
    });
    
    
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

    [LISTASELECT setDelegate:self];
    [LISTASELECT setDataSource:self];
    LISTASELECT.scrollEnabled = YES;
    baracautare.delegate =self;

     
    
 // just because
    // Do any additional setup after loading the view, typically from a nib.
    LISTASELECT.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [LISTASELECT reloadData];
    [LISTASELECT setNeedsDisplay];
}


-(IBAction)inchidecautare:(id)sender {
    [self inchideKeyboard];
}

-(void)inchideKeyboard {
    baracautare.text = @"";
    [self.baracautare resignFirstResponder];
    baracautare.showsCancelButton = NO;
    searchResults = data;
    [self modafisarenormal];
}
-(void)modafisarenormal {
    isSearching = FALSE;
    searchResults =data;
    [LISTASELECT reloadData];
    ///// [SmallScroll setContentSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width,chooseTable.frame.size.height)];
}

-(void)modafisarecautare {
    isSearching =TRUE;
    NSPredicate *predicateString;
    if([self.CE_TIP_E isEqualToString:@"Anii"]) {
        predicateString = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", baracautare.text];
    } else {
    predicateString = [NSPredicate predicateWithFormat:@"%K contains[cd] %@", @"name", baracautare.text];
    }
    searchResults = [data filteredArrayUsingPredicate:predicateString];
    if (searchResults.count ==0) {
        /////        [emtpyMainMessage setText:MyLocalizedString(@"Nu s-a gasit cautarea respectiva.",nil)];
    } else{
        //////    [emtpyMainMessage setText:@""];
        //////   emtpyMainMessage.hidden =YES;
    }
    [LISTASELECT reloadData];
    ////// [SmallScroll setContentSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width,chooseTable.frame.size.height)];
}




- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [baracautare performSelector:@selector(resignFirstResponder) withObject:nil afterDelay:0];
    searchResults = data;
    baracautare.showsCancelButton = NO;
    baracautare.text =@"";
    [self modafisarenormal];
    //  NSLog(@"k s h r a u . 1 :))");
    
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
     NSLog(@"k s h r a u . 2:))");
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [baracautare performSelector:@selector(resignFirstResponder) withObject:nil afterDelay:0];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    baracautare.showsCancelButton = YES;
    UIView* view=baracautare.subviews[0];
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *cancelButton = (UIButton*)subView;
            [cancelButton setTitle:@"Anulați" forState:UIControlStateNormal];
        }
    }
    
    if ([searchText length] == 0)
    {
        searchResults = data;
        [self modafisarenormal];
    } else {
        
        [self modafisarecautare];
        
    }
     NSLog(@"k s h r a u .4 :))");
    
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    //  NSLog(@"k s h r a u . 5:))");
    [baracautare performSelector:@selector(resignFirstResponder) withObject:nil afterDelay:0];
    if ([baracautare.text length] == 0)
    {
        searchResults = data;
        [self modafisarenormal];
        
    } else {
        //NSLog(@"eeeeee %@" ,searchResults);
        [self modafisarecautare];
    }
    
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int numarrows =0;
   
    if( isSearching) {
     numarrows = (int)searchResults.count;
     } else {
     numarrows=(int) data.count;
    }
    NSLog(@"nr rows %i", numarrows);
    if(numarrows ==0) {
        LISTASELECT.separatorStyle =UITableViewCellSeparatorStyleNone;
    }
    return numarrows;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int ipx = (int)indexPath.row;
    int cellHeightcustom =0;
       if( searchResults.count ==0 || data.count ==0) {
           cellHeightcustom =0;}
       else {
           if( [self.CE_TIP_E isEqualToString:@"Preferintenotificari"]) {
               if(ipx ==0) {
                   cellHeightcustom =39;
               } else  if(  ipx ==4){
                  cellHeightcustom =16;
               } else {
                   cellHeightcustom =55;
               }

           }
           
      else if([self.CE_TIP_E isEqualToString:@"Piesenoisecond"] ){
                  if(ipx ==0 || ipx ==4) {
                cellHeightcustom =39;
                  } else {
                cellHeightcustom =55;
                  }
       } else if([self.CE_TIP_E isEqualToString:@"Metodalivrare"]) {
            cellHeightcustom =55;
           
       }
       
       else {
                 cellHeightcustom =55;
              }
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
    ///////// [self.LISTASELECT reloadData];
    _initialTVHeighty = self.LISTASELECT.frame.size.height;
    CGRect tvFrame = self.LISTASELECT.frame;
    if(_MYkeyboardheighty >0) {
        tvFrame.size.height = _MYkeyboardheighty;
        [self.LISTASELECT setFrame:tvFrame];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.LISTASELECT setNeedsDisplay];
            [self.view layoutIfNeeded];
        });
    }
}



#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
      NSInteger ipx = indexPath.row;
    static NSString *CellIdentifier = @"CellChooseCustom";
    CellChoose *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (CellChoose*)[tableView dequeueReusableCellWithIdentifier:@"CellChooseCustom"];
      
        
    }
    
    cell.bifablue.hidden=YES;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    [cell loadObjectCell];
   
   
    if( isSearching) {
        if([self.CE_TIP_E isEqualToString:@"Producatori"]) {
            NSDictionary *producator =[self.searchResults objectAtIndex:indexPath.row];
            //     NSLog(@"prodddd %@", producator);
            NSString *numeproducator = [NSString stringWithFormat:@"%@", producator[@"name"]];
            cell.SubtitluRand.text =numeproducator;
            cell.sageata.hidden =NO;
           }
        if([self.CE_TIP_E isEqualToString:@"Modele"]) {
            NSDictionary *marca =[self.searchResults objectAtIndex:indexPath.row];
            NSString *modelmasina = [NSString stringWithFormat:@"%@", marca[@"name"]];
            cell.SubtitluRand.text =modelmasina;
            cell.sageata.hidden =NO;
        }
        if([self.CE_TIP_E isEqualToString:@"Anii"]) {
            NSString *anulales = [NSString stringWithFormat:@"%@", [self.searchResults objectAtIndex:indexPath.row]];
            cell.SubtitluRand.text =anulales;
        }
         if([self.CE_TIP_E isEqualToString:@"Judete"] || [self.CE_TIP_E isEqualToString:@"Judetsimplu"]) {
             NSDictionary *judet =[self.searchResults objectAtIndex:indexPath.row];
             NSString *judetname = [NSString stringWithFormat:@"%@", judet[@"name"]];
             cell.SubtitluRand.text =judetname;
             cell.sageata.hidden =NO;
         }
                if([self.CE_TIP_E isEqualToString:@"Localitati"] ) {
             NSDictionary *localitate =[self.searchResults objectAtIndex:indexPath.row];
             NSString *localitatename = [NSString stringWithFormat:@"%@", localitate[@"name"]];
             cell.SubtitluRand.text =localitatename;
             cell.sageata.hidden =YES;
         }
        if( [self.CE_TIP_E isEqualToString:@"Localitatisimplu"]) {
            NSDictionary *localitate =[self.searchResults objectAtIndex:indexPath.row];
            NSString *localitatename = [NSString stringWithFormat:@"%@", localitate[@"name"]];
            cell.SubtitluRand.text =localitatename;
            cell.sageata.hidden =YES;
        }
        
        
    } else {
        if([self.CE_TIP_E isEqualToString:@"Producatori"]) {
            NSDictionary *producator =[self.data objectAtIndex:indexPath.row];
            NSString *numeproducator = [NSString stringWithFormat:@"%@", producator[@"name"]];
            cell.SubtitluRand.text =numeproducator;
            cell.sageata.hidden =NO;
        }
        if([self.CE_TIP_E isEqualToString:@"Modele"]) {
            NSDictionary *marca =[self.data objectAtIndex:indexPath.row];
            //     NSLog(@"prodddd %@", producator);
            NSString *modelmasina = [NSString stringWithFormat:@"%@", marca[@"name"]];
            cell.SubtitluRand.text =modelmasina;
            cell.sageata.hidden =NO;
        }
        if([self.CE_TIP_E isEqualToString:@"Anii"]) {
            NSString *anulales = [NSString stringWithFormat:@"%@", [self.data objectAtIndex:indexPath.row]];
            cell.SubtitluRand.text =anulales;
        }
        if([self.CE_TIP_E isEqualToString:@"Judete"] || [self.CE_TIP_E isEqualToString:@"Judetsimplu"]) {
            NSDictionary *judet =[self.searchResults objectAtIndex:indexPath.row];
            NSString *judetname = [NSString stringWithFormat:@"%@", judet[@"name"]];
            cell.SubtitluRand.text =judetname;
            cell.sageata.hidden =NO;
        }
       
        if([self.CE_TIP_E isEqualToString:@"Localitati"] ) {
            NSDictionary *localitate =[self.searchResults objectAtIndex:indexPath.row];
            NSString *localitatename = [NSString stringWithFormat:@"%@", localitate[@"name"]];
            cell.SubtitluRand.text =localitatename;
            cell.sageata.hidden =YES;
        }
        if( [self.CE_TIP_E isEqualToString:@"Localitatisimplu"]) {
            NSDictionary *localitate =[self.searchResults objectAtIndex:indexPath.row];
            NSString *localitatename = [NSString stringWithFormat:@"%@", localitate[@"name"]];
            cell.SubtitluRand.text =localitatename;
            cell.sageata.hidden =YES;
        }
         if([self.CE_TIP_E isEqualToString:@"Piesenoisecond"])   {
               NSString *alegere = [NSString stringWithFormat:@"%@", [self.data objectAtIndex:indexPath.row]];
             
             AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
             NSMutableDictionary *CERERE =[[NSMutableDictionary alloc]init];
             CERERE = [del.cererepiesa mutableCopy];
             NSString *PIESENOI = [NSString stringWithFormat:@"%@",CERERE[@"IS_NEW"]];
             NSString *PIESESECOND = [NSString stringWithFormat:@"%@",CERERE[@"IS_SECOND"]];
             int valoareNOI =0;
             int valoareSECOND=0;
             BOOL Egol =YES;
             Egol = [self MyStringisEmpty:PIESENOI];
             Egol = [self MyStringisEmpty:PIESESECOND];
             if(!Egol) {
                  valoareNOI = PIESENOI.intValue;
                  valoareSECOND = PIESESECOND.intValue;
               } else {
                  cell.bifablue.hidden=YES;
             }
             
                if(ipx==0 ) {
                 cell.SubtitluRand.hidden =NO;
                 cell.selectionStyle = UITableViewCellSelectionStyleNone;
                 cell.backgroundColor = [UIColor colorWithRed:(240/255.0f) green:(240/255.0f) blue:(240/255.0f) alpha:1];
                 cell.SubtitluRand.textColor =[UIColor blackColor];
                 cell.SubtitluRand.font =[UIFont boldSystemFontOfSize: 16];
                   
                    
                 } else if(ipx==4) {
                  cell.SubtitluRand.hidden =YES;
                  cell.selectionStyle = UITableViewCellSelectionStyleNone;
                  cell.backgroundColor = [UIColor colorWithRed:(240/255.0f) green:(240/255.0f) blue:(240/255.0f) alpha:1];
                }  else {
                    switch (ipx) {
                        case 1:
                        {
                            if( valoareNOI ==1 && valoareSECOND ==0) cell.bifablue.hidden=NO;
                        }
                            break;
                        case 2:
                        {
                        if( valoareNOI ==0 && valoareSECOND ==1) cell.bifablue.hidden=NO;
                        }
                            break;
                        case 3:
                        {
                            if( valoareNOI ==1 && valoareSECOND ==1 ) cell.bifablue.hidden=NO;
                        }
                            break;
                        default:
                            break;
                    }
                 cell.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1];
                 cell.SubtitluRand.font = [UIFont systemFontOfSize:17];
             }
            cell.SubtitluRand.text =alegere;
            cell.sageata.hidden =YES;
         }
      if([self.CE_TIP_E isEqualToString:@"Preferintenotificari"]) {
          NSString *alegere = [NSString stringWithFormat:@"%@", [self.data objectAtIndex:indexPath.row]];
          cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
                   if(ipx==0 ) {
                cell.SubtitluRand.hidden =NO;
                cell.backgroundColor = [UIColor colorWithRed:(240/255.0f) green:(240/255.0f) blue:(240/255.0f) alpha:1];
                cell.SubtitluRand.textColor =[UIColor blackColor];
                cell.SubtitluRand.font =[UIFont boldSystemFontOfSize: 16];
                
                
            } else if(ipx==4) {
                cell.SubtitluRand.hidden =YES;
                cell.backgroundColor = [UIColor colorWithRed:(240/255.0f) green:(240/255.0f) blue:(240/255.0f) alpha:1];
            }
                else {
                cell.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1];
                cell.SubtitluRand.font = [UIFont systemFontOfSize:17];
                    
                    if(indexPath.row ==   tippreferinta &&   tippreferinta !=0) {
                        cell.bifablue.hidden=NO;
                        cell.SubtitluRand.font = [UIFont boldSystemFontOfSize: 17];
                    }
            }
            cell.SubtitluRand.text =alegere;
            cell.sageata.hidden =YES;

      }
         if([self.CE_TIP_E isEqualToString:@"Metodadeplata"]) {
             cell.bifablue.hidden =YES;
             NSDictionary *metodaplata =[self.data objectAtIndex:indexPath.row];
             NSString *alegere =@"";
             if(metodaplata[@"name"]) {
                 alegere =[NSString stringWithFormat:@"%@", metodaplata[@"name"]];
             }
             cell.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1];
             cell.SubtitluRand.font = [UIFont systemFontOfSize:17];
             cell.SubtitluRand.text =alegere;
             cell.sageata.hidden =YES;
             cell.selectionStyle = UITableViewCellSelectionStyleNone;

         }
        if([self.CE_TIP_E isEqualToString:@"Metodalivrare"]) {
              cell.bifablue.hidden =YES;
          
            NSDictionary *metodalivrare =[self.data objectAtIndex:indexPath.row];
            NSString *alegere =@"";
            if(metodalivrare[@"name"]) {
                alegere =[NSString stringWithFormat:@"%@", metodalivrare[@"name"]];
            }
            AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
           if(del.MODLIVRARETEMPORAR) {
               NSLog(@"del.MODLIVRARETEMPORARMODLIVRARETEMPORAR %@",del.MODLIVRARETEMPORAR);
            if([metodalivrare isEqualToDictionary: del.MODLIVRARETEMPORAR]) {
             cell.bifablue.hidden=NO;
            } else {
                  cell.bifablue.hidden =YES;
            }
                
           }
            cell.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1];
            cell.SubtitluRand.font = [UIFont systemFontOfSize:14];
            cell.SubtitluRand.numberOfLines=0;
            cell.SubtitluRand.text =alegere;
            cell.sageata.hidden =YES;
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            }
        
           }
   // cell.selectionStyle = UITableViewCellSelectionStyleNone;
  
    // cell.SubtitluRand.text =[self.data objectAtIndex:indexPath.row];
    
    return cell;
}
-(void)poptoroot {
     [self.navigationController popViewControllerAnimated:YES];
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CellChoose *CELL = (CellChoose *)[LISTASELECT cellForRowAtIndexPath:indexPath];
    
 
  
    CELL.SubtitluRand.font = [UIFont systemFontOfSize:17];
    
   // [LISTASELECT cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
      AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
       NSInteger ipx = indexPath.row;
    CellChoose *CELL = (CellChoose *)[LISTASELECT cellForRowAtIndexPath:indexPath];
   // CELL.bifablue.hidden =NO;
    utilitar=[[Utile alloc] init];
    if( isSearching) {
        //////////////////////////////////// TRIMITE-L LA MODELE
        if([self.CE_TIP_E isEqualToString:@"Producatori"]) {
            NSDictionary *producator =[self.searchResults objectAtIndex:indexPath.row];
            //     NSLog(@"prodddd %@", producator);
            NSString *idproducator = [NSString stringWithFormat:@"%@", producator[@"id"]];
            chooseview *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Choose2VC"];
            vc.CE_TIP_E = @"Modele";
            vc.data =[[NSArray alloc]init];
            AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            NSMutableDictionary *CERERE =[[NSMutableDictionary alloc]init];
            CERERE = [del.cererepiesa mutableCopy];
            [CERERE setObject:idproducator  forKey:@"PRODUCATORAUTO"];
            del.cererepiesa = CERERE;

            vc.data = [DataMasterProcessor getMarciAuto:idproducator];
            [self.navigationController pushViewController:vc animated:YES ];
            }
       
        if([self.CE_TIP_E isEqualToString:@"Modele"]) {
            NSDictionary *modelmasina =[self.searchResults objectAtIndex:indexPath.row];
            NSString *idmodelmasina = [NSString stringWithFormat:@"%@", modelmasina[@"id"]];
           
            AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            NSMutableDictionary *CERERE =[[NSMutableDictionary alloc]init];
            CERERE = [del.cererepiesa mutableCopy];
            [CERERE setObject:idmodelmasina  forKey:@"MARCAAUTO"];
            del.cererepiesa = CERERE;
            
            chooseview *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Choose3VC"];
            vc.CE_TIP_E = @"Anii";
            vc.data =[[NSArray alloc]init];
             vc.data = [DataMasterProcessor getYEARS:idmodelmasina];
            [DataMasterProcessor getYEARS:idmodelmasina];
            [self.navigationController pushViewController:vc animated:YES ];
        }
       
        if([self.CE_TIP_E isEqualToString:@"Anii"]) {
            NSString *anulales = [NSString stringWithFormat:@"%@", [self.searchResults objectAtIndex:indexPath.row]];
           //scrie in appdel. CEREREOFERTA -> si il ducem la varianta,motorizare,sasiu
            NSLog(@"anul ales %@",anulales);
           
            AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            NSMutableDictionary *CERERE =[[NSMutableDictionary alloc]init];
            CERERE = [del.cererepiesa mutableCopy];
            [CERERE setObject:anulales  forKey:@"ANMASINA"];
            del.cererepiesa = CERERE;
            
            //si du-l la varianta, motorizare, sasiu
            choose4view *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Choose4VC"];
            vc.CE_TIP_E =@"anfabricatie";
            [self.navigationController pushViewController:vc animated:YES ];
            
         }
       //// 4
        
         if([self.CE_TIP_E isEqualToString:@"Judete"]) {
             NSDictionary *judet =[self.searchResults objectAtIndex:indexPath.row];
             NSString *idjudet = [NSString stringWithFormat:@"%@", judet[@"id"]];
             
             AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
             NSMutableDictionary *CERERE =[[NSMutableDictionary alloc]init];
             CERERE = [del.cererepiesa mutableCopy];
             [CERERE setObject:idjudet  forKey:@"JUDET"];
             del.cererepiesa = CERERE;
             
             chooseview *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Choose2VC"];
             vc.CE_TIP_E = @"Localitati";
             
             vc.data =[[NSArray alloc]init];
              vc.data = [DataMasterProcessor getLocalitati:idjudet];
             [DataMasterProcessor getLocalitati:idjudet];
             [self.navigationController pushViewController:vc animated:YES ];
         }
                if([self.CE_TIP_E isEqualToString:@"Localitati"]) {
            CELL.bifablue.hidden=NO;
            NSString *localitatealeasa = [NSString stringWithFormat:@"%@", [self.searchResults objectAtIndex:indexPath.row]];
            NSDictionary *loca = [self.searchResults objectAtIndex:indexPath.row];
            NSLog(@"loca %@", loca);
            //scrie in appdel. CEREREOFERTA -> si il back ...
            NSString *localitateid = loca[@"id"];
            NSLog(@"localitatealeasa search %@",localitatealeasa);
            AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            NSMutableDictionary *CERERE =[[NSMutableDictionary alloc]init];
            CERERE = [del.cererepiesa mutableCopy];
            [CERERE setObject:localitateid  forKey:@"LOCALITATE"];
            del.cererepiesa = CERERE;
            dispatch_async(dispatch_get_main_queue(), ^{
                [utilitar mergiLaCerereNouaViewVC];
            });

          
           
           // [self.navigationController popViewControllerAnimated:NO];
        }
        if([self.CE_TIP_E isEqualToString:@"Judetsimplu"]) {
         ////jjjj     CELL.bifablue.hidden=NO;
            NSDictionary *judet =[self.searchResults objectAtIndex:indexPath.row];
            NSString *idjudet = [NSString stringWithFormat:@"%@", judet[@"id"]];
            if(del.modificariDateComanda ==YES) {
                NSDictionary *userd = [NSDictionary dictionaryWithDictionary:del.CLONADATEUSER];
                NSMutableDictionary *modat = [NSMutableDictionary dictionaryWithDictionary:userd];
                [modat setObject:idjudet forKey:@"U_judet"];
                [modat setObject:@"" forKey:@"U_localitate"]; //pentru ca schimba judetul localitatea selectata anterior dispare ->o va reselecta
                 del.CLONADATEUSER = modat;
                [self.navigationController popViewControllerAnimated:YES];
            } else {
            NSDictionary *userd = [DataMasterProcessor getLOGEDACCOUNT];
            NSMutableDictionary *modat = [NSMutableDictionary dictionaryWithDictionary:userd];
            [modat setObject:idjudet forKey:@"U_judet"];
            [modat setObject:@"" forKey:@"U_localitate"]; //pentru ca schimba judetul localitatea selectata anterior dispare ->o va reselecta
            NSLog(@"modatul meu %@", modat);
            [DataMasterProcessor insertUsers:modat];
            [self.navigationController popViewControllerAnimated:YES];
            }
        }
        
        if([self.CE_TIP_E isEqualToString:@"Localitatisimplu"]) {
            CELL.bifablue.hidden=NO;
            NSDictionary *localitate =[self.searchResults objectAtIndex:indexPath.row];
            NSArray *cells = [self.LISTASELECT visibleCells];
            for(UIView *view in cells){
                if([view isMemberOfClass:[CellChoose class]]){
                    CellChoose *cell = (CellChoose *) view;
                    UIImageView *tf = (UIImageView *)[cell bifablue];
                    tf.hidden=YES;
                }
            }
            [self.LISTASELECT beginUpdates];
            CELL.bifablue.hidden=NO;
            [self.LISTASELECT endUpdates];
            NSString *idlocalitate = [NSString stringWithFormat:@"%@", localitate[@"id"]];
            if(del.modificariDateComanda ==YES) {
                NSMutableDictionary *modat = [NSMutableDictionary dictionaryWithDictionary:del.CLONADATEUSER];
                [modat setObject:idlocalitate forKey:@"U_localitate"];
                del.CLONADATEUSER = modat;
                [self performSelector:@selector(poptoroot) withObject:nil afterDelay:0];
            } else {
                NSDictionary *userd = [DataMasterProcessor getLOGEDACCOUNT];
                NSMutableDictionary *modat = [NSMutableDictionary dictionaryWithDictionary:userd];
                [modat setObject:idlocalitate forKey:@"U_localitate"];
                [DataMasterProcessor insertUsers:modat];
                [self performSelector:@selector(poptoroot) withObject:nil afterDelay:0];
            }
          
        }

        
    } else {
        
        if([self.CE_TIP_E isEqualToString:@"Producatori"]) {
            NSDictionary *producator =[self.data objectAtIndex:indexPath.row];
            //     NSLog(@"prodddd %@", producator);
            NSString *idproducator = [NSString stringWithFormat:@"%@", producator[@"id"]];
            chooseview *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Choose2VC"];
            vc.CE_TIP_E = @"Modele";
            vc.data =[[NSArray alloc]init];
            AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            NSMutableDictionary *CERERE =[[NSMutableDictionary alloc]init];
            CERERE = [del.cererepiesa mutableCopy];
            [CERERE setObject:idproducator  forKey:@"PRODUCATORAUTO"];
            del.cererepiesa = CERERE;
              vc.data = [DataMasterProcessor getMarciAuto:idproducator];
            [self.navigationController pushViewController:vc animated:YES ];
        }
        
        if([self.CE_TIP_E isEqualToString:@"Modele"]) {
            NSDictionary *modelmasina =[self.data objectAtIndex:indexPath.row];
            NSString *idmodelmasina = [NSString stringWithFormat:@"%@", modelmasina[@"id"]];
            AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            NSMutableDictionary *CERERE =[[NSMutableDictionary alloc]init];
            CERERE = [del.cererepiesa mutableCopy];
            [CERERE setObject:idmodelmasina  forKey:@"MARCAAUTO"];
            del.cererepiesa = CERERE;
            chooseview *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Choose3VC"];
            vc.CE_TIP_E = @"Anii";
            vc.data =[[NSArray alloc]init];
            vc.data = [DataMasterProcessor getYEARS:idmodelmasina];
            [DataMasterProcessor getYEARS:idmodelmasina];
            [self.navigationController pushViewController:vc animated:YES ];
        }
      
        if([self.CE_TIP_E isEqualToString:@"Anii"]) {
            NSString *anulales = [NSString stringWithFormat:@"%@", [self.data objectAtIndex:indexPath.row]];
            //scrie in appdel. CEREREOFERTA -> si il ducem la varianta,motorizare,sasiu
            NSLog(@"anul ales %@",anulales);
            AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            NSMutableDictionary *CERERE =[[NSMutableDictionary alloc]init];
            CERERE = [del.cererepiesa mutableCopy];
            [CERERE setObject:anulales  forKey:@"ANMASINA"];
            del.cererepiesa = CERERE;
            //GO TO Varianta
            choose4view *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Choose4VC"];
            vc.CE_TIP_E =@"anfabricatie";
            [self.navigationController pushViewController:vc animated:YES ];
        }
      
        if([self.CE_TIP_E isEqualToString:@"Judete"]) {
            NSDictionary *judet =[self.data objectAtIndex:indexPath.row];
            NSString *idjudet = [NSString stringWithFormat:@"%@", judet[@"id"]];

            AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            NSMutableDictionary *CERERE =[[NSMutableDictionary alloc]init];
            CERERE = [del.cererepiesa mutableCopy];
            [CERERE setObject:idjudet  forKey:@"JUDET"];
            del.cererepiesa = CERERE;
            
            chooseview *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Choose2VC"];
            vc.CE_TIP_E = @"Localitati";
            vc.data =[[NSArray alloc]init];
            vc.data = [DataMasterProcessor getLocalitati:idjudet];
            [DataMasterProcessor getLocalitati:idjudet];
            [self.navigationController pushViewController:vc animated:YES ];
           //  [self presentViewController:vc animated:YES completion:nil];
      
        }
        
         if([self.CE_TIP_E isEqualToString:@"Localitati"]) {
             CELL.bifablue.hidden=NO;
             NSString *localitatealeasa = [NSString stringWithFormat:@"%@", [self.data objectAtIndex:indexPath.row]];
              NSLog(@"localitatealeasa %@",localitatealeasa);
             NSDictionary *loca = [self.data objectAtIndex:indexPath.row];
             NSLog(@"loca  2 %@", loca);
             //scrie in appdel. CEREREOFERTA -> si il duce back ...
             NSString *localitateid = loca[@"id"];
             NSLog(@"localitatealeasa search %@",localitatealeasa);
             AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
             NSMutableDictionary *CERERE =[[NSMutableDictionary alloc]init];
             CERERE = [del.cererepiesa mutableCopy];
             [CERERE setObject:localitateid  forKey:@"LOCALITATE"];
             del.cererepiesa = CERERE;
             dispatch_async(dispatch_get_main_queue(), ^{
                 [utilitar mergiLaCerereNouaViewVC];
             });
         }
         if([self.CE_TIP_E isEqualToString:@"Piesenoisecond"]) {
             //  self.piesenoisausecond =@[@"Piese noi",@"Piese second",@"Piese noi și second"];
             switch (ipx) {
                 case 0:  case 4:{
                      NSLog(@"nimic");
                      CELL.bifablue.hidden =YES;
                      break;
                 }
                 case 1: {
                    // NSLog(@"nimic");
                     NSArray *cells = [self.LISTASELECT visibleCells];
                     for(UIView *view in cells){
                         if([view isMemberOfClass:[CellChoose class]]){
                             CellChoose *cell = (CellChoose *) view;
                             UIImageView *tf = (UIImageView *)[cell bifablue];
                             tf.hidden=YES;
                         }
                     }
                     CELL.bifablue.hidden =NO;
                     AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                     NSMutableDictionary *CERERE =[[NSMutableDictionary alloc]init];
                     CERERE = [del.cererepiesa mutableCopy];
                     [CERERE setObject:@"1"  forKey:@"IS_NEW"];
                     [CERERE setObject:@"0"  forKey:@"IS_SECOND"];
                     del.cererepiesa = CERERE;
                     dispatch_async(dispatch_get_main_queue(), ^{
                         [utilitar mergiLaCerereNouaViewVC];
                     });
                     
                }
                  break;
                 case 2: {
                   //  NSLog(@"nimic 1");
                     NSArray *cells = [self.LISTASELECT visibleCells];
                     for(UIView *view in cells){
                         if([view isMemberOfClass:[CellChoose class]]){
                             CellChoose *cell = (CellChoose *) view;
                             UIImageView *tf = (UIImageView *)[cell bifablue];
                             tf.hidden=YES;
                         }
                     }
                     CELL.bifablue.hidden =NO;
                     AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                     NSMutableDictionary *CERERE =[[NSMutableDictionary alloc]init];
                     CERERE = [del.cererepiesa mutableCopy];
                     [CERERE setObject:@"0"  forKey:@"IS_NEW"];
                     [CERERE setObject:@"1"  forKey:@"IS_SECOND"];
                     del.cererepiesa = CERERE;
                     dispatch_async(dispatch_get_main_queue(), ^{
                         [utilitar mergiLaCerereNouaViewVC];
                     });
                 }
                     break;
                 case 3: {
                     NSArray *cells = [self.LISTASELECT visibleCells];
                     for(UIView *view in cells){
                         if([view isMemberOfClass:[CellChoose class]]){
                             CellChoose *cell = (CellChoose *) view;
                             UIImageView *tf = (UIImageView *)[cell bifablue];
                             tf.hidden=YES;
                         }
                     }
                       CELL.bifablue.hidden =NO;
                    //   NSLog(@"nimic 2 ");
                     AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                     NSMutableDictionary *CERERE =[[NSMutableDictionary alloc]init];
                     CERERE = [del.cererepiesa mutableCopy];
                     [CERERE setObject:@"1"  forKey:@"IS_NEW"];
                     [CERERE setObject:@"1"  forKey:@"IS_SECOND"];
                     del.cererepiesa = CERERE;
                     dispatch_async(dispatch_get_main_queue(), ^{
                         [utilitar mergiLaCerereNouaViewVC];
                     });
                 }
                     break;
                 default:
                     break;
             }
         }
        
       if([self.CE_TIP_E isEqualToString:@"Preferintenotificari"]){
            //  PREFERINTE_NOTIFICARI 1 2 3 -> 1 = În aplicație 2 = Pe e-mail 3=În aplicație și pe e-mail
           utilitar=[[Utile alloc] init];
           NSString *authtoken=@"";
           BOOL elogat = NO;
           elogat = [utilitar eLogat];
           if(elogat) {
               authtoken = [utilitar AUTHTOKEN];
           }
           CellChoose *CELL = (CellChoose *)[LISTASELECT cellForRowAtIndexPath:indexPath];
         
           switch (ipx) {
                case 0:  case 4:{
                    NSLog(@"nimic");
                    CELL.bifablue.hidden =YES;
                }
                    break;
                case 1: {
                  
                    tippreferinta = 1;
                  
                    CELL.bifablue.hidden=NO;
                    
                     CELL.SubtitluRand.font =[UIFont boldSystemFontOfSize: 17];
                    [self.LISTASELECT reloadData];
                    NSMutableDictionary *userlogat = [NSMutableDictionary dictionaryWithDictionary:[DataMasterProcessor getLOGEDACCOUNT]];
                    [userlogat  setObject:@"1" forKey:@"U_preferinte_notificari"];
                    NSMutableDictionary *userupdate = [userlogat mutableCopy];
                     [self editProfile:authtoken :userupdate :@"preferintenotificari"];
                    
                   // [DataMasterProcessor insertUsers:userupdate];
                }
                    break;
                case 2: {
                   
                   
                  tippreferinta = 2;
                    CELL.bifablue.hidden=NO;
                  
                     CELL.SubtitluRand.font =[UIFont boldSystemFontOfSize: 17];
                     [self.LISTASELECT reloadData];
                    NSMutableDictionary *userlogat = [NSMutableDictionary dictionaryWithDictionary:[DataMasterProcessor getLOGEDACCOUNT]];
                    [userlogat  setObject:@"2" forKey:@"U_preferinte_notificari"];
                    NSMutableDictionary *userupdate = [userlogat mutableCopy];
                    [self editProfile:authtoken :userupdate :@"preferintenotificari"];
                }
                    break;
                case 3: {
                    
                       tippreferinta = 3;
                    CELL.bifablue.hidden=NO;
                  
                     CELL.SubtitluRand.font =[UIFont boldSystemFontOfSize: 17];
                     [self.LISTASELECT reloadData];
                    NSMutableDictionary *userlogat = [NSMutableDictionary dictionaryWithDictionary:[DataMasterProcessor getLOGEDACCOUNT]];
                    [userlogat  setObject:@"3" forKey:@"U_preferinte_notificari"];
                    NSMutableDictionary *userupdate = [userlogat mutableCopy];
                    [self editProfile:authtoken :userupdate :@"preferintenotificari"];
                }
                    break;
                default:
                    break;
            }
           NSLog(@"PREFERINTE_NOTIFICARI -end");
          //   [self.navigationController popViewControllerAnimated:YES];
       }
        if([self.CE_TIP_E isEqualToString:@"Judetsimplu"]) {
          ////    CELL.bifablue.hidden=NO;
            NSDictionary *judet =[self.data objectAtIndex:indexPath.row];
            NSString *idjudet = [NSString stringWithFormat:@"%@", judet[@"id"]];
            NSLog(@"e clar %@", idjudet);
            
            if(del.modificariDateComanda ==YES) {
                NSMutableDictionary *modat = [NSMutableDictionary dictionaryWithDictionary:del.CLONADATEUSER];
                [modat setObject:idjudet forKey:@"U_judet"];
                [modat setObject:@"" forKey:@"U_localitate"]; //pentru ca schimba judetul localitatea selectata anterior dispare ->o va reselecta
                del.CLONADATEUSER = modat;
                [self.navigationController popViewControllerAnimated:YES];
            } else {
            NSDictionary *userd = [DataMasterProcessor getLOGEDACCOUNT];
            NSMutableDictionary *modat = [NSMutableDictionary dictionaryWithDictionary:userd];
            [modat setObject:idjudet forKey:@"U_judet"];
            [modat setObject:@"" forKey:@"U_localitate"]; //pentru ca schimba judetul localitatea selectata anterior dispare ->o va reselecta
            NSLog(@"judet %@",judet);
            BOOL OK=NO;
            OK =[DataMasterProcessor insertUsers:modat];
            NSLog(@"de ce %i", OK);
                 [self.navigationController popViewControllerAnimated:YES];
            }
         }
        if([self.CE_TIP_E isEqualToString:@"Localitatisimplu"]) {
            NSArray *cells = [self.LISTASELECT visibleCells];
            for(UIView *view in cells){
                if([view isMemberOfClass:[CellChoose class]]){
                    CellChoose *cell = (CellChoose *) view;
                    UIImageView *tf = (UIImageView *)[cell bifablue];
                    tf.hidden=YES;
                }
            }
            [self.LISTASELECT beginUpdates];
            CELL.bifablue.hidden=NO;
            [self.LISTASELECT endUpdates];
            NSDictionary *localitate =[self.data objectAtIndex:indexPath.row];
            NSString *idlocalitate = [NSString stringWithFormat:@"%@", localitate[@"id"]];
            if(del.modificariDateComanda ==YES) {
                NSMutableDictionary *modat = [NSMutableDictionary dictionaryWithDictionary:del.CLONADATEUSER];
                [modat setObject:idlocalitate forKey:@"U_localitate"];
                del.CLONADATEUSER = modat;
                [self performSelector:@selector(poptoroot) withObject:nil afterDelay:0];
            } else {
            NSDictionary *userd = [DataMasterProcessor getLOGEDACCOUNT];
            NSMutableDictionary *modat = [NSMutableDictionary dictionaryWithDictionary:userd];
            [modat setObject:idlocalitate forKey:@"U_localitate"];
            [DataMasterProcessor insertUsers:modat];
           [self performSelector:@selector(poptoroot) withObject:nil afterDelay:0];
            }
        }
        if([self.CE_TIP_E isEqualToString:@"Metodadeplata"]) {
          
            NSDictionary *metodaplata =[self.data objectAtIndex:indexPath.row];
            del.MODPLATATEMPORAR = [NSMutableDictionary dictionaryWithDictionary:metodaplata];
            NSLog(@"metodaplata aleasa %@", metodaplata);
           [self.navigationController popViewControllerAnimated:YES];
        }
        if([self.CE_TIP_E isEqualToString:@"Metodalivrare"]) {
        
        //curata bife CELL.bifablue.hidden =YES;
            NSArray *cells = [self.LISTASELECT visibleCells];
            for(UIView *view in cells){
                if([view isMemberOfClass:[CellChoose class]]){
                    CellChoose *cell = (CellChoose *) view;
                    UIImageView *tf = (UIImageView *)[cell bifablue];
                    tf.hidden=YES;
                }
            }
            [self.LISTASELECT beginUpdates];
            CELL.bifablue.hidden=NO;
            NSDictionary *metodalivrare =[self.data objectAtIndex:indexPath.row];
            del.MODLIVRARETEMPORAR = [NSMutableDictionary dictionaryWithDictionary:metodalivrare];
            NSLog(@"metodalivrare aleasa %@", metodalivrare);
        //    [self.navigationController popViewControllerAnimated:YES];
          [self.LISTASELECT endUpdates];
          [self performSelector:@selector(inchidemetodalivrare) withObject:nil afterDelay:0];
        }
    }
}

-(void)inchidemetodalivrare {
     [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)viewWillLayoutSubviews{
   
}

-(IBAction)mergila2:(id)sender {
    NSLog(@"ecran2");
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
          if([tip_date isEqualToString:@"preferintenotificari"]) {
            if(DATEUSER[@"U_preferinte_notificari"]) {
                NSString *U_preferinte_notificari=  [NSString stringWithFormat:@"%@",DATEUSER[@"U_preferinte_notificari"]];
                [dic2 setObject:U_preferinte_notificari forKey:@"notify"];
            }
        }
        
        NSDictionary *userd =[DataMasterProcessor getLOGEDACCOUNT];
        //        echo 'm=offer_prefered&p={"offer_id": 1826651, "is_prefered": 1,"authtoken":"1248f7g5719f33bgKREY4f9PM_CIAPRTmTg2ME4RMbFgDC9sYiiDpaYU8PA","version":"9.0"}'  | curl --tlsv1 --cacert ./dev5.activesoft.crt --data @- -- https://dev5.activesoft.ro:277/
        
        //  NSString *U_preferinte_notificari=  [NSString stringWithFormat:@"%@",userd[@"U_preferinte_notificari"]];
        //        NSString *U_prenume=  [NSString stringWithFormat:@"%@",userd[@"U_prenume"]];
        //        NSString *U_nume=  [NSString stringWithFormat:@"%@",userd[@"U_nume"]];
        ////   NSString *U_telefon=  [NSString stringWithFormat:@"%@",userd[@"U_telefon"]];
        //    NSString *U_localitate=  [NSString stringWithFormat:@"%@",userd[@"U_localitate"]];
        //  NSString *U_cod_postal=  [NSString stringWithFormat:@"%@",userd[@"U_cod_postal"]];
        // NSString *U_adresa=  [NSString stringWithFormat:@"%@",userd[@"U_adresa"]];
        /*PARAMETRII:  (cel putin una dintre)
         - first_name
         - last_name
         - localitate_id
         - address
         - zip_code
         - phone1
         - notify: 1=app, 2=email, 3=app + email*/
        //        [dic2 setObject:U_preferinte_notificari forKey:@"notify"];
        //        [dic2 setObject:U_prenume forKey:@"first_name"];
        //        [dic2 setObject:U_nume forKey:@"last_name"];
        //        [dic2 setObject:U_telefon forKey:@"phone1"];
        //        [dic2 setObject:U_localitate forKey:@"localitate_id"];
        //        [dic2 setObject:U_cod_postal forKey:@"zip_code"];
        //        [dic2 setObject:U_adresa forKey:@"address"];
        
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
                           if([tip_date isEqualToString:@"preferintenotificari"]) {
                            NSMutableDictionary *modat = [NSMutableDictionary dictionaryWithDictionary:userd];
                            NSString *tipnotificare = [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"notify"]];
                            [modat setObject:tipnotificare forKey:@"U_preferinte_notificari"];
                            [DataMasterProcessor updateUsers:modat];
                            [self.navigationController popViewControllerAnimated:YES];
                     }
                                            
                        
                        // [DataMasterProcessor insertUsers:modat];
                        
                        //                    dispatch_async(dispatch_get_main_queue(), ^{
                        //                     //   [self updateprofile:multedate:AUTHTOKEN];
                        //                    });
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


