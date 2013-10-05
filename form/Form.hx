package form;
import form.input.Checkbox;
import form.input.Input;
import form.input.Radio;
import form.input.Text;
import haxe.web.Request;
import php.Lib;
import php.Sys;
import php.Web;
import haxe.ds.StringMap;

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
	
	public var content(default, null) : Group;
	public var upload : Bool;
	public var action : String;
	public var method : Method;
	public var attr : Dynamic;
	public var submitValue : Null<String>;

	public function new() 
	{
		content = new Group();
		upload = false;
		action = Request.getURI();
		method = GET;
		attr = { };
		submitValue = null;
		params = Web.getParams();
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
		populateGroup(content);
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

		content.attr.clazz = "haxe-form " + content.attr.clazz;
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
		Sys.print(html());
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
		return validGroup(content);
	}

	/*
	 * TODO:
		 * Code display:
			* Add \n to html methods and a pre tag to have a better formatting
		 * Fields rules
		 * Form post/get data (Neko compatibility needed)
		 * Execution times:
			 * Rendering
			 * Validating
	 */
	public function debug() : Void {
		Sys.print("<fieldset><legend>Form " + (attr.id ? "#" + attr.id : "") + " debug display</legend>");
		Sys.print("<fieldset><legend>Form rendering source code</legend><code>"+ StringTools.htmlEscape(html()) +"</code></fieldset>");
		Sys.print("<fieldset><legend>Fields rules</legend></fieldset>");
		Sys.print("<fieldset><legend>Validation errors</legend></fieldset>");
		#if php
		Sys.print("<fieldset><legend>" + Std.string(method) + " data</legend>" + (method == GET ? Debug.formGetData() : Debug.formPostData()) +"</fieldset>");
		#else
		Sys.print("<fieldset><legend>" + Std.string(method) + " data</legend>Not compatible with your compilation target</fieldset>");
		#end
		Sys.print("<fieldset><legend>Files</legend>" + (upload ? "" : "Not an upload form") + "</fieldset>");
		Sys.print("<fieldset><legend>Execution times</legend></fieldset>");
		Sys.print("</fieldset>");
	}
}