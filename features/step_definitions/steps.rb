Given(/^an empty todo list$/) do
  `./todo destroy`
end

When(/^I add an item to the list$/) do
  `./todo add new item`
end

Then(/^I should see it in the list$/) do
  items = `./todo list`
  expect(items).to include "new item"
end
