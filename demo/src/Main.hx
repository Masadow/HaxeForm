package ;

import form.Form;
import form.input.Text;
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
		
		//Test custom class
		Sys.print("<style>.red{color: red;}#blue{color: blue;}</style>");
		
		//This boolean will align labels and inputs
		form.aligned = true;
		form.alignedWidth = 250; //150 px default
//		form.action = "myaction"; // By default, it is the same as the current URL
		form.method = POST; //GET by default
		
		//Add some inputs to the form
		var textinput : Text = form.addTextInput("Enter a sentence beginning with 'Hello'", "hello", "Hello");
		textinput.attr.clazz = "red"; //Note "clazz" instead of "class".

		textinput = new Text();
		textinput.label = "Do not leave it blank";
		textinput.name = "noblank";
		form.addInput(textinput).attr.id = "blue";
		
		form.addRadioInput("A", "radio[]", "A");
		form.addRadioInput("B", "radio[]", "B");
		form.addRadioInput("C (FALSE)", "radio[]", "C").attr.checked = true;
		form.addRadioInput("D", "radio[]", "D");

		form.addCheckboxInput("Dog", "cb[]", "dog");
		form.addCheckboxInput("Cat", "cb[]", "cat").attr.checked = true;
		form.addCheckboxInput("Kitchen", "cb[]", "kitchen").attr.checked = true;
		form.addCheckboxInput("Bird", "cb[]", "bird");

		form.submitValue = "GO GO GO !";
		
		//Print the form. You can print each input yourself by calling Input.print() method
		form.print();
	}

}