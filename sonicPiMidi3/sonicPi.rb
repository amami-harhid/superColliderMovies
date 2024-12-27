use_debug false
set :bpm, 180
use_bpm get[:bpm]
MIDI_NOTE_ON = "/midi:loopmidi_port_0:1/note_on"
MIDI_PROGRAM_CHANGE = "/midi:loopmidi_port_0:1/program_change"
MIDI_NOTE_ON2 = "/midi:loopmidi_port_0:2/note_on"
MIDI_NOTE_OFF2 = "/midi:loopmidi_port_0:2/note_off"
ON_LOOP01 = 60 # C3
ON_LOOP02 = 62 # D3
ON_LOOP03 = 64 # E3
ON_LOOP04 = 65 # F3
ON_LOOP05 = 67 # F3
ACTIVE = 1
NOT_ACTIVE = 0
# グローバルタイムストアに ACTIVEnn を設定する(初期値:0)
5.times do |number|
  activeName = sprintf("ACTIVE%02d", number+1);
  set activeName, NOT_ACTIVE
end

# グローバルタイムストアに ACTIVEnn を設定する(初期値:0)
5.times do |number|
  activeName = sprintf("ACTIVE%02d", number+1);
  set activeName, NOT_ACTIVE
end

# live_loopの制御用（実行と停止）
define :loopCtl do | loopNo |
  activeName = "ACTIVE#{loopNo}"
  cueName = "SYNC#{loopNo}"
  active = get[activeName]
  if get[activeName] == NOT_ACTIVE then
    # live_loop を Stopさせない設定
    set activeName, ACTIVE
    cue cueName # live_loopを開始する cue
  else
    # live_loop内で Stopする設定
    set activeName, NOT_ACTIVE
  end
end

live_loop :midi01 do
  # MIDI SYNC するまで待つ
  note, velocity = sync_bpm MIDI_NOTE_ON
  case note
  when ON_LOOP01 then
    loopCtl("01")
  when ON_LOOP02 then
    loopCtl("02")
  when ON_LOOP03 then
    loopCtl("03")
  when ON_LOOP04 then
    loopCtl("04")
  when ON_LOOP05 then
    loopCtl("05")
  end
end

live_loop :midi02 do
  # MIDI SYNC するまで待つ
  program,_ = get MIDI_PROGRAM_CHANGE
  program = (program == nil)? 3 : program
  bpm = 100 + 20 * program
  set :bpm, bpm
  sleep 0.5
end

# Metronome loop
live_loop :metro do
  use_bpm get[:bpm]
  sample :drum_cymbal_closed, amp: 1.0
  sleep 1
  sample :drum_cymbal_closed, amp: 0.5
  sleep 1
  sample :drum_cymbal_closed, amp: 0.5
  sleep 1
  sample :drum_cymbal_open, amp: 0.2
  sleep 1
end

# スレッドを起動
in_thread do
  # ループが始まる
  loop do
    sync :SYNC01 # 『cue "SYNC01"』 されたら開始する
    live_loop :LOOP01 ,sync: :metro do # metroループと同期する
      use_bpm get[:bpm]
      sample :drum_snare_soft, amp: 0.5
      sleep 4
      stop if get[:ACTIVE01] == NOT_ACTIVE # LOOP01を停止する
    end
  end
end

# スレッドを起動
in_thread do
  # ループが始まる
  loop do
    sync :SYNC02 # 『cue "SYNC02"』 されたら開始する
    live_loop :LOOP02 ,sync: :metro do # metroループと同期する
      use_bpm get[:bpm]
      sleep 1.0
      sample :drum_heavy_kick,amp: 0.5
      sleep 1.0
      sample :drum_heavy_kick,amp: 1.5
      sleep 1.0
      sample :drum_heavy_kick,amp: 0.5
      sleep 1.0
      stop if get[:ACTIVE02] == NOT_ACTIVE # LOOP02を停止する
    end
  end
end

# スレッドを起動
in_thread do
  # ループが始まる
  loop do
    sync :SYNC03 # 『cue "SYNC03"』 されたら開始する
    live_loop :LOOP03 ,sync: :metro do # metroループと同期する
      use_bpm get[:bpm]
      sample :bd_fat, amp: 2, sustain: 1.5
      sleep 1
      sample :drum_cymbal_pedal, amp: 0.5
      sleep 1
      sample :bd_fat, amp: 2, sustain: 1.5
      sleep 1
      sample :drum_cymbal_pedal, amp: 0.5
      sleep 1
      stop if get[:ACTIVE03] == NOT_ACTIVE # LOOP03を停止する
    end
  end
end

# スレッドを起動
in_thread do
  # ループが始まる
  loop do
    sync :SYNC04 # 『cue "SYNC04"』 されたら開始する
    live_loop :LOOP04 ,sync: :metro do # metroループと同期する
      use_bpm get[:bpm]
      sample :hat_noiz
      sleep 2.0
      sample :hat_noiz
      sleep 2.0
      stop if get[:ACTIVE04] == NOT_ACTIVE # LOOP04を停止する
    end
  end
end

in_thread do
  loop do
    sync :SYNC05
    live_loop :LOOP05, sync: :metro do
      use_bpm get[:bpm]
      note, _ = get MIDI_NOTE_ON2
      n = (note == nil)? :e3 : note
      use_synth :dsaw
      use_random_seed 3
      notes = scale( n, :major_pentatonic, num_octaves: 3).shuffle
      play notes.tick, release: 0.25, cutoff: 80, amp: 0.5
      sleep 0.25
      stop if get[:ACTIVE05] == NOT_ACTIVE # LOOP05を停止する
      
    end
  end
end

#-----------------------------------------
# 【チャンネル2: キーボードで音を鳴らす制御】
#-----------------------------------------
#
# ※ set_audio_latency!
# MIDIコントローラー側のキーボードをたたいてから 音が始まるタイミングが遅れるときに
# set_audio_latency!　を試すとよいことがあるかもしれない。
# マイナス値の場合Audioイベントの開始は 150ms早くなる。
# 早くしすぎても限界があるはずなので、うまくいけばラッキーと思う程度にしてほしい。
# 同じ環境であっても -150で良い感じのことがあれば -700 で良い感じのときもある。
# そのときのマシンのご機嫌によるのかもしれない。
# ちなみにここまでの件は Windows11(64bit)での話です。
# REF: https://sunderb.me/sonic-pi-docs-test/ja/reference/lang/set_audio_latency!.html
set_audio_latency! -700

AMP = 0.2
sHash = []
live_loop :midi02_on do
  note, velocity = sync MIDI_NOTE_ON2
  s = sHash[note]
  if s != nil then
    sHash[note] = nil
    kill s if s != nil
  end
  use_synth :fm
  s = play note, release: 2, amp:AMP # 演奏
  sHash[note] = s
end

# キーボードのNoteを押したまますばやく移動すると、押す（離す）が短時間で繰り返される。
#
live_loop :midi02_off do
  note, _ = sync MIDI_NOTE_OFF2
  s = sHash[note]
  if s != nil then
    sHash[note] = nil
    sleep 0.2
    kill s if s != nil
  end
end