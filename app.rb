require 'sinatra'
require 'slim'
require 'sinatra/reloader'
require 'sqlite3'

get('/fruits') do
  #gör koppling till db
  db = SQLite3::Database.new("db/fruits.db")

  #[{},{},{}] önskar vi oss istället för [[], [],[]]
  db.results_as_hash = true

  #hämta allting från db
  @datafruit = db.execute("SELECT * FROM fruits")

  p @datafruit

  #visa med slim
  slim(:"fruits/index")

end


