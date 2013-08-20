package form;

/**
 * ...
 * @author Masadow
 */
class Utils
{

	public static function generateAttributes(attr : Dynamic) : String {
		var code = "";
		for (attribute in Reflect.fields(attr))
			code += (attribute == "clazz" ? "class" : attribute) + "='" + Reflect.field(attr, attribute) + "' ";
		return code;
	}
	
}