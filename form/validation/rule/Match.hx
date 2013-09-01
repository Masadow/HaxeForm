package form.validation.rule;
import form.validation.Rule;

/**
 * ...
 * @author Masadow
 */
class Match implements Rule
{
	
	public var reg : EReg;
	public var error : Bool;
	public var message : String;

	public function new(reg : EReg) 
	{
		this.reg = reg;
		error = false;
		message = "The field \"##\" should respect the format " + reg;
	}
	
	public function apply(value : String) : Bool
	{
		return reg.match(value);
	}
	
}