package form;
import form.input.Checkbox;
import form.input.Input;
import form.input.Radio;
import form.input.Text;
import haxe.web.Request;

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
	}
	
	public function addInput(input : Input) : Input {
		content.addInput(input);
		return input;
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
}