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
#import "pozemesajeviewVC.h"
#import "CellPoza.h"
#import <CoreText/CoreText.h>
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

@interface pozemesajeviewVC(){
    BOOL newMedia;
}
@end

@implementation pozemesajeviewVC
@synthesize faopoza, ttil, POZEALESE,POZEUTILIZATOR,librarie,numarmaxpoze,libraryx,pozaNOUA,ARRAYASSETURI;
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

//singletone  ca sa nu piarda referinta la library . Invalid attempt to access ALAssetPrivate.
- (ALAssetsLibrary *)defaultAssetsLibrary {
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred, ^{
        library = [[ALAssetsLibrary alloc] init];
    });
    return library;
}
/*
 "IMG_max_height" = 768;
 "IMG_max_width" = 1024;
 */
-(void)preiaPOZEALESE {
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    int IMG_max_height = 768;
    int IMG_max_width = 1024;
    NSUserDefaults* prefs=[NSUserDefaults standardUserDefaults];
    if([prefs objectForKey:@"IMG_max_height"]) {
        IMG_max_height =[[prefs objectForKey:@"IMG_max_height"]intValue];
    }
    if([prefs objectForKey:@"IMG_max_width"]) {
        IMG_max_width =[[prefs objectForKey:@"IMG_max_width"]intValue];
    }
    ARRAYASSETURI = [[NSMutableArray alloc]init];
    NSMutableArray *iduripoze =[[NSMutableArray alloc]init];
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")){
        //             __block id WeakSelf = self;
        __block UIImage *ima;
        NSMutableArray *images = [NSMutableArray arrayWithCapacity:[self.POZEALESE count]];
        for(int i=0;i< self.POZEALESE.count; i++) {
            //path to local asset big image
            
            if( [[self.POZEALESE objectAtIndex:i]isKindOfClass:[NSString class]]) {
                NSString *idASSET = [NSString stringWithFormat:@"%@",[self.POZEALESE objectAtIndex:i]];
                
                for(int y=0;y<self.POZEUTILIZATOR.count;y++) {
                    if( [[self.POZEUTILIZATOR objectAtIndex:y]isKindOfClass:[PHAsset class]]) {
                        PHAsset *asset = [self.POZEUTILIZATOR objectAtIndex:y];
                        NSString *idASSETINBAZA = [NSString stringWithFormat:@"%@",asset.localIdentifier];
                        if([idASSETINBAZA isEqualToString:idASSET]) {
                            NSLog(@"am gasit id");
                            PHImageManager *manager = [PHImageManager defaultManager];
                            CGSize widhththumb = CGSizeMake(IMG_max_width,IMG_max_height);
                            PHImageRequestOptions *requestOptions = [[PHImageRequestOptions alloc] init];
                            requestOptions.resizeMode   = PHImageRequestOptionsResizeModeExact;
                            requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
                            requestOptions.synchronous = true;
                            [manager requestImageForAsset:asset
                                               targetSize:widhththumb
                                              contentMode:PHImageContentModeAspectFit
                                                  options:requestOptions
                                            resultHandler:^void(UIImage *image, NSDictionary *info) {
                                                //to avoid high mem crash        handle all images with the data instead of covert into original image. maybe test...
                                                /* [manager requestImageDataForAsset:asset
                                                 options:self.requestOptions
                                                 resultHandler:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info)
                                                 {
                                                 // UIImage *image = [UIImage imageWithData:imageData];
                                                 [Albumimages addObject:imageData];
                                                 
                                                 }];
                                                 */
                                                
                                                NSLog(@"immag 8 %@",image);
                                                ima = image;
                                                [images addObject:ima];
                                                
                                            }];
                            self.ARRAYASSETURI = images;
                            
                            NSLog(@"POZE REALE %@",self.ARRAYASSETURI);
                            //  });
                            break;
                        }
                    }
                }
            }
        }
        for(int i=0;i< self.POZEALESE.count; i++) {
            if( [[POZEALESE objectAtIndex:i]isKindOfClass:[NSDictionary class]] && [[self.POZEALESE objectAtIndex:i]respondsToSelector:@selector(allKeys)]) {
                NSDictionary *detaliupoza =[self.POZEALESE objectAtIndex:i];
                //   NSString *idPOZA = [NSString stringWithFormat:@"%@",detaliupoza[@"id"]];
                [iduripoze addObject:detaliupoza];
            }
            NSLog(@"iduripoze %@",iduripoze);
        }
        for(int i=0;i< self.POZEALESE.count; i++) {
            if( [[POZEALESE objectAtIndex:i]isKindOfClass:[UIImage class]]) {
                UIImage *detaliupoza =[self.POZEALESE objectAtIndex:i];
                [ARRAYASSETURI addObject:detaliupoza];
            }
       }
        
        
    } else{    //iOS7
        
        for(int i=0;i< self.POZEALESE.count; i++) {
            if( [[self.POZEALESE objectAtIndex:i]isKindOfClass:[NSString class]]) {
                NSString *idASSET = [NSString stringWithFormat:@"%@",[self.POZEALESE objectAtIndex:i]];
                UIImage *pozaSELECTATA = [[UIImage alloc]init];
                for(int y=0;y<self.POZEUTILIZATOR.count;y++) {
                    if( [[self.POZEUTILIZATOR objectAtIndex:y]isKindOfClass:[ALAsset class]]) {
                        ALAsset *asset = [self.POZEUTILIZATOR objectAtIndex:y];
                        NSString *idASSETINBAZA = [NSString stringWithFormat:@"%@",asset.defaultRepresentation.url];
                        //  NSLog(@"CE COMPAR ID ALES  %@ -> IDBAZA %@",idASSET, idASSETINBAZA);
                        if([idASSETINBAZA isEqualToString:idASSET]) {
                            NSLog(@"am gasit id");
                            ALAssetRepresentation *rep = [asset defaultRepresentation];
                            CGImageRef iref = [rep fullResolutionImage];
                            if (iref)
                            {
                                pozaSELECTATA =[UIImage imageWithCGImage:iref];
                                [self.ARRAYASSETURI addObject: pozaSELECTATA];
                            }
                            break;
                        }
                    }
                }
            }
        }
            for(int i=0;i< self.POZEALESE.count; i++) {
                if( [[POZEALESE objectAtIndex:i]isKindOfClass:[NSDictionary class]] && [[self.POZEALESE objectAtIndex:i]respondsToSelector:@selector(allKeys)]) {
                    NSDictionary *detaliupoza =[self.POZEALESE objectAtIndex:i];
                    //   NSString *idPOZA = [NSString stringWithFormat:@"%@",detaliupoza[@"id"]];
                    [iduripoze addObject:detaliupoza];
                }
                NSLog(@"iduripoze %@",iduripoze);
            }
            for(int i=0;i< self.POZEALESE.count; i++) {
                if( [[POZEALESE objectAtIndex:i]isKindOfClass:[UIImage class]]) {
                    UIImage *detaliupoza =[self.POZEALESE objectAtIndex:i];
                    [ARRAYASSETURI addObject:detaliupoza];
                }
                
            }
        
    }
    NSMutableArray *finala = [[NSMutableArray alloc] init];
    [finala addObjectsFromArray:iduripoze];
    [finala addObjectsFromArray:self.ARRAYASSETURI];
    self.ARRAYASSETURI= finala;
    /////// [self.ARRAYASSETURI addObjectsFromArray:iduripoze];
    del.ARRAYASSETURIMESAJ =self.ARRAYASSETURI;
    NSLog(@"POZE REALE x%@",self.ARRAYASSETURI);
   
    
    
}
-(void)finalizeazaAction {
    NSLog(@"indeed");
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    del.POZEMESAJ = self.POZEALESE;
    NSLog(@" self.POZEALESE %@", self.POZEALESE);
    [self preiaPOZEALESE];
    NSLog(@" ARRAYASSETURI %@", self.ARRAYASSETURI);
    utilitar=[[Utile alloc] init];
    dispatch_async(dispatch_get_main_queue(), ^{
  //      [utilitar mergiLaCerereNouaViewVC];
    });
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)forcereload {
    if(pozaNOUA) {
        
        pozaNOUA =NO;
    }
    [self.ttil.collectionViewLayout invalidateLayout];
    ////////nu uita -> DE VERIFICAT PE 7 face load cam mare
    dispatch_async(dispatch_get_main_queue(), ^ {
        //   [self.ttil reloadData];
        NSLog(@"ce %li ", (long)[self.ttil numberOfItemsInSection:0]);
        [self.ttil performBatchUpdates:^{
            [self.ttil reloadSections:[NSIndexSet indexSetWithIndex:0]];
            //[self.ttil reloadData];
            NSLog(@"ce 2 %li ", (long)[self.ttil numberOfItemsInSection:0]);
            
        } completion:nil];
        
    });
    
}

-(void)POZEIOS7 {
    NSLog(@"cate am %lu", (unsigned long)self.POZEUTILIZATOR.count);
    // self.librarie = [self defaultAssetsLibrary]; //atentie daca il muti in alt ecran fa init la librarie acolo cu cea de aici, altfel pierde referinte Asset
    self.librarie = [[ALAssetsLibrary alloc]init];
    __block  NSMutableArray *collector = [[NSMutableArray alloc] init];
    //preia poze externe de la web [la cell for row intotdeauna va verifica tipul de obiect NSDict sau asset
    
    if([ALAssetsLibrary authorizationStatus])
    {
        //Library Access code goes here
        // Enumerate just the photos and videos group by using ALAssetsGroupSavedPhotos.
        [self.librarie enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            // Within the group enumeration block, filter to enumerate just photos.
            [group setAssetsFilter:[ALAssetsFilter allPhotos]];
            [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:^(ALAsset *alAsset, NSUInteger index, BOOL *innerStop) {
                // The end of the enumeration is signaled by asset == nil.
                if (alAsset!= nil) {
                    [collector addObject:alAsset];
                }
                //  NSLog(@"cate am dupa 2 collector %lu", (unsigned long)collector.count);
            }];
            self.POZEUTILIZATOR =collector;
            NSLog(@"cate am dupa 3 %lu", (unsigned long)self.POZEUTILIZATOR.count);
            [self forcereload];
        }
                                   failureBlock: ^(NSError *error) {
                                       // Typically you should handle an error more gracefully than this.
                                       NSLog(@"No groups");
                                   }];
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                            message:@"Permiteti aplicatiei sa utilizeze galeria foto"
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}
-(void)POZEIOS8 {
    self.POZEUTILIZATOR = [self mo8];
    NSLog(@"cate am %lu", (unsigned long)self.POZEUTILIZATOR.count);
    [self forcereload];
    
}
-(void)perfecttimeforback{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)viewWillAppear:(BOOL)animated {
     self.title = @"Adaugă poze";
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

    // no need in sstoryboard [[self ttil] registerClass:[CellPoza class] forCellWithReuseIdentifier:@"CellPOZA"];
    self.librarie = [[ALAssetsLibrary alloc] init];
    self.ttil.delegate =self;
    self.ttil.dataSource =self;
    NSLog(@"ecran poze mesaje view");
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")){
        self.POZEUTILIZATOR = [self mo8];
        [self forcereload];
    } else {
        [self POZEIOS7];
    }
}

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    NSLog(@" self.POZEALESE %@", self.POZEALESE);
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(del.POZEMESAJ.count >0) {
        self.POZEALESE = del.POZEMESAJ;
    } else {
        self.POZEALESE = [[NSMutableArray alloc]init];
    }
    if(del.ARRAYASSETURIMESAJ.count >0) {
        self.ARRAYASSETURI = del.ARRAYASSETURIMESAJ;
    } else {
        self.ARRAYASSETURI = [[NSMutableArray alloc]init];
    }
  
    
    
    pozaNOUA =NO;
    NSLog(@"poze view");
    NSUserDefaults* prefs=[NSUserDefaults standardUserDefaults];
    if([prefs objectForKey:@"COMMENT_max_images"]) {
        numarmaxpoze =[[prefs objectForKey:@"COMMENT_max_images"]intValue];
    } else {
        numarmaxpoze =8;
    }
    // testat cu    numarmaxpoze =20; e ok
    NSLog(@"nr max poze %@ %i",[prefs objectForKey:@"COMMENT_max_images"], numarmaxpoze);
    self.POZEUTILIZATOR= [[NSMutableArray alloc]init];
    
    //// self.ARRAYASSETURI = [[NSMutableArray alloc]init];
    
    
    
    /*   for (int i=0;i<50;i++) {
     [POZEUTILIZATOR insertObject:@"redblock.png" atIndex:i];
     }*/
    //
    
    //
    UIBarButtonItem *butonDreapta = [[UIBarButtonItem alloc] initWithTitle:@"Finalizează" style:UIBarButtonItemStylePlain target:self action:@selector(finalizeazaAction)];
    
    self.navigationItem.rightBarButtonItem = butonDreapta;
    [self EnableSauDisableRightButton];
    //marci
  
    // Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)ContinuaAction:(id)sender {
    //scrie valorile in appdel si //
    utilitar=[[Utile alloc] init];
    dispatch_async(dispatch_get_main_queue(), ^{
 //       [utilitar mergiLaCerereNouaViewVC];
    });
     [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return POZEUTILIZATOR.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    int ipx = (int)indexPath.row;
    // provide the data for the top view
    CellPoza *cell;
    cell = [self.ttil dequeueReusableCellWithReuseIdentifier:@"CellPOZA" forIndexPath:indexPath];
    if(ipx ==0){
        cell.tag =15000000;
        NSString *safestringpoza = [NSString stringWithFormat:@"butonmarefapoza.png"];
        cell.pozaTHUMB.image =[UIImage imageNamed:safestringpoza];
        cell.patrat.hidden =YES;
        cell.scriscifre.text = @"";
        cell.scriscifre.hidden=YES;
        CGFloat borderWidth = 0.0f;
        cell.pozaTHUMB.layer.borderColor = [[UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1] CGColor];
        cell.pozaTHUMB.layer.borderWidth = borderWidth;
    }
    if(ipx !=0) {
        //1 NSDic
        if( [[self.POZEUTILIZATOR objectAtIndex:indexPath.row-1]isKindOfClass:[NSDictionary class]] && [[self.POZEUTILIZATOR objectAtIndex:indexPath.row-1]respondsToSelector:@selector(allKeys)]) {
            //is nsdict din preluate
            cell.tag =ipx;
            CGRect framepoza = cell.pozaTHUMB.frame;
            CGRect boundscorecte = self.view.frame; //[self screenBoundsOrientationDependent];
            CGSize screenSize = boundscorecte.size;
            CGSize widhththumb = CGSizeMake(screenSize.width/3.0f,screenSize.width/3.0f);
            framepoza.size = widhththumb;
            cell.pozaTHUMB.frame = framepoza;
            NSDictionary *detaliupoza =[self.POZEUTILIZATOR objectAtIndex:indexPath.row-1];
            if(detaliupoza[@"original"]) {
                NSString *calepozaserver = [NSString stringWithFormat:@"%@",detaliupoza[@"original"]];
                UIImage * imagineda;
                NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:calepozaserver]];
                imagineda = [UIImage imageWithData:data];
                if(imagineda && imagineda.size.height !=0){
                    UIImage *thumbpoza1 = imagineda;
                    cell.pozaTHUMB.image =thumbpoza1;
                }
            }
            if([self.POZEALESE containsObject:detaliupoza]) {
                int alcatelea = (int)[self.POZEALESE indexOfObject:detaliupoza]+1;
                //+1 pt label
                cell.patrat.hidden =NO;
                CGRect layoutpatrat = cell.patrat.frame;
                layoutpatrat.size.height = cell.frame.size.height /4;
                layoutpatrat.size.width = cell.frame.size.width /4;
                cell.patrat.frame = layoutpatrat;
                [cell.patrat setContentMode:UIViewContentModeScaleAspectFit];
                cell.patrat.clipsToBounds =YES;
                cell.scriscifre.text = [NSString stringWithFormat:@"%d", alcatelea];
                cell.scriscifre.hidden=NO;
                CGFloat borderWidth = 5.0f;
                cell.pozaTHUMB.layer.borderColor = [[UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] CGColor];
                cell.pozaTHUMB.layer.borderWidth = borderWidth;
                //   NSLog(@"cel back frame 1 %f %f", cell.pozaTHUMB.frame.size.width,cell.pozaTHUMB.frame.size.height );
            } else {
                cell.patrat.hidden =YES;
                cell.scriscifre.text = @"";
                cell.scriscifre.hidden=YES;
                CGFloat borderWidth = 0.0f;
                cell.pozaTHUMB.layer.borderColor = [[UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1] CGColor];
                cell.pozaTHUMB.layer.borderWidth = borderWidth;
            }
            
        }
        //2 UIImage
        if( [[self.POZEUTILIZATOR objectAtIndex:indexPath.row-1]isKindOfClass:[UIImage class]] ) {
            cell.tag =ipx;
            CGRect framepoza = cell.pozaTHUMB.frame;
            CGRect boundscorecte = self.view.frame; //[self screenBoundsOrientationDependent];
            CGSize screenSize = boundscorecte.size;
            CGSize widhththumb = CGSizeMake(screenSize.width/3.0f,screenSize.width/3.0f);
            framepoza.size = widhththumb;
            cell.pozaTHUMB.frame = framepoza;
            UIImage *detaliupoza =[self.POZEUTILIZATOR objectAtIndex:indexPath.row-1];
            cell.pozaTHUMB.image =detaliupoza;
            if([self.POZEALESE containsObject:detaliupoza]) {
                int alcatelea = (int)[self.POZEALESE indexOfObject:detaliupoza]+1;
                //+1 pt label
                cell.patrat.hidden =NO;
                CGRect layoutpatrat = cell.patrat.frame;
                layoutpatrat.size.height = cell.frame.size.height /4;
                layoutpatrat.size.width = cell.frame.size.width /4;
                cell.patrat.frame = layoutpatrat;
                [cell.patrat setContentMode:UIViewContentModeScaleAspectFit];
                cell.patrat.clipsToBounds =YES;
                cell.scriscifre.text = [NSString stringWithFormat:@"%d", alcatelea];
                cell.scriscifre.hidden=NO;
                CGFloat borderWidth = 5.0f;
                cell.pozaTHUMB.layer.borderColor = [[UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] CGColor];
                cell.pozaTHUMB.layer.borderWidth = borderWidth;
                //   NSLog(@"cel back frame 1 %f %f", cell.pozaTHUMB.frame.size.width,cell.pozaTHUMB.frame.size.height );
            } else {
                cell.patrat.hidden =YES;
                cell.scriscifre.text = @"";
                cell.scriscifre.hidden=YES;
                CGFloat borderWidth = 0.0f;
                cell.pozaTHUMB.layer.borderColor = [[UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1] CGColor];
                cell.pozaTHUMB.layer.borderWidth = borderWidth;
            }
        }
        //3 PHAsset sau ALAsset
        if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")){
            if( [[self.POZEUTILIZATOR objectAtIndex:indexPath.row-1]isKindOfClass:[PHAsset class]] ) {
                PHImageManager *manager = [PHImageManager defaultManager];
                if (cell.tag && ipx !=0) {
                    [manager cancelImageRequest:(PHImageRequestID)cell.tag];
                }
                CGRect boundscorecte = self.view.frame; //[self screenBoundsOrientationDependent];
                CGSize screenSize = boundscorecte.size;
                CGSize widhththumb = CGSizeMake(screenSize.width/3.0f,screenSize.width/3.0f);
                CGRect framepoza = cell.pozaTHUMB.frame;
                framepoza.size = widhththumb;
                cell.pozaTHUMB.frame = framepoza;
                PHAsset *asset = [self.POZEUTILIZATOR objectAtIndex:indexPath.row-1]; //pt ca 0 e imaginea de fa poza
                cell.tag = [manager requestImageForAsset:asset
                                              targetSize:widhththumb
                                             contentMode:PHImageContentModeAspectFill
                                                 options:nil
                                           resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                               cell.pozaTHUMB.image = result;
                                               //// NSLog(@"resultttt %@", info);
                                           }];
                
                __block  NSString *pathpozaasset = @"";
                pathpozaasset = [NSString stringWithFormat:@"%@",  asset.localIdentifier];
                
                if([self.POZEALESE containsObject:pathpozaasset]) {
                    int alcatelea = (int)[self.POZEALESE indexOfObject:pathpozaasset]+1;
                    //+1 pt label
                    cell.patrat.hidden =NO;
                    CGRect layoutpatrat = cell.patrat.frame;
                    layoutpatrat.size.height = cell.frame.size.height /4;
                    layoutpatrat.size.width = cell.frame.size.width /4;
                    cell.patrat.frame = layoutpatrat;
                    [cell.patrat setContentMode:UIViewContentModeScaleAspectFit];
                    cell.patrat.clipsToBounds =YES;
                    cell.scriscifre.text = [NSString stringWithFormat:@"%d", alcatelea];
                    cell.scriscifre.hidden=NO;
                    CGFloat borderWidth = 5.0f;
                    cell.pozaTHUMB.layer.borderColor = [[UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] CGColor];
                    cell.pozaTHUMB.layer.borderWidth = borderWidth;
                    //   NSLog(@"cel back frame 1 %f %f", cell.pozaTHUMB.frame.size.width,cell.pozaTHUMB.frame.size.height );
                } else {
                    cell.patrat.hidden =YES;
                    cell.scriscifre.text = @"";
                    cell.scriscifre.hidden=YES;
                    CGFloat borderWidth = 0.0f;
                    cell.pozaTHUMB.layer.borderColor = [[UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1] CGColor];
                    cell.pozaTHUMB.layer.borderWidth = borderWidth;
                }
                
                //    NSLog(@"cell.backgroundView %f %f", cell.contentView)
                cell.pozaTHUMB.clipsToBounds =YES;
                
                //  NSLog(@"cel back frame %f %f", cell.backgroundView.frame.size.width,cell.backgroundView.frame.size.height );
            }
        }
        ///iOS 7
        else {
            // NSLog(@"poze alese %@",self.POZEALESE);
            if( [[self.POZEUTILIZATOR objectAtIndex:indexPath.row-1]isKindOfClass:[ALAsset class]] ) {
                ALAsset *asset = [self.POZEUTILIZATOR objectAtIndex:indexPath.row-1]; //aria ...pt ca la cell 0 e poza
                cell.pozaTHUMB.image =[UIImage imageWithCGImage:[asset thumbnail]];
                NSString *calepoza =@"";
                calepoza = [NSString stringWithFormat:@"%@",asset.defaultRepresentation.url];
                //     NSString *indexAssetRow = [NSString stringWithFormat:@"%i",(int)[self.POZEUTILIZATOR indexOfObject:asset]];
                if([self.POZEALESE containsObject:calepoza]) {
                    int alcatelea = (int)[self.POZEALESE indexOfObject:calepoza]+1;
                    //+1 pt label
                    cell.patrat.hidden =NO;
                    CGRect layoutpatrat = cell.patrat.frame;
                    layoutpatrat.size.height = cell.frame.size.height /4;
                    layoutpatrat.size.width = cell.frame.size.width /4;
                    cell.patrat.frame = layoutpatrat;
                    [cell.patrat setContentMode:UIViewContentModeScaleAspectFit];
                    cell.patrat.clipsToBounds =YES;
                    cell.scriscifre.text = [NSString stringWithFormat:@"%d", alcatelea];
                    cell.scriscifre.hidden=NO;
                    CGFloat borderWidth = 6.0f;
                    cell.pozaTHUMB.layer.borderColor = [[UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] CGColor];
                    cell.pozaTHUMB.layer.borderWidth = borderWidth;
                }else {
                    cell.patrat.hidden =YES;
                    cell.scriscifre.text = @"";
                    cell.scriscifre.hidden=YES;
                    CGFloat borderWidth = 0.0f;
                    cell.pozaTHUMB.layer.borderColor = [[UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1] CGColor];
                    cell.pozaTHUMB.layer.borderWidth = borderWidth;
                }
                //  NSLog(@"here asset %@", asset);
                
            }
        }
    }
    
    [cell bringSubviewToFront:cell.pozaTHUMB];
    [cell bringSubviewToFront:cell.patrat];
    [cell bringSubviewToFront:cell.scriscifre];
    [cell.pozaTHUMB setContentMode:UIViewContentModeScaleAspectFill];
    return cell;
}
-(void)EnableSauDisableRightButton {
    if(self.POZEALESE.count !=0) {
        self.navigationItem.rightBarButtonItem.enabled =YES;
    } else {
        self.navigationItem.rightBarButtonItem.enabled =NO;
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info
                           objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = [info
                          objectForKey:UIImagePickerControllerOriginalImage];
        //J26 salvare custom in folder automemo
        NSLog(@"iiiima %@", image);
        
        if (newMedia)
            
            UIImageWriteToSavedPhotosAlbum(image,
                                           self,
                                           @selector(image:finishedSavingWithError:contextInfo:),
                                           nil);
        
        
    }   [self dismissViewControllerAnimated:NO completion:^(void){}];
    
}

- (void) useCamera
{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:
                                  (NSString *) kUTTypeImage,
                                  nil];
        imagePicker.allowsEditing = NO;
        /*  [self presentModalViewController:imagePicker
         animated:YES];*/
        [self presentViewController:imagePicker animated:YES completion:nil];
        //[imagePicker release];
        newMedia = YES;
    }
}
-(void)image:(UIImage *)image
finishedSavingWithError:(NSError *)error
 contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    } else {
        NSLog(@"fiin");
        pozaNOUA =YES;
        if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")){
            [self POZEIOS8];
        } else {
            [self POZEIOS7];
            // [self ULTIMAPOZAIOS7];
        }
    }
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:NO completion:^(void){}];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    int ipx = (int)indexPath.row;
    CellPoza *datasetCell =(CellPoza *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")){
        if(ipx ==0) { //este poza 0 adica fa o poza -> il ducem sa faca poza daca nr max nu e atins inca
            if(self.POZEALESE.count == numarmaxpoze) {
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                    message:@"Ai selectat deja numărul maxim de poze  pentru o cerere"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"Ok"
                                                          otherButtonTitles:nil];
                [alertView show];
                
            } else {
                // du-l la fa poza
                [self  useCamera];
            }
            
        }else {
            ////1. e nsdict
            if( [[self.POZEUTILIZATOR objectAtIndex:indexPath.row-1]isKindOfClass:[NSDictionary class]] && [[self.POZEUTILIZATOR objectAtIndex:indexPath.row-1]respondsToSelector:@selector(allKeys)]) {
                //is nsdict din preluate
                NSDictionary *  pathpozaasset =[self.POZEUTILIZATOR objectAtIndex:indexPath.row-1];
                if(datasetCell.patrat.hidden ==YES) {
                    //add IN BAZA SI PUNE TEXT
                    if(![self.POZEALESE containsObject:pathpozaasset] && self.POZEALESE.count !=numarmaxpoze) {
                        [self.POZEALESE addObject:pathpozaasset];
                        int alcatelea = (int)[self.POZEALESE indexOfObject:pathpozaasset]+1;// +1 pt label
                        datasetCell.patrat.hidden =NO;
                        datasetCell.scriscifre.text = [NSString stringWithFormat:@"%d", alcatelea];
                        datasetCell.scriscifre.hidden=NO;
                        CGFloat borderWidth = 5.0f;
                        datasetCell.pozaTHUMB.layer.borderColor = [[UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] CGColor];
                        datasetCell.pozaTHUMB.layer.borderWidth = borderWidth;
                        //    NSLog(@"cel back frame 3 %f %f", datasetCell.pozaTHUMB.frame.size.width,datasetCell.pozaTHUMB.frame.size.height );
                        
                    } else if(![self.POZEALESE containsObject:pathpozaasset] &&  self.POZEALESE.count ==numarmaxpoze) {
                        if(self.POZEALESE.count ==numarmaxpoze) {
                            //du-l la tabel poze direct
                            NSLog(@"enogh");
                        }
                    }
                }
                else
                    //scos din BAZA ascunde text
                    if([self.POZEALESE containsObject:pathpozaasset]) {
                        //   [self.POZEALESE removeObject:asset];
                        [self.POZEALESE removeObject:pathpozaasset];
                        datasetCell.patrat.hidden =YES;
                        datasetCell.scriscifre.hidden=YES;
                        CGFloat borderWidth = 0.0f;
                        datasetCell.pozaTHUMB.layer.borderColor = [[UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1] CGColor];
                        datasetCell.pozaTHUMB.layer.borderWidth = borderWidth;
                        //    NSLog(@"deselect cel back frame 4 %f %f", datasetCell.pozaTHUMB.frame.size.width,datasetCell.pozaTHUMB.frame.size.height );
                    }
            }
            ///2. e imagine
            if( [[self.POZEUTILIZATOR objectAtIndex:indexPath.row-1]isKindOfClass:[UIImage class]] ) {
                UIImage *pathpozaasset = [self.POZEUTILIZATOR objectAtIndex:indexPath.row-1];
                if(datasetCell.patrat.hidden ==YES) {
                    //add IN BAZA SI PUNE TEXT
                    if(![self.POZEALESE containsObject:pathpozaasset] && self.POZEALESE.count !=numarmaxpoze) {
                        [self.POZEALESE addObject:pathpozaasset];
                        int alcatelea = (int)[self.POZEALESE indexOfObject:pathpozaasset]+1;// +1 pt label
                        datasetCell.patrat.hidden =NO;
                        datasetCell.scriscifre.text = [NSString stringWithFormat:@"%d", alcatelea];
                        datasetCell.scriscifre.hidden=NO;
                        CGFloat borderWidth = 5.0f;
                        datasetCell.pozaTHUMB.layer.borderColor = [[UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] CGColor];
                        datasetCell.pozaTHUMB.layer.borderWidth = borderWidth;
                        
                    } else if(![self.POZEALESE containsObject:pathpozaasset] &&  self.POZEALESE.count ==numarmaxpoze) {
                        if(self.POZEALESE.count ==numarmaxpoze) {
                            //du-l la tabel poze direct
                            NSLog(@"enogh");
                        }
                    }
                }
                else
                    //scos din BAZA ascunde text
                    if([self.POZEALESE containsObject:pathpozaasset]) {
                        //   [self.POZEALESE removeObject:asset];
                        [self.POZEALESE removeObject:pathpozaasset];
                        datasetCell.patrat.hidden =YES;
                        datasetCell.scriscifre.hidden=YES;
                        CGFloat borderWidth = 0.0f;
                        datasetCell.pozaTHUMB.layer.borderColor = [[UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1] CGColor];
                        datasetCell.pozaTHUMB.layer.borderWidth = borderWidth;
                        //    NSLog(@"deselect cel back frame 4 %f %f", datasetCell.pozaTHUMB.frame.size.width,datasetCell.pozaTHUMB.frame.size.height );
                    }
            }
            ///3. e PHAsset
            if( [[self.POZEUTILIZATOR objectAtIndex:indexPath.row-1]isKindOfClass:[PHAsset class]] ) {
                PHAsset *asset = [self.POZEUTILIZATOR objectAtIndex:indexPath.row-1]; //
                __block  NSString *pathpozaasset = @"";
                pathpozaasset = [NSString stringWithFormat:@"%@",  asset.localIdentifier];
                if(datasetCell.patrat.hidden ==YES) {
                    //add IN BAZA SI PUNE TEXT
                    if(![self.POZEALESE containsObject:pathpozaasset] && self.POZEALESE.count !=numarmaxpoze) {
                        [self.POZEALESE addObject:pathpozaasset];
                        int alcatelea = (int)[self.POZEALESE indexOfObject:pathpozaasset]+1;// +1 pt label
                        datasetCell.patrat.hidden =NO;
                        datasetCell.scriscifre.text = [NSString stringWithFormat:@"%d", alcatelea];
                        datasetCell.scriscifre.hidden=NO;
                        CGFloat borderWidth = 5.0f;
                        datasetCell.pozaTHUMB.layer.borderColor = [[UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] CGColor];
                        datasetCell.pozaTHUMB.layer.borderWidth = borderWidth;
                        
                    } else if(![self.POZEALESE containsObject:pathpozaasset] &&  self.POZEALESE.count ==numarmaxpoze) {
                        if(self.POZEALESE.count ==numarmaxpoze) {
                            //du-l la tabel poze direct
                            NSLog(@"enogh");
                        }
                    }
                }
                else
                    //scos din BAZA ascunde text
                    if([self.POZEALESE containsObject:pathpozaasset]) {
                        //   [self.POZEALESE removeObject:asset];
                        [self.POZEALESE removeObject:pathpozaasset];
                        datasetCell.patrat.hidden =YES;
                        datasetCell.scriscifre.hidden=YES;
                        CGFloat borderWidth = 0.0f;
                        datasetCell.pozaTHUMB.layer.borderColor = [[UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1] CGColor];
                        datasetCell.pozaTHUMB.layer.borderWidth = borderWidth;
                        //    NSLog(@"deselect cel back frame 4 %f %f", datasetCell.pozaTHUMB.frame.size.width,datasetCell.pozaTHUMB.frame.size.height );
                    }
                
            }
        }
    }
    
    else {
        if(ipx ==0) { //este poza 0 adica fa o poza -> il ducem sa faca poza daca nr max nu e atins inca
            if(self.POZEALESE.count == numarmaxpoze) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                                    message:@"Ai selectat deja numărul maxim de poze  pentru o cerere"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"Ok"
                                                          otherButtonTitles:nil];
                [alertView show];
            } else {
                // du-l la fa poza
                [self  useCamera];
            }
        }else {
            if( [[self.POZEUTILIZATOR objectAtIndex:indexPath.row-1]isKindOfClass:[NSDictionary class]] && [[self.POZEUTILIZATOR objectAtIndex:indexPath.row-1]respondsToSelector:@selector(allKeys)]) {
                //is nsdict din preluate
                NSDictionary *  pathpozaasset =[self.POZEUTILIZATOR objectAtIndex:indexPath.row-1];
                if(datasetCell.patrat.hidden ==YES) {
                    //add IN BAZA SI PUNE TEXT
                    if(![self.POZEALESE containsObject:pathpozaasset] && self.POZEALESE.count !=numarmaxpoze) {
                        [self.POZEALESE addObject:pathpozaasset];
                        int alcatelea = (int)[self.POZEALESE indexOfObject:pathpozaasset]+1;// +1 pt label
                        datasetCell.patrat.hidden =NO;
                        datasetCell.scriscifre.text = [NSString stringWithFormat:@"%d", alcatelea];
                        datasetCell.scriscifre.hidden=NO;
                        CGFloat borderWidth = 5.0f;
                        datasetCell.pozaTHUMB.layer.borderColor = [[UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] CGColor];
                        datasetCell.pozaTHUMB.layer.borderWidth = borderWidth;
                        //    NSLog(@"cel back frame 3 %f %f", datasetCell.pozaTHUMB.frame.size.width,datasetCell.pozaTHUMB.frame.size.height );
                        
                    } else if(![self.POZEALESE containsObject:pathpozaasset] &&  self.POZEALESE.count ==numarmaxpoze) {
                        if(self.POZEALESE.count ==numarmaxpoze) {
                            //du-l la tabel poze direct
                            NSLog(@"enogh");
                        }
                    }
                }
                else
                    //scos din BAZA ascunde text
                    if([self.POZEALESE containsObject:pathpozaasset]) {
                        //   [self.POZEALESE removeObject:asset];
                        [self.POZEALESE removeObject:pathpozaasset];
                        datasetCell.patrat.hidden =YES;
                        datasetCell.scriscifre.hidden=YES;
                        CGFloat borderWidth = 0.0f;
                        datasetCell.pozaTHUMB.layer.borderColor = [[UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1] CGColor];
                        datasetCell.pozaTHUMB.layer.borderWidth = borderWidth;
                        //    NSLog(@"deselect cel back frame 4 %f %f", datasetCell.pozaTHUMB.frame.size.width,datasetCell.pozaTHUMB.frame.size.height );
                    }
            }
            ///2. e imagine
            if( [[self.POZEUTILIZATOR objectAtIndex:indexPath.row-1]isKindOfClass:[UIImage class]] ) {
                UIImage *pathpozaasset = [self.POZEUTILIZATOR objectAtIndex:indexPath.row-1];
                if(datasetCell.patrat.hidden ==YES) {
                    //add IN BAZA SI PUNE TEXT
                    if(![self.POZEALESE containsObject:pathpozaasset] && self.POZEALESE.count !=numarmaxpoze) {
                        [self.POZEALESE addObject:pathpozaasset];
                        int alcatelea = (int)[self.POZEALESE indexOfObject:pathpozaasset]+1;// +1 pt label
                        datasetCell.patrat.hidden =NO;
                        datasetCell.scriscifre.text = [NSString stringWithFormat:@"%d", alcatelea];
                        datasetCell.scriscifre.hidden=NO;
                        CGFloat borderWidth = 5.0f;
                        datasetCell.pozaTHUMB.layer.borderColor = [[UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1] CGColor];
                        datasetCell.pozaTHUMB.layer.borderWidth = borderWidth;
                        
                    } else if(![self.POZEALESE containsObject:pathpozaasset] &&  self.POZEALESE.count ==numarmaxpoze) {
                        if(self.POZEALESE.count ==numarmaxpoze) {
                            //du-l la tabel poze direct
                            NSLog(@"enogh");
                        }
                    }
                }
                else
                    //scos din BAZA ascunde text
                    if([self.POZEALESE containsObject:pathpozaasset]) {
                        //   [self.POZEALESE removeObject:asset];
                        [self.POZEALESE removeObject:pathpozaasset];
                        datasetCell.patrat.hidden =YES;
                        datasetCell.scriscifre.hidden=YES;
                        CGFloat borderWidth = 0.0f;
                        datasetCell.pozaTHUMB.layer.borderColor = [[UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1] CGColor];
                        datasetCell.pozaTHUMB.layer.borderWidth = borderWidth;
                        //    NSLog(@"deselect cel back frame 4 %f %f", datasetCell.pozaTHUMB.frame.size.width,datasetCell.pozaTHUMB.frame.size.height );
                    }
            }
            if( [[self.POZEUTILIZATOR objectAtIndex:indexPath.row-1]isKindOfClass:[ALAsset class]] ) {
                ALAsset *asset = [self.POZEUTILIZATOR objectAtIndex:indexPath.row-1];
                NSString *calepoza = @"";
                calepoza =[NSString stringWithFormat:@"%@",asset.defaultRepresentation.url];
                
                if(datasetCell.patrat.hidden ==YES) {
                    //add IN BAZA SI PUNE TEXT
                    if(![self.POZEALESE containsObject:calepoza] && self.POZEALESE.count !=numarmaxpoze) {
                        [self.POZEALESE addObject:calepoza];
                        int alcatelea = (int)[self.POZEALESE indexOfObject:calepoza]+1;
                        //+1 pt label
                        datasetCell.patrat.hidden =NO;
                        datasetCell.scriscifre.text = [NSString stringWithFormat:@"%d", alcatelea];
                        datasetCell.scriscifre.hidden=NO;
                    } else if(![self.POZEALESE containsObject:calepoza] &&  self.POZEALESE.count ==numarmaxpoze) {
                        if(self.POZEALESE.count ==numarmaxpoze) {
                            //du-l la tabel poze direct
                            NSLog(@"enogh");
                        }
                    }
                }
                else
                    //scos din BAZA ascunde text
                    if([self.POZEALESE containsObject:calepoza]) {
                        //   [self.POZEALESE removeObject:asset];
                        [self.POZEALESE removeObject:calepoza];
                        datasetCell.patrat.hidden =YES;
                        datasetCell.scriscifre.hidden=YES;
                        CGFloat borderWidth = 0.0f;
                        datasetCell.pozaTHUMB.layer.borderColor = [[UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1] CGColor];
                        datasetCell.pozaTHUMB.layer.borderWidth = borderWidth;
                    }
            }
        }
    }
    ///  NSLog(@"si acum %@ image H%f W%f ", datasetCell.pozaTHUMB,ceva.size.height,ceva.size.width);
    [self EnableSauDisableRightButton]; //ACTIVEAZA BTN SUS FINALIZEAZA
    [self.ttil reloadData];
    
}
//
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0; // This is the minimum inter item spacing, can be more
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return  0;
}
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //top,left,botttom,right
    return UIEdgeInsetsMake(0, 0,0,0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float cellWidth =100;
    CGRect boundscorecte = self.view.frame; //[self screenBoundsOrientationDependent];
    CGSize screenSize = boundscorecte.size;
    cellWidth = screenSize.width / 3.0f;
    //    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")){
    //        cellWidth = screenSize.width / 3.0f; //Replace the divisor with the column count requirement. Make sure to have it in float. are margini la select
    //    } else{
    //        cellWidth = screenSize.width / 3.12f; //Replace the divisor with the column count requirement. Make sure to have it in float. are margini la select
    //    }
    ////// NSLog(@"screenSize %f %f",screenSize.width, screenSize.height);
    // screenWidth =screenSize.width;
    
    //////  NSLog(@"size 3 %f",cellWidth);
    
    
    CGSize size = CGSizeMake(cellWidth, cellWidth);
    return size;
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

//-(void) mo8:(myCompletion) compblock{
//    //do stuff
//    compblock(YES);
//}

-(NSMutableArray*)mo8 {
    // Get all Smart Albums
    __block  NSMutableArray *xtest = [[NSMutableArray alloc]init];
    NSMutableArray *finala = [[NSMutableArray alloc]init];
    //introdu in acest array si pozele externe sunt de tip NSDictionary
    PHFetchOptions *allPhotosOptions = [PHFetchOptions new];
    allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    PHFetchResult *allPhotosResult = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:allPhotosOptions];
    [allPhotosResult enumerateObjectsUsingBlock:^(PHAsset *asset, NSUInteger idx, BOOL *stop) {
    }];
    for (PHAsset *asset in allPhotosResult) {
        //    NSLog(@"asset %@, asset.localIdentifier%@", asset, asset.localIdentifier );
        //       [obiectulmeu setValue:asset.localIdentifier forKey:@"asset"];
        [xtest addObject:asset];
    }
    
    
    PHCachingImageManager *cachingImageManager = [[PHCachingImageManager alloc] init];
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.predicate = [NSPredicate predicateWithFormat:@"favorite == YES"];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"" ascending:YES]];
    
    CGRect boundscorecte = self.view.frame;
    CGSize screenSize = boundscorecte.size;
    CGSize widhththumb = CGSizeMake(screenSize.width/3.0f,screenSize.width/3.0f);
    [cachingImageManager startCachingImagesForAssets:xtest
                                          targetSize:widhththumb
                                         contentMode:PHImageContentModeAspectFill
                                             options:nil];
    ////  NSLog(@"XTEST %@",xtest);
    // return xtest;
  
    [finala addObjectsFromArray:xtest];
    return finala;
    
}



@end

