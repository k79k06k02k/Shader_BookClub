Shader "Polycount/VertexTransparencyShader" {
	Properties {
		VertexColorMultiplier("VertexColorMultiplier",Range(0.0,1.0))=1.0
		Transparency("Transparency",Range(0.0,1.0))=1.0
	}
	SubShader {
		
		Tags{ "Queue"="Transparent" }
		
		
		Pass
		{	
			Blend SrcAlpha OneMinusSrcAlpha
		
			CGPROGRAM
			
				#pragma vertex vert
				#pragma fragment frag

				fixed VertexColorMultiplier;
				fixed Transparency;
				
				struct v2f
				{
					fixed4 rasterSpacePos : POSITION ;
					
					fixed4 vertexColor : COLOR;
				
				};
				
				v2f vert( fixed4 vertPos : POSITION , fixed4 vertColor: COLOR )
				{
					v2f output;
					
					output.rasterSpacePos = mul( UNITY_MATRIX_MVP , vertPos );
					
					output.vertexColor = vertColor ;
					
					return output;
					
				}
				
				fixed4 frag( v2f input ) : SV_TARGET
				{
				
					return fixed4( input.vertexColor.rgb*VertexColorMultiplier ,Transparency );
				
				}
			
			ENDCG
		}
	} 
}
