Shader "Tutorial/Outline"
{
    Properties
    {
		_Texture("Texture", 2D) = "white"{}
		_Outline("Scale", Range(0,0.025)) = 0.01
    	_OutlineColor ("Outline Color", Color) = (0,0,1,1)
	}
    SubShader
    {
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
        {
            Cull Front

			CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

			fixed _Outline;
			fixed4 _OutlineColor;

			struct appdata
			{
				fixed4 vertex : POSITION;
				fixed4 normal : NORMAL;
			};

			struct v2f
            {
                fixed4 vertex : SV_POSITION;
            };

            v2f vert (appdata v) 
            {
                v2f o;
				v.vertex.xyz += v.normal * _Outline;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
                return o;
            }
            
            fixed4 frag (v2f i) : SV_Target
            {
                return _OutlineColor;
            }
            ENDCG
		}

        Pass
        {			
			CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

			sampler2D _Texture;
			
			struct appdata
			{
				fixed4 vertex : POSITION;
				fixed2 uv : TEXCOORD0;
			};

            struct v2f
            {
                fixed2 uv : TEXCOORD0;
                fixed4 vertex : SV_POSITION;
            };


            v2f vert (appdata v)
            {
                v2f o;
				o.uv = v.uv;				
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