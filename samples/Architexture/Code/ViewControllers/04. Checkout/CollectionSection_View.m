//
//  CollectionSection_View.m
//  Architexture
//
//  Created by Enric Vergara Carreras on 10/09/13.
//
//

#import "CollectionSection_View.h"

@implementation CollectionSection_View

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (id)initWithCollectionName:(NSString*) _collectionName
{
    if (self)
    {
        float section_width     = 320;
        float section_height    = 45;
        self = [super initWithFrame:CGRectMake(8, 0, section_width, section_height)];
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.9f;
        
        //----- ADD TIME LABEL:--------------
        UILabel *l_Label_CollectionName = [[UILabel alloc]initWithFrame:CGRectMake(12, 10.0, 320, 30.f)];
        l_Label_CollectionName.textColor = [UIColor whiteColor];
        l_Label_CollectionName.font = [UIFont systemFontOfSize:20.f];
        l_Label_CollectionName.text = _collectionName;
        l_Label_CollectionName.textAlignment = NSTextAlignmentLeft;
        l_Label_CollectionName.backgroundColor = [UIColor clearColor];
        [self addSubview:l_Label_CollectionName];

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
