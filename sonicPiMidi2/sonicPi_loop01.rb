define :liveLoop01 do
    live_loop :LOOP01 ,sync: :metro do # metroループと同期する
        use_bpm get[:bpm]
        sample :elec_blip, amp: 0.5
        sleep 4
        stop if get[:ACTIVE01] == NOT_ACTIVE # LOOP01を停止する
    end
end
define :liveLoop02 do
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