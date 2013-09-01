package form.validation.rule;
import form.validation.Rule;

/**
 * ...
 * @author Masadow
 */
class ExactLength implements Rule
{
	public var length : Int;
	public var error : Bool;
	public var message : String;
	
	public function new(x : Int)
	{
		error = false;
		message = "The field \"##\" should length " + x + " characters";
		length = x;
	}
	
	public function apply(value : String) : Bool
	{
		return value.length == max;
	}

}