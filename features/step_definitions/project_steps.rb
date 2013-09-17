Given(/^a project "(.*?)" exists$/) do |project_name|
  step %{I run `profess new project #{project_name}`}
end

When(/^I change to the root of the project "(.*?)"$/) do |project_name|
  step %{I cd to "#{project_name}"}
end