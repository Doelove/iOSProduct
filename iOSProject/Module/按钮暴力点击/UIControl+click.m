//
//  UIControl+click.m
//  iOSProject
//
//  Created by 豆豆 on 2020/10/19.
//  Copyright © 2020 软素. All rights reserved.
//

#import "UIControl+click.h"


static char * const qi_eventIntervalKey = "qi_eventIntervalKey";
static char * const eventUnavailableKey = "eventUnavailableKey";


@interface UIControl ()

@property(nonatomic, assign)BOOL eventUnavailable;

@end


@implementation UIControl (click)


- (void)qi_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    if ([self isMemberOfClass:[UIButton class]]) {
        
        if (self.eventUnavailable == NO) {
            self.eventUnavailable = YES;
            [self qi_sendAction:action to:target forEvent:event];
            [self performSelector:@selector(setEventUnavailable:) withObject:0 afterDelay:self.qi_eventInterval];
        }
    }else{
        [self qi_sendAction:action to:target forEvent:event];
    }
}


- (NSTimeInterval)qi_eventInterval{
    return [objc_getAssociatedObject(self, qi_eventIntervalKey) doubleValue];
}

- (void)setQi_eventInterval:(NSTimeInterval)qi_eventInterval{
    
    Method method = class_getInstanceMethod(NSClassFromString(@"UIControl"), @selector(sendAction:to:forEvent:));
    Method qi_method = class_getInstanceMethod(NSClassFromString(@"UIControl"), @selector(qi_sendAction:to:forEvent:));
    method_exchangeImplementations(method, qi_method);
    
    objc_setAssociatedObject(self, qi_eventIntervalKey, @(qi_eventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)eventUnavailable{
    return [objc_getAssociatedObject(self, eventUnavailableKey) boolValue];
}

- (void)setEventUnavailable:(BOOL)eventUnavailable{
    objc_setAssociatedObject(self, eventUnavailableKey, @(eventUnavailable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
