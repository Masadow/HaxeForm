package form.input;
import haxe.io.Output;
import haxe.io.StringInput;

/**
 * ...
 * @author Masadow
 */
class Text extends Input
{

	public function new() 
	{
		super();
	}
	
	override public function html():String 
	{
		attr.type = "text";
		return super.html();
	}

}