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
get("/square_root/new") do
  erb(:squarerootnew)
end
get("/payment/new") do
  erb(:paymentnew)
end
get("/random/new") do
  erb(:randomnew)
end
get("/upload/new") do
  erb(:uploadnew)
end


configure do
  # Ensure the uploads directory exists
  FileUtils.mkdir_p("uploads")

  # Set maximum multipart content length to 50MB (for example)
  set :max_multipart_content_length, 50 * 1024 * 1024 # 50MB
end
post("/upload/results") do
  
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

  erb(:uploadresult)
end


get("/square/results") do
  @the_num = params.fetch("users_number").to_f
  @the_result = @the_num**2
  erb(:squareresult)
end
get("/square_root/results") do
  @the_num = params.fetch("users_number").to_f
  @the_result = @the_num**0.5
  erb(:squarerootresult)
end
get("/payment/results") do
  @APR = params.fetch("rate").to_f.round(4)
  @rate = params.fetch("rate").to_f/100/12
  @pv = params.fetch("pv").to_f.round(2)
  @pv_formatted = sprintf("$%0.2f", @pv).reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
  @years = params.fetch("nper").to_f.round(0)
  @nper = params.fetch("nper").to_f*12
  @numerator = (@rate*@pv)
  @denominator = (1-((1+@rate)**(-1*@nper)))
  @pmt = (@numerator/@denominator).round(2)
  @pmt_formatted = sprintf("$%0.2f", @pmt).reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
  erb(:paymentresult)
end
get("/random/results") do
  # Fetch the two user inputs
  @lownum = params.fetch("lownum").to_f
  @highnum = params.fetch("highnum").to_f
  # Ensure user_input1 is the lower bound and user_input2 is the upper bound
  lower_bound = [@lownum, @highnum].min
  upper_bound = [@lownum, @highnum].max
  # Generate a random number between the two inputs
  @the_result = rand(lower_bound..upper_bound)
  erb(:randomresult)
end



configure do
  # Ensure the uploads directory exists
  FileUtils.mkdir_p("uploads")
end
