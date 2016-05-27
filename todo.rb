require_relative 'todo_list'

def get_input(prompt = '')
  print prompt
  gets.chomp
end

def get_list_name
  get_input('List name: ').downcase.gsub(' ', '_')
end

todo_list = TodoList.new

# Main loop
while input = get_input('>> ').downcase
  case input
  when 'add'
    text = get_input('Task: ')
    todo_list.add_task(text)
  when 'complete', 'remove'
    task_num = get_input('Task #').to_i
    todo_list.send("#{input}_task", task_num)
  when 'help'
    puts File.read('help.txt')
  when 'list'
    puts todo_list
  when 'load'
    filename = get_list_name + '.todo.yaml'
    todo_list.load(filename)
  when'save'
    # Name needs to be stored in TodoList for use by #save
    list_name ||= get_list_name
    filename = list_name + '.todo.yaml'
    todo_list.save(filename)
  when 'quit'
    break
  end
end