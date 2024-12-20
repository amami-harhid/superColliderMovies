# superColliderMovies

## 参考
https://qiita.com/a2kiti/items/4449d15e16c1793fd53f


-----------------------
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
![mp4](https://amami-harhid.github.io/superColliderMovies/osc/sinOsc01.mp4)

### ノコギリ波（Sawtooth Wave）
すべての整数倍音を豊富に含みます。明るく力強い音になります。
```superCollider
var osc = {
	var f = 440;
	Saw.ar(feq:f, mul:1, add:0);	
};
osc.play;
```
![mp4](https://amami-harhid.github.io/superColliderMovies/osc/saw01.mp4)


### パルス波（Pulse Wave）
矩形波同様四角い形をした波形です。
パルス幅（pulse width)と呼ばれる周期の幅を変更することで、含まれる倍音成分が変化する特徴があります。
```superCollider
var osc = {
	var f = 440;
    var w = 0.8;
	Pulse.ar(freq: f, width: w, mul: 1.0, add: 0.0);	
};
osc.play;
```
![mp4](https://amami-harhid.github.io/superColliderMovies/osc/saw01.mp4)

### 矩形波（Square Wave）
奇数倍音のみを豊富に含みます。機械的なピコピコ音です。
矩形波はパルス波の一種であり、パルス幅が５０％（左右対称のもの）のものが矩形波で、奇数倍音しか含みません。
```superCollider
var osc = {
	var f = 440;
    var w = 0.5;
	Pulse.ar(freq: f, width: w, mul: 1.0, add: 0.0);	
};
osc.play;
```
![mp4](https://amami-harhid.github.io/superColliderMovies/osc/square01.mp4)

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
![mp4](https://amami-harhid.github.io/superColliderMovies/osc/triangle01.mp4)


### ノイズ(Noise)
ノイズは、音響学的には「周波数」「振幅」「位相」が完全にランダムな波形のことを指します。
スネアドラム等の打楽器や、効果音の生成には欠かすことのできない存在です。

# 加算合成
複数のオシレータを重ね合わせて、単体のオシレータでは出せない音色（=倍音成分）を持ったサウンドを生み出すことができます。

## デチューン（Detune）
デチューンとは、重ね合わせた各オシレータのピッチを微妙にずらすことで、音色に厚みを出すテクニックです。

## ユニゾン（Unison / Unisono）
同じ種類の波形を何音も同時に鳴らす機能のことをいいます。

# フィルター
オシレータが発した周波数成分のうち、任意の周波数成分のみを通過させ、それ以外をカットすることで、周波数特性を変化させる仕組みのことです。

## フィルターの主要なパラメーター
### カットオフ周波数（Cutoff）
カットオフ周波数を境に緩やかに減衰していきます。

### レゾナンス（Resonance,Q）
カットオフ周波数付近の倍音を共振させて、強調・増幅させる機能です。

### スロープ（Slope）
カットオフ周波数から、実際に音が消えてなくなるまでの勾配を決めるパラメータです。

## 代表的なフィルターの種類

### ローパスフィルター（Low Pass Filter）
指定した周波数以下の帯域を通過させ、高域成分をカットするフィルターです。
高音域をカットし、丸く柔らかい音に加工できます。

### ハイパスフィルター（High Pass Filter）
指定した周波数以上の帯域を通過させ、低域成分をカットするフィルターです。
低音域をカットし、軽くシャキシャキした音に加工できます。

### バンドパスフィルター（Band Pass Filter）
指定した周波数の周囲(狙った帯域成分)のみを通過させ、その他の帯域をすべてカットするフィルターです。

通過させる範囲（Ｑ）を極端に狭めることで、音程を持たないノイズに任意の音程を持たせたりできます。

### バンドストップフィルター（Band Stop Filter）
指定した周波数成分のみをカットするフィルターで、バンドパスフィルターの真逆の作用があります。

### コムフィルター（Comb Filter）
コム（comb）とは櫛のことで、その名の通り櫛形のギザギザした周波数特性を持つフィルターです。
ノイズから音程のある音色を作り出すことも可能で、ノイズをより攻撃的なリードに仕上げることができます。