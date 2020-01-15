//
//  BridgeObjc.h
//  EvilCard
//
//  Created by keltonxian on 8/5/14.
//
//

#ifndef __EvilCard__BridgeObjc__
#define __EvilCard__BridgeObjc__

#import <UIKit/UIKit.h>
#include "cocos2d.h"

USING_NS_CC;

@interface ForumView : UIView <UIWebViewDelegate> {
    UIWebView *webView;
    UIToolbar *toobar;
    UIView *spinner;
    CGRect frameSpinner;
    BOOL isSending;
    int _scriptHandler;
}

+ (void)openURL:(NSDictionary *)dict;
- (void)sendRequest;
- (void)sendRequest:(NSString *)url;
- (void)backClicked:(id)sender;

@end

#ifdef E_APPSTORE_CN
@interface IAPView : UIView <UIAlertViewDelegate> {
    UIView *spinner;
    CGRect frameSpinner;
    int _scriptHandler;
}

@property (nonatomic, retain) NSString *serverUrl;
@property (nonatomic, retain) NSString *orderNo;
@property (nonatomic, readwrite) int mode;
+ (void)checkIAPClear:(NSDictionary *)dict;
+ (void)requestAppStorePay:(NSDictionary *)dict;
+ (void)cleanIAPrecord:(NSDictionary *)dict;
+ (void)testSend:(NSDictionary *)dict;
- (void)sendToServer:(NSData *)receipt transactionId:(NSString *)transactionId;
- (void)validateLocal:(NSData *)receipt;

@end
#endif

#ifdef E_APAY
@interface APayView : UIView <UIAlertViewDelegate> {
    UIView *spinner;
    CGRect frameSpinner;
    int _scriptHandler;
}

+ (void)requestAPayView:(UIViewController *)view;
+ (void)requestAPay:(NSDictionary *)dict;

@end
#endif

@interface SysTool : NSObject {
//    void
}
@property (nonatomic) int a;

+ (void)textToPasteboard:(NSDictionary *)dict;
+ (void)alertWithTitle:(NSString *)title message:(NSString *)message delegate:(id<UIAlertViewDelegate>)delegate;
+ (void)alertWithTitle2:(NSString *)title btnAction:(NSString *)btnAction message:(NSString *)message delegate:(id<UIAlertViewDelegate>)delegate;
+ (void)setUpLocalPush:(NSDictionary *)dict;
+ (void)setUpLocalPushBySec:(NSString *)key sec:(int)sec min:(int)min hour:(int)hours days:(int)days limitFromHour:(int)startHour to:(int)endHour message:(NSString*)inputMessage;
+ (void)cancelAllLocalPush;
+ (void)cancelAllLocalPushByKey:(NSDictionary *)dict;
+ (NSString *)base64_encode:(const uint8_t *)input length:(NSInteger)length;
+ (void)requestPay:(NSDictionary *)dict;
+ (int)getLanguage:(NSDictionary *)dict;
+ (void)saveRMS:(id)data key:(id)key;
+ (id)loadRMS:(id)key;
+ (void)removeRMS:(id)key;

@end

#endif /* defined(__EvilCard__BridgeObjc__) */