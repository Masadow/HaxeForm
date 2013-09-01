package form.validation.rule;
import form.validation.Rule;

/**
 * ...
 * @author Masadow
 */
class MinLength implements Rule
{
	public var min : Int;
	public var error : Bool;
	public var message : String;

	public function new(x : Int)
	{
		min = x;
		error = false;
		message = "The field \"##\" should length more than " + x + " characters";
	}
	
	public function apply(value : String) : Bool
	{
		return value.length >= min;
	}

}