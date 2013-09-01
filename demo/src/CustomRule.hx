package ;
import form.validation.Rule;

/**
 * ...
 * @author Masadow
 */
class CustomRule implements Rule
{
	public var error : Bool;
	public var message : String;

	public function new() 
	{
		error = false;
		message = "The field \"##\" should starts with \"hello\"";
	}
	
	public function apply(value : String) : Bool
	{
		return StringTools.startsWith(value, "hello");
	}
	
}