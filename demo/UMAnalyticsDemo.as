/**
 * User: coler
 * Date: 5/17/13
 * Time: 11:49 上午
 */
package {
import flash.display.Sprite;
import flash.utils.setTimeout;

import utils.UMMobClickAneLib;

public class UMAnalyticsDemo extends Sprite {
    public function UMAnalyticsDemo() {
        /**
         * 请在app.xml里加上
         <extensions>
         <extensionID>ane.ios.UMMobClickAne</extensionID>
         </extensions>
         */
        setTimeout(function():void{
            // 初始化
            UMMobClickAneLib.instance.startWithAppkeyForDebugger("xxxxxx");  // debugger模式下有效使用了实时模式 REALTIME

           // UMMobClickAneLib.instance.startWithAppkey("xxxxxxx");// 初始化
           // UMMobClickAneLib.instance.startWithAppkeyAndChannelId("xxxxxx","xxxxx"); // 带渠道号的初始化
            UMMobClickAneLib.instance.startSession();

        },1000);
        setTimeout(function():void{
            // 测试
            // 事件统计
            UMMobClickAneLib.instance.event("playButtonClick");
            // 时长统计
            UMMobClickAneLib.instance.beginEvent("inPlay");
            setTimeout(function ():void {
                UMMobClickAneLib.instance.endEvent("inPlay");
            }, 1000);

        },2000);
    }
}
}
