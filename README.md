# HaxeForm Library for Haxe users #

----------

**Haxeform** is a tool designed for **web** environment under **Haxe**. It is actually developed for **PHP** target but ***will*** be compatible with **Neko** target.

The goal of this library is to help the developer to create all forms in his website. **HaxeForm** is not only designed for HTML rendering, but also designed for form validation. You simply have to set all your rules for each of your forms and **HaxeForm** will do the rest. It will also, *if you want*, repopulate your forms in case of any user mistake.

## How to install ? ##

> Note: The project is not released yet. That's why installation is painfull.

To install properly HaxeForm, just follow this step by step tutorial

* Clone the current git repository **OR** download it as a ZIP file and decompress it
* Copy the entire ***form*** folder inside your project folder
* Add the recently moved folder to the classpath during compilation

You're done here.

## How to setup ? ##

> Note: This part will be usefull when the library will be released under haxelib

## How to display a form ##

First of all, you will have to instanciate a Form object.

    var form : Form = new Form();
	// From now, you can set some attribute to your form
	// Below are the default values of each attributes
	form.upload = false; // Form upload or not
	form.method = GET; // Can also be POST
	form.action = Request.getURI(); // Please note that the default action is the actual page

You may use `form.attr` to set some other attribute on the form tag. You may want to add a custom `class` or `id` to your form for example.

	form.attr.id = "main-form";
	form.attr.clazz = "red yellow"; //Note that since class is a language keyword, you have to use clazz instead

> Note: You always have to instanciate a Form object, even if you're going to render the form yourself

Now, you simply have to attach your fields to your form. Here is the list of supported fields

	* Checkbox
	* Radio
	* Text

Here is an example of how to create a field and then, attach it to your form

		textinput = new Text(); //Instanciate your field
		textinput.attr.label.clazz = "green"; //Set some attributes
		textinput.label = "Do not leave it blank"; //You can specify the title of your field
		textinput.name = "noblank"; // Field name attribute
		form.content.addInput(textinput).attr.id = "blue"; //Attach your field to the form

Let's explain the last line step by step. First of all, we're accessing `form.content`. It is the main container of your form. It is typed as a `Group` object which I'll explain later. `Group` object can either contain `Input` object or other `Group` object.

Since `addInput` method returns the object freshly added, you can still chain some call. In the example, we're just adding an id to the field.

After adding some other fields, you may want to show them up. To do so, simply call `form.print();` right after adding all your fields.


----------

Last edition 05/10/2013 00:54:24  