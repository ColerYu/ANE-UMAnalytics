/**
 * User: coler
 * Date: 5/13/13
 * Time: 11:29 上午
 */
package utils {
import flash.events.Event;
import flash.utils.getDefinitionByName;


public class UMMobClickAneLib {
    private  var inIOS:Boolean = false;
    private var iOSUtils:*;
    private var iOSUtilsCls:Class;
    private static var _instance:UMMobClickAneLib;
    public function UMMobClickAneLib() {

        // 1. [MobClick startWithAppkey:@"xxxxxxxxxxxxxxx"];
        // 2. [MobClick updateOnlineConfig];  //在线参数配置
        // 3. + (void)setLogSendInterval:(double)second; 来改变这个最小间隔值。
        // 4. [MobClick beginEvent:@"music_play"];
        // 5. [MobClick endEvent:@"music_play"];
        // 6. - [MobClick startWithAppkey:@"xxxxxxxxxxxxxxx" reportPolicy:REALTIME channelId:@"91store"];
        // 7. [MobClick beginLogPageView:@"PageOne"];
        // 8. [MobClick endLogPageView:@"PageOne"];
        // 9. [MobClick startSession:nil];
        // 10. [MobClick event:@"xxx"];
        // 11.  [MobClick  event:[NSString stringWithUTF8String:(const char *)chars] label:[NSString stringWithUTF8String:(const char *)chars2]];

        // 12  + (void)event:(NSString *)eventId label:(NSString *)label; // label为nil或@""时，等同于 event:eventId label:eventId;
        // 13  + (void)event:(NSString *)eventId acc:(NSInteger)accumulation;
        // 14  + (void)event:(NSString *)eventId label:(NSString *)label acc:(NSInteger)accumulation;
        try{
            iOSUtilsCls = getDefinitionByName('ios.UMMobClickAne') as Class;
            inIOS =  iOSUtilsCls!= null;
            if(inIOS)  {
                iOSUtils = iOSUtilsCls.instance; // UMMobClickAne.instance.UMMobClick_CallFun()
            }
        }catch(e:*){
            trace('ane.ios.UMMobClickAne not defined inIOS=',inIOS)        ;
        }

        try{

            var NativeApplicationCls:Class = getDefinitionByName('flash.desktop.NativeApplication') as Class;
            NativeApplicationCls.nativeApplication.addEventListener(
                    Event.ACTIVATE,onActivate);

            NativeApplicationCls.nativeApplication.addEventListener(
                    Event.DEACTIVATE, onDeActivate);
        }catch(e:*){
			trace('flash.desktop.NativeApplication == null ');
        }
        onResume();
    }

    private function onActivate(event:Event):void {

        trace('onActivate');
        onResume();
    }

    private function onDeActivate(event:Event):void {
        trace('onDeActivate');
        onPause();
    }
    /**
     *    事件数量统计
     * @param eventId
     * @param label  当前事件的不同属性
     * @param accumulation  自定义次数
     */
    public function eventWithLabelAndAccumulation(eventId:String,label:String,accumulation:uint):void{
        if(inIOS)iOSUtils.UMMobClick_CallFun(14,eventId ,label,accumulation) ;
    }
    /**
     *   事件数量统计
     * @param eventId
     * @param accumulation   自定义次数
     */
    public function eventWithAccumulation(eventId:String,accumulation:uint):void{
        if(inIOS)iOSUtils.UMMobClick_CallFun(13,eventId ,accumulation) ;
    }

    /**
     *   事件数量统计
     * @param eventId
     * @param label 当前事件的不同属性
     */
    public function eventWithLabel(eventId:String,label:String):void{
        if(inIOS)iOSUtils.UMMobClick_CallFun(12,eventId ,label) ;
    }
    /**
     * 设置appKey
     * @param key
     */
    public function startWithAppkey(key:String):void{
        if(inIOS)iOSUtils.UMMobClick_CallFun(1,key) ;
    }
    /**
     * 设置appKey 实时模式  REALTIME  , Debugger模式下有效
     * @param key
     */
    public function startWithAppkeyForDebugger(key:String):void{
        if(inIOS)iOSUtils.UMMobClick_CallFun(11,key) ;
    }
    public function updateOnlineConfig():void{
        if(inIOS)iOSUtils.UMMobClick_CallFun(2) ;
    }

    /**
     *设置记录日志间隔s
     * @param second
     */
    public function setLogSendInterval(second:Number = 10):void{
        if(inIOS)iOSUtils.UMMobClick_CallFun(3,second) ;
    }

    /**
     * 时长统计 开始
     * @param eventId
     */
    public function beginEvent(eventId:String):void{
        if(inIOS)iOSUtils.UMMobClick_CallFun(4,eventId) ;
    }
    /**
     * 时长统计 结束
     * @param eventId
     */
    public function endEvent(eventId:String):void{
        if(inIOS)iOSUtils.UMMobClick_CallFun(5,eventId) ;
    }

    /**
     *   设置appKey 和 渠道id
     * @param key
     * @param channelId
     */
    public function startWithAppkeyAndChannelId(key:String,channelId:String):void{
        if(inIOS)iOSUtils.UMMobClick_CallFun(6,key,channelId ) ;
    }

    /**
     * 页面访问路径统计 进入
     * @param page
     */
    public function beginLogPageView(page:String):void{
        if(inIOS)iOSUtils.UMMobClick_CallFun(7,page ) ;
    }

    /**
     *  页面访问路径统计 离开
     * @param page
     */
    public function endLogPageView(page:String):void{
        if(inIOS)iOSUtils.UMMobClick_CallFun(8,page ) ;
    }

    /**
     *启动统计模块
     */
    public function startSession():void{
        if(inIOS)iOSUtils.UMMobClick_CallFun(9 ) ;
    }
	
	public function initFeedBack():void{
		if(inIOS)iOSUtils.UMMobClick_CallFun(19 ) ;
	}

	
	public function openFeedBack():void{
		if(inIOS)iOSUtils.UMMobClick_CallFun(20) ;
	}

    private function onResume():void{
        if(inIOS)iOSUtils.UMMobClick_CallFun(16) ;
    }
    private function onPause():void{
        if(inIOS)iOSUtils.UMMobClick_CallFun(17) ;
    }
    public function event(eventId:String):void{
        if(inIOS)iOSUtils.UMMobClick_CallFun(10,eventId ) ;
    }
	
    public static function get instance():UMMobClickAneLib {
        if(_instance == null){
            _instance = new UMMobClickAneLib();
        }
        return _instance;
    }

}
}
