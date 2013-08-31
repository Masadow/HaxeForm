package form.validation;

/**
 * ...
 * @author Masadow
 */
interface Rule
{
	public function apply(value : String) : Bool;
}