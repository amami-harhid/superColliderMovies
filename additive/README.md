# 加算合成 (Additive synthesis)

## Mix

音を混ぜます。

音Aと音Bを混ぜるとき、音量が Aの音量 + Bの音量となりますので、合成後の音量が大きくなりすぎないように注意しましょう。


## Mixの例その１

```superCollider
{
   var a = SinOsc.ar(freq:440, phase:0, mul:0.5, add:0.0);
   var b = LFTri.ar(freq:220, iphase: 0.5, mul: 1.0, add: 0.0);
   a + b;
}.play;
```

## Mixの例その２
```superCollider
{
   var a = SinOsc.ar(freq:440, phase:0.0, mul:0.5, add:0.0);
   var b = SinOsc.ar(freq:220, phase:0.5, mul:1.0, add:0.0);
   Mix([a,b]);
}.play;
```


### ランダムに生成した音を重ねる（ rrand ）

ランダムに生成した音を重ねるときは  Mix.fill(n, function)を使う。

- n : 配列の数
- function : {  }で囲んだ音の集まり

```superCollider
{
   var n = 12;
   Mix.fill(n, {
      SinOsc.ar(
         freq:[rrand(40,2000), rrand(40,2000)],
         phase:0,
         mul:n.reciprocal * 0.75,
         add:0
      )
   });
}.play;
```
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/additive/CodeSample_01.mp4" muted="false"></video></div>

## 補足解説

- rrand(a, b) : a と b の間のランダムな値 
- SimpleNumber.reciprocal : 逆数です。 12.reciprocal ==> 1/12


# pulseCount

```superCollider
{ 
   var impulse1 = Impulse.ar(10);
   var impulse2 = Impulse.ar(9);
   var pulseCount = PulseCount.ar(trig: impulse1, reset: impulse2 );
   SinOsc.ar( pulseCount*900, 0, 0.5);
}.scope;
```
