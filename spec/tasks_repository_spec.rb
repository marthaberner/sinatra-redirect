require 'rspec'
require 'tasks_repository'
gem 'pg', '~> 0.17.1'


describe 'it manages tasks' do
  before do
    DB = Sequel.connect('postgres://gschool_user:password@localhost:5432/tasks_manager')
    DB.create_table! :tasks do
      primary_key :id
      String :name
      FalseClass :completed
    end
    DB.set_column_default :tasks, :completed, false
  end
  it 'allows a user to insert information into a database' do
    tasks = TasksRepository.new(DB)
    tasks.insert({:name => 'Get milk'})
    tasks.insert({:name => 'Get eggs'})
    expect(tasks.display_all).to eq [
                                      {:id => 1, :name => 'Get milk', :completed => false},
                                      {:id => 2, :name => 'Get eggs', :completed => false}
                                    ]
  end
  it 'allows a user to update information in the database' do
    tasks = TasksRepository.new(DB)
    tasks.insert({:name => 'Get milk'})
    tasks.insert({:name => 'Get eggs'})
    tasks.update(1, {:name => 'Get juice'})
    expect(tasks.display_all).to eq [
                                      {:id => 2, :name => 'Get eggs', :completed => false},
                                 { :id => 1, :name => 'Get juice', :completed => false }]
  end
end