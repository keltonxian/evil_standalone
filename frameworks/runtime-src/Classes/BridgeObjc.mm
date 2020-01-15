//
//  BridgeObjc.mm
//  EvilCard
//
//  Created by keltonxian on 8/5/14.
//
//

#include "BridgeObjc.h"
#import "CCEAGLView.h"
#include "CCLuaEngine.h"
#include "CCLuaBridge.h"

#ifdef TARGET_VERSION_ALIPAY
#import "AlipayHandler.h"
#endif

#ifdef E_APPSTORE_CN
#import "StoreObserver.h"
#import "StoreManager.h"
#endif

#ifdef E_APAY
#import "APay.h"
#endif

#define SAVE_IAP_RECEIPT @"SAVE_IAP_RECEIPT"

@implementation ForumView

+ (void)openURL:(NSDictionary *)dict
{
    NSString *url = [dict objectForKey:@"url"];
    cocos2d::GLView *glview = cocos2d::Director::getInstance()->getOpenGLView();
    float scale = glview->getContentScaleFactor();
    float scalex = glview->getScaleX();
    float scaley = glview->getScaleY();
    cocos2d::Size size = glview->getVisibleSize();
    CGRect rect = CGRectMake(0, 0, size.width/scale*scalex, size.height/scale*scaley);
//    NSLog(@"size[%f][%f][%f][%f][%f]", rect.size.width, rect.size.height, scale, scalex, scaley);
    ForumView *forumView = [[ForumView alloc] initWithFrame:rect];
    UIView *view = (UIView *)glview->getEAGLView();
    [view addSubview:forumView];
    [forumView sendRequest:url];
    int scriptHandler = [[dict objectForKey:@"handler"] intValue];
    [forumView setScriptHandler:scriptHandler];
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self == nil) {
		return self;
	}
    float toolBarheight = 35;
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, toolBarheight, frame.size.width, frame.size.height-toolBarheight)];
	webView.opaque = NO;
	webView.backgroundColor = [UIColor clearColor];
	[self addSubview:webView];
	[webView release];
    webView.delegate = self;
    
    toobar = [[UIToolbar alloc] init];
    [toobar setFrame:CGRectMake(0, 0, frame.size.width, toolBarheight)];
    toobar.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem *mBackButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backClicked:)];
    [toobar setItems:[NSArray arrayWithObjects:mBackButton,nil] animated:YES];
    [self addSubview:toobar];
    [toobar release];
    
    spinner = nil;
    frameSpinner = CGRectMake(0, toolBarheight, frame.size.width, frame.size.height-toolBarheight);
    
    return self;
}

- (void)backClicked:(id)sender {
    [self removeFromSuperview];
    if (_scriptHandler)
    {
        LuaBridge::pushLuaFunctionById(_scriptHandler);
        LuaStack *stack = LuaBridge::getStack();
        stack->pushString("back");
        stack->executeFunction(1);
    }
}

- (void) setScriptHandler:(int)scriptHandler
{
    if (_scriptHandler)
    {
        LuaBridge::releaseLuaFunctionById(_scriptHandler);
        _scriptHandler = 0;
    }
    _scriptHandler = scriptHandler;
}

- (void)dealloc {
    [super dealloc];
}

- (void)sendRequest {
    
}

- (void)sendRequest:(NSString *)url {
    NSURL *u = [NSURL URLWithString:url];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:u cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
	[webView loadRequest:requestObj];
	[webView setContentMode:UIViewContentModeScaleToFill];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webView start load");
    if (nil != spinner) {
        [spinner removeFromSuperview];
    }
    spinner = [[UIView alloc] initWithFrame:frameSpinner];
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	[indicator setCenter:CGPointMake(frameSpinner.size.width/2, frameSpinner.size.height/2)];
    [spinner addSubview:indicator];
    [indicator release];
	[indicator startAnimating];
	[self addSubview:spinner];
	[spinner release];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webView finish load");
    [spinner removeFromSuperview];
    spinner = nil;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [spinner removeFromSuperview];
    spinner = nil;
    NSLog(@"%@\n%ld\n%@", error, (long)[error code], [error domain]);
    NSString *msg = [error description];
    UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"IOS Alert" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [msgbox autorelease];
    [msgbox show];
}

@end


#pragma mark AppStore iap
#ifdef E_APPSTORE_CN
@implementation IAPView

@synthesize serverUrl;
@synthesize mode;
@synthesize orderNo;

+ (void)requestAppStorePay:(NSDictionary *)dict
{
    NSString *product_id = [dict objectForKey:@"product_id"];
    NSString *serverUrl = [dict objectForKey:@"url"];
    NSString *orderNo = [dict objectForKey:@"order_no"];
    int mode = [[dict objectForKey:@"mode"] intValue];
    cocos2d::GLView *glview = cocos2d::Director::getInstance()->getOpenGLView();
    float scale = glview->getContentScaleFactor();
    float scalex = glview->getScaleX();
    float scaley = glview->getScaleY();
    cocos2d::Size size = glview->getVisibleSize();
    CGRect rect = CGRectMake(0, 0, size.width/scale*scalex, size.height/scale*scaley);
    //    NSLog(@"size[%f][%f][%f][%f][%f]", rect.size.width, rect.size.height, scale, scalex, scaley);
    IAPView *iapView = [[IAPView alloc] initWithFrame:rect];
    UIView *view = (UIView *)glview->getEAGLView();
    [view addSubview:iapView];
    [iapView setServerUrl:serverUrl];
    [iapView setOrderNo:orderNo];
    [iapView setMode:mode];
    int scriptHandler = [[dict objectForKey:@"handler"] intValue];
    [iapView setScriptHandler:scriptHandler];
//    product_id = @"1000001";
    NSLog(@"iap productId[%@]", product_id);
    [iapView requestPay:product_id];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self == nil) {
        return self;
    }
    spinner = nil;
    frameSpinner = CGRectMake(0, 0, frame.size.width, frame.size.height);
    
    [self addObserver];
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)addLoading
{
    if (nil != spinner) {
        [spinner removeFromSuperview];
    }
    spinner = [[UIView alloc] initWithFrame:frameSpinner];
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [indicator setCenter:CGPointMake(frameSpinner.size.width/2, frameSpinner.size.height/2)];
    [spinner addSubview:indicator];
    [indicator release];
    [indicator startAnimating];
    [self addSubview:spinner];
    [spinner release];
}

- (void)removeLoading
{
    [spinner removeFromSuperview];
    spinner = nil;
}

- (void)setScriptHandler:(int)scriptHandler
{
    if (_scriptHandler)
    {
        LuaBridge::releaseLuaFunctionById(_scriptHandler);
        _scriptHandler = 0;
    }
    _scriptHandler = scriptHandler;
}

- (void)back
{
    [self removeObserver];
    [self removeFromSuperview];
    if (_scriptHandler)
    {
        LuaBridge::pushLuaFunctionById(_scriptHandler);
        LuaStack *stack = LuaBridge::getStack();
        stack->pushString("back");
        stack->executeFunction(1);
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    NSLog(@"IAPView alertView click:[%d]", buttonIndex);
    if (0 == buttonIndex) {
        [self back];
        return;
    }
    if (1 == buttonIndex) {
        [self reValidateReceipt];
        return;
    }
}

- (void)addObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleProductRequestNotification:)
                                                 name:IAPProductRequestNotification
                                               object:[StoreManager sharedInstance]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handlePurchasesNotification:)
                                                 name:IAPPurchaseNotification
                                               object:[StoreObserver sharedInstance]];
}

- (void)removeObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IAPProductRequestNotification
                                                  object:[StoreManager sharedInstance]];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IAPPurchaseNotification
                                                  object:[StoreObserver sharedInstance]];
}

- (void)requestPay:(NSString *)product_id
{
    if([SKPaymentQueue canMakePayments])
    {
        [self addLoading];
        NSArray *productIds = @[product_id];
        [[StoreManager sharedInstance] fetchProductInformationForIds:productIds];
    }
    else
    {
        [SysTool alertWithTitle:@"Warning" message:@"Purchases are disabled on this device." delegate:self];
    }
}

- (void)handleProductRequestNotification:(NSNotification *)notification
{
    StoreManager *productRequestNotification = (StoreManager*)[notification object];
    IAPProductRequestStatus result = (IAPProductRequestStatus)productRequestNotification.status;
    NSLog(@"IAPView handleProductRequestNotification result[%d]", result);
    switch (result)
    {
        case IAPProductsFound:
        {
            NSArray *productRequestResponse = productRequestNotification.availableProducts;
            NSLog(@"iap product productRequestResponse count[%lu]", (unsigned long)[productRequestResponse count]);
            if ([productRequestResponse count] < 1) {
                [SysTool alertWithTitle:@"Warning" message:@"IAPProductsFound" delegate:self];
                break;
            }
            SKProduct *product = (SKProduct *)productRequestResponse[0];
            // Attempt to purchase the tapped product
            [[StoreObserver sharedInstance] buy:product];
        }
            break;
            
        case IAPIdentifiersNotFound:
        {
            [SysTool alertWithTitle:@"Warning" message:@"IAPIdentifiersNotFound" delegate:self];
        }
            break;
        case IAPRequestFailed:
        {
            [SysTool alertWithTitle:@"Warning" message:productRequestNotification.errorMessage delegate:self];
            [self back];
        }
            break;
        default:
            break;
    }
}

- (void)handlePurchasesNotification:(NSNotification *)notification
{
    StoreObserver *purchasesNotification = (StoreObserver *)[notification object];
    IAPPurchaseNotificationStatus status = (IAPPurchaseNotificationStatus)purchasesNotification.status;
    NSLog(@"IAPView handlePurchasesNotification status[%d]", status);
    
    switch (status)
    {
        case IAPPurchaseRemovedTransactions:
        {
            [self back];
        }
            break;
        case IAPPurchaseSucceeded:
        {
//            NSString *title = [[StoreManager sharedInstance] titleMatchingProductIdentifier:purchasesNotification.purchasedID];
//            NSString *displayedTitle = (title.length > 0) ? title : purchasesNotification.purchasedID;
//            [SysTool alertWithTitle:@"Purchase Status" message:[NSString stringWithFormat:@"%@ was successfully purchased.",displayedTitle] delegate:self];
            SKPaymentTransaction *transaction = [purchasesNotification.productsPurchased lastObject];
            NSString *transactionId = transaction.transactionIdentifier;
            NSData *receipt = transaction.transactionReceipt;
//            NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
//            NSData *receipt = [NSData dataWithContentsOfURL:receiptURL];
            if (!receipt) {
                [SysTool alertWithTitle:@"Purchase Status" message:@"no receipt found" delegate:self];
            } else {
//                [SysTool alertWithTitle:@"Purchase Status" message:[NSString stringWithFormat:@"receipt[%@]",receipt] delegate:self];
//                [self validateLocal:receipt];
                [self sendToServer:receipt transactionId:transactionId];
//                [self sendToServer:receipt transactionId:transactionId];
                if (_scriptHandler)
                {
//                    LuaBridge::pushLuaFunctionById(_scriptHandler);
//                    LuaStack *stack = LuaBridge::getStack();
//                    stack->pushString("receipt");
//                    NSString *r = [receipt base64EncodedStringWithOptions:0];
//                    const char *s = [r UTF8String];
//                    stack->pushString(s);
//                    stack->executeFunction(2);
                }
                else
                {
                    NSLog(@"========= _scriptHandler is nil");
                }
            }
        }
            break;
        case IAPPurchaseFailed:
            [SysTool alertWithTitle:@"Purchase Status" message:purchasesNotification.message delegate:self];
//            [self alertWithTitle:@"Purchase Status" message:purchasesNotification.message];
            break;
            // Switch to the iOSPurchasesList view controller when receiving a successful restore notification
        case IAPRestoredSucceeded:
        {
            // Get the view controller currently displayed
//            UIViewController *selectedController = [self viewControllerForSelectedIndex:self.segmentedControl.selectedSegmentIndex];
//            self.segmentedControl.selectedSegmentIndex = 1;
//            [self cycleFromViewController:selectedController toViewController:self.purchasesList];
        }
            break;
        case IAPRestoredFailed:
//            [self alertWithTitle:@"Purchase Status" message:purchasesNotification.message];
            break;
            // Notify the user that downloading is about to start when receiving a download started notification
        case IAPDownloadStarted:
        {
//            self.hasDownloadContent = YES;
//            [self.view addSubview:self.statusMessage];
        }
            break;
            // Display a status message showing the download progress
        case IAPDownloadInProgress:
        {
//            self.hasDownloadContent = YES;
//            NSString *title = [[StoreManager sharedInstance] titleMatchingProductIdentifier:purchasesNotification.purchasedID];
//            NSString *displayedTitle = (title.length > 0) ? title : purchasesNotification.purchasedID;
//            self.statusMessage.text = [NSString stringWithFormat:@"Downloading %@ %.2f%%",displayedTitle, purchasesNotification.downloadProgress];
        }
            break;
            // Downloading is done, remove the status message
        case IAPDownloadSucceeded:
        {
//            self.hasDownloadContent = NO;
//            self.statusMessage.text = @"Download complete: 100%";
//            
//            // Remove the message after 2 seconds
//            [self performSelector:@selector(hideStatusMessage) withObject:nil afterDelay:2];
        }
        default:
            break;
    }
}

+ (void)testSend:(NSDictionary *)dict
{
    NSString *receiptString = @"ewoJInNpZ25hdHVyZSIgPSAiQW5LS281dkhkRGpnZ2xkRHBZRCtNM0labk9qZzZzTDhmU1BGOTdtWGZoT1d2SmxnM2dmektXeWxuYTZHK0VEMUJCdGQwT0Y5ZExaRkVQb1FRU0dFZGpnTWNIY3dxNjJ5eXBRTWp1WmhURXY1RFM3cXVndmdlbGI0cFVKKzlSVzMxcVk4djVrbHBNanNXUVdySEpPbnBic1Z3OGd1djk5b0pUMlprUUxSWWgyR0FBQURWekNDQTFNd2dnSTdvQU1DQVFJQ0NCdXA0K1BBaG0vTE1BMEdDU3FHU0liM0RRRUJCUVVBTUg4eEN6QUpCZ05WQkFZVEFsVlRNUk13RVFZRFZRUUtEQXBCY0hCc1pTQkpibU11TVNZd0pBWURWUVFMREIxQmNIQnNaU0JEWlhKMGFXWnBZMkYwYVc5dUlFRjFkR2h2Y21sMGVURXpNREVHQTFVRUF3d3FRWEJ3YkdVZ2FWUjFibVZ6SUZOMGIzSmxJRU5sY25ScFptbGpZWFJwYjI0Z1FYVjBhRzl5YVhSNU1CNFhEVEUwTURZd056QXdNREl5TVZvWERURTJNRFV4T0RFNE16RXpNRm93WkRFak1DRUdBMVVFQXd3YVVIVnlZMmhoYzJWU1pXTmxhWEIwUTJWeWRHbG1hV05oZEdVeEd6QVpCZ05WQkFzTUVrRndjR3hsSUdsVWRXNWxjeUJUZEc5eVpURVRNQkVHQTFVRUNnd0tRWEJ3YkdVZ1NXNWpMakVMTUFrR0ExVUVCaE1DVlZNd2daOHdEUVlKS29aSWh2Y05BUUVCQlFBRGdZMEFNSUdKQW9HQkFNbVRFdUxnamltTHdSSnh5MW9FZjBlc1VORFZFSWU2d0Rzbm5hbDE0aE5CdDF2MTk1WDZuOTNZTzdnaTNvclBTdXg5RDU1NFNrTXArU2F5Zzg0bFRjMzYyVXRtWUxwV25iMzRucXlHeDlLQlZUeTVPR1Y0bGpFMU93QytvVG5STStRTFJDbWVOeE1iUFpoUzQ3VCtlWnRERWhWQjl1c2szK0pNMkNvZ2Z3bzdBZ01CQUFHamNqQndNQjBHQTFVZERnUVdCQlNKYUVlTnVxOURmNlpmTjY4RmUrSTJ1MjJzc0RBTUJnTlZIUk1CQWY4RUFqQUFNQjhHQTFVZEl3UVlNQmFBRkRZZDZPS2RndElCR0xVeWF3N1hRd3VSV0VNNk1BNEdBMVVkRHdFQi93UUVBd0lIZ0RBUUJnb3Foa2lHOTJOa0JnVUJCQUlGQURBTkJna3Foa2lHOXcwQkFRVUZBQU9DQVFFQWVhSlYyVTUxcnhmY3FBQWU1QzIvZkVXOEtVbDRpTzRsTXV0YTdONlh6UDFwWkl6MU5ra0N0SUl3ZXlOajVVUllISytIalJLU1U5UkxndU5sMG5rZnhxT2JpTWNrd1J1ZEtTcTY5Tkluclp5Q0Q2NlI0Szc3bmI5bE1UQUJTU1lsc0t0OG9OdGxoZ1IvMWtqU1NSUWNIa3RzRGNTaVFHS01ka1NscDRBeVhmN3ZuSFBCZTR5Q3dZVjJQcFNOMDRrYm9pSjNwQmx4c0d3Vi9abEwyNk0ydWVZSEtZQ3VYaGRxRnd4VmdtNTJoM29lSk9PdC92WTRFY1FxN2VxSG02bTAzWjliN1BSellNMktHWEhEbU9Nazd2RHBlTVZsTERQU0dZejErVTNzRHhKemViU3BiYUptVDdpbXpVS2ZnZ0VZN3h4ZjRjemZIMHlqNXdOelNHVE92UT09IjsKCSJwdXJjaGFzZS1pbmZvIiA9ICJld29KSW05eWFXZHBibUZzTFhCMWNtTm9ZWE5sTFdSaGRHVXRjSE4wSWlBOUlDSXlNREUxTFRBekxUSTBJREUxT2pFMk9qSXpJRUZ0WlhKcFkyRXZURzl6WDBGdVoyVnNaWE1pT3dvSkluVnVhWEYxWlMxcFpHVnVkR2xtYVdWeUlpQTlJQ0kzWXpCbU16Qm1PVFZoTmpVelpURmtOakl6TVROalptWTFNMk5oT1RVMVpUVXlZVGsyWWpFMklqc0tDU0p2Y21sbmFXNWhiQzEwY21GdWMyRmpkR2x2YmkxcFpDSWdQU0FpTVRBd01EQXdNREUwT0RneE1qa3lNU0k3Q2draVluWnljeUlnUFNBaU1TNDFJanNLQ1NKMGNtRnVjMkZqZEdsdmJpMXBaQ0lnUFNBaU1UQXdNREF3TURFME9EZ3hNamt5TVNJN0Nna2ljWFZoYm5ScGRIa2lJRDBnSWpFaU93b0pJbTl5YVdkcGJtRnNMWEIxY21Ob1lYTmxMV1JoZEdVdGJYTWlJRDBnSWpFME1qY3lNelV6T0RNNU9USWlPd29KSW5WdWFYRjFaUzEyWlc1a2IzSXRhV1JsYm5ScFptbGxjaUlnUFNBaU1FSkVPREEwTkVZdE5EWTRNeTAwUVRORUxVSTROMFF0UlVaR01UQkdSalZFTlRWRElqc0tDU0p3Y205a2RXTjBMV2xrSWlBOUlDSXhNREF3TURRaU93b0pJbWwwWlcwdGFXUWlJRDBnSWprM01qazVNVGs1T1NJN0Nna2lkbVZ5YzJsdmJpMWxlSFJsY201aGJDMXBaR1Z1ZEdsbWFXVnlJaUE5SUNJNE1URTVNVGcxTVRVaU93b0pJbUpwWkNJZ1BTQWlZMjl0TG5scGNXa3VaV01pT3dvSkluQjFjbU5vWVhObExXUmhkR1V0YlhNaUlEMGdJakUwTWpjeU16VXpPRE01T1RJaU93b0pJbkIxY21Ob1lYTmxMV1JoZEdVaUlEMGdJakl3TVRVdE1ETXRNalFnTWpJNk1UWTZNak1nUlhSakwwZE5WQ0k3Q2draWNIVnlZMmhoYzJVdFpHRjBaUzF3YzNRaUlEMGdJakl3TVRVdE1ETXRNalFnTVRVNk1UWTZNak1nUVcxbGNtbGpZUzlNYjNOZlFXNW5aV3hsY3lJN0Nna2liM0pwWjJsdVlXd3RjSFZ5WTJoaGMyVXRaR0YwWlNJZ1BTQWlNakF4TlMwd015MHlOQ0F5TWpveE5qb3lNeUJGZEdNdlIwMVVJanNLZlE9PSI7CgkiZW52aXJvbm1lbnQiID0gIlNhbmRib3giOwoJInBvZCIgPSAiMTAwIjsKCSJzaWduaW5nLXN0YXR1cyIgPSAiMCI7Cn0=";
    NSString *url = [dict objectForKey:@"url"];
    NSString *modeString = @"0";
    NSString *orderNoString = @"1427235368495";
    NSString *transactionId = @"1000000148812921";
    
    [SysTool saveRMS:[NSArray arrayWithObjects:url, modeString, orderNoString, transactionId, receiptString, nil] key:SAVE_IAP_RECEIPT];
    
    cocos2d::GLView *glview = cocos2d::Director::getInstance()->getOpenGLView();
    float scale = glview->getContentScaleFactor();
    float scalex = glview->getScaleX();
    float scaley = glview->getScaleY();
    cocos2d::Size size = glview->getVisibleSize();
    CGRect rect = CGRectMake(0, 0, size.width/scale*scalex, size.height/scale*scaley);
    //    NSLog(@"size[%f][%f][%f][%f][%f]", rect.size.width, rect.size.height, scale, scalex, scaley);
    IAPView *iapView = [[IAPView alloc] initWithFrame:rect];
    UIView *view = (UIView *)glview->getEAGLView();
    [view addSubview:iapView];
    int scriptHandler = [[dict objectForKey:@"handler"] intValue];
    [iapView setScriptHandler:scriptHandler];
    
    
    [iapView doValidateReceipt:url modeString:modeString orderNoString:orderNoString transactionId:transactionId receiptString:receiptString];
}

- (void)doValidateReceipt:(NSString *)url modeString:(NSString *)modeString orderNoString:(NSString *)orderNoString transactionId:(NSString *)transactionId receiptString:(NSString *)receiptString
{
    NSError *error;
    NSDictionary *requestContents = @{
                                      @"receipt-data": receiptString
                                      };
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:requestContents options:0 error:&error];
    
    NSURL *serverURL = [NSURL URLWithString:url];
    NSLog(@"IAP serverURL[%@]", url);
    NSMutableURLRequest *serverRequest = [NSMutableURLRequest requestWithURL:serverURL];
    [serverRequest setHTTPMethod:@"POST"];
    [serverRequest setValue:modeString forHTTPHeaderField:@"mode"];
    [serverRequest setValue:orderNoString forHTTPHeaderField:@"orderno"];
    [serverRequest setValue:transactionId forHTTPHeaderField:@"transactionId"];
    [serverRequest setHTTPBody:requestData];
    
    
    [self addLoading];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:serverRequest queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (connectionError) {
                                   /* ... Handle error ... */
                                   NSLog(@"server connectionError[%ld]", (long)[connectionError code]);
                                   //                                   [SysTool alertWithTitle:@"Purchase Status" message:@"网络连接失败" delegate:self];
                               } else {
                                   NSError *error;
                                   NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                   if (!jsonResponse) {
                                       /* ... Handle error ...*/
                                       NSLog(@"server jsonResponse is nil");
                                   }
                                   
                                   dispatch_async(dispatch_get_main_queue(), ^{
                                       if (0 > [[jsonResponse valueForKey:@"status"] intValue]) {
                                           [SysTool alertWithTitle2:@"验证失败" btnAction:@"重试" message:[jsonResponse valueForKey:@"msg"] delegate:self];
                                       } else {
                                           [SysTool removeRMS:SAVE_IAP_RECEIPT];
                                       }
                                       /* ... Send a response back to the device ... */
                                       NSLog(@"server get receipt success");
                                       [self removeLoading];
                                   });
                               }
                           }];

}

- (void)reValidateReceipt
{
    NSArray *payInfo = [SysTool loadRMS:SAVE_IAP_RECEIPT];
    if (nil == payInfo) {
        return;
    }
    NSString *url = [payInfo objectAtIndex:0];
    NSString *modeString = [payInfo objectAtIndex:1];
    NSString *orderNoString = [payInfo objectAtIndex:2];
    NSString *transactionId = [payInfo objectAtIndex:3];
    NSString *receiptString = [payInfo objectAtIndex:4];
    [self doValidateReceipt:url modeString:modeString orderNoString:orderNoString transactionId:transactionId receiptString:receiptString];
    
}

+ (void)checkIAPClear:(NSDictionary *)dict
{
    NSArray *payInfo = [SysTool loadRMS:SAVE_IAP_RECEIPT];
    if (nil == payInfo) {
        return;
    }
    cocos2d::GLView *glview = cocos2d::Director::getInstance()->getOpenGLView();
    float scale = glview->getContentScaleFactor();
    float scalex = glview->getScaleX();
    float scaley = glview->getScaleY();
    cocos2d::Size size = glview->getVisibleSize();
    CGRect rect = CGRectMake(0, 0, size.width/scale*scalex, size.height/scale*scaley);
    //    NSLog(@"size[%f][%f][%f][%f][%f]", rect.size.width, rect.size.height, scale, scalex, scaley);
    IAPView *iapView = [[IAPView alloc] initWithFrame:rect];
    UIView *view = (UIView *)glview->getEAGLView();
    [view addSubview:iapView];
    
    [SysTool alertWithTitle2:@"验证提示" btnAction:@"重试" message:@"你有一个成功付款的内购项目因验证失败导致未能兑现，请点击重试进行重新验证。如有疑问请联系客服" delegate:iapView];
    return;
}

+ (void)cleanIAPrecord:(NSDictionary *)dict
{
    [SysTool removeRMS:SAVE_IAP_RECEIPT];
}

- (void)sendToServer:(NSData *)receipt transactionId:(NSString *)transactionId
{
//    NSError *error;
    NSString *receiptString = [receipt base64EncodedStringWithOptions:0];
//    NSDictionary *requestContents = @{
//                                      @"receipt-data": receiptString
//                                      };
//    NSData *requestData = [NSJSONSerialization dataWithJSONObject:requestContents options:0 error:&error];
    NSString *url = [self serverUrl];
    NSString *modeString = [NSString stringWithFormat:@"%d", [self mode]];
    NSString *orderNoString = [self orderNo];
    
    [SysTool saveRMS:[NSArray arrayWithObjects:url, modeString, orderNoString, transactionId, receiptString, nil] key:SAVE_IAP_RECEIPT];
    
    [self doValidateReceipt:url modeString:modeString orderNoString:orderNoString transactionId:transactionId receiptString:receiptString];
    
//    NSURL *serverURL = [NSURL URLWithString:url];
//    NSLog(@"IAP serverURL[%@]", url);
//    NSMutableURLRequest *serverRequest = [NSMutableURLRequest requestWithURL:serverURL];
//    [serverRequest setHTTPMethod:@"POST"];
//    [serverRequest setValue:[NSString stringWithFormat:@"%d", [self mode]] forHTTPHeaderField:@"mode"];
//    [serverRequest setValue:[NSString stringWithFormat:@"%@", [self orderNo]] forHTTPHeaderField:@"orderno"];
//    [serverRequest setValue:[NSString stringWithFormat:@"%@", transactionId] forHTTPHeaderField:@"transactionId"];
//    [serverRequest setHTTPBody:requestData];
//
//    
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    [NSURLConnection sendAsynchronousRequest:serverRequest queue:queue
//                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//                               if (connectionError) {
//                                   /* ... Handle error ... */
//                                   NSLog(@"server connectionError[%ld]", (long)[connectionError code]);
////                                   [SysTool alertWithTitle:@"Purchase Status" message:@"网络连接失败" delegate:self];
//                               } else {
//                                   NSError *error;
//                                   NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
//                                   if (!jsonResponse) {
//                                       /* ... Handle error ...*/
//                                       NSLog(@"server jsonResponse is nil");
//                                   }
//                                   if (0 > [[jsonResponse valueForKey:@"status"] intValue]) {
//                                       dispatch_async(dispatch_get_main_queue(), ^{
//                                       [SysTool alertWithTitle:@"验证失败" message:[jsonResponse valueForKey:@"msg"] delegate:self];
//                                       });
//                                   }
//                                   /* ... Send a response back to the device ... */
//                                   NSLog(@"server get receipt success");
//                               }
//                           }];
}

- (void)validateLocal:(NSData *)receipt
{
    // Create the JSON object that describes the request
    NSError *error;
    NSDictionary *requestContents = @{
                                      @"receipt-data": [receipt base64EncodedStringWithOptions:0]
                                      };
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:requestContents options:0 error:&error];

    if (!requestData) { /* ... Handle error ... */ }
    
    NSString *verifyURL;
    verifyURL = @"https://sandbox.itunes.apple.com/verifyReceipt";
//    verifyURL = @"https://buy.itunes.apple.com/verifyReceipt";
    
    // Create a POST request with the receipt data.
    NSURL *storeURL = [NSURL URLWithString:verifyURL];
    NSMutableURLRequest *storeRequest = [NSMutableURLRequest requestWithURL:storeURL];
    [storeRequest setHTTPMethod:@"POST"];
    [storeRequest setHTTPBody:requestData];

    // Make a connection to the iTunes Store on a background queue.
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:storeRequest queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (connectionError) {
                                   /* ... Handle error ... */
                                   NSLog(@"connectionError[%ld]", (long)[connectionError code]);
                               } else {
                                   NSError *error;
                                   NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                   if (!jsonResponse) {
                                       /* ... Handle error ...*/
                                       NSLog(@"jsonResponse is nil");
                                   }
                                   NSString *s = [jsonResponse description];
                                   NSLog(@"verify receipt success\n[%@]", s);
                               }
                           }];

}

@end
#endif
#pragma mark AppStore iap ------ 

#pragma mark apay
#ifdef E_APAY

#import <CommonCrypto/CommonCrypto.h>
#import "AppController.h"

@interface APayView() <APayDelegate>
@end

@implementation APayView

+ (void)requestAPayView:(UIViewController *)view1
{
    cocos2d::GLView *glview = cocos2d::Director::getInstance()->getOpenGLView();
    float scale = glview->getContentScaleFactor();
    float scalex = glview->getScaleX();
    float scaley = glview->getScaleY();
    cocos2d::Size size = glview->getVisibleSize();
    CGRect rect = CGRectMake(0, 0, size.width/scale*scalex, size.height/scale*scaley);
    APayView *apayView = [[APayView alloc] initWithFrame:rect];
    UIView *view = (UIView *)glview->getEAGLView();
    [view addSubview:apayView];
//    int scriptHandler = [[dict objectForKey:@"handler"] intValue];
//    [apayView setScriptHandler:scriptHandler];
    NSString *payData = [APayView randomPaa];
    [APay startPay:payData viewController:view1 delegate:apayView mode:@"01"];
}

+ (void)requestAPay:(NSDictionary *)dict
{
//    APayViewController *viewController = [[APayViewController alloc] initWithNibName:nil bundle:nil];
    NSString *merchantId = [dict objectForKey:@"merchantId"];
    NSString *orderNo = [dict objectForKey:@"orderNo"];
    NSString *receiveUrl = [dict objectForKey:@"receiveUrl"];
    NSString *productName = [dict objectForKey:@"productName"];
    NSString *price = [dict objectForKey:@"price"];
    NSString *mode = [dict objectForKey:@"mode"];
    NSString *key = [dict objectForKey:@"key"];
//    NSLog(@"requestAPay product_id[%@]", product_id);
    cocos2d::GLView *glview = cocos2d::Director::getInstance()->getOpenGLView();
    float scale = glview->getContentScaleFactor();
    float scalex = glview->getScaleX();
    float scaley = glview->getScaleY();
    cocos2d::Size size = glview->getVisibleSize();
    CGRect rect = CGRectMake(0, 0, size.width/scale*scalex, size.height/scale*scaley);
    APayView *apayView = [[APayView alloc] initWithFrame:rect];
    UIView *view = (UIView *)glview->getEAGLView();
    [view addSubview:apayView];
    int scriptHandler = [[dict objectForKey:@"handler"] intValue];
    [apayView setScriptHandler:scriptHandler];
//    NSString *payData = [APayView randomPaa]; // test
    NSString *payData = [APayView getPaa:merchantId orderNo:orderNo productName:productName receiveUrl:receiveUrl price:price key:key];
//    UIViewController *vc = [wwww rootViewController];
    UIViewController *vc = [[AppController getWindowInstance] rootViewController];
    if (nullptr == vc) {
        NSLog(@"view controller is nil ");
        [apayView back];
        return;
    }
//    mode = @"00";
    [APay startPay:payData viewController:vc delegate:apayView mode:mode];
//    [apayView back];
}

+ (NSString *)getPaa:(NSString *)merchantId orderNo:(NSString *)orderNo productName:(NSString *)productName receiveUrl:(NSString *)receiveUrl price:(NSString *)price key:(NSString *)key
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate * workDate = [NSDate dateWithTimeIntervalSinceReferenceDate:[NSDate timeIntervalSinceReferenceDate]];
    NSString * timeStr = [dateFormatter stringFromDate:workDate];
    
    NSArray * paaDic = @[
                         @"1", @"inputCharset",
                         receiveUrl, @"receiveUrl",
                         @"v1.0", @"version",
                         @"1", @"signType",  // 0 means using MD5 key (not cert)
                         merchantId, @"merchantId",
                         orderNo, @"orderNo",
                         price, @"orderAmount",
                         @"0", @"orderCurrency",
                         timeStr, @"orderDatetime", //  orderDateTime can be now()
                         productName, @"productName",
                         //@"<USER>201406131006408</USER>", @"ext1", // allinpay do not accept this format
                         @"27", @"payType", // both credit and debit card
                         key, @"key",
                         ];
    
    NSString *paaStr = [self formatPaa:paaDic];
    NSLog(@"paaStr %@", paaStr);
    return paaStr;
}

+ (NSString *)randomPaa
{
    int count = 0;
    
    //test
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate * workDate = [NSDate dateWithTimeIntervalSinceReferenceDate:[NSDate timeIntervalSinceReferenceDate]];
    NSString * timeStr = [dateFormatter stringFromDate:workDate];
    NSString * orderStr = [NSString stringWithFormat:@"%@%@", timeStr, [NSString stringWithFormat:@"%04d", count]];
    
    NSArray * paaDic = @[
                         @"1", @"inputCharset",
                         @"http://127.0.0.1:7730/pay_server/AllinpayServlet", @"receiveUrl",
                         @"v1.0", @"version",
                         @"0", @"signType",  // 0 means using MD5 key (not cert)
                         @"100020091218001", @"merchantId",
                         orderStr, @"orderNo",
                         @"100", @"orderAmount",
                         @"0", @"orderCurrency",
                         timeStr, @"orderDatetime", //  orderDateTime can be now()
                         @"crystal", @"productName",
                         //@"<USER>201406131006408</USER>", @"ext1", // allinpay do not accept this format
                         @"27", @"payType", // both credit and debit card
                         @"1234567890", @"key",
                         ];
    
    NSString *paaStr = [self formatPaa:paaDic];
    NSLog(@"paaStr %@", paaStr);
    
    count++;
    
    return paaStr;
}

+ (NSString *)formatPaa:(NSArray *)array
{
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    NSMutableString *paaStr = [[NSMutableString alloc] init];
    for (int i = 0; i < array.count; i++) {
        [paaStr appendFormat:@"%@=%@&", array[i+1], array[i]];
        mdic[array[i+1]] = array[i];
        i++;
    }
    NSString *signMsg = [self md5:[paaStr substringToIndex:paaStr.length - 1]];
    mdic[@"signMsg"] = signMsg.uppercaseString;
    if (mdic[@"key"]) {//商户私有签名密钥 通联后台持有不传入插件
        [mdic removeObjectForKey:@"key"];
    }
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:mdic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonStr = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
    [paaStr setString:jsonStr];
    return paaStr;
}

+ (NSString *)md5:(NSString *)string
{
    const char *str = [string cStringUsingEncoding:NSUTF8StringEncoding];
    CC_LONG strLen = (CC_LONG)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    unsigned char *result = (unsigned char *)calloc(CC_MD5_DIGEST_LENGTH, sizeof(unsigned char));
    CC_MD5(str, strLen, result);
    
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; ++i) {
        [hash appendFormat:@"%02x", result[i]];
    }
    
    free(result);
    
    return hash;
}

- (void)APayResult:(NSString *)result
{
    NSLog(@"%@", result);
    NSArray *parts = [result componentsSeparatedByString:@"="];
    NSError *error;
    NSData *data = [[parts lastObject] dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    NSInteger payResult = [dic[@"payResult"] integerValue];
    NSString *format_string = @"支付结果::支付%@";
    if (payResult == APayResultSuccess) {
        NSLog(format_string,@"成功");
        [SysTool alertWithTitle:@"通联支付结果" message:@"支付结果::支付成功" delegate:self];
    } else if (payResult == APayResultFail) {
        NSLog(format_string,@"失败");
        [SysTool alertWithTitle:@"通联支付结果" message:@"支付结果::支付失败" delegate:self];
    } else if (payResult == APayResultCancel) {
        NSLog(format_string,@"取消");
        [SysTool alertWithTitle:@"通联支付结果" message:@"支付结果::支付取消" delegate:self];
    } else {
        [SysTool alertWithTitle:@"通联支付结果" message:[NSString stringWithFormat:@"支付结果::payResult[%d]", payResult] delegate:self];
    }
    [self back];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self == nil) {
        return self;
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)setScriptHandler:(int)scriptHandler
{
    if (_scriptHandler)
    {
        LuaBridge::releaseLuaFunctionById(_scriptHandler);
        _scriptHandler = 0;
    }
    _scriptHandler = scriptHandler;
}

- (void)back
{
    [self removeFromSuperview];
    if (_scriptHandler)
    {
        LuaBridge::pushLuaFunctionById(_scriptHandler);
        LuaStack *stack = LuaBridge::getStack();
        stack->pushString("back");
        stack->executeFunction(1);
    }
}
@end
#endif
#pragma mark apay ------

@implementation SysTool

+ (void)textToPasteboard:(NSDictionary *)dict
{
    NSString *text = [dict objectForKey:@"text"];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:text];
}

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message delegate:(id<UIAlertViewDelegate>)delegate
{
    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:title
                                                       message:message
                                                      delegate:delegate
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
    [alerView show];
    
}

+ (void)alertWithTitle2:(NSString *)title btnAction:(NSString *)btnAction message:(NSString *)message delegate:(id<UIAlertViewDelegate>)delegate
{
    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:title
                                                       message:message
                                                      delegate:delegate
                                             cancelButtonTitle:@"关闭"
                                             otherButtonTitles:btnAction, nil];
    [alerView show];
    
}

+ (void)setUpLocalPush:(NSDictionary *)dict
{
    int sec = [[dict objectForKey:@"sec"] intValue];
    int min = [[dict objectForKey:@"min"] intValue];
    int hours = [[dict objectForKey:@"hours"] intValue];
    int days = [[dict objectForKey:@"days"] intValue];
    int startHour = [[dict objectForKey:@"startHour"] intValue];
    int endHour = [[dict objectForKey:@"endHour"] intValue];
    NSString *message = [dict objectForKey:@"message"];
    NSString *key = [dict objectForKey:@"key"];
    [self setUpLocalPushBySec:key sec:sec min:min hour:hours days:days limitFromHour:startHour to:endHour message:message];
}

+ (void)setUpLocalPushBySec:(NSString *)key sec:(int)sec min:(int)min hour:(int)hours days:(int)days limitFromHour:(int)startHour to:(int)endHour message:(NSString*)inputMessage {
    UIDevice* thisDevice = [UIDevice currentDevice];
    
    NSString *verString = thisDevice.systemVersion;
    
    float verNum = [verString floatValue];
    
    if (verNum < 4.0){
        return;
    }
    
    int SECOND_IN_MINUTE = 60;
    int SECOND_IN_HOUR = 60*SECOND_IN_MINUTE;
    int SECOND_IN_DAY = 24*SECOND_IN_HOUR;
    
    
    int totalSec = (days * SECOND_IN_DAY) + (hours * SECOND_IN_HOUR)+ (min * SECOND_IN_MINUTE) + sec;
    
    
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    
    // Get the current date
    NSDate *currentDate = [NSDate date];
    NSDate *targetTime = [currentDate dateByAddingTimeInterval:totalSec];
    
    // Break the date up into components
    NSDateComponents *dateComponents = [calendar components:( NSYearCalendarUnit |
                                                             NSMonthCalendarUnit |
                                                             NSDayCalendarUnit )
                                                   fromDate:targetTime];
    NSDateComponents *timeComponents = [calendar components:( NSHourCalendarUnit |
                                                             NSMinuteCalendarUnit |
                                                             NSSecondCalendarUnit )
                                                   fromDate:targetTime];
    int second = [timeComponents second];
    int minute = [timeComponents minute];
    int day = [dateComponents day];
    int hour = [timeComponents hour];
    
    //limit the push to 10am-10pm only
    if (hour < startHour){
        hour = startHour;
    }
    
    if (hour >= endHour){
        hour = startHour;
        day++;
    }
    
    NSLog(@"LocalPush - day %d hour %d min %d second %d",day,hour,minute,second);
    
    // Set up the fire time
    NSDateComponents *dateComps = [[NSDateComponents alloc] init];
    [dateComps setDay:day];
    [dateComps setMonth:[dateComponents month]];
    [dateComps setYear:[dateComponents year]];
    [dateComps setHour:hour];
    [dateComps setMinute:minute];
    [dateComps setSecond:second];
    NSDate *itemDate = [calendar dateFromComponents:dateComps];
    [dateComps release];
    
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    if (localNotif == nil)
        return;
    localNotif.fireDate = itemDate;
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
    localNotif.repeatInterval = kCFCalendarUnitSecond;
    
    // Notification details
    //NSLog(@"Local Push Testing sec:%d min:%d day:%d",sec,min,days);
    localNotif.alertBody = inputMessage;
    // Set the action button
    localNotif.alertAction = @"进入游戏";
    
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    localNotif.applicationIconBadgeNumber = 0;
    
    // Specify custom data for the notification
    NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"just a mark" forKey:key];
    localNotif.userInfo = infoDict;
    
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        // 通知重复提示的单位，可以是天、周、月
        localNotif.repeatInterval = NSCalendarUnitDay;
    } else {
        localNotif.repeatInterval = NSDayCalendarUnit;
    }
    
    // Schedule the notification
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    [localNotif release];
    
}

+ (void)cancelAllLocalPush {
    UIDevice* thisDevice = [UIDevice currentDevice];
    
    NSString *verString = thisDevice.systemVersion;
    
    float verNum = [verString floatValue];
    
    if (verNum < 4.0){
        return;
    }
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

+ (void)cancelAllLocalPushByKey:(NSDictionary *)dict
{
    NSString *key = [dict objectForKey:@"key"];
    
    // 获取所有本地通知数组
    NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    
    for (UILocalNotification *notification in localNotifications) {
        NSDictionary *userInfo = notification.userInfo;
        if (userInfo) {
            // 根据设置通知参数时指定的key来获取通知参数
            NSString *info = userInfo[key];
            
            // 如果找到需要取消的通知，则取消
            if (info != nil) {
                [[UIApplication sharedApplication] cancelLocalNotification:notification];
                break;
            }
        }
    }
}


+ (NSString *)base64_encode:(const uint8_t *)input length:(NSInteger)length
{
//    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_ ";
    
    char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_ ";
    NSMutableData *data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t *output = (uint8_t *)data.mutableBytes;
    
    for (NSInteger i = 0; i < length; i += 3) {
        NSInteger value = 0;
        for (NSInteger j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger indexCode = (i / 3) * 4;
        output[indexCode + 0] =                    table[(value >> 18) & 0x3F];
        output[indexCode + 1] =                    table[(value >> 12) & 0x3F];
        output[indexCode + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : ' ';//'='
        output[indexCode + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : ' ';//'='
    }
    
    return [[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] autorelease];
}

+ (void)requestPay:(NSDictionary *)dict
{
#ifdef TARGET_VERSION_ALIPAY
    NSString *tradeNo = [dict objectForKey:@"trade_no"];
    NSString *title = [dict objectForKey:@"title"];
    NSString *desc = [dict objectForKey:@"desc"];
    int price = [[dict objectForKey:@"price"] intValue];
    [AlipayHandler requestPay:tradeNo title:title desc:desc price:price];
    return;
#endif
}

+ (int)getLanguage:(NSDictionary *)dict
{
#ifdef LANG_CN
    return 1;
#else
    return 2;
#endif
}


+ (void)saveRMS:(id)data key:(id)key {
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    if (preferences == nil) return;
    if ([preferences objectForKey:key] != nil) {
        [preferences removeObjectForKey:key];
    }
    
    [preferences setObject:data forKey:key];
    [preferences synchronize];
}

+ (id)loadRMS:(id)key {
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    if (preferences == nil) return nil;
    
    return [preferences objectForKey:key];
}

+ (void)removeRMS:(id)key
{
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    if (preferences != nil) {
        [preferences removeObjectForKey:key];
    }
}

@end



