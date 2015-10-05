require 'erb'

class HtmlExporter

  def initialize(todos)
    @todos = todos
  end

  def export(file_name)
    File.open(file_name, 'wb') do |output_file|
      template_source = File.new('todos.html.erb').read
      erb = ERB.new(template_source)
      rendered_html = erb.result(binding)
      output_file.write(rendered_html)
    end

    puts "Written HTML export to file #{file_name}."
  end

end
