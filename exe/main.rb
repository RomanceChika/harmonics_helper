require "rexml/document"
require "complex"

SOUNDS = {
  "C" => 1,
  "D" => 3,
  "E" => 5,
  "F" => 6,
  "G" => 8,
  "A" => 10,
  "B" => 12,
}

# 半音換算での距離と度数変換
DGREES = {
  0 => 1,
  1 => 2,
  2 => 2,
  3 => 3,
  4 => 3,
  5 => 4,
  6 => 5,
  7 => 5,
  8 => 6,
  9 => 6,
  10 => 7,
  11 => 7,
  12 => 1
}

# 転回形
ROTATIONS = {
  [1, 3, 5] => "basic",
  [1, 3] => "basic",
  [3, 5] => "basic",
  [1, 3, 6] => "first",
  [1, 6] => "first"
}

document = REXML::Document.new(open("RomanceChika_2_1.xml"))

# 拍子の分子と分母を取得
def beat_and_types(doc)
  time = doc.elements["//attributes/time"]
  beats = time.elements["beats"].text
  beat_type = time.elements["beat-type"].text
  return beats, beat_type
end

# 拍子の分数表記を出力する
def print_rhythm(beats, beat_type)
  puts beats + "/" + beat_type
end

beats, beat_type = beat_and_types(document)
print_rhythm(beats, beat_type)

# 各小節の要素を配列で分けて取得する
def measures(doc)
  REXML::XPath.each(doc, "//measure"){ |element| element }
end

# 存在する声部を重複なく取得する
def part_numbers(doc)
  part_numbers = []
  REXML::XPath.each(doc, "//note/voice") do |element| 
    if !part_numbers.include?(element.text)
      part_numbers << element.text
    end
  end
  return part_numbers
end

# 各声部の拍ごとの情報を取得する
def each_voice(doc, voice)
  each_voice = []
  REXML::XPath.each(doc, "//note") do |e|
    if e.elements["voice"].text == voice
      step = e.elements["pitch/step"].text
      octave = e.elements["pitch/octave"].text
      duration = e.elements["duration"].text.to_i()

      voice_info = {}
      voice_info["step"] = step
      voice_info["octave"] = octave
      for num in 1..duration do
        each_voice << voice_info
      end
    end
  end
  return each_voice
end

# MuseScoreでルールに添えば声部はこうなるので一旦固定で
soprano = each_voice(document, "1")
alt = each_voice(document, "2")
tenor = each_voice(document, "5")
bass = each_voice(document, "6")

# 拍ごとにコードの構成音を取得する
def step_elements(soprano, alt, tenor, bass)
  code_sounds = []
  0.upto(soprano.size-1) do |index|
    code_sounds_each_beat = []
    code_sounds_each_beat << soprano[index]["step"]
    code_sounds_each_beat << alt[index]["step"]
    code_sounds_each_beat << tenor[index]["step"]
    code_sounds_each_beat << bass[index]["step"]
    code_sounds << code_sounds_each_beat
  end
  return code_sounds
end

# 音名を数字に置換する
def step_to_number(step)
  SOUNDS[step]
end

# step_to_numberをarrayに適用する
def step_numbers(steps)
  steps.map{ |step| step_to_number(step) }
end

# 数値化した音を取得する
def number_steps(step_elements)
  step_elements.map{ |steps| step_numbers(steps) }
end

st_el = step_elements(soprano, alt, tenor, bass)
num_step = number_steps(st_el)

# ベース音を取得する
def bass(steps)
  steps[3]
end

# 音の距離を半音単位で計測する。オクターブは同値とする
def distance(number1, number2)
  (number1 > number2)? number1 - number2 : number1 + 12 - number2
end

# 音程をを度数で計測する
def distance_as_degree(number1, number2)
  DGREES[distance(number1, number2)]
end

# バス音からの音程リストに変換する
def step_degrees(number_steps)
  number_steps.map{ |steps| steps.map{ |step| distance_as_degree(step, bass(steps)) }.uniq.sort }
end

s_ds = step_degrees(num_step)

# 転回形を判定する
def rotation_type(degrees)
  ROTATIONS[degrees]
end

# 転回形一覧を取得する
def rotation_types(step_degrees)
  step_degrees.map{ |degrees| rotation_type(degrees) }
end

p rotation_types(s_ds)

=begin
# 音程の距離を半音の数の数字で求める。8度未満という前提でとる
def distance(number1, number2)
  max = [number1, number2].max
  min = [number1, number2].min
  (max - min <= 8)? max - min : (min - (max - 12)).abs
end

def whitch_code(steps)
  codes = []
  CODES.each do |code_name, code_steps|
    puts code_name
    p code_steps
    p steps
    if code_steps - steps == []
       codes << code_name
    end
  end
end

steps = code(sop, alt, tenor, bass)
p whitch_code(steps)
=end