# Completed step definitions for basic features: AddMovie, ViewDetails, EditMovie 

Given /^I am on the RottenPotatoes home page$/ do
  visit movies_path
 end


 When /^I have added a movie with title "(.*?)" and rating "(.*?)"$/ do |title, rating|
  visit new_movie_path
  fill_in 'Title', :with => title
  select rating, :from => 'Rating'
  click_button 'Save Changes'
 end

 Then /^I should see a movie list entry with title "(.*?)" and rating "(.*?)"$/ do |title, rating| 
   result=false
   all("tr").each do |tr|
     if tr.has_content?(title) && tr.has_content?(rating)
       result = true
       break
     end
   end  
  expect(result).to be_truthy
 end

 When /^I have visited the Details about "(.*?)" page$/ do |title|
   visit movies_path
   click_on "More about #{title}"
 end

 Then /^(?:|I )should see "([^"]*)"$/ do |text|
    expect(page).to have_content(text)
 end

 When /^I have edited the movie "(.*?)" to change the rating to "(.*?)"$/ do |movie, rating|
  click_on "Edit"
  select rating, :from => 'Rating'
  click_button 'Update Movie Info'
 end


# New step definitions to be completed for HW5. 
# Note that you may need to add additional step definitions beyond these


# Add a declarative step here for populating the DB with movies.

Given /the following movies have been added to RottenPotatoes:/ do |movies_table|
  #pending  # Remove this statement when you finish implementing the test step
  movies_table.hashes.each do |movie|
    # Each returned movie will be a hash representing one row of the movies_table
    # The keys will be the table headers and the values will be the row contents.
    # Entries can be directly to the database with ActiveRecord methods
    # Add the necessary Active Record call(s) to populate the database.
    movie = Movie.create(movie)
    
    
    
  end
end

When /^I have opted to see movies rated: "(.*?)"$/ do |arg1|
  # HINT: use String#split to split up the rating_list, then
  # iterate over the ratings and check/uncheck the ratings
  # using the appropriate Capybara command(s)
  #pending  #remove this statement after implementing the test step
  
  x = Movie.all_ratings
  y = arg1.split
  x.each do |i|
      if (i&&y).any?
        check("ratings[#{i}]")
      else
        uncheck("ratings[#{i}]")
      end
    end
  
  click_on("ratings_submit")
  
  
end

Then /^I should see only movies rated: "(.*?)"$/ do |arg1|
  #pending  #remove this statement after implementing the test step
   result=false
   y = arg1.split
   all("tr").each do |tr|
     if (tr&&y).any?
       result = true
     else
       result = false
       break
     end
   end  
  expect(result).to be_truthy
 end
  
  

Then /^I should see all of the movies$/ do
  #pending  #remove this statement after implementing the test step
  
   rows = 0
   all("tr").each do |tr|
    rows=rows+1
   end  
   
   rows.should == 11
  
end

Then /^I should see Alladin before Amelie$/ do 
    expect(page.body) == /\A\s*\S*(Alladin)\s*\S*(Amelie)\s*\S*\z/i
 end

When /^I have opted to see sort Movies Alphabetically$/ do
  
  click_on("title_header")
  
end


When /^I have opted to see sort Movies by release date$/ do
  
  click_on("release_date_header")
  
end

Then /^I should see Raiders of the Lost Ark before The Terminator$/ do 
    expect(page.body) == /\A\s*\S*(Raiders of the Lost Ark)\s*\S*(The Terminator)\s*\S*\z/i
 end