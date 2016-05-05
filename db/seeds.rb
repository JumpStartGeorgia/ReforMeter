# This file should contain all the record creation needed to seed the database
# with its default values. The data can then be loaded with the rake db:seed
# (or created alongside the db with db:setup).

roles = %w(super_admin site_admin content_manager)
roles.each do |role|
  Role.find_or_create_by(name: role)
end

# load page content records with placeholder text
# home page about
PageContent.find_or_create_by(name: 'home_page_about') do |pc|
    puts 'creating page content for home page about'
    pc.title = 'What are Reforms?'
    pc.content = 'I have no idea.'
end
# expert methodology
PageContent.find_or_create_by(name: 'methodology_expert') do |pc|
    puts 'creating page content for methodology expert'
    pc.title = 'Expert Survey Methodology'
    pc.content = 'TBD ...'
end
# government methodology
PageContent.find_or_create_by(name: 'methodology_government') do |pc|
    puts 'creating page content for methodology government'
    pc.title = 'Government Survey Methodology'
    pc.content = 'TBD ...'
end
# stakeholder methodolgy
PageContent.find_or_create_by(name: 'methodology_stakeholder') do |pc|
    puts 'creating page content for methodology stakeholder'
    pc.title = 'Stakeholder Survey Methodology'
    pc.content = 'TBD ...'
end
# about text
PageContent.find_or_create_by(name: 'about_text') do |pc|
    puts 'creating page content for about text'
    pc.title = 'About ReforMeter'
    pc.content = 'TBD ...'
end
# reform text
PageContent.find_or_create_by(name: 'reform_text') do |pc|
    puts 'creating page content for reform text'
    pc.title = 'What are Reforms?'
    pc.content = 'TBD ...'
end
# expert text
PageContent.find_or_create_by(name: 'expert_text') do |pc|
    puts 'creating page content for expert text'
    pc.title = 'Experts'
    pc.content = 'TBD ...'
end
# download text
PageContent.find_or_create_by(name: 'download_text') do |pc|
    puts 'creating page content for download text'
    pc.title = 'Download Data & Reports'
    pc.content = 'TBD ...'
end
# download expert text
PageContent.find_or_create_by(name: 'download_expert_text') do |pc|
    puts 'creating page content for download expert text'
    pc.title = 'Experts'
    pc.content = 'TBD ...'
end
# download reform text
PageContent.find_or_create_by(name: 'download_reform_text') do |pc|
    puts 'creating page content for download reform text'
    pc.title = 'Reforms'
    pc.content = 'TBD ...'
end
# download ext ind text
PageContent.find_or_create_by(name: 'download_external_indicator_text') do |pc|
    puts 'creating page content for download external indicators text'
    pc.title = 'External Indicators'
    pc.content = 'TBD ...'
end
# download reports text
PageContent.find_or_create_by(name: 'download_report_text') do |pc|
    puts 'creating page content for download report text'
    pc.title = 'Quarterly Reports'
    pc.content = 'TBD ...'
end



# if the env variable of load_test_data exists, load the data
if ENV['load_test_data'].present?
  puts 'LOADING TEST DATA'
  Quarter.transaction do
    # first clear all data
    puts 'deleting data in database (quarter, reform, experts, survey data, etc'
    Quarter.destroy_all
    Reform.destroy_all
    Expert.destroy_all

    # create reform
    puts 'creating test reform'
    reform = Reform.create(name: 'Test Reform', summary: 'This is a brief summary about the test reform.')

    # create experts
    puts 'creating experts'
    exp1 = Expert.create(name: 'Expert One')
    exp2 = Expert.create(name: 'Expert Two')
    exp3 = Expert.create(name: 'Expert Three')

    # create quarters
    puts 'creating quarters'
    q2 = Quarter.create(year: 2015, quarter: 2, is_public: true)
    q3 = Quarter.create(year: 2015, quarter: 3, is_public: true)
    q4 = Quarter.create(year: 2015, quarter: 4, is_public: true)

    # create expert surveys
    puts 'creating expert surveys'
    es = q2.create_expert_survey(overall_score: 6.4, category1_score: 6, category2_score: 8, category3_score: 5, summary: 'this is a summary')
    es.experts << exp1
    es.experts << exp2

    es = q3.create_expert_survey(overall_score: 5.36, category1_score: 5.8, category2_score: 6, category3_score: 4.5, summary: 'this is a summary')
    es.experts << exp2
    es.experts << exp3

    es = q4.create_expert_survey(overall_score: 6.82, category1_score: 6.5, category2_score: 8.3, category3_score: 5.5, summary: 'this is a summary')
    es.experts << exp1
    es.experts << exp3

    # create reform surveys
    puts 'creating reform surveys'
    q2.reform_surveys.create(reform_id: reform.id, 
            government_overall_score: 63.5,government_category1_score: 70,government_category2_score: 35,government_category3_score: 62,government_category4_score: 80, 
            stakeholder_overall_score: 5.6,stakeholder_category1_score: 6,stakeholder_category2_score: 6.8,stakeholder_category3_score: 4.2,
            summary: 'this is a summary', government_summary: 'this is a government summary', stakeholder_summary: 'this is a stakeholder summary')
    q3.reform_surveys.create(reform_id: reform.id, 
            government_overall_score: 65,government_category1_score: 72,government_category2_score: 38,government_category3_score: 63,government_category4_score: 80, 
            stakeholder_overall_score: 5.36,stakeholder_category1_score: 5.8,stakeholder_category2_score: 6,stakeholder_category3_score: 4.5,
            summary: 'this is a summary', government_summary: 'this is a government summary', stakeholder_summary: 'this is a stakeholder summary')
    q4.reform_surveys.create(reform_id: reform.id, 
            government_overall_score: 66.9,government_category1_score: 73,government_category2_score: 41,government_category3_score: 65,government_category4_score: 82, 
            stakeholder_overall_score: 6.82,stakeholder_category1_score: 6.5,stakeholder_category2_score: 8.3,stakeholder_category3_score: 5.5,
            summary: 'this is a summary', government_summary: 'this is a government summary', stakeholder_summary: 'this is a stakeholder summary')

    puts 'LOADING TEST DATA DONE'
  end
end