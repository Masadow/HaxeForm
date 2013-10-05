package form.input;
import haxe.io.Output;
import haxe.io.StringInput;

/**
 * ...
 * @author Masadow
 */
class Dropdown extends Input
{
	private var items : List<Item>;

	public function new() 
	{
		super();
		items = new List<Item>();
	}
	
	public function addItem(item : Item) {
		items.add(item);
	}
	
	override public function html() : String {
		var code = "<select ";
		if (label != "") {
			var labelCode = "<label";
			if (attr.id != null || name != "") {
				if (attr.id == null)
					attr.id = name;
				labelCode += " for='" + attr.id + "'";
			}
			if (attr.label) {
				labelCode += Utils.generateAttributes(attr.label);
			}
			code = labelCode + ">" + label + "</label>" + code;
		}
		attr.name = name;
		code += Utils.generateAttributes(attr) + ">";
		for (item in items) {
			code += "<option value='" + item.value + "'" + (value == item.value ? " selected " : " ") + item.extra + ">" + item.label + "</option>";
		}
		code += "</select>";
		var error = getError();
		if (error.length > 0) {
			code += "<span class=\"formError\">" + error +"</span>";
		}
		return code;
	}
}

class Item {
	public var label : String;
	public var extra : String;
	public var value : String;
	
	public function new(label : String, value : String, extra : String = "") {
		this.label = label;
		this.extra = extra;
		this.value = value;
	}
}