# superColliderMovies

## Extensions

### MoogVCF：CodeSample
※ 参照先：https://note.com/sc3/n/n1f85934c5444

マウスカーソルの位置を動かすとMoogVCFパラメータが変化する。

```superCollider
(
~rvb = Bus.audio(s, 2);
SynthDef(\fvrb, {
	var eff, src;
	src = In.ar(~rvb, 2);
	eff = FreeVerb2.ar(src[0], src[1], 1.0, 2);
	eff = LPF.ar(eff, 3000);
	Out.ar(0, eff);
}).add;

~dly = Bus.audio(s, 2);
SynthDef(\apdly, {
	var eff_l, eff_r, eff, src;
	src = In.ar(~dly, 2);
	eff_l = AllpassN.ar(src, 1.0, 1/5*2, 3);
	eff_r = AllpassN.ar(src, 1.0, 1/5*3, 3);
	// eff = LPF.ar(eff, 3000);
	Out.ar(0, [eff_l, eff_r]);
}).add;
)

(
SynthDef(\demand, {
	arg freq=220, gate=1;
	var trg, sig, amp= -9.dbamp, env, cycl=5, wet=0.15, dly=0.15;
	env = EnvGen.kr(Env.asr(0.01, 1.0, 0.01), gate, doneAction:2);
	trg = LFPulse.kr(cycl);
	freq = Demand.kr(trg, 0, Dseq([48, 36, 55, 62, 55, 48, 46, 55].midicps, inf));
	sig = Mix(Saw.ar([freq, freq+0.5, freq-0.5]));//* SinOsc.ar(freq*2);
	sig = Trig1.kr(trg, cycl.reciprocal*0.99) * sig;
	sig = MoogVCF.ar(sig, MouseY.kr(20, 4000), MouseX.kr(0, 0.85)).clip(-0.3, 0.3);
	Out.ar(~dly, sig * env * amp!2 * dly);
	Out.ar(~rvb, sig * env * amp!2 * wet);
	Out.ar(0   , sig * env * amp!2 * (1-wet));
}).add;
)

(
SynthDef(\bass, {
	arg freq=220, gate=1;
	var sig, amp= -6.dbamp, env;
	env = EnvGen.kr(Env.adsr(0.3, 2.0, 0.2, 0.1), gate, doneAction:2);
	sig = Pulse.ar(freq);
	sig = MoogVCF.ar(sig, freq*4, 0.1);
	// Out.ar(~rvb, sig * env * amp!2 * 0);
	Out.ar(0   , sig * env * amp!2 * 0.5);
}).add;
)

(
~cycl = 1/5;
~seq = Pbind(
	\instrument, \demand,
	\dur, ~cycl*8,
	\sustain, ~cycl*8);
~seq2 = Pbind(
	\instrument, \bass,
	\midinote, Pseq([43, 46, 39], inf),
	\dur, Pseq(~cycl*[14, 8, 10], inf),
	\sustain, Pseq(~cycl*[14, 8, 10], inf));

~pp = Ppar([Pfx(~seq, \fvrb), Pfx(~seq, \apdly), Pfx(~seq2, \fvrb)]).play(TempoClock(1));
)
```
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/extensions/CodeSample_01.mp4" muted="false"></video></div>
