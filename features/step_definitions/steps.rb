module TodoDsl
  def destroy
    todo_command "destroy"
  end

  def add(item)
    todo_command "add #{item}"
  end

  def todos
    todo_command "list"
  end

  def todo_item
    "new item"
  end

  private
  def todo_command(command)
    `./todo #{command}`
  end
end

World TodoDsl

Given(/^an empty todo list$/) do
  destroy
end


When(/^I add an item to the list$/) do
  add(todo_item)
end

Then(/^I should see it in the list$/) do
  expect(todos).to include(todo_item)
end
