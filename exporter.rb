require './csv_exporter'
require './html_exporter'

class Exporter

  FORMAT_CSV = "csv"
  FORMAT_HTML = "html"
  SUPPORTED_FORMATS = [FORMAT_CSV, FORMAT_HTML]

  def initialize(todos)
    @todos = todos
  end

  def supported_formats
    SUPPORTED_FORMATS
  end

  def export(format)
    case format
    when FORMAT_CSV
      export_csv
    when FORMAT_HTML
      export_html
    else
      puts "[EXPORTER] Format #{format} is not supported."
    end
  end

  def readline(prompt = "")
    print "#{prompt} "
    gets.chomp
  end

  def export_csv
    file_name = readline("Please enter a file name:")
    csv_exporter = HtmlExporter.new(@todos)
    csv_exporter.export(file_name)
  end

  def export_html
    file_name = readline("Please enter a file name:")
    html_exporter = ErbExporter.new(@todos)
    html_exporter.export(file_name)
  end

end
