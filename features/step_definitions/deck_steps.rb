Given(/^the following decks exist within the project "(.*?)":$/) do |project_name, deck_names|
  
  step %{I cd to "#{project_name}"}
  
  deck_names.raw.flatten.each do |deck_name|
    step %{I run `profess new deck #{deck_name}`}
  end
  
end