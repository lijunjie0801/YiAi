//
//  WebViewJS.h
//  TianLiSenProject
//
//  Created by fyaex001 on 2017/3/1.
//  Copyright © 2017年 fyaex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>


@protocol WebViewJSObjectProtocol <JSExport>


-(void)photo;


@end



@protocol WebViewJSDelegate <NSObject>



-(void)photoJS;




@end


    

@interface WebViewJS : NSObject<WebViewJSObjectProtocol>

@property(nonatomic, weak) id<WebViewJSDelegate> delegate;


@end
