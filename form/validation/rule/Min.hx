package form.validation.rule;
import form.validation.Rule;

/**
 * ...
 * @author Masadow
 */
class Min implements Rule
{
	public var min : Int;
	public var error : Bool;
	public var message : String;
	
	public function new(x : Int)
	{
		min = x;
		error = false;
		message = "The field \"##\" should be over " + x;
	}
	
	public function apply(value : String) : Bool
	{
		return Std.parseInt(value) >= min;
	}

}