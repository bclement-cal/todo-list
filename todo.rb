require_relative 'todo_list'

def get_input(prompt = '')
  print prompt
  gets.chomp
end

def get_list_name
  get_input('To-Do list name: ').downcase.gsub(' ', '_')
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
    todo_list = TodoList.load(filename)
  when'save'
    todo_list.name = get_list_name unless todo_list.has_name?
    filename = todo_list.name + '.todo.yaml'
    todo_list.save(filename)
  when 'quit'
    break
  end
end