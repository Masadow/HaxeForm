package form;
import haxe.ds.StringMap;
import haxe.ds.StringMap;
import haxe.ds.StringMap;
import php.Web;
import form.Form.*;

/**
 * ...
 * @author Masadow
 */
class Debug
{
	private static function cutParams(str : String) : StringMap<String> {
		var ret = new StringMap<String>();
		for (data in str.split("&")) {
			var v = data.split("=");
			ret.set(StringTools.urlDecode(v[0]), StringTools.urlDecode(v[1]));
		}
		return ret;
	}
	
	private static function formData(d : StringMap<String>) : String {
		var data = "";
		for (k in d.keys()) {
			if (StringTools.endsWith(k, "[]")) {					
				var values = Web.getParamValues(k.substr(0, k.length - 2));
				if (values != null) {
					data += k + " = { ";
					var first = true;
					for (value in values) {
						data += (first ? " " : ", ") + "\"" + value + "\"";
						first = false;
					}
					data += " }";
				}
			}
			else
				data += k + " = \"" + d.get(k) + "\"";
			data += "<br />";
		}
		return data;
	}
	
	public static function formGetData() : String {
		var data : String = "<code>";
		#if php
			var d : StringMap<String> = cutParams(Web.getParamsString());
			data += formData(d);
		#end
		return data + "</code>";
	}

	public static function formPostData() : String {
		var data : String = "<code>";
		#if php
			var d : StringMap<String> = cutParams(Web.getPostData());
			data += formData(d);
		#end
		return data + "</code>";
	}
	
}