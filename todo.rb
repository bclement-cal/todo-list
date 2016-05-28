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
    list_name = get_list_name
    todo_list = TodoList.load(list_name) unless list_name.empty?
  when'save'
    if todo_list.has_name?
      todo_list.save
    else
      list_name = get_list_name
      unless list_name.empty?
        todo_list.set_name(list_name) unless todo_list.has_name?
        todo_list.save
      end
    end
  when 'quit'
    break
  end
end