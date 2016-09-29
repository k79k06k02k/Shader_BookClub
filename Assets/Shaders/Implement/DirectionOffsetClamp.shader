Shader "Tutorial/Implement/DirectionOffsetClamp"
{
	Properties
	{
		_Texture("Texture", 2D) = "white"{}
		_Color("Color", Color) = (1,1,1,1)
		_Pos("Pos", Range(-1, 1)) = 0.1
		_Range("Range", Range(0, 2)) = 0.2
		_Scale("Scale", Range(0,0.05)) = 0.02
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

			sampler2D _Texture;
			fixed4 _Color;
			fixed _Pos;
			fixed _Range;
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
				fixed4 color : COLOR;
			};
		
			v2f vert (appdata v)
			{
				v2f o;
				o.uv = v.uv;

				if(v.vertex.z <= _Pos && v.vertex.z >= _Pos - _Range)
				{
					o.color = _Color;
					v.vertex.xyz += v.normal * _Scale;
				}
				else
				{
					o.color = fixed4(1,1,1,1);
				}

				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);

				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{			
				return tex2D(_Texture, i.uv) * i.color;
			}
			ENDCG
		}
	}
}