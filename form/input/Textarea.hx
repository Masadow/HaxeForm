package form.input;
import haxe.io.Output;
import haxe.io.StringInput;

/**
 * ...
 * @author Masadow
 */
class Textarea extends Input
{

	public function new() 
	{
		super();
	}
	
	override public function html() : String {
		var code = "<textarea ";
		if (label != "") {
			var labelCode = "<label";
			if (attr.id != null || name != "") {
				if (attr.id == null)
					attr.id = name;
				labelCode += " for='" + attr.id + "'";
			}
			if (attr.label) {
				labelCode += Utils.generateAttributes(attr.label);
			}
			code = labelCode + ">" + label + "</label>" + code;
		}
		attr.name = name;
		code += Utils.generateAttributes(attr) + ">" + value + "</textarea>";
		var error = getError();
		if (error.length > 0) {
			code += "<span class=\"formError\">" + error +"</span>";
		}
		return code;
	}


}