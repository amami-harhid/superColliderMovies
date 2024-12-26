# sonicPi

## mini

- loopMIDI
- Pocket MIDI

```ruby

note, velocity = sync "/midi:loopmidi_port_0:1/note_on"
note, velocity = sync "/midi:loopmidi_port_0:1/note_off"

```

```ruby
# Pocket MIDI 上でキーボードを押したときに鳴る。
# キーを押し続けても鳴り続きはしない。
use_synth :tb303
live_loop :midi01 do
  note, velocity = sync "/midi:loopmidi_port_0:1/note_on"
  play note, amp: velocity/127.0
end
```


## sync

```ruby
live_loop :metro do
  cue :ticker
  sleep 0.25
end


use_synth :tb303
live_loop :loop1 do
  sync:ticker
  play choose(chord(:E3, :minor)), release: 0.3, cutoff: rrand(60, 120)
end
```


## MIDI + sync

```ruby
use_debug false
use_bpm 180

ON_LOOP01 = 60
ON_LOOP02 = 62
set :ACTIVE01,0
set :ACTIVE02,0

live_loop :midi01 do
  note, velocity = sync "/midi:loopmidi_port_0:1/note_on"
  case note
  when ON_LOOP01 then
    if get[:ACTIVE01]==0 then
      set :ACTIVE01, 1
      cue :SYNC01
    else
      set :ACTIVE01, 0
    end
  when ON_LOOP02 then
    if get[:ACTIVE02]==0 then
      set :ACTIVE02, 1
      cue :SYNC02
    else
      set :ACTIVE02, 0
    end
  end
end

live_loop :metro do
  cue :TICK
  sample :tabla_dhec
  sleep 1
end


in_thread do
  loop do
    sync :SYNC01
    live_loop :LOOP01 do
      sync :TICK
      sample :bass_hit_c
      sleep 0.25
      sample :bass_hit_c
      sleep 0.25
      sleep 0.5
      stop if get[:ACTIVE01] == 0
    end
  end
end

in_thread do
  loop do
    sync :SYNC02
    live_loop :LOOP02 do
      sync :TICK
      sample :sn_dolf
      sleep 0.5
      sample :sn_dolf
      sleep 0.5
      stop if get[:ACTIVE02] == 0
    end
  end
end
```

```ruby
use_debug false
set :bpm, 120
use_bpm get[:bpm]
MIDI_NOTE_ON = "/midi:loopmidi_port_0:1/note_on"
MIDI_PROGRAM_CHANGE = "/midi:loopmidi_port_0:1/program_change"
ON_LOOP01 = 60 # C3
ON_LOOP02 = 62 # D3
ON_LOOP03 = 64 # E3
ON_LOOP04 = 65 # F3
ACTIVE = 1
NOT_ACTIVE = 0

# グローバルタイムストアに ACTIVEnn を設定する(初期値:0)
4.times do |number|
  activeName = sprintf("ACTIVE%02d", number+1);
  set activeName, NOT_ACTIVE
end

# live_loopの制御用（実行と停止）
define :loopCtl do | loopNo |
  activeName = "ACTIVE#{loopNo}"
  cueName = "SYNC#{loopNo}"
  active = get[activeName]
  puts "ACTIVE ---> #{active}"
  if get[activeName] == NOT_ACTIVE then
    # live_loop を Stopさせない設定
    set activeName, ACTIVE
    puts "cue ---> #{cueName}"
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
  end
end

live_loop :midi02 do
  # MIDI program_changeを GET する
  program,_ = get MIDI_PROGRAM_CHANGE
  case program
  when 1 then
    set :bpm, 140
  when 2 then
    set :bpm, 160
  when 3 then
    set :bpm, 180
  when 4 then
    set :bpm, 200
  when 5 then
    set :bpm, 220
  else
    set :bpm, 120
  end
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
  sample :drum_cymbal_closed, amp: 0.5
  sleep 1
end

# スレッドを起動
in_thread do
  # ループが始まる
  loop do
    sync :SYNC01 # 『cue "SYNC01"』 されたら開始する
    live_loop :LOOP01 ,sync: :metro do # metroループと同期する
      use_bpm get[:bpm]
      sample :drum_snare_soft, amp: 1.5
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
```