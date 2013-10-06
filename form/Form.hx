package form;
import form.input.Checkbox;
import form.input.Input;
import form.input.Radio;
import form.input.Text;
import haxe.Timer;
import haxe.web.Request;
import php.Lib;
import php.Sys;
import php.Web;
import haxe.ds.StringMap;
import sys.io.File;

enum Method {
	GET;
	POST;
}

/**
 * Main form container
 * @author Masadow
 */
class Form implements Display
{
	private var params : StringMap<String>;

	public var theme(default, null) : String;
	public var debug(default, null) : Debug;
	public var content(default, null) : Group;
	public var upload : Bool;
	public var action : String;
	public var method : Method;
	public var attr : Dynamic;
	public var submitValue : Null<String>;

	public function new() 
	{
		theme = "";
		content = new Group();
		upload = false;
		action = Request.getURI();
		method = GET;
		attr = { };
		submitValue = null;
		params = Web.getParams();
		debug = new Debug(this);
	}
	
	public function addInput(input : Input) : Input {
		content.addInput(input);
		return input;
	}
	
	private function populateGroup(group : Group) {
		for (input in group.inputs) {
			if (Std.is(input, Group)) {
				populateGroup(cast input);
			}
			else {
				var i : Input = cast input; 
				if (params.exists(i.name)) {
					i.value = params.get(i.name);
				}
				else if (StringTools.endsWith(i.name, "[]") && params.exists(i.name.substr(0, i.name.length - 2))) {
					//trace(params.get(i.name.substr(0, i.name.length - 2)));
					//var arr : Array<String> = cast params.get(i.name.substr(0, i.name.length - 2));

					//TMP BEGIN
					//Wait for Haxe 3.1
					if (Reflect.hasField(i.attr, "checked") && Web.getParamValues(i.name.substr(0, i.name.length - 2)).length > 0) {
						var attr : Dynamic = { };
						for (field in Reflect.fields(i.attr)) {
							if (field != "checked")
								Reflect.setField(attr, field, Reflect.field(i.attr, field));
						}
						i.attr = attr;
					}
					var checked : Bool = Reflect.hasField(i.attr, "checked");
					//TMP END

					for (value in Web.getParamValues(i.name.substr(0, i.name.length - 2))) {
						if (i.value == value) {
							i.attr.checked = true;
							break ;
						}
						//Fixed in Haxe 3.1
						//if (Reflect.hasField(i.attr, "checked"))
							//Reflect.deleteField(i.attr, "checked");
					}
				}
			}
		}
	}
	
	public function repopulate() {
		debug.measureStart();
		populateGroup(content);
		debug.measureEnd("Populating");
	}

	public function html() : String {
		var code = "";
		code += "<form ";
		
		content.tag = null;

		attr.action = action;
		attr.method = Std.string(method);
		if (upload == true) {
			attr.enctype = "multipart/form-data";
		}

		content.attr.clazz = "haxe-form" + (content.attr.clazz != null ? (" " + content.attr.clazz) : "");
		for (field in Reflect.fields(attr)) {
			Reflect.setField(content.attr, field, Reflect.field(attr, field));
		}

		code += content.html();
		if (submitValue != null) {
			code += "<input type=\"submit\" value=\""+ submitValue +"\" />";
		}
		return code + "</form>";
	}
	
	public function print() : Void {
		debug.measureStart();
		Sys.print("<style>" + theme + "</style>");
		Sys.print(html());
		debug.measureEnd("Printing");
	}
	
	private function validGroup(group : Group) : Bool
	{
		var valid : Bool = true;
		for (element in group.inputs) {
			if (Std.is(element, Group)) {
				valid = validGroup(cast element) && valid;
			}
			else {
				var input : Input = cast element;
				if (!params.exists(input.name)) {
					valid = false; //The form is can't say to be valid if it hasn't been submitted yet
					continue;
				}
				for (rule in input.rules) {
					var value : String;
					if (StringTools.endsWith(input.name, "[]")) {
						value = Web.getParamValues(input.name.substr(0, input.name.length - 2)).toString();
					}
					else {
						value = params.get(input.name);
					}
					rule.message = StringTools.replace(rule.message, "##", input.errorLabel != null ? input.errorLabel : input.label);
					valid = !(rule.error = !rule.apply(value)) && valid;
				}
			}
		}
		return valid;
	}
	
	public function valid() : Bool
	{
		debug.measureStart();
		var isValid = validGroup(content);
		debug.measureEnd("Validation");
		return isValid;
	}
	
	public function setTheme(data : String, loadFile : Bool = true)
	{
		if (loadFile) {
			data = File.getContent(data);
		}
		theme = data;
	}
}