# ruby_version: 2.3
# encoding: utf-8
class Score
  attr_reader(:points)

  def initialize
    @points = 0
  end

  def test_result
    case @points
    when 30..31 then 0
    when 25..29 then 1
    when 19..24 then 2
    when 14..18 then 3
    when 9..13 then 4
    when 4..8 then 5
    when 1..3 then 6
    else 7
    end
  end

  def increase_points(answer)
    @points += case answer
               when :yes then 2
               when :sometimes then 1
               else 0
               end
  end
end
