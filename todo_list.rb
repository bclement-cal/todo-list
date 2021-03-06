require 'yaml'

class TodoList
  attr_reader :tasks

  def initialize
    @tasks = []
  end

  def add_task(text)
    @tasks << Task.new(text) unless text.empty?
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

  def load(filename)
    if File.exists?(filename)
      todo_list = File.read(filename)
      @tasks = YAML.load(todo_list).tasks
    else
      puts 'To-Do list does not exist'
    end

    self
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

  def save(filename)
    File.write(filename, YAML.dump(self))
    self
  end

  def to_s
    @tasks.each_with_index
      .map { |task, i| " #{task.completed? ? 'X' : ' '} #{i + 1}.\t#{task}" }
      .join("\n")
  end

  private

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