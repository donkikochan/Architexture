//
//  InfoRings.m
//  Architexture
//
//  Created by DonKikochan on 05/11/13.
//
//

#import "InfoRings.h"

@implementation InfoRings

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        self = [[[NSBundle mainBundle] loadNibNamed:@"InfoRings" owner:self options:nil] objectAtIndex:0];
        _m_Label_FullCollection.text    = NSLocalizedString(@"FULL_COLLECTIONS",nil);
        _m_Label_ViewProfile.text       = NSLocalizedString(@"VIEW_PROFILE",nil);
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
