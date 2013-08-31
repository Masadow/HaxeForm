package form.validation.rule;
import form.validation.Rule;

/**
 * ...
 * @author Masadow
 */
class isNumber implements Rule
{

	public function new() 
	{
		
	}

	public function apply(value : String) : Bool
	{
		return Std.parseInt(value) != null;
	}

}