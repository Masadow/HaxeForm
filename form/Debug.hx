package form;
import haxe.ds.StringMap;
import haxe.ds.StringMap;
import haxe.ds.StringMap;
import php.Web;
import form.Form.*;
import haxe.Timer;

/**
 * TODO:
	 * Code display:
		* Add \n to html methods and a pre tag to have a better formatting
	 * Fields rules
	 * Form post/get data (Neko compatibility needed)
	 * Execution times:
		 * Rendering
		 * Validating
 * @author Masadow 
 */
class Debug
{
	private var times : Hash<Float>;
	private var currentStamp : Float;
	private var form : Form;

	public function new(form : Form) {
		times = new Hash<Float>();
		currentStamp = Timer.stamp();
		this.form = form;
	}

	public function measureStart() {
		currentStamp = Timer.stamp();
	}

	public function measureEnd(key : String) {
		times.set(key, (Timer.stamp() - currentStamp) * 1000);
	}

	public function show() {
		Sys.print("<fieldset><legend>Form " + (form.attr.id ? "#" + form.attr.id : "") + " debug display</legend>");
		Sys.print("<fieldset><legend>Theme</legend><code>"+ StringTools.htmlEscape("<style>" + form.theme + "</style>") +"</code></fieldset>");
		Sys.print("<fieldset><legend>Form rendering source code</legend><code>"+ StringTools.htmlEscape(form.html()) +"</code></fieldset>");
		Sys.print("<fieldset><legend>Fields rules</legend></fieldset>");
		Sys.print("<fieldset><legend>Validation errors</legend></fieldset>");
		#if php
		Sys.print("<fieldset><legend>" + Std.string(form.method) + " data</legend>" + (form.method == GET ? formGetData() : formPostData()) +"</fieldset>");
		#else
		Sys.print("<fieldset><legend>" + Std.string(form.method) + " data</legend>Not compatible with your compilation target</fieldset>");
		#end
		Sys.print("<fieldset><legend>Files</legend>" + (form.upload ? "" : "Not an upload form") + "</fieldset>");
		Sys.print("<fieldset><legend>Execution times</legend>" + debugTimes() + "</fieldset>");
		Sys.print("</fieldset>");
	}
	
	private function debugTimes() : String {
		if (Lambda.empty(times))
			return "";
		var html = "<ul>";
		for (key in times.keys()) {
			html += "<li>" + key + ": " + Math.round(times.get(key)) + "ms</li>";
		}
		return html + "</ul>";
	}

	private function cutParams(str : String) : StringMap<String> {
		var ret = new StringMap<String>();
		for (data in str.split("&")) {
			var v = data.split("=");
			ret.set(StringTools.urlDecode(v[0]), StringTools.urlDecode(v[1]));
		}
		return ret;
	}
	
	private function formData(d : StringMap<String>) : String {
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
	
	private function formGetData() : String {
		var data : String = "<code>";
		#if php
			var d : StringMap<String> = cutParams(Web.getParamsString());
			data += formData(d);
		#end
		return data + "</code>";
	}

	private function formPostData() : String {
		var data : String = "<code>";
		#if php
			var d : StringMap<String> = cutParams(Web.getPostData());
			data += formData(d);
		#end
		return data + "</code>";
	}
	
}