package form.validation.rule;
import form.validation.Rule;

/**
 * ...
 * @author Masadow
 */
class Min implements Rule
{
	public var min : Int;
	
	public function new(x : Int)
	{
		min = x;
	}
	
	public function apply(value : String) : Bool
	{
		return Std.parseInt(value) >= min;
	}

}