package cpp;
// borrowed from hxvlc (jigsaw u da goat)
// https://github.com/MAJigsaw77/hxvlc/blob/3a8dbd26d097de3374b705951e1aa149d17c9d7d/source/cpp/StdVector.hx
@:include('vector')
@:native('std::vector')
@:nativeArrayAccess
@:unreflective
@:structAccess
extern class StdVector<T> implements ArrayAccess<Reference<T>>
{
	@:overload(function(size:Int):Void {})
	function new():Void;

	function at(index:Int):T;
	function front():T;
	function back():T;
	function data():RawPointer<T>;

	function empty():Bool;
	function size():Int;
	function capacity():Int;
	function reserve(newCapacity:Int):Void;

	function clear():Void;
	function push_back(value:T):Void;
	function pop_back():Void;
	function resize(newSize:Int):Void;
}