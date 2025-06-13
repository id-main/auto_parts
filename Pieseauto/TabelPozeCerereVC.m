//
//pozeview.m -> un view cu 3 textfields
//  Pieseauto
//
//  Created by Ioan Ungureanu on 14/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//
#import "utile.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"
#import "CellPozaRow.h"
#import "TutorialHomeViewController.h"
#import <CoreText/CoreText.h>
#import "TabelPozeCerereVC.h"
#import "pozeViewVC.h"
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

@interface TabelPozeCerereVC()
@end

@implementation TabelPozeCerereVC
@synthesize  LISTASELECT,POZEALESE,labelsusaddpoza,ARRAYASSETURIEXTERNE,POZEUTILIZATOR,librarie;
-(void)adaugaAltepoze {
    //pentru ca nu stim daca a acordat deja permisiile
    [self MERGILAECRANGALERIE];
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
                        pozeviewVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"pozeVC"];
                    [self.navigationController pushViewController:vc animated:NO ];
                
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
                     
                            pozeviewVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"pozeVC"];
                            [self.navigationController pushViewController:vc animated:NO ];
                       
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
              
                    pozeviewVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"pozeVC"];
                    [self.navigationController pushViewController:vc animated:NO ];
                
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
                                 pozeviewVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"pozeVC"];
                    [self.navigationController pushViewController:vc animated:NO ];
                
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

-(void)finalizeazaAction {
    NSLog(@"indeed");
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    del.POZECERERE  = self.POZEALESE;
    if(del.reposteazacerere ==YES ) {
        del.ARRAYASSETURIEXTERNE =self.ARRAYASSETURIEXTERNE;
    } else {
        del.ARRAYASSETURI = self.ARRAYASSETURI;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addhud{
    [MBProgressHUD showHUDAddedTo:self.navigationController.visibleViewController.view animated:YES];
}
-(void)removehud{
    [MBProgressHUD hideAllHUDsForView:self.navigationController.visibleViewController.view animated:YES];
}

-(void)perfecttimeforback{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)viewWillAppear:(BOOL)animated {
    [self removehud];
    self.POZEUTILIZATOR =[[NSMutableArray alloc]init];
    NSLog(@"tabel poze cerere");
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.POZEALESE = [[NSMutableArray alloc]init];
    self.POZEALESE=del.POZECERERE;
    if(del.reposteazacerere ==YES ) {
        self.ARRAYASSETURIEXTERNE = del.ARRAYASSETURIEXTERNE;
    } else {
        self.ARRAYASSETURI = del.ARRAYASSETURI;
    }
    self.title = @"Poze";
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
    UIBarButtonItem *butonDreapta = [[UIBarButtonItem alloc] initWithTitle:@"Finalizează" style:UIBarButtonItemStylePlain target:self action:@selector(finalizeazaAction)];
    self.navigationItem.rightBarButtonItem = butonDreapta;
    butonDreapta.enabled =NO;
  
    [self EnableSauDisableRightButton];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    LISTASELECT.delegate =self;
    LISTASELECT.dataSource =self;
    LISTASELECT.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(adaugaAltepoze)];
    [singleTap setNumberOfTapsRequired:1];
    [labelsusaddpoza setUserInteractionEnabled:YES];
    [labelsusaddpoza addGestureRecognizer:singleTap];
    [self EnableSauDisableRightButton];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.POZEALESE.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 96;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//    }
}
-(void)viewDidLayoutSubviews
{
    if ([self.LISTASELECT respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.LISTASELECT setSeparatorInset:UIEdgeInsetsZero];
    }
//    if ([self.LISTASELECT respondsToSelector:@selector(setLayoutMargins:)]) {
//        [self.LISTASELECT setLayoutMargins:UIEdgeInsetsZero];
//    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(IBAction)stergeRowAction:(id)sender {
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UITapGestureRecognizer *gesture = (UITapGestureRecognizer *) sender;
    NSLog(@"Tag = %ld", (long)gesture.view.tag);
    int ipx = (int)gesture.view.tag;
    
    //reposteaza cerere
    if(del.reposteazacerere ==YES ) {
        [self.ARRAYASSETURIEXTERNE removeObjectAtIndex:ipx];
        del.ARRAYASSETURIEXTERNE = self.ARRAYASSETURIEXTERNE;
        self.POZEALESE =self.ARRAYASSETURIEXTERNE;
        del.POZECERERE  =  self.POZEALESE;
    } else {
        //cerere noua
        [self.ARRAYASSETURI removeObjectAtIndex:ipx];
        del.ARRAYASSETURI = self.ARRAYASSETURI;
        [self.POZEALESE removeObjectAtIndex:ipx];
        del.POZECERERE  = self.POZEALESE;
    }
    
    [self EnableSauDisableRightButton]; //ACTIVEAZA BTN SUS FINALIZEAZA
    [self.LISTASELECT reloadData];
    if(self.POZEALESE.count ==0) {
        ///alerta vrei sa adaugi ? daca da .il duci la fa poza //daca nu  il duc back si se goleste array POZEMESAJ
        NSLog(@"Alerta ");
        RIButtonItem *ok = [RIButtonItem item];
        ok.label = @"Da";
        ok.action = ^{
            [self adaugaAltepoze];
            
        };
        
        RIButtonItem *cancelItem = [RIButtonItem item];
        cancelItem.label =@"Nu";
        cancelItem.action = ^{
            del.ARRAYASSETURIMESAJ = [[NSMutableArray alloc]init];
            del.POZEMESAJ =[[NSMutableArray alloc]init];
            [self.navigationController popViewControllerAnimated:YES];
            
        };
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Piese Auto"
                                                            message:@"Vrei sa adaugi alte poze?"
                                                   cancelButtonItem:cancelItem
                                                   otherButtonItems:ok,nil];
        [alertView show];
        
        
    }
    
    NSLog(@"AAA %d", ipx);
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    int ipx = (int)indexPath.row;
    static NSString *CellIdentifier = @"CellPozaRow";
    CellPozaRow *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (CellPozaRow*)[tableView dequeueReusableCellWithIdentifier:@"CellPozaRow"];
    }
    NSLog(@"del.ARRAYASSETURI %@",del.ARRAYASSETURI);
    
    if(del.reposteazacerere ==YES ) {
        if(del.ARRAYASSETURIEXTERNE && del.ARRAYASSETURIEXTERNE.count >0) {
            if( [[self.ARRAYASSETURIEXTERNE objectAtIndex:ipx]isKindOfClass:[NSDictionary class]] && [[self.ARRAYASSETURIEXTERNE objectAtIndex:ipx]respondsToSelector:@selector(allKeys)]) {
                NSDictionary *detaliupoza =[del.ARRAYASSETURIEXTERNE objectAtIndex:ipx];
                if(detaliupoza[@"original"]) {
                    NSString *calepozaserver = [NSString stringWithFormat:@"%@",detaliupoza[@"original"]];
                    UIImage * imagineda;
                    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:calepozaserver]];
                    imagineda = [UIImage imageWithData:data];
                    if(imagineda && imagineda.size.height !=0){
                        UIImage *thumbpoza1 = imagineda;
                        cell.pozaRow.image =thumbpoza1;
                    }
                }
            }
            else if( [[self.ARRAYASSETURIEXTERNE objectAtIndex:ipx]isKindOfClass:[UIImage class]]) {
                UIImage *detaliupoza =[del.ARRAYASSETURIEXTERNE objectAtIndex:ipx];
                cell.pozaRow.image =detaliupoza;
            }
            cell.tag = ipx;
            UITapGestureRecognizer *singleTap2 =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stergeRowAction:)];
            [singleTap2 setNumberOfTapsRequired:1];
            [cell addGestureRecognizer:singleTap2];
            cell.stergeRand.userInteractionEnabled =YES;
            [cell.pozaRow setContentMode:UIViewContentModeScaleAspectFill];
            cell.SubtitluRand.textColor =[UIColor darkGrayColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            LISTASELECT.allowsSelection = NO;
        }
    }
    else {
        if(del.ARRAYASSETURI && del.ARRAYASSETURI.count >0) {
            if( [[self.ARRAYASSETURI objectAtIndex:ipx]isKindOfClass:[NSDictionary class]] && [[self.ARRAYASSETURI objectAtIndex:ipx]respondsToSelector:@selector(allKeys)]) {
                NSDictionary *detaliupoza =[del.ARRAYASSETURI objectAtIndex:ipx];
                if(detaliupoza[@"original"]) {
                    NSString *calepozaserver = [NSString stringWithFormat:@"%@",detaliupoza[@"original"]];
                    UIImage * imagineda;
                    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:calepozaserver]];
                    imagineda = [UIImage imageWithData:data];
                    if(imagineda && imagineda.size.height !=0){
                        UIImage *thumbpoza1 = imagineda;
                        cell.pozaRow.image =thumbpoza1;
                    }
                }
            }
            
            else if( [[self.ARRAYASSETURI objectAtIndex:ipx]isKindOfClass:[UIImage class]]) {
                UIImage *detaliupoza =[del.ARRAYASSETURI objectAtIndex:ipx];
                cell.pozaRow.image =detaliupoza;
            }
            
            
        }
        cell.tag = ipx;
        UITapGestureRecognizer *singleTap2 =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stergeRowAction:)];
        [singleTap2 setNumberOfTapsRequired:1];
        [cell addGestureRecognizer:singleTap2];
        cell.stergeRand.userInteractionEnabled =YES;
        [cell.pozaRow setContentMode:UIViewContentModeScaleAspectFill];
        cell.SubtitluRand.textColor =[UIColor darkGrayColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        LISTASELECT.allowsSelection = NO;
        
    }
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // [LISTASELECT cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //int ipx = (int)indexPath.row;
    //   CellPozaRow *CELL = (CellPozaRow *)[LISTASELECT cellForRowAtIndexPath:indexPath];
    
}
-(void)EnableSauDisableRightButton {
    
    if(self.POZEALESE.count !=0) {
        self.navigationItem.rightBarButtonItem.enabled =YES;
    } else {
        self.navigationItem.rightBarButtonItem.enabled =NO;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

