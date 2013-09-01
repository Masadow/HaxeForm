package form.validation.rule;
import form.validation.Rule;

/**
 * ...
 * @author Masadow
 */
class Max implements Rule
{
	public var max : Int;
	public var error : Bool;
	public var message : String;

	public function new(x : Int)
	{
		max = x;
		error = false;
		message = "The field \"##\" should be below " + x;
	}
	
	public function apply(value : String) : Bool
	{
		return Std.parseInt(value) <= max;
	}

}