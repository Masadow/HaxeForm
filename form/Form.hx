package form;
import form.input.Input;
import form.input.Text;

/**
 * Main form container
 * @author Masadow
 */
class Form implements Display
{
	
	private var inputs : List<Input>;
	public var upload : Bool;
	public var action : String;
	public var method : String;
	public var attr : Dynamic;
	public var aligned : Bool;
	public var alignedWidth : Int = 150; //Pixel

	public function new() 
	{
		inputs = new List<Input>();
		upload = false;
		action = "";
		method = "GET";
		attr = { };
		aligned = false;
	}
	
	public function addInput(input : Input) {
		inputs.add(input);
	}
	
	public function addTextInput(label : String, name : String, ?value : String) {
		var input = new Text();
		input.label = label;
		input.name = name;
		if (value != null) {
			input.value = value;
		}
		inputs.add(input);
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
		attr.method = method;
		if (upload == true) {
			attr.enctype = "multipart/form-data";
		}
		code += Utils.generateAttributes(attr) + ">";
		for (input in inputs) {
			code += input.html() + "<br />";
		}
		return code + "</form>";
	}
	
	public function print() : Void {
		Sys.print(html());
	}
}