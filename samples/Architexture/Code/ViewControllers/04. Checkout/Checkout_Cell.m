//
//  Checkout_Cell.m
//  ArchiteXture
//
//  Created by DonKikochan on 27/07/13.
//
//

#import "Checkout_Cell.h"

@implementation Checkout_Cell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setId:(NSString*)theID
{
    _id = theID;
}

- (NSString*) getId
{
    return _id;
}

- (IBAction)imageRing_Clicked:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CheckoutCell_imageClicked" object:_id];
}

- (IBAction)add_Clicked:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CheckoutCell_addClicked" object:_id];
}

- (IBAction)remove_Clicked:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CheckoutCell_removeClicked" object:_id];
}

@end
