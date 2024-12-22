# 減算合成 ( Subtractive Synthesis )

加算合成とは逆で、倍音を沢山含んだ信号の倍音をフィルタで削って、音量などの調整を行います。
例えば、弦楽器などでは、まずランダムな励振(excitation)を生成して、自然な共振周波数を持った楽器のボディを通して音をフィルタリング、整形します。人間の声も舌とか口の形で音を加工しているので、減算合成みたいなものです。

## LPF

```superCollider
{
    var out;
    out = LPF.ar(
        Saw.ar([800, 840] ),
        LFNoise0.kr(4, 800, 840)
    );
    Out.ar(0, out);
}.play;

```
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/subtractive/LPF_01.mp4" muted="false"></video></div>

### Saw
```superCollider
{
   Saw.ar([800, 840] );
}.play;
```
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/subtractive/LPF_02.mp4" muted="false"></video></div>

### LFNoise
```superCollider
{
   LFNoise0.ar(4, 800, 840);
}.play;
```
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/subtractive/LPF_03.mp4" muted="false"></video></div>


# Filter

[フィルター概説](./filter/)