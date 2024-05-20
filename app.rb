require "sinatra"
require "sinatra/reloader"
require "fileutils"

get("/") do
  erb(:squarenew)
end
get("/howdy") do
  erb(:hello)
end
get("/goodbye") do
  erb(:bye)
end

get("/square/new") do
  erb(:squarenew)
end
get("/squareroot/new") do
  erb(:squarerootnew)
end
get("/payment/new") do
  erb(:paymentnew)
end
get("/random/new") do
  erb(:randomnew)
end



configure do
  # Ensure the uploads directory exists
  FileUtils.mkdir_p("uploads")

  # Set maximum multipart content length to 50MB (for example)
  set :max_multipart_content_length, 50 * 1024 * 1024 # 50MB
end
post("/square/results") do
  @the_num = params.fetch("users_number").to_f
  @the_result = @the_num**2

  if params[:uploaded_files]
    @uploaded_files = params[:uploaded_files].map do |file|
      filename = file[:filename]
      file_data = file[:tempfile].read
      # You can save the file here if needed
      FileUtils.mkdir_p("uploads") unless Dir.exist?("uploads")
      File.open("uploads/#{filename}", "wb") { |f| f.write(file_data) }
      filename
    end
  end

  erb(:squareresult)
end


# get("/square/results") do
#   @the_num = params.fetch("users_number").to_f
#   @the_result = @the_num**2
#   erb(:squareresult)
# end
get("/squareroot/results") do
  @the_num = params.fetch("users_number").to_f
  @the_result = @the_num**0.5
  erb(:squarerootresult)
end
get("/payment/results") do
  @rate = params.fetch("rate").to_f/100/12
  @pv = params.fetch("pv").to_f
  @nper = params.fetch("nper").to_f*12
  @numerator = (@rate*@pv)
  @denominator = (1-((1+@rate)**(-1*nper)))
  @pmt = @numerator/@denominator
  erb(:paymentresult)
end
get("/random/results") do
  @the_num = params.fetch("users_number").to_f
  @the_result = @the_num**2
  erb(:randomresult)
end



configure do
  # Ensure the uploads directory exists
  FileUtils.mkdir_p("uploads")
end
