# MarsSegmentBar


### 一个swift版，分页控制器，使用简单，无代码入侵，不依赖其他库 

### usage使用

### Install 安装

-------
#### Pod 安装
pod 'MarsSegmentBar'

####手动安装
You just need to drag/copy the "MarsSegmentBar" folder and drop in your project
将“MarsSegmentBar”文件夹拖进你的工程中即可

-------

usage is simple
   		
-------WARNING-------- first,you should subclass a navigationController

		#import "RxWebViewNavigationViewController.h"

		@interface myNavigationViewController : RxWebViewNavigationViewController

		@end
   		
then use webviewController as normal viewController
   		
   		NSString* urlStr = @"http://github.com";
		RxWebViewController* webViewController = [[RxWebViewController alloc] initWithUrl:[NSURL URLWithString:urlStr]];
    	[self.navigationController pushViewController:webViewController animated:YES];

and if you want to do some custom things with webview,just subclass it 如果你需要webview的更进一步自定义，子类化即可


		@interface myWebViewController : RxWebViewController

		//do your custom things

		@end
                                
                                
navigation bar tint color and back button style 导航栏的颜色和返回按钮样式


导航栏中出现的 返回 和 关闭 ，均会继承你的 navigationController 中对 navigationBar 的设置，比如：

		UIColor* tintColor = [UIColor whiteColor];
    	UIColor* barTintColor = [UIColor blueColor];
		self.navigationController.navigationBar.tintColor = tintColor;
    	self.navigationController.navigationBar.barTintColor = barTintColor;
    	[self.navigationController.navigationBar setTitleTextAttributes:@{                                                          			NSForegroundColorAttributeName:tintColor
                                                                      }];
                                                                      
 这样来自定义你的navigationBar各控件颜色，webViewController中会遵循此设置，如图
 ![image](http://img.hb.aicdn.com/4287d071d7fa4dd8e1276506ed904093a7489352da24-56cRLk_fw658)
 
 
 **也可以像微信那样在你的 navigationBar 中使用自定义的 backButtonBackgroundImage，如图**
 
 ![image](http://img.hb.aicdn.com/ab84843887791178ba8764b9bde04f4b34f338cc10f8e-1umnI5_fw658)
 
 
### Thanks

-------

 **I used [NJKWebViewProgress](https://github.com/ninjinkun/NJKWebViewProgress) to make navigation progress, it helps a lot**