Shader "Tutorial/Implement/Fade"
{
	Properties 
	{
		_Texture("Texture", 2D) = "white"{}
		_Transparency("_Transparency", Range(0.0,1.0)) = 0.5
	}
	SubShader 
	{
		
		Tags{ "RenderType"="Transparent" "Queue"="Transparent" }
		LOD 100

		Pass
		{	 
			Blend SrcAlpha OneMinusSrcAlpha
		
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			sampler2D _Texture;
			fixed _Transparency;
				
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
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
										
				return o;
			}
				
			fixed4 frag(v2f i) : SV_TARGET
			{
				fixed4 col = tex2D(_Texture, i.uv);
				col.a = _Transparency;

				return col;
			}
			
			ENDCG
		}
	} 
}