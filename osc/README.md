
https://kensukeinage.com/synth_osc/

# オシレーター(Oscillator:発振器)

## パラメーターの種類
### 周波数（Frequency）
周波数とは「音の高さ（音程）」に関わる要素です。
単位はおなじみ「Ｈｚ（ヘルツ）」です。
１秒間に４４０回の周期で繰り返す波形は４４０Ｈｚと表します。（実音でＡ４の音）
### 振幅（Amplitude）
振幅は、「音の大きさ（音量）」に関わる要素です。
単位はこちらもおなじみ「ｄＢ（デシベル）」で表します。
### 位相（Phase）
位相は、「波形のスタート位置」を決定する要素です。単位は「度（＝角度）」で表します。
～ 位相０度（正相）と１８０度（逆相）

## オシレーターの種類
オシレータの種類を覚える上で最も重要なのは、音に含まれる倍音成分です。
### サイン波（Sine Wave）
基音以外の倍音成分を一切含まない、音色は丸くてなめらかで、非常にシンプルな音になります。
```superCollider
var osc = {
	var f = 440;
	SinOsc.ar(feq:f, phase:0, mul:1, add:0);	
};
osc.play;
```
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/osc/sinOsc_01.mp4" muted="false"></video></div>

### ノコギリ波（Sawtooth Wave）
のこぎりの歯のような波形であり、すべての整数倍音を豊富に含みます。明るく力強い音になります。

```superCollider
var osc = {
	var f = 440;
	Saw.ar(feq:f, mul:1, add:0);	
};
osc.play;
```
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/osc/saw_01.mp4" muted="false"></video></div>


### パルス波（Pulse Wave）
四角い形をした波形です。
パルス幅（pulse width)と呼ばれる周期の幅を変更することで、含まれる倍音成分が変化する特徴があります。
```superCollider
var osc = {
	var f = 440;
    var w = 0.8;
	Pulse.ar(freq: f, width: w, mul: 1.0, add: 0.0);	
};
osc.play;
```
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/osc/pulse_01.mp4" muted="false"></video></div>

### 矩形波（Square Wave）
矩形波はパルス波の一種であり、パルス幅が５０％（左右対称のもの）のものが矩形波で、奇数倍音しか含みません。奇数倍音のみを豊富に含みます。機械的なピコピコ音です。

```superCollider
var osc = {
	var f = 440;
	var w = 0.5;
	Pulse.ar(freq: f, width: w, mul: 1.0, add: 0.0);	
};
osc.play;
```
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/osc/square_01.mp4" muted="false"></video></div>

### 三角波（Triangle Wave）
周波数特性は矩形波と同じく奇数倍音のみを含む波形です。
矩形波と異なる点は、倍音の音量であり、高い倍音ほど弱いので サイン波に近い柔らかい音色です。

```superCollider
var osc = {
	var f = 440;
    var w = 1;
	LFTri.ar(freq: f, iphase: 0.0, mul: 1.0, add: 0.0)	
};
osc.play;
```
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/osc/triangle_01.mp4" muted="false"></video></div>

### インパルス( Impulse )
```superCollider
var osc = {
	var f = 440;
	Impulse.ar(freq: f, phase: 0.0, mul: 1.0, add: 0.0);
};
osc.play;
```
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/osc/impulse_01.mp4" muted="false"></video></div>

### プラック( Pluck )
```superCollider
var osc = {
	Pluck.ar(in: WhiteNoise.ar(0.1), trig:Impulse.kr(2), maxdelaytime:440.reciprocal, delaytime:440.reciprocal, decaytime:10, coef:0.0);
};
osc.play;
```
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/osc/pluck_01.mp4" muted="false"></video></div>


### ノイズ(Noise)
ノイズは、音響学的には「周波数」「振幅」「位相」が完全にランダムな波形のことを指します。
スネアドラム等の打楽器や、効果音の生成には欠かすことのできない存在です。

#### ホワイトノイズ( WhiteNoise )
```superCollider
var osc = {
	WhiteNoise.ar(mul: 1.0, add: 0.0);
};
osc.play;
```
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/osc/whiteNoise_01.mp4" muted="false"></video></div>

#### デマンドホワイト( Dwhite )
```superCollider
var osc = {
	var a = Dwhite(lo:0, hi:15, length:inf);
	var f = 440;
	var trig = Impulse.kr( f / 10 );
	var f2 = Demand.kr(trig, 0, a) * 30 + 340;
	SinOsc.ar(f2) * 0.1
};
osc.play;
```
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/osc/Dwhite_01.mp4" muted="false"></video></div>

#### デマンドブラウン( Dbrown )
```superCollider
var osc = {
	var a = Dbrown(lo:0, hi:15, step:0.01, length:inf);
	var f = 440;
	var trig = Impulse.kr( f / 10 );
	var f2 = Demand.kr(trig, 0, a) * 30 + 340;
	SinOsc.ar(f2) * 0.1
};
osc.play;
```
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/osc/Dbrown_01.mp4" muted="false"></video></div>


#### ブラウンノイズ( BrownNoise )

```superCollider
var osc = {
	BrownNoise.ar(mul: 1.0, add: 0.0);
};
osc.play;
```
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/osc/brownNoise_01.mp4" muted="false"></video></div>


#### ピンクノイズ( PinkNoise )
```superCollider
var osc = {
	PinkNoise.ar(mul: 1.0, add: 0.0);
};
osc.play;
```
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/osc/pinkNoise_01.mp4" muted="false"></video></div>


#### LFノイズ0 ( LFNoise0 )
```superCollider
var osc = {
	var f = 440.0;
	LFNoise0.ar(freq: f, mul: 1.0, add: 0.0)
};
osc.play;
```
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/osc/LFNoise0_01.mp4" muted="false"></video></div>

#### LFノイズ1 ( LFNoise1 )
```superCollider
var osc = {
	var f = 440.0;
	LFNoise1.ar(freq: f, mul: 1.0, add: 0.0)
};
osc.play;
```
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/osc/LFNoise1_01.mp4" muted="false"></video></div>

#### LFノイズ2 ( LFNoise2 )
```superCollider
var osc = {
	var f = 440.0;
	LFNoise2.ar(freq: f, mul: 1.0, add: 0.0)
};
osc.play;
```
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/osc/LFNoise2_01.mp4" muted="false"></video></div>


#### LDFノイズ0 ( LFDNoise0 )
```superCollider
var osc = {
	var f = 440.0;
	LFDNoise0.ar(freq: f, mul: 1.0, add: 0.0)
};
osc.play;
```
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/osc/LFDNoise0_01.mp4" muted="false"></video></div>

#### LFDノイズ1 ( LFDNoise1 )
```superCollider
var osc = {
	var f = 440.0;
	LFDNoise1.ar(freq: f, mul: 1.0, add: 0.0)
};
osc.play;
```
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/osc/LFDNoise1_01.mp4" muted="false"></video></div>

#### LFDノイズ3 ( LFDNoise3 )
```superCollider
var osc = {
	var f = 440.0;
	LFDNoise3.ar(freq: f, mul: 1.0, add: 0.0)
};
osc.play;
```
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/osc/LFDNoise3_01.mp4" muted="false"></video></div>

#### クリップノイズ ( ClipNoise )
```superCollider
var osc = {
	ClipNoise.ar(mul: 1.0, add: 0.0);
};
osc.play;
```
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/osc/clipNoise_01.mp4" muted="false"></video></div>

#### パリパリノイズ ( CrackleNoise )
```superCollider
var osc = {
	var cp = 1.5;
	Crackle.ar(chaosParam: cp, mul: 1.0, add: 0.0);
};
osc.play;
```
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/osc/cracleNoise_01.mp4" muted="false"></video></div>
