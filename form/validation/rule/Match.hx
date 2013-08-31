package form.validation.rule;
import form.validation.Rule;

/**
 * ...
 * @author Masadow
 */
class Match implements Rule
{
	
	public var reg : EReg;

	public function new(reg : EReg) 
	{
		this.reg = reg;
	}
	
	public function apply(value : String) : Bool
	{
		return reg.match(value);
	}
	
}