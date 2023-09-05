Shader "Custom/ClippingPlanesShader" {
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

    _ClipPlaneXPos ("Clip Plane X Pos", Vector) = (0,0,0,0)
    _ClipPlaneXNormal ("Clip Plane X Normal", Vector) = (1,0,0,0)
    _ClipPlaneYPos ("Clip Plane Y Pos", Vector) = (0,0,0,0)
    _ClipPlaneYNormal ("Clip Plane Y Normal", Vector) = (0,1,0,0)
    _ClipPlaneZPos ("Clip Plane Z Pos", Vector) = (0,0,0,0)
    _ClipPlaneZNormal ("Clip Plane Z Normal", Vector) = (0,0,1,0)
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

    float4 _ClipPlaneXPos;
    float4 _ClipPlaneXNormal;
    float4 _ClipPlaneYPos;
    float4 _ClipPlaneYNormal;
    float4 _ClipPlaneZPos;
    float4 _ClipPlaneZNormal;
    
    struct Input {
      float2 uv_MainTex;
      float2 uv_BumpMap;
      float2 uv_MetallicGlossMap;
      float2 uv_OcclusionMap;
      float2 uv_EmissionMap;
      float3 worldPos;
      float4 color : COLOR;
    };

    half _Metallic;
    half _AlphaCutoff;
    half _BumpScale;
    fixed4 _Color;
    fixed4 _EmissionColor;

    UNITY_INSTANCING_BUFFER_START(Props)
    UNITY_INSTANCING_BUFFER_END(Props)

    void surf (Input IN, inout SurfaceOutputStandard o) {
      fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
      o.Albedo = c.rgb * IN.color;
      clip(c.a - _AlphaCutoff);
      fixed4 m = tex2D (_MetallicGlossMap, IN.uv_MetallicGlossMap);
      o.Metallic = m.b * _Metallic;
      o.Smoothness = 0;
      o.Normal = UnpackScaleNormal (tex2D (_BumpMap, IN.uv_BumpMap), _BumpScale);
      o.Occlusion = tex2D (_OcclusionMap, IN.uv_OcclusionMap).r;
      o.Emission = tex2D (_EmissionMap, IN.uv_EmissionMap) * _EmissionColor;

      float4 worldPos = float4(IN.worldPos, 1.0);
      clip(dot(worldPos - _ClipPlaneXPos, _ClipPlaneXNormal));
      clip(dot(worldPos - _ClipPlaneYPos, _ClipPlaneYNormal));
      clip(dot(worldPos - _ClipPlaneZPos, _ClipPlaneZNormal));
    }
    ENDCG
  }
  FallBack "Diffuse"
}