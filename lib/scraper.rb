require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    
    index_page = Nokogiri::HTML(open(index_url)).each do |card|
    students = []
    card.css(".student-card a").each do |stu|
    stu.css("div.roster-cards-container").each do |student|
      student_name = student.css(".student-name").text
      student_location = student.css(".student-location").text
      profile_link = "#{student.attr('href')}"
      students << {name: student_name, location: student-location, profile_url: profile_link}
    end
  end
    students
  end

 def self.scrape_profile_page(profile_url)
    student_profile = {}
    html = open(profile_url)
    profile = Nokogiri::HTML(html)

    # Social Links

    profile.css("div.main-wrapper.profile .social-icon-container a").each do |social|
      if social.attribute("href").value.include?("twitter")
        student_profile[:twitter] = social.attribute("href").value
      elsif social.attribute("href").value.include?("linkedin")
        student_profile[:linkedin] = social.attribute("href").value
      elsif social.attribute("href").value.include?("github")
        student_profile[:github] = social.attribute("href").value
      else
        student_profile[:blog] = social.attribute("href").value
      end
    end

    student_profile[:profile_quote] = profile.css("div.main-wrapper.profile .vitals-text-container .profile-quote").text
    student_profile[:bio] = profile.css("div.main-wrapper.profile .description-holder p").text

    student_profile
  end
end

