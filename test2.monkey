#ANDROID_APP_LABEL="MT_Test2"
#ANDROID_APP_PACKAGE="com.test.mt.2"

Import mojo
Import mt.mt

Function Main:Int()
	New Game()
End Function

Class Game Extends App
	Global num:Int[1200]  'MTRnd numbers
	Global num2:Int[1200]  'Rnd numbers
	
	Global lo1 = 100000, lo2 = 100000, hi1, hi2
	Global time1, time2
	
	Method OnCreate()
		SetUpdateRate 30
		ReInit()
	End Method
	
	Method OnUpdate()
		If KeyHit(KEY_ESCAPE) Then Error("")
		If KeyHit(KEY_SPACE) or TouchHit(0) Then ReInit()
	End Method
	
	Method OnRender()
		Cls()

		
		For Local i:Int = 0 Until 1200

			SetAlpha(0.6)
			SetColor(0, 0, 255)
			DrawLine(i * 0.5 + 20, 8, i * 0.5 + 20, 8 + 2.0 * (num[i] - lo1))
			
			SetColor(255, 0, 0)
			DrawLine(i * 0.5 + 20, 120, i * 0.5 + 20, 120 + 2.0 * (num2[i] - lo2))

			
			SetAlpha(0.3)
			SetColor(0, 255, 255)
			DrawLine(i * 0.5 + 20, 480, i * 0.5 + 20, 480 - 5.0 * (num[i] - lo1))
			
			SetColor(255, 0, 0)
			DrawLine(i * 0.5 + 20, 480, i * 0.5 + 20, 480 - 5.0 * (num2[i] - lo2))
			
			SetAlpha(1)
			
		Next
		
		SetColor(255, 255, 255)
		SetAlpha(0.5)
		DrawText("MT  GenTime:  " + time1 + "ms", 8, 8)
		DrawText("Rnd GenTime:  " + time2 + "ms", 8, 120)
		
		DrawText("Mins:MT " + lo1 + " Rnd " + lo2, 8, 480,, 1)
		DrawText("Maxs:MT " + hi1 + " Rnd " + hi2, 8, 468,, 1)
		SetAlpha(1)
	End Method

	Method ReInit:Void()
		MersenneTwister.Init()  'Sets seed to Now
		Local s:= GetDate()
		Seed = s[6] + (s[5] * 60) + (s[4] * 360)
		
		num = New Int[1200]
		num2 = New Int[1200]
		
		Local ms = Millisecs()
		For Local i:Int = 0 To 50000
			num[MersenneTwister.Rnd(1200)] += 1
		Next
		time1 = Millisecs() -ms

		ms = Millisecs()
		For Local i:Int = 0 To 50000
			num2[Rnd(1200)] += 1
		Next
		time2 = Millisecs() -ms
		
		For Local i:Int = 0 Until 600
			lo1 = Min(num[i], lo1)
			lo2 = Min(num2[i], lo1)
			hi1 = Max(num[i], lo1)
			hi2 = Max(num2[i], lo1)
		Next
	End Method
End Class