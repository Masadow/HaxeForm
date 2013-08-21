package form;

import form.input.Input;
import form.input.Radio;
import form.input.Text;
import form.input.Checkbox;

/**
 * ...
 * @author Masadow
 */
class Group implements Display
{

	private var inputs : List<Display>;
	public var aligned : Bool;
	public var alignedWidth : Int; //Pixel
	public var attr : Dynamic;
	public var tag : Null<String>;
	public var legend : Null<String>; //Used when tag is a fieldset
	public var isInline : Bool;

	public function new() 
	{
		aligned = false;
		isInline = false;
		alignedWidth = 150;
		attr = { };
		inputs = new List<Display>();
		tag = "div";
		legend = null;
	}
	
	public function addInput(input : Input) : Input {
		inputs.add(input);
		return input;
	}

	public function setAlign(b : Bool, offset : Int = 150) {
		aligned = b;
		alignedWidth = offset;
	}

	public function addTextInput(label : String, name : String, ?value : String) : Text {
		return cast addInput(Utils.initInput(new Text(), label, name, value));
	}
	public function addRadioInput(label : String, name : String, ?value : String) : Radio {
		return cast addInput(Utils.initInput(new Radio(), label, name, value));
	}
	public function addCheckboxInput(label : String, name : String, ?value : String) : Checkbox {
		return cast addInput(Utils.initInput(new Checkbox(), label, name, value));
	}
	
	public function addGroup(group : Group) : Group {
		inputs.add(group);
		return group;
	}
	
	public function html() : String {
		var code : String = tag != null ? "<" + tag + " " : "";

		code += Utils.generateAttributes(attr) + ">";

		if (aligned) {
			var id = "";
			if (attr.id != null)
				id = "#" + attr.id;
			else if (attr.clazz != null)
				id = "." + attr.clazz;
			code += "<style>label"+ id +".form-align{display : block;width : " + alignedWidth + "px;float : left;}</style>";
		}
		
		if (tag == "fieldset") {
			code += "<legend>" + legend + "</legend>";
		}
		
		for (input in inputs) {
			if (aligned && input.attr.label) //Make sure we are editing an input
				input.attr.label.clazz += " form-align";
			code += input.html() + (isInline ? "" : "<br />");
		}
		return code + (tag != null ? "</" + tag + ">" : "");
	}
	
	public function print() {
		Sys.print(html());
	}
}