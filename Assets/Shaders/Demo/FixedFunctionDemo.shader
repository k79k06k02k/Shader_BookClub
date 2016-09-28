Shader "Tutorial/Demo/FixedFunctionDemo" 
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,1)
		_MainTex("Base (RGB)", 2D) = "white" { }
	}

	SubShader
	{
		Pass
		{
			Lighting On

			SetTexture[_MainTex]
			{
				constantColor[_Color]
				combine texture * constant
			}
		}
	}

	FallBack "Diffuse"
}