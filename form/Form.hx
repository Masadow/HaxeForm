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
	
	private var inputs : List<Input>;
	public var upload : Bool;
	public var action : String;
	public var method : Method;
	public var attr : Dynamic;
	public var aligned : Bool;
	public var alignedWidth : Int = 150; //Pixel
	public var submitValue : Null<String>;

	public function new() 
	{
		inputs = new List<Input>();
		upload = false;
		action = Request.getURI();
		method = GET;
		attr = { };
		aligned = false;
		submitValue = null;
	}
	
	public function addInput(input : Input) : Input {
		inputs.add(input);
		return input;
	}
	
	private function initInput(input : Input, label : String, name : String, value : Null<String>) : Input {
		input.label = label;
		input.name = name;
		if (value != null) {
			input.value = value;
		}
		return input;
	}
	
	public function addTextInput(label : String, name : String, ?value : String) : Text {
		inputs.add(initInput(new Text(), label, name, value));
		return cast inputs.last();
	}
	public function addRadioInput(label : String, name : String, ?value : String) : Radio {
		inputs.add(initInput(new Radio(), label, name, value));
		return cast inputs.last();
	}
	public function addCheckboxInput(label : String, name : String, ?value : String) : Checkbox {
		inputs.add(initInput(new Checkbox(), label, name, value));
		return cast inputs.last();
	}

	public function html() : String {
		var code = "";
		if (aligned) {
			var id = "";
			if (attr.id != null)
				id = "#" + attr.id;
			else if (attr.clazz != null)
				id = "." + attr.clazz;
			code += "<style>label"+ id +"{display : block;width : " + alignedWidth + "px;float : left;}</style>";
		}
		code += "<form ";
		attr.action = action;
		attr.method = Std.string(method);
		if (upload == true) {
			attr.enctype = "multipart/form-data";
		}
		code += Utils.generateAttributes(attr) + ">";
		for (input in inputs) {
			code += input.html() + "<br />";
		}
		if (submitValue != null) {
			code += "<input type=\"submit\" value=\""+ submitValue +"\" />";
		}
		return code + "</form>";
	}
	
	public function print() : Void {
		Sys.print(html());
	}
}