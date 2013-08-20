package form.input;

/**
 * ...
 * @author Masadow
 */
class Radio extends Input
{

	public function new() 
	{
		super();
	}

	override public function html():String 
	{
		attr.type = "radio";
		return super.html();
	}
}