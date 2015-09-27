require './csv_exporter'

class Exporter

  FORMAT_CSV = "csv"
  SUPPORTED_FORMATS = ["csv"]

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
    csv_exporter = CsvExporter.new(@todos)
    csv_exporter.export(file_name)
	end

end
