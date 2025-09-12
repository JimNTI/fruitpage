require 'sinatra'
require 'slim'
require 'sinatra/reloader'

get('/') do
  slim(:start)

end

get('/bye') do
  slim(:bye)

end

get ('/name') do
  @name = "Jim"
  slim(:name)

end

get('/fruits') do
 @fruits = ["Äpple",
"Banan","Apelsin"]
 slim(:fruits)
end
