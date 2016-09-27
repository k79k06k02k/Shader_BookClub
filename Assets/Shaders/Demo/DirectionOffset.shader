Shader "Tutorial/DirectionOffset"
{
	Properties
	{
		_Texture("Texture", 2D) = "white"{}
		_Scale("Scale", Range(0,0.025)) = 0.0125
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			sampler2D _Texture;
			fixed _Scale;

			struct appdata
			{
				fixed4 vertex : POSITION;
				fixed4 normal : NORMAL;
				fixed2 uv : TEXCOORD0;
			};

			struct v2f
			{
				fixed4 vertex : SV_POSITION;
				fixed2 uv : TEXCOORD0;
			};
		
			v2f vert (appdata v)
			{
				v2f o;
				o.uv = v.uv;

				v.vertex.xyz += v.normal * _Scale;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				return tex2D(_Texture, i.uv);
			}
			ENDCG
		}
	}
}