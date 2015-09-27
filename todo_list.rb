require './storage'
require './exporter'

class TodoList
  FILENAME = 'todo_list.csv'

  def initialize
    @storage = Storage.new(FILENAME)
    @todos = @storage.load
  end

  def print_todos
    @todos.each do |todo|
      if todo.completed?
        puts "[X] #{todo.title}"
      else
        puts "[ ] #{todo.title}"
      end
    end
  end

  def add(title)
    todo = Todo.new(title, false)
    @todos.push(todo)
    puts "'#{todo.title}' was added."
  end

  def remove(title)
    todo = @todos.find { |todo| todo.title == title }
    @todos.delete(todo)
    puts "'#{todo.title}' was removed."
  end

  def mark(title)
    todo = @todos.find { |todo| todo.title == title }
    if todo
      todo.completed = true
      puts "'#{todo.title}' marked as completed."
    else
      puts "Todo with title '#{title}' could not be found."
    end
  end

  def unmark(title)
    todo = @todos.find { |todo| todo.title == title }
    if todo
      todo.completed = false
      puts "'#{todo.title}' marked as uncompleted."
    else
      puts "Todo with title '#{title}' could not be found."
    end
  end

  def save
    @storage.save(@todos)
  end

  def export
    exporter = Exporter.new(@todos)
    supported_formats = exporter.supported_formats.join(", ")
    format = readline("Please enter an export format (#{supported_formats}):")
    exporter.export(format)
  end
end

todo_list = TodoList.new

def readline(prompt = ">")
  print "#{prompt} "
  gets.chomp
end

puts 'Welcome to the todo_list app!'
puts 'Type help for listing all commands.'
loop do
  command = readline
  case command
  when 'help'
    puts 'help: Print this help'
    puts 'list: List all todos'
    puts 'add: Add a new todo'
    puts 'remove: Remove an existing todo'
    puts 'mark: Mark a todo as completed'
    puts 'unmark: Unmark a completed todo'
    puts 'export: Export the current todos'
    puts 'exit: Exit the application and saves all todos'
  when 'list'
    todo_list.print_todos
  when 'add'
    puts 'Enter the title of the todo:'
    title = readline
    todo_list.add(title)
  when 'remove'
    puts 'Enter the title of the todo:'
    title = readline
    todo_list.remove(title)
  when 'mark'
    puts 'Enter the title of the todo:'
    title = readline
    todo_list.mark(title)
  when 'unmark'
    puts 'Enter the title of the todo:'
    title = readline
    todo_list.unmark(title)
  when 'export'
    puts '[TODOLIST] export...'
    todo_list.export
  when 'exit'
    todo_list.save
    exit
  end
end
