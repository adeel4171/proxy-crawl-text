
******************* Instrutions to run this project *************

The project is build using Ruby on Rails framework

* Make sure that you have correct database configurations. Open database.yml file & mention the correct username & password

- After clone this project, you need to run following command

  1- Run "bundle install command" in the project directory
  2- run "rake db:create"
  3- run "rake db:migrate"
  4- run "rake db:seed"
  5- Run rails server


- To run the crawler you need to visit "http://localhost:3000/amazon_links" & the there will be a link to run the crawler, make sure sidekiq will be in working condition


- The crawler will run in the background & will update the details shortly.

- You can use these Rest Apis for CRUD
     *** To run these apis, make sure JSON request will be sent.. if you use postman then make sure headers accept value is "application/json"

    1- For create, make sure the request type is POST "http://localhost:3000/amazon_links?product_details={name: "abcd1", ratings: "763736"}&url="https://example.com"

    2- For update, make sure the request type is "PATCH" "http://localhost:3000/amazon_links/1?product_details={"name": "abcd"}"

    3- For Show/read make sure the request type is "Get" "http://localhost:3000/amazon_links/1"

    4- For Index/ All items make sure the request type is "Get" "http://localhost:3000/amazon_links"


- The crawler will run on cron automaticlaly on Monday at 10AM. Open the schedule.rb file & you can see here the cron job is mentioned.Here
    are the gems details https://medium.com/@pawlkris/scheduling-tasks-in-rails-with-cron-and-using-the-whenever-gem-34aa68b992e3
    You need to run the whenever --update-crontab at your side to load the cron jobs

- You can vire the data using that link http://localhost:3000/admin/amazon_links, you need to login as credentials are mentioned in the seed file
