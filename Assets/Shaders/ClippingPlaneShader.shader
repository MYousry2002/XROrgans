Shader "Custom/ClippingShader" {
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

        _ClipPlane ("Clip Plane", Vector) = (0,1,0,0)
    }
    SubShader {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        #pragma target 3.0

        #pragma multi_compile _ CLIP_PLANE_ON

        sampler2D _MainTex;
        sampler2D _MetallicGlossMap;
        sampler2D _BumpMap;
        sampler2D _OcclusionMap;
        sampler2D _EmissionMap;
        float4 _ClipPlane;

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

        #include "UnityCG.cginc"

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
            #if defined(CLIP_PLANE_ON)
                clip(dot(IN.worldPos, _ClipPlane.xyz) - _ClipPlane.w);
            #endif
        }
        ENDCG
    }
    FallBack "Standard"
}