package form.input;
import form.Display;
import form.Utils;
import form.validation.Rule;
import php.Web;

/**
 * ...
 * @author Masadow
 */
class Input implements Display
{
	public var label : String;
	public var errorLabel : Null<String>;
	public var name : String;
	public var value : String;
	public var attr : Dynamic;
	public var rules : Array<Rule>;

	public function new() 
	{
		label = "";
		errorLabel = null;
		name = "";
		value = "";
		attr = { };
		attr.label = { };
		rules = new Array<Rule>();
	}
	
	public function html() : String {
		var code = "<input ";
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
		attr.value = value;
		attr.name = name;
		code += Utils.generateAttributes(attr) + "/>";
		var error = getError();
		if (error.length > 0) {
			code += "<span class=\"formError\">" + error +"</span>";
		}
		return code;
	}
	
	public function print() : Void {
		Sys.print(html());
	}
	
	public function getError() : String {
		var errors : String = "";
		for (rule in rules) {
			if (rule.error)
				errors += "<span class=\"formErrorElement\">" + rule.message + "</span>";
		}
		return errors;
	}
	
}