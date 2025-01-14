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
	SinOsc.ar(freq:f, phase:0, mul:1, add:0);	
};
osc.play;
```
#### Plot
![alt text](./sinOsc_01_plot.png)

#### 再生
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/osc/sinOsc_01.mp4" muted="false"></video></div>

### ノコギリ波（Sawtooth Wave）
のこぎりの歯のような波形であり、すべての整数倍音を豊富に含みます。明るく力強い音になります。

```superCollider
var osc = {
	var f = 440;
	Saw.ar(freq:f, mul:1, add:0);	
};
osc.play;
```
#### Plot
![alt text](./saw_01_plot.png)

#### 再生
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
#### Plot
![alt text](./pulse_01_plot.png)

#### 再生
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
#### Plot
![alt text](./square_01_plot.png)

#### 再生
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/osc/square_01.mp4" muted="false"></video></div>

### 三角波（Triangle Wave）
周波数特性は矩形波と同じく奇数倍音のみを含む波形です。
矩形波と異なる点は、倍音の音量であり、高い倍音ほど弱いので サイン波に近い柔らかい音色です。

```superCollider
var osc = {
	var f = 440;
	LFTri.ar(freq: f, iphase: 0.0, mul: 1.0, add: 0.0)	
};
osc.play;
```
#### Plot
![alt text](./triangle_01_plot.png)

#### 再生
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/osc/triangle_01.mp4" muted="false"></video></div>

### インパルス( Impulse )
```superCollider
var osc = {
	var f = 440;
	Impulse.ar(freq: f, phase: 0.0, mul: 1.0, add: 0.0);
};
osc.play;
```
#### Plot
![alt text](./impulse_01_plot.png)

#### 再生
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/osc/impulse_01.mp4" muted="false"></video></div>

### プラック( Pluck )
```superCollider
var osc = {
	Pluck.ar(
		in: WhiteNoise.ar(0.1), 
		trig:Impulse.kr(2), 
		maxdelaytime:440.reciprocal, 
		delaytime:440.reciprocal, 
		decaytime:10, 
		coef:0.0
	);
};
osc.play;
```
※ Number.reciprocal --> 逆数です。 440.reciprocal --> 1/440 です。

#### Plot
![alt text](./pluck_01_plot.png)

#### 再生
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
#### Plot
![alt text](./whiteNoise_01_plot.png)

#### 再生
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/osc/whiteNoise_01.mp4" muted="false"></video></div>

#### デマンドホワイト( Dwhite )
```superCollider
var osc = {
	var a = Dwhite(lo:0, hi:25, length:inf);
	var f = 440;
	var trig = Impulse.kr( f / 10 );
	var f2 = Demand.kr(trig, 0, a) * 30 + 340;
	Saw.ar(f2) * 0.1
};
osc.play;
```
#### Plot
![alt text](./Dwhite_01_plot.png)

#### 再生
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/osc/Dwhite_01.mp4" muted="false"></video></div>

#### デマンドブラウン( Dbrown )
```superCollider
var osc = {
	var a = Dbrown(lo:0, hi:25, step:0.01, length:inf);
	var f = 440;
	var trig = Impulse.kr( f / 10 );
	var f2 = Demand.kr(trig, 0, a) * 30 + 340;
	Saw.ar(f2) * 0.1
};
osc.play;
```
#### Plot
![alt text](./Dbrown_01_plot.png)

#### 再生
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/osc/Dbrown_01.mp4" muted="false"></video></div>


#### ブラウンノイズ( BrownNoise )
色（茶色）に起因した名称ではなく、ブラウン運動パターンに類似したものであるため、ブラウンノイズと呼ばれています。周波数が高くなるにつれてノイズパワーが小さくなるノイズです。低周波成分が多めになりますので「雷鳴」「滝の轟音」といった深みのある音質が特徴です。
ホワイトノイズやピンクノイズと比べて、減衰した、あるいは柔らかい音質に聞こえます。

```superCollider
var osc = {
	BrownNoise.ar(mul: 1.0, add: 0.0);
};
osc.play;
```

#### Plot
![alt text](./brownNoise_01_plot.png)

#### 再生
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/osc/brownNoise_01.mp4" muted="false"></video></div>


#### ピンクノイズ( PinkNoise )
パワーが周波数に反比例する雑音のことで、同じ周波数成分を持つ光がピンク色に見えることからピンクノイズと呼ばれています。

```superCollider
var osc = {
	PinkNoise.ar(mul: 1.0, add: 0.0);
};
osc.play;
```
#### Plot
![alt text](./pinkNoise_01_plot.png)

#### 再生
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/osc/pinkNoise_01.mp4" muted="false"></video></div>


#### LFノイズ0 ( LFNoise0 )
```superCollider
var osc = {
	var f = 440.0;
	LFNoise0.ar(freq: f, mul: 1.0, add: 0.0)
};
osc.play;
```
#### Plot
![alt text](./LFNoise0_01_plot.png)

#### 再生
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/osc/LFNoise0_01.mp4" muted="false"></video></div>

#### LFノイズ1 ( LFNoise1 )
```superCollider
var osc = {
	var f = 440.0;
	LFNoise1.ar(freq: f, mul: 1.0, add: 0.0)
};
osc.play;
```
#### Plot
![alt text](./LFNoise1_01_plot.png)

#### 再生
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/osc/LFNoise1_01.mp4" muted="false"></video></div>

#### LFノイズ2 ( LFNoise2 )
```superCollider
var osc = {
	var f = 440.0;
	LFNoise2.ar(freq: f, mul: 1.0, add: 0.0)
};
osc.play;
```
#### Plot
![alt text](./LFNoise2_01_plot.png)

#### 再生
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/osc/LFNoise2_01.mp4" muted="false"></video></div>


#### LDFノイズ0 ( LFDNoise0 )
```superCollider
var osc = {
	var f = 440.0;
	LFDNoise0.ar(freq: f, mul: 1.0, add: 0.0)
};
osc.play;
```
#### Plot
![alt text](./LFDNoise0_01_plot.png)

#### 再生
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/osc/LFDNoise0_01.mp4" muted="false"></video></div>

#### LFDノイズ1 ( LFDNoise1 )
```superCollider
var osc = {
	var f = 440.0;
	LFDNoise1.ar(freq: f, mul: 1.0, add: 0.0)
};
osc.play;
```
#### Plot
![alt text](./LFDNoise1_01_plot.png)

#### 再生
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/osc/LFDNoise1_01.mp4" muted="false"></video></div>

#### LFDノイズ3 ( LFDNoise3 )
```superCollider
var osc = {
	var f = 440.0;
	LFDNoise3.ar(freq: f, mul: 1.0, add: 0.0)
};
osc.play;
```
#### Plot
![alt text](./LFDNoise3_01_plot.png)

#### 再生
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/osc/LFDNoise3_01.mp4" muted="false"></video></div>

#### クリップノイズ ( ClipNoise )
クリッピングとは、音声信号が過度に大きな振幅を持ち、正確な波形が失われる現象を指します。
クリップノイズとは、オーディオ録音や再生中に、信号がクリッピング（オーバーロード）された際に発生するノイズ、またはそれに似たノイズを指します。

```superCollider
var osc = {
	ClipNoise.ar(mul: 1.0, add: 0.0);
};
osc.play;
```
#### Plot
![alt text](./clipNoise_01_plot.png)

#### 再生
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/osc/clipNoise_01.mp4" muted="false"></video></div>

#### パリパリノイズ ( CrackleNoise )
不規則な「パチパチ」という音のノイズです。古いレコードや不良なケーブル接続による接触不良などで起こるノイズ音に似ています。

```superCollider
var osc = {
	var cp = 1.5;
	Crackle.ar(chaosParam: cp, mul: 1.0, add: 0.0);
};
osc.play;
```
#### Plot
![alt text](./cracleNoise_01_plot.png)

#### 再生
<div><video controls src="https://amami-harhid.github.io/superColliderMovies/osc/cracleNoise_01.mp4" muted="false"></video></div>
