/**
 * User: coler
 * Date: 5/17/13
 * Time: 11:49 上午
 */
package {
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.system.Capabilities;
import flash.text.TextField;
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

        var inAndroid:Boolean = Capabilities.manufacturer.toLowerCase().indexOf("android") != -1;
        var inIOS:Boolean = Capabilities.manufacturer.toLowerCase().indexOf("ios") != -1;


        /**
         * 在iOS上的初始化，
         */
        trace("Capabilities.manufacturer.toLowerCase()",Capabilities.manufacturer.toLowerCase());
        if(inIOS){
            // 初始化
            UMMobClickAneLib.instance.startWithAppkeyForDebugger("5388801f56240ba94b023736");  // debugger模式下有效使用了实时模式 REALTIME

            //UMMobClickAneLib.instance.startWithAppkey("5388801f56240ba94b023736");// 初始化
            // UMMobClickAneLib.instance.startWithAppkeyAndChannelId("xxxxxx","xxxxx"); // 带渠道号的初始化
            UMMobClickAneLib.instance.startSession();
            trace('initSDK inIOS');
        }
        else if(inAndroid){
            /**
             * 安卓上的初始化配置在  app.xml 里
             *
             *
             <application android:enabled="true">

             <activity android:name="com.umeng.fb.ConversationActivity" android:theme="@android:style/Theme.NoTitleBar"/>
             <activity android:name="com.umeng.fb.ContactActivity" android:theme="@android:style/Theme.NoTitleBar"/>
             <activity android:excludeFromRecents="false">
             <intent-filter>
             <action android:name="android.intent.action.MAIN"/>
             <category android:name="android.intent.category.LAUNCHER"/>
             </intent-filter>
             </activity>
             <meta-data android:value="5388c6d356240ba94803f116" android:name="UMENG_APPKEY"></meta-data>
             <meta-data android:value="test" android:name="UMENG_CHANNEL"/>
             </application>
             */



            UMMobClickAneLib.instance.startWithAppkeyForDebugger("5388c6d356240ba94803f116");  // for Debugger Mode  MobClickAgent.setDebugMode( true );
            UMMobClickAneLib.instance.startSession();
            trace('initSDK inAndroid');

        }
        trace('inIOS',inIOS,'inAndroid',inAndroid);

        var btn:Sprite =  createBtn("EventTest",300,200);
        btn.addEventListener(MouseEvent.CLICK, function(e:*):void{
            // 测试
            // 事件统计
            trace('test');
            UMMobClickAneLib.instance.event("playButtonClick");
            UMMobClickAneLib.instance.eventWithAccumulation("playButtonClick",2);
            // 统计当前事件的不同属性次数
            UMMobClickAneLib.instance.eventWithLabel("player_dead","level"+1);
            UMMobClickAneLib.instance.eventWithLabel("player_dead","level"+2);
            // 统计当前事件的不同属性次数 自定义次数
            UMMobClickAneLib.instance.eventWithLabelAndAccumulation("player_dead","level"+1,2);
            UMMobClickAneLib.instance.eventWithLabelAndAccumulation("player_dead","level"+2,3);
            // 时长统计
            UMMobClickAneLib.instance.beginEvent("inPlay");
            setTimeout(function ():void {
                UMMobClickAneLib.instance.endEvent("inPlay");
            }, 1000);

        });

        if(inAndroid){
            // 反馈插件在安卓上可用
            btn =  createBtn("FeedBack",300,280);

            btn.addEventListener(MouseEvent.CLICK, function(e:*):void{

                UMMobClickAneLib.instance.initFeedBack();
                trace('FeedBack');
                UMMobClickAneLib.instance.openFeedBack();
            });
        }

    }
    private function createBtn(label:String,x:Number,y:Number):Sprite{

        var btn:Sprite = new Sprite();
        btn.graphics.beginFill(0xff0000);
        btn.graphics.drawRect(0,0,140,50);
        btn.graphics.endFill();
        btn.x = x;
        btn.y = y;
        addChild(btn);
        var txt:TextField = new TextField();
        txt.text = label;
        txt.x = 2;
        txt.y = 2;
        txt.scaleX = txt.scaleY = 2;
        txt.selectable = false;
        txt.mouseEnabled = false;
        btn.addChild(txt);
        btn.addEventListener(MouseEvent.MOUSE_DOWN,function(e:*):void{
            btn.alpha = .5;
        })  ;

        btn.addEventListener(MouseEvent.MOUSE_UP,function(e:*):void{
            btn.alpha = 1;
        })  ;
        return btn;
    }
}
}
