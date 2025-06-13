//
//  CellLanguage.m
//  Piese auto
//
//  Created by Ioan Ungureanu on 02/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellLanguage.h"
#import <QuartzCore/QuartzCore.h>

@interface CellLanguage ()

@end


@implementation CellLanguage
@synthesize  TitluTara,SubtitluTara,Steag,sageata;
-(void)viewWillAppear:(BOOL)animated {
    
    
}
-(void)loadObjectCell{
      NSLog(@"aici cell tara");
    
}
- (void)awakeFromNib
{
    
    // Initialization code
    self.contentView.frame = self.bounds;
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    self.contentView.layer.borderWidth = 1;
//    self.contentView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end