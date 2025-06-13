//
//  CellPoza.m
//  Piese auto
//
//  Created by Ioan Ungureanu on 04/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.

#import <Foundation/Foundation.h>
#import "CellPoza.h"
#import "AppDelegate.h"

@interface CellPoza ()

@end


@implementation CellPoza
@synthesize  patrat,scriscifre,pozaTHUMB;
-(void)viewWillAppear:(BOOL)animated {
   
    
}
-(void)loadObjectCell{
   NSLog(@"aici cell poza");
}
- (void)awakeFromNib
{
    
    // Initialization code
//    NSLog(@"aici cell poza nib");
 /*   self.patrat.hidden =YES;
    self.scriscifre.hidden=YES;*/
    self.contentView.frame = self.bounds;
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.pozaTHUMB.clipsToBounds =YES;
    self.pozaTHUMB.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:YES];
   
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