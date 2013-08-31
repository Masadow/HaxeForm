package form.validation.rule;
import form.validation.Rule;

/**
 * ...
 * @author Masadow
 */
class ExactLength implements Rule
{
	public var length : Int;
	
	public function new(x : Int)
	{
		length = x;
	}
	
	public function apply(value : String) : Bool
	{
		return value.length == max;
	}

}