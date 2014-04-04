require 'sequel'

class TasksRepository
  def initialize(db)
    @db = db
    @tasks_table = @db[:tasks]
  end

  def insert(task)
    @tasks_table.insert(task)
  end

  def display_all
    @tasks_table.all
  end

  def update(id, name)
    @tasks_table.where(:id => id).update(name)
  end

  def delete(id)
    @tasks_table.where(:id => id).delete
  end

  def find(id)
    @tasks_table.where(:id => id).to_a.first
  end
end
