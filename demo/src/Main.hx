package ;

import form.Form;
import php.Lib;

/**
 * ...
 * @author Masadow
 */

class Main 
{

	static function main() 
	{
		var form : Form = new Form();
		
		//This boolean will align labels and inputs
		form.aligned = true;
		form.alignedWidth = 250; //150 px default
		
		//Add some inputs to the form
		form.addTextInput("Enter a sentence beginning with 'Hello'", "hello", "Hello");
		form.addTextInput("Do not leave it blank", "noblank");
		
		//Print the form. You can print each input yourself by calling Input.print() method
		form.print();
	}

}