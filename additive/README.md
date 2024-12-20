# 加算合成 (Additive synthesis)

```superCollider
{ 
   var impulse1 = Impulse.ar(10);
   var impulse2 = Impulse.ar(9);
   var pulseCount = PulseCount.ar(trig: impulse1, reset: impulse2 );
   SinOsc.ar( pulseCount*900, 0, 0.5);
}.scope;
```
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/pulse/PulseCountSample.mp4" muted="false"></video></div>
