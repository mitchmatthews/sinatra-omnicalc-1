require "sinatra"
require "sinatra/reloader"

get("/howdy") do
  erb(:hello)
end

get("/goodbye") do
  erb(:bye)
end

get("/square/new") do
  erb(:square)
end
get("/squareroot/new") do
  erb(:squareroot)
end
get("/payment/new") do
  erb(:payment)
end
get("/random/new") do
  erb(:random)
end

get("/") do
  "
  <h1>Welcome to your Sinatra App!</h1>
  <p>Define some routes in app.rb</p>
  "
end
