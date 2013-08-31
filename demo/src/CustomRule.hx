package ;
import form.validation.Rule;

/**
 * ...
 * @author Masadow
 */
class CustomRule implements Rule
{

	public function new() 
	{
		
	}
	
	public function apply(value : String) : Bool
	{
		return StringTools.startsWith(value, "hello");
	}
	
}