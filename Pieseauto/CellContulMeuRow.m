//
//  CellContulMeuRow.m
//  Piese auto
//
//  Created by Ioan Ungureanu on 25/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "CellContulMeuRow.h"
#import "AppDelegate.h"

@interface CellContulMeuRow ()

@end


@implementation CellContulMeuRow
@synthesize sageatablue,pozaRow,TitluRand,badgeRow,labelModifica,imgModifica,CONTINUTRand,dynamicheightCONTINUTRAND,TitluRandUNU,customBAADGE;

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
    
}
-(BOOL)MyStringisEmpty:(NSString *)str
{
    if(str.length==0 || [str isKindOfClass:[NSNull class]] || [str isEqualToString:@""]||[str  isEqualToString:@"NULL"]||[str isEqualToString:@"(null)"]|| [str isEqualToString:@"<null>"] || [str isEqualToString:@"null"] ||str==nil){
        return YES;
    }
    return NO;
}

@end