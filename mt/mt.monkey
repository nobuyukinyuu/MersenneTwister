'Copyright 2014 Nobuyuki (nobu@subsoap.com).
'This module is licensed under The MIT License.
'For more information:  http://github.com/nobuyukinyuu/MersenneTwister/

'Notes:  
'  * FLASH DOESN'T COMPILE (Yet!)  All pull requests welcome.
'  * For our purposes, the canonical implementation of the Mersenne Twister is MersenneTwister.cpp.
'  * Correctness for HTML5 is not guaranteed.  You should be accurate to whole numbers for at least 
'    a few iterations.  Beyond that, who knows.  JS likes to decide its own float accuracy...
'  * Java and XNA are only single-precision accurate.  This is not a large amount :(
'    This may be fixed in a later update.....
'  * The functions utilize the 32-bit method to get a float. The period frequency for this sucks.
'    This should probably also be fixed in a later update.

Import "MersenneTwister.${LANG}"
Import mojo

Class MersenneTwister
	Global p:MTProto

	'Summary:  Seed using the default seed GetTime().
	Function Init:Void()
		#If LANG="cpp"
			Local s:= GetDate()
			init_by_array(s[0], s[1], s[2], s[3], s[4], s[5], s[6])
		#ElseIf LANG="js" 
			p = New MTProto()
			Local s:= GetDate()
			p.init_by_array(s, s.Length)
		#ElseIf LANG="java" Or LANG="cs"
			p = New MTProto()
			p.init_by_array(GetDate())
		#End
	End Function
	
	'Summary:  Seed using int32.
	Function Init:Void(seed:Int)
		#If LANG="cpp" 
			init_genrand(seed)
		#ElseIf LANG="js" Or LANG="java" Or LANG="as" Or LANG="cs"
			p = New MTProto()
			p.init_genrand(seed)
		#End
	End Function
		
	'Summary:  Returns a value from [0-1)
	Function Rnd:Float()
		#If LANG="cpp" 
			Return genrand_real2()
		#ElseIf LANG="js" Or LANG="java" Or LANG="as" Or LANG="cs"
			If p = Null Then p = New MTProto()
			Return p.random()
		#End
	End Function
	'Summary:  Returns a value from 0-range, exclusive.
	Function Rnd:Float(range:Float)
		#If LANG="cpp" 
			Return genrand_real2() * range
		#ElseIf LANG="js" Or LANG="java" Or LANG="as" Or LANG="cs"
			If p = Null Then p = New MTProto()
			Return p.random() * range
		#End
	End Function
	'Summary:  Returns a value from first (inclusive) to last (exclusive.)
	Function Rnd:Float(first:Float, last:Float)
		Return Rnd(last - first) + first
	End Function
End Class


Private Extern

#If LANG="cpp"
	Function init_genrand:Void(s:Int)
	Function init_by_array:Void(a, b, c, d, e, f, g) = "monkey_date_init"
	Function genrand_real2:Float()
	
#ElseIf LANG="js"
	Class MTProto = "MersenneTwister"
		Method init_genrand:Void(s:Int)
		Method init_by_array:Void(init_key:Int[], key_length:Int)
		Method random:Float()  'some assbutt renamed this from genrand_real2
	End Class
	
#ElseIf LANG="java"
	Class MTProto = "MersenneTwisterFast"
		Method init_genrand:Void(s:Int) = "setSeed"
		Method init_by_array:Void(init_key:Int[]) = "setSeed"
		Method random:Float() = "nextFloat"
	End Class

#ElseIf LANG="cs"
	Class MTProto = "MersenneTwister"
		Method init_genrand:Void(s:Int) = "MonkeyInit"
		Method init_by_array:Void(init_key:Int[]) = "MonkeyInit"
		Method random:Float() = "NextSingle"
		'Method random2:Float() = ""
	End Class
#ElseIf LANG="as"
	'Jerks didn't exactly expose the proper functions here...
	Class MTProto = "MersenneTwister"
		Method init_genrand:Void(s:Int)
		Method random:Float() = "genrand_real2"
	End Class	
#End 