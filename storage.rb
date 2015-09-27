require 'csv'
require './todo'

class Storage
  def initialize(filename)
    @filename = filename
  end

  def load
    todos = []
    CSV.foreach(@filename) do |row|
      todos << Todo.new(row[0], parse_boolean(row[1]))
    end

    todos
  end

  def save(todos)
    CSV.open(@filename, 'wb') do |csv|
      todos.each do |todo|
        csv << [todo.title, todo.completed?]
      end
    end
  end

  def parse_boolean(boolean)
    if boolean == "true"
      true
    else
      false
    end
  end
end
