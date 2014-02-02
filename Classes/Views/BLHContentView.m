//
//  BLHContentView.m
//  yssy
//
//  Created by Rurui Ye on 2/1/14.
//  Copyright (c) 2014 Rurui Ye. All rights reserved.
//

#import "BLHContentView.h"
#import "BLHContent.h"
#import "Colours.h"

@interface BLHContentView()
@property NSMutableArray* content;
@end

@implementation BLHContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)initContent:(NSMutableArray *)content
{
    self.content = content;
    for (BLHContent *object in content) {
        if (object.type == TYPE_STRING)
        {
            UILabel * label = [[UILabel alloc]init];
            label.text = object.content;
            [self addSubview:label];
        }
        else if (object.type == TYPE_IMAGE)
        {
            UIImageView* image = [[UIImageView alloc]init];
            [self addSubview:image];
        }
        else if (object.type == TYPE_REFRENCE)
        {
            UILabel * label = [[UILabel alloc]init];
            label.text = object.content;
            label.textColor = [UIColor coolGrayColor];
            [self addSubview:label];
        }
    }
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/*- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGMutablePathRef path = CGPathCreateMutable(); //1
    CGPathAddRect(path, NULL, self.bounds );
    
    NSAttributedString* attString = [[NSAttributedString alloc] initWithString:@"Hello core text world!"]; //2
    
    CTFramesetterRef framesetter =
    CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString); //3
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
                             CFRangeMake(0, [attString length]), path, NULL);
    
    CTFrameDraw(frame, context); //4
    
    CFRelease(frame); //5
    CFRelease(path);
    CFRelease(framesetter);

    // Drawing code
}*/
@end
