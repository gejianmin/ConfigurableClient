//
//  HHSessionManager.m
//  HHNetworking
//
//  Created by LWJ on 2016/10/21.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import "HHInterface.h"
#import <objc/runtime.h>
#import <HHSecurityNetwork/HHSecurityNetwork.h>
@implementation HHSessionManager
-(NSMutableDictionary *)sessions{
    if (_sessions==nil) {
        _sessions=[NSMutableDictionary dictionary];
    }
    return _sessions;
}
-(void)forwardInvocation:(NSInvocation *)anInvocation{
    if ([self respondsToSelector:[anInvocation selector]]) {
        [anInvocation invokeWithTarget:self];
    }else{
        [anInvocation invokeWithTarget:self.sessions[self.currentSessionClassName]];
    }
    
}
-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSString *aSelectorStr=NSStringFromSelector(aSelector);
    if ([self respondsToSelector:aSelector]) {
        return [super methodSignatureForSelector:aSelector];
    }
    unsigned int pc=0;
    __unsafe_unretained Protocol **alist= class_copyProtocolList([self class], &pc);
    for (int i=0; i<pc; i++) {
        Protocol *ap=alist[i];
        unsigned int count=0;
        __unsafe_unretained Protocol **blist=protocol_copyProtocolList(ap, &count);
        for (int k=0; k<count; k++) {
            Protocol *bp=blist[k];
            const char *pname=protocol_getName(bp);
            NSString *name=[NSString stringWithCString:pname encoding:NSUTF8StringEncoding];
            Class aclass=NSClassFromString(name);
            u_int mcount;
            Method *method = class_copyMethodList(aclass, &mcount);
            for (int m=0; m<mcount; m++) {
                Method amethod=method[m];
                SEL asel=method_getName(amethod);
                NSString *aselStr=NSStringFromSelector(asel);
                if ([aselStr isEqualToString:aSelectorStr]) {
                    if (!self.sessions[name]) {
                        self.sessions[name]=[(HHURLSession *)[aclass alloc] initWithBaseURL:[HHClient sharedInstance].baseURL];
                    }
                    self.currentSessionClassName=name;
                    
                    NSMethodSignature *sig = [aclass instanceMethodSignatureForSelector:aSelector];
                    if(sig == nil) {
                        sig = [NSMethodSignature signatureWithObjCTypes:"@^v^c"];
                    }
                    return sig;
                }
            }
        }
    }
    return [super methodSignatureForSelector:aSelector];

}
@end
