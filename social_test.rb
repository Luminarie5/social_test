# name: "Тест - Ваш уровень общительности"
# author: Shubin Pavlik
# version: 3.2

# ruby_version: 2.3
# encoding: utf-8
# source: http://syntone.ru/psytesty/vash-uroven-obshhitelnosti/

begin
  require_relative 'lib/questioneer.rb'
  require_relative 'lib/score.rb'
rescue Exception => error
  puts 'lib error'
  puts error.message
  exit
end

score       = Score.new
questioneer = Questioneer.new

questioneer.greetings

while questioneer.remaining_questions > 0
  questioneer.ask
  score.increase_points(questioneer.check_answer)
end

questioneer.show_test_result(score.points, score.test_result)