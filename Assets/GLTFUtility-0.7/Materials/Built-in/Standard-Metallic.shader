Shader "GLTFUtility/Standard (Metallic)" {
  Properties {
    _Color ("Color", Color) = (1,1,1,1)
    _MainTex ("Albedo (RGB)", 2D) = "white" {}
    _MetallicGlossMap ("Metallic (B) Gloss (G)", 2D) = "white" {}
    _Metallic ("Metallic", Range(0,1)) = 1
    [Normal] _BumpMap ("Normal", 2D) = "bump" {}
    _BumpScale("NormalScale", Float) = 1.0
    _OcclusionMap ("Occlusion (R)", 2D) = "white" {}
    _EmissionMap ("Emission", 2D) = "black" {}
    _EmissionColor ("Emission Color", Color) = (0,0,0,0)
    _AlphaCutoff ("Alpha Cutoff", Range(0,1)) = 0
  }
  SubShader {
    Tags { "RenderType"="opaque" }
    LOD 200

    CGPROGRAM
    // Physically based Standard lighting model, and enable shadows on all light types
    #pragma surface surf Standard fullforwardshadows
    // Use shader model 3.0 target, to get nicer looking lighting
    #pragma target 3.0

    sampler2D _MainTex;
    sampler2D _MetallicGlossMap;
    sampler2D _BumpMap;
    sampler2D _OcclusionMap;
    sampler2D _EmissionMap;
    
    struct Input {
      float2 uv_MainTex;
      float2 uv_BumpMap;
      float2 uv_MetallicGlossMap;
      float2 uv_OcclusionMap;
      float2 uv_EmissionMap;
      float4 color : COLOR;
    };

    half _Metallic;
    half _AlphaCutoff;
    half _BumpScale;
    fixed4 _Color;
    fixed4 _EmissionColor;

    // #pragma instancing_options assumeuniformscaling
    UNITY_INSTANCING_BUFFER_START(Props)
    // put more per-instance properties here
    UNITY_INSTANCING_BUFFER_END(Props)

    void surf (Input IN, inout SurfaceOutputStandard o) {
      // Albedo comes from a texture tinted by color
      fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
      o.Albedo = c.rgb * IN.color;
      clip(c.a - _AlphaCutoff);
      // Metallic comes from blue channel tinted by slider variables
      fixed4 m = tex2D (_MetallicGlossMap, IN.uv_MetallicGlossMap);
      o.Metallic = m.b * _Metallic;
      // Smoothness comes from blue channel tinted by slider variables
      o.Smoothness = 0; // Set Smoothness to 0, which sets Roughness to 1.
      // Normal comes from a bump map
      o.Normal = UnpackScaleNormal (tex2D (_BumpMap, IN.uv_BumpMap), _BumpScale);
      // Ambient Occlusion comes from red channel
      o.Occlusion = tex2D (_OcclusionMap, IN.uv_OcclusionMap).r;
      // Emission comes from a texture tinted by color
      o.Emission = tex2D (_EmissionMap, IN.uv_EmissionMap) * _EmissionColor;
    }
    ENDCG
  }
  FallBack "Diffuse"
}