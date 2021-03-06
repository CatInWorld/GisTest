package Config
{
	import mx.utils.StringUtil;
	
	import cn.zhrz.arcgis.LogManager;
	

	public class LargeDataAreaConfigManager
	{
		public function LargeDataAreaConfigManager()
		{
		}
		
		private static var instance : LargeDataAreaConfigManager;
		
		public static function getInstance():LargeDataAreaConfigManager{
			if( instance == null ){
				instance = new LargeDataAreaConfigManager();
			}
			return instance;
		}
		
		public var largeDataAreaConfig : Object;
		
		public function parseConfig(content:String):void{
			if( StringUtil.trim(content) == "" ){	
				log("LargeDataAreaConfig配置文件内容为null");
				return;
			}
			try{
				var xml : XML = new XML(content);
				var xmlChildrenList : XMLList = xml.children();
				largeDataAreaConfig = new Object();
				for( var i : int = 0; i < xmlChildrenList.length();i++ ){
					var level : Number = Number(xmlChildrenList[i].@id);
					var block : Number = Number(xmlChildrenList[i].@block);
					var lpos : Number = Number(xmlChildrenList[i].@lpos);
					var rpos : Number = Number(xmlChildrenList[i].@rpos);
					var tpos : Number = Number(xmlChildrenList[i].@tpos);
					var bpos : Number = Number(xmlChildrenList[i].@bpos);
					var areaArr : Array = new Array();
					largeDataAreaConfig[level] = { "block":block,lpos:lpos,rpos:rpos,tpos:tpos,bpos:bpos,"areaArr":areaArr};
					var children : XMLList = (xmlChildrenList[i] as XML).children();
					for each( var child : XML in children ){
						var areaObj : Object = new Object();
						areaObj.col = Number(child.@col);
						areaObj.row = Number(child.@row);
						areaArr.push(areaObj);
					}
				}
			}catch(e:Error){
				log(e.message);
			}finally{
				
			}
		}
		
		
		private function log(message : String):void{
			LogManager.getInstance().onLogMessage(message);
		}
		
	}
}