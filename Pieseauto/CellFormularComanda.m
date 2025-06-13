//
//  CellFormularComanda.m
//  Piese auto
//
//  Created by Ioan Ungureanu on 25/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "CellFormularComanda.h"
#import "AppDelegate.h"

@interface CellFormularComanda ()

@end


@implementation CellFormularComanda
@synthesize TitluRand,labelModifica,imgModifica,RANDNORMAL,RANDADRESA,TitluAdresa,labelSalveaza,btnSalveaza;
@synthesize PRETOFERTA,TITLUOFERTA,DATEOFERTA;
@synthesize OBSERVATIICOMANDA,textObservatii,UTLIMULRAND,btntrimiteComanda,LIVRARELABEL,heighttitlurand,heightlabelAdresa,dynamicheightTEXTVIEW;
-(void)viewWillAppear:(BOOL)animated {
}
-(void)loadObjectCell{
 //  NSLog(@"aici cell choose 4");
  
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
//    textObservatii.delegate =self;
//    textObservatii.text =@"Poți adăuga informații suplimentare";
//    textObservatii.textColor = [UIColor lightGrayColor]; //optional
//    self.contentView.frame = self.bounds;
//    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}
//- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
//    [textObservatii resignFirstResponder];
//    return YES;
//    
//}
//- (void) textViewDidChange:(UITextView *)textView
//{
//    NSLog(@"did cha");
//    if ([textObservatii.text isEqualToString:@""]) {
//        textObservatii.text = @"Poți adăuga informații suplimentare";
//        textObservatii.textColor = [UIColor lightGrayColor]; //optional
//        [textObservatii resignFirstResponder];
//    } else {
//        // [textView resignFirstResponder];
//    }
//    
//    
//}
////INCHIDE LA DONE...
//-(BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
//    if([text isEqualToString:@"\n"]) {
//        NSString *textcomanda = [NSString stringWithFormat:@"%@",textObservatii.text];
//      NSLog(@"textcomanda %@",textcomanda);
//        [textView resignFirstResponder];
//        return NO;
//    }
//    return YES;
//}
//- (void)textViewDidBeginEditing:(UITextView *)textView
//{
//    if ([textObservatii.text isEqualToString:@"Poți adăuga informații suplimentare"]) {
//        textObservatii.text = @"";
//        textObservatii.textColor = [UIColor blackColor]; //optional
//    }
//    [textObservatii becomeFirstResponder];
//}
//
//- (void)textViewDidEndEditing:(UITextView *)textView
//{
//    if ([textObservatii.text isEqualToString:@""]) {
//        textObservatii.text = @"Poți adăuga informații suplimentare";
//        textObservatii.textColor = [UIColor lightGrayColor]; //optional
//    }
//    [textObservatii resignFirstResponder];
//}


-(BOOL)MyStringisEmpty:(NSString *)str
{
    if(str.length==0 || [str isKindOfClass:[NSNull class]] || [str isEqualToString:@""]||[str  isEqualToString:@"NULL"]||[str isEqualToString:@"(null)"]|| [str isEqualToString:@"<null>"] || [str isEqualToString:@"null"] ||str==nil){
        return YES;
    }
    return NO;
}

@end