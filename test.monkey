#ANDROID_APP_LABEL="MT_Test"
#ANDROID_APP_PACKAGE="com.test.mt"

Import mojo
Import mt.mt

Global num:Float[11]  'numbers


Function Main:Int()
	MersenneTwister.Init(12345)
	For Local i:Int = 0 To 10
		num[i] = MersenneTwister.Rnd()
		Print num[i]
	Next	

	New Game()
End Function

Class Game Extends App
	
	Method OnCreate()
		SetUpdateRate 30
	End Method
	
	Method OnUpdate()
		If KeyHit(KEY_ESCAPE) Then Error("")
		If KeyHit(KEY_SPACE) or TouchHit(0) Then ReInit()
	End Method
	
	Method OnRender()
		Cls()
		DrawCircle(DeviceWidth() -32, Rnd(64), 32)

		Scale(2,2)
		For Local i:Int = 0 To 10
			DrawText(num[i], 4, i * 20)
		Next
	End Method

	Method ReInit:Void()
		MersenneTwister.Init()  'Sets seed to Now
		
		For Local i:Int = 0 To 10
			'num[i] = MersenneTwister.Rnd(9999999)
			num[i] = MersenneTwister.Rnd()
		Next	
	End Method
End Class