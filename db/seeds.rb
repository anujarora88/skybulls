# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Exchange.create(:name => 'NasDaq',
               :logo_url => '/images/wd4d.jpg',
               :starts_at =>   Time.now,
               :ends_at =>  Time.now+2,
               :symbol => 'NASDAQ')

Exchange.create(:name => 'Bombay Stock Exchange',
                :logo_url => '/images/bse.jpg',
                :starts_at =>   Time.now,
                :ends_at =>  Time.now+3,
                :symbol => 'BSE')

Exchange.create(:name => 'Ney York Stock Exchange',
                :logo_url => '/images/nyse.jpg',
                :starts_at =>   Time.now,
                :ends_at =>  Time.now+4,
                :symbol => 'NYSE')

Company.create(name: "Microsoft")
Company.create(name: "Apple")
Company.create(name: "Yahoo")
Company.create(name: "Facebook")
Company.create(name: "Oracle")

Stock.create(company_id: 1, exchange_id: 1, latest_price: Money.new(10000), symbol: "MSFT")
Stock.create(company_id: 2, exchange_id: 1, latest_price: Money.new(10000), symbol: "AAPL")
Stock.create(company_id: 3, exchange_id: 1, latest_price: Money.new(10000), symbol: "YHOO")
Stock.create(company_id: 4, exchange_id: 1, latest_price: Money.new(10000), symbol: "FB")
Stock.create(company_id: 5, exchange_id: 1, latest_price: Money.new(10000), symbol: "ORCL")