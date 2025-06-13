//
//  CellHome.m
//  Piese auto
//
//  Created by Ioan Ungureanu on 07/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellHome.h"
#import "AppDelegate.h"

@interface CellHome ()

@end


@implementation CellHome
@synthesize  TitluRand,SubtitluRand,AlegeRand,sageata,CEREACUM,GriRand,texteditabil,ALEGE,fapoza,texteneeditabil,RANDSECUNDAR;
@synthesize dynamicheightsybtitlurand,dynamicheighttexteditabil;

-(void)viewWillAppear:(BOOL)animated {

}

-(void)loadObjectCell{
    NSLog(@"aici cell home");
   //  texteditabil.delegate =self;
  
}
- (void)awakeFromNib
{
    // Initialization code
    texteneeditabil.text=@"Exemplu: Bară față roșie Renault Megane 2014";
    texteneeditabil.textColor =[UIColor lightGrayColor];
    texteneeditabil.hidden=YES;
    texteneeditabil.font =[UIFont systemFontOfSize:17];
    texteditabil.scrollEnabled=NO;
 ///   jNSLog(@"aici cell home nib");
  //////  texteditabil.delegate =self;
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary *CERERE =[[NSMutableDictionary alloc]init];
    CERERE = [del.cererepiesa mutableCopy];
    NSString *TEXTCERERE = [NSString stringWithFormat:@"%@",CERERE[@"TEXTCERERE"]];
 //   jNSLog(@"TExt cerere %@", TEXTCERERE);
    BOOL Egol  = [self MyStringisEmpty:TEXTCERERE];
    if(!Egol) {
        texteditabil.text = TEXTCERERE;
        texteditabil.textColor =[UIColor colorWithRed:255/255.0f green:102/255.0f blue:0/255.0f alpha:1];
    } else {
        texteditabil.text =@"";
        texteneeditabil.hidden=NO;
    }
  
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0,  [self superview].frame.size.width, 40)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    texteditabil.inputAccessoryView = numberToolbar;
  ////  texteditabil.delegate=self;
    [fapoza setImage:[UIImage imageNamed:@"Icon_Camera_LightGrey_144x144.png"] forState:UIControlStateNormal];
    [fapoza setImage:[UIImage imageNamed:@"Icon_Camera_LightGrey_144x144.png"] forState:UIControlStateSelected];
    self.contentView.frame = self.bounds;
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}
-(void)doneWithNumberPad {
    if(![self MyStringisEmpty:texteditabil.text]) {
                    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                    NSMutableDictionary *CERERE =[[NSMutableDictionary alloc]init];
                    CERERE = [del.cererepiesa mutableCopy];
                     NSString *TEXTCERERE = [NSString stringWithFormat:@"%@",texteditabil.text];
                    [CERERE setObject:TEXTCERERE  forKey:@"TEXTCERERE"];
                //   jNSLog(@"TEXTCERERETEXTCERERETEXTCERERE %@",TEXTCERERE);
                    del.cererepiesa = CERERE;
                    texteditabil.textColor =[UIColor colorWithRed:255/255.0f green:102/255.0f blue:0/255.0f alpha:1];
                    texteneeditabil.hidden=YES;
    } else {
                    texteneeditabil.hidden=NO;
                }

    [texteditabil resignFirstResponder];
}
//INCHIDE LA DONE...
//-(BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
//    
//    if([text isEqualToString:@"\n"] ) {
//       if(![self MyStringisEmpty:texteditabil.text]) {
//            AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//            NSMutableDictionary *CERERE =[[NSMutableDictionary alloc]init];
//            CERERE = [del.cererepiesa mutableCopy];
//             NSString *TEXTCERERE = [NSString stringWithFormat:@"%@",texteditabil.text];
//            [CERERE setObject:TEXTCERERE  forKey:@"TEXTCERERE"];
//           NSLog(@"TEXTCERERETEXTCERERETEXTCERERE %@",TEXTCERERE);
//            del.cererepiesa = CERERE;
//            texteditabil.textColor =[UIColor colorWithRed:255/255.0f green:102/255.0f blue:0/255.0f alpha:1];
//            texteneeditabil.hidden=YES;
//        } else {
//            texteneeditabil.hidden=NO;
//        }
//       [textView resignFirstResponder];
//        return NO;
//    }
//   //  NSLog(@"TEXTCERERETEXTCERERETEXTCERERE %@",TEXTCERERE);
//    return YES;
//}
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
//    
//    if([text isEqualToString:@"\n"]) {
//        [textView resignFirstResponder];
//        return NO;
//    }
//    
//    return YES;
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(BOOL)MyStringisEmpty:(NSString *)str
{
    if(str.length==0 || [str isKindOfClass:[NSNull class]] || [str isEqualToString:@""]||[str  isEqualToString:@"NULL"]||[str isEqualToString:@"(null)"]|| [str isEqualToString:@"<null>"] || [str isEqualToString:@"null"] ||str==nil){
        return YES;
    }
    return NO;
}


@end