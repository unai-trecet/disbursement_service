# README

Here you can find my proposed solution for the challeged. It took me more time than the timeboxed three hours proposed, I had more time I wanted to do as much as I could. I did it in several takes and not in one sit but I would say it took me around 6-8 hours at least, probably more. I thing this is important and let you have a better picture. Some aspects, like getting to know 'money-rails' and how to use it, took more time than expected.

## Description
The solution is a *Rails 7* app in API mode using a *PostgreSQL* database and *Ruby 3.1.2*.
I had an idea about how to approach it from the beginning and I tried to stick to it. The main principles were:
 1. Use a proper way to handle money.
 2. Separate concerns as much as possible into different actors/services that isolate responsabilities.

The first point made me try 'money-rails' gem and use Money object to handle amounts, specifically in cents. This way we avoid problems dealing with floats (with BigDecimal you can achieve this as well). 
For the second pronciple I created the following elements:
- A service to handle all disbursementsmoney calculations that allow us to extend it and have all this logic encapsulated: OrderDisbursementCalculator
- A service to handle disbursement creation, taking care of data preparation and error handling: *DisbursementCreator*
- A job that allows us to do the creation asynchronously and perform the weekly calculation given the passed date: *CreateWeeklyDisbursementsJob*
- A rake task that would allow us the programming of the task every Monday using Crontab for example.
- A serializer ro do the heavy wait of the presentation layer for disbursements.
- A *disbursements_controller* with an index action exposed to provide disbursement information.

All of these elements have their tests. I approach the task following TDD for almost every element of the solution. I didn´t use any stubbing approach ffor testing, I prefered to use the whole code flow.
The data structures are very straight forward, I've followed the proposed structures.
The weekly generation logic is based on the last seven days from the given date. It could be possible to create a data structure that for example handles the disbursements weekly, an intermidiate class that allows us to associate disbursements and weeks. With this approach we might use week numbers as param as a possibility.

## API Endpoint

There is an endpoint, *disbursements#index*, to request disbursements data. It returns json data and admits a merchant name and a date. In caso no date is given, the response is a *bad_request* error.
If both, date and merchant name are provided, it returns disburments blonging to that merchant that where created within the seven days previous to the passed date.
If only date if provided we pass all the disburments created in that week.

## Further improvements and TODOs
These are the improvements I´d like to tackle with more time:
- Proper seeding to have testing data to, for example, test the api endpoint on a running server.
- Move texts into *en.yml*
- Maybe use *timecop* gem to make date testing more solid.
- Extract all *Logger* calls into a module defining a *log_error(message)* that might be used everywere.
- Set uniqueness of *Merchant* name and cif, similarly for *Sjopper*
- Ensure *Order* and *Disbursement* idempotency: an order must have only one disbursement.
- Move the filtering logic of *disbursements_controller* into a specific service that handles all of it leaving the controller to handle only params and responses.
- Better documentation where is needed.

I hope you find it good enough :)

* Ruby version: *3.1.2*

* Set up

```
bundle install
```

* Database creation
```
rails db:create db:migrate
```
* How to run the test suite
```
rspec spec
```


