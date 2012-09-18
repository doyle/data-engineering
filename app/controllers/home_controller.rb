class HomeController < ApplicationController
  rescue_from Encoding::UndefinedConversionError, :with => :bad_file

  def index
  end

  def upload
    uploaded_io = params[:file]
    
    path = Rails.root.join('public', 'uploads', uploaded_io.original_filename)
    File.open(path, 'w') do |file|
      file.write(uploaded_io.read)
    end
    parser = TsvImporter.new
    f = File.open(path, 'r')
    @value = parser.import_file f
    File.delete path if File.exist? path
     
  end

  private
 
  def bad_file
    flash.keep[:error] = "The file does not appear to be text"
    redirect_to :root
  end
end
