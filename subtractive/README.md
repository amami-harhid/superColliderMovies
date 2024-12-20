# 減算合成 ( Subtractive Synthesis )

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
