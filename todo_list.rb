require 'yaml'

class TodoList
  attr_reader :tasks, :name

  FILE_EXT = '.todo.yaml'

  def initialize
    @tasks = []
    @name = nil
  end

  def add_task(text)
    unless text.empty?
      @tasks << Task.new(text)
      puts 'Added'
    end

    self
  end

  def complete_task(task_num)
    if valid_task?(task_num)
      task = @tasks[task_num - 1].mark_completed
      puts %[Completed "#{task}"]
    else
      puts 'Task does not exist'
    end
    
    self
  end

  def has_name?
    not @name.nil?
  end

  def self.load(list_name)
    filename = list_name + FILE_EXT

    if File.exists?(filename)
      todo_list = YAML.load(File.read(filename))
      puts 'Loaded'
      todo_list
    else
      puts 'To-Do list does not exist'
    end
  end

  def remove_task(task_num)
    if valid_task?(task_num)
      task = @tasks.delete_at(task_num - 1)
      puts %[Removed "#{task}"], 'Task numbers have been updated'
      task
    else
      puts 'Task does not exist'
      self
    end
  end

  def save
    raise 'To-Do list has no name to save' unless has_name?

    File.write(@name + FILE_EXT, YAML.dump(self))
    puts 'Saved'
    self
  end

  def set_name(name)
    @name = name.downcase.gsub(' ', '_')
  end  

  def to_s
    @tasks.each_with_index
      .map { |task, i| " #{task.completed? ? 'X' : ' '} #{i + 1}.\t#{task}" }
      .join("\n")
  end

  protected

  def valid_task?(task_num)
    1 <= task_num && task_num <= @tasks.length
  end

  class Task
    def initialize(text)
      @text = text
      @completed = false
    end

    def completed?
      @completed
    end

    def mark_completed
      @completed = true
      self
    end

    def to_s
      @text
    end
  end
end