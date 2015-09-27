class HtmlExporter

  def initialize(todos)
    @todos = todos
  end

  def export(file_name)
    File.open(file_name, 'wb') do |html|
      begin_html = "
        <!DOCTYPE html>
        <html>
        <head>
        <title>Todo List Export</title>
        </head>

        <body>
        <h1>Here's all the todos!</h1>

        <ul>
      "
      html << begin_html

      @todos.each do |todo|
        html << "<li>#{todo.title} (#{todo.completed?})</li>\n"
      end

      end_html = "
        </ul>

        </body>
        </html>
      "
      html << end_html
    end

    puts "Written HTML export to file #{file_name}."
  end

end
