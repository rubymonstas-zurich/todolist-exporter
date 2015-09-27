require 'csv'

class CsvExporter

  def initialize(todos)
    @todos = todos
  end

  def export(file_name)
    CSV.open(file_name, 'wb') do |csv|
      @todos.each do |todo|
        csv << [todo.title, todo.completed?]
      end
    end
    puts "Written CSV export to file #{file_name}."
  end

end
