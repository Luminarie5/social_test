class Questioneer
  attr_reader :remaining_questions
  require 'unicode_utils/downcase'
  require 'yaml'

  def initialize
    @questions           = take_data_from_file('questions')
    @remaining_questions = @questions.length
    @results             = take_data_from_file('results')
    @comments            = YAML::load(open('./config/comments.yml'))
    @user_name           = @comments['default_name']
  end

  def take_data_from_file(data_name)
    current_path = File.dirname(__FILE__)
    file_path    = current_path + "/../data/#{data_name}.txt"
    f            = File.new(file_path, 'r:UTF-8')
    data         = f.readlines.each { |line| line.chomp! }
    f.close
    data
  end

  def name_the_user
    @user_name = ARGV[0].encode('UTF-8') if ARGV[0] != nil
  end

  def greetings
    name_the_user
    puts @user_name + @comments['greetings'] + @comments['ask'] + "\n\n"
  end

  def ask
    @remaining_questions -= 1
    puts @questions.pop
  end

  def check_answer
    loop do
      puts @comments['answer_type'] +
             "#{@comments['anwer_yes']}, #{@comments['anwer_no']}, #{@comments['anwer_sometimes']}"
      user_input = UnicodeUtils.downcase(STDIN.gets.chomp.encode('utf-8'), :ru)

      return :yes if user_input == @comments['anwer_yes']
      return :no if user_input == @comments['anwer_no']
      return :sometimes if user_input == @comments['anwer_sometimes']
    end
  end

  def show_test_result(points, result_number)
    puts
    puts @user_name
    puts @comments['result_message'] + points.to_s
    puts @results[result_number]
  end
end
