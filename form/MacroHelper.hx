package form;

import haxe.macro.Expr;
import sys.io.File;

/**
 * ...
 * @author Masadow
 */
class MacroHelper
{

	macro public static function getFileContent(filename : String) : Expr {
		return macro $v{File.getContent(filename)};
	}
	
}