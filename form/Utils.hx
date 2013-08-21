package form;

import form.input.Input;

/**
 * ...
 * @author Masadow
 */
class Utils
{

	public static function generateAttributes(attr : Dynamic) : String {
		var code = "";
		for (attribute in Reflect.fields(attr)) {
			if (attribute != "label") //Reserved attribute to parameterize labels
				code += (attribute == "clazz" ? "class" : attribute) + "='" + Reflect.field(attr, attribute) + "' ";
		}
		return code;
	}

	public static function initInput(input : Input, label : String, name : String, value : Null<String>) : Input {
		input.label = label;
		input.name = name;
		if (value != null) {
			input.value = value;
		}
		return input;
	}

}