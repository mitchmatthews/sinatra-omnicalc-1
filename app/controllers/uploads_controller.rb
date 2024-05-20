class UploadsController < ApplicationController
  def new
    # This will render the form
  end

  def create
    # This will handle the uploaded files
    params[:files].each do |file|
      # Handle each file, e.g., save it to the filesystem or a cloud service
      # Here we save it to the Rails tmp directory for simplicity
      File.open(Rails.root.join('tmp', file.original_filename), 'wb') do |f|
        f.write(file.read)
      end
    end
    redirect_to uploadpage_path, notice: 'Files uploaded successfully'
  end
end
