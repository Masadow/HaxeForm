package form.validation.rule;
import form.validation.Rule;

/**
 * ...
 * @author Masadow
 */
class isNumber implements Rule
{
	public var error : Bool;
	public var message : String;

	public function new() 
	{
		error = false;
		message = "The field \"##\" should be a number";
	}

	public function apply(value : String) : Bool
	{
		return Std.parseInt(value) != null;
	}

}