package form.validation.rule;
import form.validation.Rule;

/**
 * ...
 * @author Masadow
 */
class Max implements Rule
{
	public var max : Int;
	
	public function new(x : Int)
	{
		max = x;
	}
	
	public function apply(value : String) : Bool
	{
		return Std.parseInt(value) <= max;
	}

}