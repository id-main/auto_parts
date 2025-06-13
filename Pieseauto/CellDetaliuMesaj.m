//
//  CellDetaliuMesaj.m
//  Piese auto
//
//  Created by Ioan Ungureanu on 04/05/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "CellDetaliuMesaj.h"
#import "AppDelegate.h"

@interface CellDetaliuMesaj ()

@end


@implementation CellDetaliuMesaj
@synthesize badgeRow,dynamiccellLEFT,fundalmesaj,elpozaalbastra,eupozagri,bifablue,textmesaj,continutmesaj,dynamictableheightJ,heighttitlurand; //
@synthesize  COMPUNE,compunetextmesaj,fapoza,TRIMITE,trimitetextmesaj,sageatatrimite,pozamesajdejatrimis;
@synthesize dynamicTEXTVIEWHEIGHT;
@synthesize dynamicCOMPUNEROWHEIGHT;
@synthesize dynamicLINIEGRIHEIGHT;

-(void)viewWillAppear:(BOOL)animated {
}
-(void)loadObjectCell{
   NSLog(@"CellDetaliuMesaj");
  
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)awakeFromNib
{
    
 // Initialization code
    self.contentView.frame = self.bounds;
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    compunetextmesaj.delegate =self;
//    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    compunetextmesaj.text= del.TEXTMESAJTEMPORAR;
//   // compunetextmesaj.text =@"| Mesaj către vânzător";
//     if( ![self MyStringisEmpty:[NSString stringWithFormat:@"%@",del.TEXTMESAJTEMPORAR]] && ![del.TEXTMESAJTEMPORAR isEqualToString:@"| Mesaj către vânzător"]) {
//         compunetextmesaj.textColor = [UIColor blackColor];
//     } else {
//         compunetextmesaj.textColor = [UIColor lightGrayColor]; //optional
//     }
    self.contentView.frame = self.bounds;

    
}
//- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
//    [compunetextmesaj resignFirstResponder];
//    return YES;
//    
//}
//- (void) textViewDidChange:(UITextView *)textView
//{
//    NSLog(@"did cha");
//    if ([compunetextmesaj.text isEqualToString:@""]) {
//        compunetextmesaj.text = @"Mesaj către vânzător";
//       compunetextmesaj.textColor = [UIColor lightGrayColor]; //optional
//        [compunetextmesaj resignFirstResponder];
//    } else {
//        // [textView resignFirstResponder];
//         compunetextmesaj.textColor = [UIColor blackColor]; //optional
//    }
//    
//    
//}
////INCHIDE LA DONE...
//-(BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
//    if([text isEqualToString:@"\n"]) {
//   AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//   del.TEXTMESAJTEMPORAR = compunetextmesaj.text;
//        [textView resignFirstResponder];
//        return NO;
//    }
//    return YES;
//}
//- (void)textViewDidBeginEditing:(UITextView *)textView
//{
//    if ([compunetextmesaj.text isEqualToString: @"Mesaj către vânzător"]) {
//        compunetextmesaj.text = @"";
//      //  compunetextmesaj.textColor = [UIColor blackColor]; //optional
//    }
//   
//    [compunetextmesaj becomeFirstResponder];
//     compunetextmesaj.textColor = [UIColor blackColor];
//}
//
//- (void)textViewDidEndEditing:(UITextView *)textView
//{
//    if ([compunetextmesaj.text isEqualToString:@""]) {
//        compunetextmesaj.text =  @"Mesaj către vânzător";
//        compunetextmesaj.textColor = [UIColor lightGrayColor]; //optional
//        AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        del.TEXTMESAJTEMPORAR =compunetextmesaj.text;
//
//    } else  {
//         compunetextmesaj.textColor = [UIColor blackColor];
//    }
//    [compunetextmesaj resignFirstResponder];
//}
-(BOOL)MyStringisEmpty:(NSString *)str
{
    if(str.length==0 || [str isKindOfClass:[NSNull class]] || [str isEqualToString:@""]||[str  isEqualToString:@"NULL"]||[str isEqualToString:@"(null)"]|| [str isEqualToString:@"<null>"] || [str isEqualToString:@"null"] ||str==nil){
        return YES;
    }
    return NO;
}

@end