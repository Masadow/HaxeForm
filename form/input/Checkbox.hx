package form.input;

/**
 * ...
 * @author Masadow
 */
class Checkbox extends Input
{

	public function new() 
	{
		super();
	}

	override public function html():String 
	{
		attr.type = "checkbox";
		return super.html();
	}
}