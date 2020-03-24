require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    students = {}
    page.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
      student_name = student.css(".student-name").text
      student_location = student.css(".student-location").text 
      student_link = "#{student.attr('href')}"
      students << {name: student_name, location: student_location, student_url: student_-link}
    end
  
  students
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    profile = Nokogiri::HTML(open(profile_url))
    urls = profile.css(".social-icon-container").childeren.css("a").map {|el| el.attribute("href").value}
    urls.each do |url|
      if link.include?("linkdin")
        student[:linkdin] = link
        elsif link.include?("github")
        student[:github] = link 
        elsif link.include?("twitter")
        student[:twitter] = link
      else
        student[:blog] = link 
      end
    end 
    student[:profile_quote] = profile.css("div.main-wrapper.profile .vitals-text-container .profile-quote").text 
    student[:bio] = profile.css("div.main-wrapper.profile .description-holder p").text 
    student 
  end

end

