require 'active_record'
require './lib/employee'
require './lib/project'
require './lib/division'
require './lib/contribution'


database_configuration = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configuration['development']
ActiveRecord::Base.establish_connection(development_configuration)

def menu
  choice = nil
  until choice == 'x'
    puts '1: add division, 2: add employee, 3: list employees, 4: add project , 5: list projects, 6: add project to employee, x: exit'
    choice = gets.chomp
    case choice
    when '1'
      add_division
    when '2'
      add_employee
    when '3'
      list_employees
    when '4'
      add_project
    when '5'
      list_projects
    when '6'
      add_project_to_employee
    when 'x'
      puts "good bye"
    else
      puts "invalid choice"
    end
  end
end

def add_division
  puts "division name:"
  division_name = gets.chomp
  division = Division.new(:name => division_name)
  division.save
end

def list_divisions
  Division.all.each {|division| puts division.name}
end

def add_employee
  puts "employee name:"
  employee_name = gets.chomp
  list_divisions
  puts "which division are they in?"
  division_name = gets.chomp
  division = Division.all.where(:name => division_name).pop
  employee = Employee.new(:name => employee_name, :division_id => division.id)
  employee.save
end

def list_employees
  Employee.all.each {|employee| puts employee.name}
end

def add_project
  puts "project name:"
  project_name = gets.chomp
  project = Project.new(:name => project_name)
  project.save
end

def add_project_to_employee
  # Project.all.each { |project| puts project.name }
  puts "which employee do you want to add a project too?"
  list_employees
  employee_choice = gets.chomp
  employee = Employee.all.where(:name => employee_choice).pop
  puts "which project to add"
  Project.all.each { |project| puts project.name }
  project_choice = gets.chomp
  project = Project.all.where(:name => project_choice).pop
  puts "what is the employees contribution?"
  contribution_name =gets.chomp
  Contribution.create(:project_id => project.id, :employee_id => employee.id, :name => contribution_name)
end

def list_projects
  Project.all.each do |project|
    puts project.name
    project.contributions.each {|contribution| puts contribution.employee_id}
    puts "\n"
  end
end

menu
