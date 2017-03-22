class Questioneer
  attr_reader :remaining_questions

  require 'unicode_utils/downcase'
  require 'yaml'

  PHRASES = YAML::load(open('./config/PHRASES.yml'))

  def initialize
    @questions = take_data_from_file('questions')
    @remaining_questions = @questions.length
    @results = take_data_from_file('results')
    @user_name = if ARGV[0] != nil
                   ARGV[0].encode('UTF-8')
                 else
                   PHRASES['default_name']
                 end
  end

  def take_data_from_file(data_name)
    file_path = "#{File.dirname(__FILE__)}/../data/#{data_name}.txt"
    File.readlines(file_path, encoding: 'UTF-8').map { |l| l.chomp }
  end

  def greetings
    puts "#{@user_name}#{PHRASES['greetings']}\n\n"
  end

  def ask
    @remaining_questions -= 1
    puts @questions.pop
  end

  def check_answer
    loop do
      puts PHRASES['answer_type'] +
             "#{PHRASES['anwer_yes']}, #{PHRASES['anwer_no']}, #{PHRASES['anwer_sometimes']}"
      user_input = UnicodeUtils.downcase(STDIN.gets.chomp.encode('utf-8'), :ru)

      case user_input
      when PHRASES['anwer_yes'] then return :yes
      when PHRASES['anwer_no'] then return :no
      when PHRASES['anwer_sometimes'] then return :sometimes
      end
    end
  end

  def show_test_result(points, result_number)
    puts "\n#{@user_name}\n#{PHRASES['result_message']}#{points.to_s}\n#{@results[result_number]}"
  end
end
