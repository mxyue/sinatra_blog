class Job < ActiveRecord::Base
  require 'unirest'

  CITIES = ['北京']
  KEY_WORDS = ['ruby', 'ruby on rails', 'go', 'nodejs']

  class << self
    def jobs_query


      CITIES.each do |city|
        KEY_WORDS.each do |key|
          job_count(key, city)
        end
      end
    end

    def job_count(name, city)
      reg_counter = /职位 \( <span>([0-9]+)<\/span>/
      par = {romSearch: true,city: city}
      response = Unirest.get("http://www.lagou.com/jobs/list_#{name}",parameters: par)
      num = reg_counter.match(response.body)[1]
      puts "=职位：#{name}, 数量：#{num}<===="
      job = Job.find_or_create_by(name: name, city: city, num: num, website: 'www.lagou.com', query_date: Date.today )
      puts "创建时间：#{job.created_at}"
    end
  end


end