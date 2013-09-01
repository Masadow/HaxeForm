package form.validation.rule;
import form.validation.Rule;

/**
 * ...
 * @author Masadow
 */
class MaxLength implements Rule
{
	public var max : Int;
	public var error : Bool;
	public var message : String;

	public function new(x : Int)
	{
		error = false;
		message = "The field \"##\" should length more than " + x + " characters";
		max = x;
	}
	
	public function apply(value : String) : Bool
	{
		return value.length <= max;
	}

}