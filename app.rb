require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("sinatra/activerecord")
require("./lib/employee")
require("./lib/division")
require("pg")

get('/') do
  @employees = Employee.all()
  @divisions = Division.all()
  erb(:index)
end

get('/employees/:id/edit') do
  @employee = Employee.find(params.fetch("id").to_i())
  erb(:employee_edit)
end

patch("/employees/:id") do
  name = params.fetch("name")
  @employee = Employee.find(params.fetch("id").to_i())
  @employee.update({:name => name})
  @employees = Employee.all()
  erb(:index)
end

post('/divisions') do
  description = params.fetch('description')
  @division = Division.new({:description => description})
  @division.save()
  erb(:success)
end

get('/divisions/:id/edit') do
  @division = Division.find(params.fetch("id").to_i())
  erb(:divisions_edit)
end

delete("/divisions/:id") do
  @division = Division.find(params.fetch("id").to_i())
  @division.destroy()
  @division = Division.all()
  redirect('/')
  erb(:divisions)
end

post('/divisions/:id') do
  name = params.fetch("name")
  @division = Division.find(params.fetch("id").to_i())
  @employee = Employee.create({:name => name, :division_id => (params.fetch("id"))})
  erb(:divisions)
end

patch("/divisions/:id") do
  description = params.fetch("description")
  @division = Division.find(params.fetch("id").to_i())
  @division.update({:description => description})
  @divisions = Division.all()
  erb(:index)
end

get("/divisions/:id") do
  @division = Division.find(params.fetch("id").to_i())
  @employees = Employee.all()
  erb(:divisions)
end

get('/allemployees') do
  @employees = Employee.all()
  erb(:allemployees)
end
