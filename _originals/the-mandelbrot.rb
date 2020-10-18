# =======================================================
# SONG - The Mandelbrot
# 
# SUMMARY - A Mandelbrot Set is a true fusion of art and 
# mathematics, much like how Sonic Pi is a true fusion
# of art and programming. Read more about Mandelbrot Set
# here - https://en.wikipedia.org/wiki/Mandelbrot_set
# 
# Listen to the song here - https://youtu.be/ZiBzF9sxK0Q
# Kindly note that I DID NOT make the video. 
# All the video rights rest with the creator
# https://www.youtube.com/channel/UClSpgl1Xhhf2a8FW5XpHFIg
# 
# =======================================================
# SAMPLES
# 
# 1. https://reverbmachine.com/blog/deconstructing-brian-eno-music-for-airports/
# 2. https://www.shutterstock.com/blog/free-music-samples
# 
# =======================================================
# THANK YOU
# 
# 1. Alex Esc - For introducing me to Brian Eno's
#    Music for Airports 
#    https://in-thread.sonic-pi.net/u/alexesc
# 2. Paul Whitfield - for adding Chimes & Sam's ocean
#    to Alex's code
#    https://in-thread.sonic-pi.net/u/Eli
# 
# =======================================================


# =======================================================
# DEPENDENCIES
# ------------

# Samples
samplesRoot = "~/Desktop/home/OS/sonic-pi/_samples"
airportChoir = samplesRoot + "/music-for-airports-loops/Choir"
airportPiano = samplesRoot + "/music-for-airports-loops/Piano"
drumFloorTom = samplesRoot + "/shutter-stock/drumnbass-samples/Floor-Tom"
guitarPsychedelic = samplesRoot + "/shutter-stock/guitar-psychedelic-rock"

# =======================================================
# FUNCTIONS
# ---------

# drums track
define :drumBeat do
  with_fx :reverb do
    in_thread do
      8.times do
        sample drumFloorTom, 4
        sleep 0.25
        sample drumFloorTom, 5
        sleep 0.25
        sample drumFloorTom, 7
        sleep 0.25
        sample drumFloorTom, 4
        sleep 0.25
      end
      sleep 1
      loop do
        sample drumFloorTom, 4
        sleep 1
      end
    end
  end
end

# load samples from folder
define :loopThroughFolder do |n, samp, initialWait|
  # sleep initialWait
  n.times do |i| #i goes from 0 to n-1
    in_thread do
      loop do
        sample samp, i
        sleep sample_duration samp, i
      end
    end
  end
end

# =======================================================
# MAIN THREAD
# -----------

sample guitarPsychedelic, 4
sleep 16
drumBeat
sleep 4
loopThroughFolder 7, airportChoir, 20
sleep 4
loopThroughFolder 8, airportPiano, 20

live_loop :chime1 do
  sample :elec_chime, amp: rand(0.01..0.05)
  sleep sample_duration :elec_chime
  sleep rand(2.5..4.5)
end

live_loop :chime2 do
  sample :drum_cymbal_soft, amp: rand(0.1..0.3)
  sleep sample_duration :drum_cymbal_soft
  sleep rand(2.5..4.5)
end

with_fx :reverb, mix: 0.5 do
  live_loop :oceans do
    s = synth [:bnoise, :cnoise, :gnoise].choose, amp: rand(0.05..0.075), attack: rrand(0, 4),
      sustain: rrand(0, 2), release: rrand(1, 3), cutoff_slide: rrand(0, 5), cutoff: rrand(60, 100),
      pan: rrand(-1, 1), pan_slide: rrand(1, 5)# ,  amp: rrand(0.150, 0.3)
    control s, pan: rrand(-1, 1), cutoff: rrand(60, 70)
    sleep rrand(1, 3)
  end
end

