package ;

import form.Form;
import form.Group;
import form.input.Dropdown;
import form.input.Text;
import form.input.Textarea;
import form.validation.rule.Min;
import form.validation.rule.MinLength;
import form.MacroHelper;
import php.Lib;

/**
 * TODO:
	 * File input
	 * Rules:
		 * mail
		 * greater than (eq), lower than (eq), equals
		 * matches
		 * notempty
		 * date
		 * custom
	 * Textareas
	 * Select
 * @author Masadow
 */
class Main 
{

	static function main() 
	{
		var form : Form = new Form();

		//Test custom class
		Sys.print("<style>.red{color: red;}#blue{color: blue;}.green{color: green;}</style>");
		
		//This boolean will align labels and inputs
		form.content.setAlign(true, 250); //Second parameter corresponds to offset in pixel
//		form.action = "myaction"; // By default, it is the same as the current URL
		form.method = POST; //GET by default
		
		//Add some inputs to the form
		var textinput : Text = form.content.addTextInput("Enter a sentence beginning with 'Hello'", "hello", "Hello");
		textinput.errorLabel = "First";
		textinput.attr.clazz = "red"; //Note "clazz" instead of "class".
		textinput.rules.push(new CustomRule());

		textinput = new Text();
		textinput.attr.label.clazz = "green";
		textinput.label = "Do not leave it blank";
		textinput.name = "noblank";
		textinput.rules.push(new Min(1));
		form.content.addInput(textinput).attr.id = "blue";
		
		var radioGroup = new Group();
		radioGroup.isInline = true;
		radioGroup.addRadioInput("A", "radio[]", "A");
		radioGroup.addRadioInput("B", "radio[]", "B");
		radioGroup.addRadioInput("C", "radio[]", "C").attr.checked = true;
		radioGroup.addRadioInput("D", "radio[]", "D");
		form.content.addGroup(radioGroup);

		var cbGroup = new Group();
		cbGroup.tag = "fieldset";
		cbGroup.legend = "This is a legend";
		cbGroup.addCheckboxInput("Dog", "cb[]", "dog");
		cbGroup.addCheckboxInput("Cat", "cb[]", "cat").attr.checked = true;
		cbGroup.addCheckboxInput("Kitchen", "cb[]", "kitchen").attr.checked = true;
		cbGroup.addCheckboxInput("Bird", "cb[]", "bird");
		form.content.addGroup(cbGroup);
		
		var textarea = new Textarea();
		textarea.label = "Tell your story. No less than 50 characters";
		textarea.name = "story";
		textarea.errorLabel = "Story";
		textarea.rules.push(new MinLength(50));
		form.content.addInput(textarea);
		
		var dropdown = new Dropdown();
		dropdown.label = "Pick a color";
		dropdown.name = "color";
		dropdown.errorLabel = "Color";

		dropdown.addItem(new Item("Red", "red", "style='color:red'"));
		dropdown.addItem(new Item("Green", "green", "style='color:green'"));
		dropdown.addItem(new Item("Blue", "blue", "style='color:blue'"));
		
		form.content.addInput(dropdown);

		form.submitValue = "GO GO GO !";

		if (form.valid()) {
			trace("valid");
		}
		
		//Repopulate all fields after the form was submited
		//Don't do anything the first time
		form.repopulate();

		// Apply a CSS file to your form
		/* You have two possibilities using this method
			* If the second parameter is set to true (default), you have to give a valid css file path as first argument
			* If the second parameter is set to false, you have to pass a valid css string
		 */
		form.setTheme(MacroHelper.getFileContent("demo.css"), false);
		
		//Print the form. You can print each input yourself by calling Input.print() method
		form.print();
		
		//Debug purpose
		form.debug.show();
	}

}