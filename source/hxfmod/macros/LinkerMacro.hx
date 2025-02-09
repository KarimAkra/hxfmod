package hxfmod.macros;

import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.xml.Printer;
import sys.FileSystem;

using haxe.io.Path;

/**
 * This class provides a macro to include an XML build file in the metadata of a Haxe class.
 * The file must be located relative to the directory of the Haxe class that uses this macro.
 * 
 * originally written by @MAJigsaw77
 */
class LinkerMacro
{
	public static macro function build(header:String, ?native:String, unreflective:Bool = true, structAccess:Bool = false):Array<Field>
	{
		final pos:Position = Context.currentPos();
		final fileToInclude:String = Path.join([LibMacro.getHXFmodDir(), "project/Build.xml"]);

		final includeElement:Xml = Xml.createElement('include');
		includeElement.set('name', fileToInclude);
		Context.getLocalClass().get().meta.add(':buildXml', [{expr: EConst(CString(Printer.print(includeElement, true))), pos: pos}], pos);

		Context.getLocalClass().get().meta.add(':include', [{expr: EConst(CString(header)), pos: pos}], pos);

		if (unreflective)
		{
			Context.getLocalClass().get().meta.add(':unreflective', [], pos);
		}

		if (structAccess)
		{
			Context.getLocalClass().get().meta.add(':structAccess', [], pos);
		}

		if (native != null)
		{
			Context.getLocalClass().get().meta.add(':native', [{expr: EConst(CString(native)), pos: pos}], pos);
		}

		return Context.getBuildFields();
	}
}
