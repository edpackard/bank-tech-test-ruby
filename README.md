# Bank tech test

![Success](acceptance.png)

- Here is my program meeting the [acceptance criteria](#acceptance-criteria) example below

## Introduction

This is a command line app that uses Ruby to deliver simple banking functionality. It is fully tested with RSpec (100% coverage according to SimpleCov).

I enjoyed this tech test: it allowed me to demonstrate what I've learned so far on the Makers course, while also exposing areas for further practice and improvement both conceptually and in terms of specific Ruby/RSpec skills.

I am happy with my code, and am looking forward to feedback on how to improve it further. My main concerns are the appropriateness (or not) of the Account class unit tests. There is a [full log of my thinking](#progress-log) as the project developed below, as well as the [user stories](#user-stories) and [plan](#class-diagram) that I extracted from the specification.

## Installation

If you do not have `bundler` installed, run `gem install bundler`

Then:

```
git clone https://github.com/edpackard/bank-tech-test-ruby.git
cd bank-tech-test-ruby
bundle install
```

## How to use this program

From the `bank-tech-test` directory, run `irb` and then `require './lib/account.rb`

To make a new account:

`account = Account.new`

Once you have created an account, you can carry out the follow banking operations:

To make a deposit:

`account.deposit(10.00)`

To make a withdrawal:

`account.withdraw(10.00)`

To view your statement:

`account.statement`

Notes:

- There is no overdraft limit.
- You must enter numeric currency values only: `10`, `10.0`, and `10.00` are all fine, `10.000` or `"10.00"` will raise an error.
- There is another public method - `current_balance` - which returns the current balance. This is set as a BigDecimal value to maintain accuracy, so users are encouraged to use the `statement` method to check their balance.

## How to run the tests

```
cd bank-tech-test-ruby
rspec
```

You may need to run `bundle install` in the directory before running `rspec`.
To run an individual test, specify the file path like this:

```
rspec ./spec/account_spec.rb
```

### Technologies used:

- Ruby 2.7.3 (including BigDecimal library)
- Rubocop (linting)
- RSpec (testing)
- SimpleCov (coverage) - 100% coverage
- Timecop (freezing time for tests)

## Specification

### Requirements

- You should be able to interact with your code via a REPL like IRB or the JavaScript console. (You don't need to implement a command line interface that takes input from STDIN.)
- Deposits, withdrawal.
- Account statement (date, amount, balance) printing.
- Data can be kept in memory (it doesn't need to be stored to a database or anything).

### Acceptance criteria

**Given** a client makes a deposit of 1000 on 10-01-2023  
**And** a deposit of 2000 on 13-01-2023  
**And** a withdrawal of 500 on 14-01-2023  
**When** she prints her bank statement  
**Then** she would see

```
date || credit || debit || balance
14/01/2023 || || 500.00 || 2500.00
13/01/2023 || 2000.00 || || 3000.00
10/01/2023 || 1000.00 || || 1000.00
```

## User stories

```
As a client
So that I can undertake banking activities
I want to open a new account

As a client
So that I can save money
I want to deposit money into my account

As a client
So I can spend my savings
I want to withdraw money from my account

As a client
So I can keep track of my transactions
I want the date to be recorded on a deposit or withdrawal

As a client
So that I can see a record of my banking activity
I want to print a statement of my transactions
```

## Class diagram

![Class diagram](plan.png)

## Progress log

### Day 1

- set up local and github repo
- turned requirements into user stories
- modelled a basic class diagram
- set up project with rspec, rubocop, simplecov
- wrote very basic test for Account class - decided more logical to start with Transaction class
- basic withdrawal/deposit tests written and passed
- enjoyed 'transaction initialised with current date' test, as had to mock ('freeze') time
- transaction class done in a fairly simple form: wondering whether to put in edge case testing (i.e. for non-floats) in this class or in Account class: Account class seems most logical place to do this, so Transaction class is then not bound to any restrictions and could hypothetically then be used by other non-float based classes
- end of day 1: have made progress with account class and have tested it with considerable mocking/doubling of transaction class. Code requires refactoring.

### Day 2

- refactored account class
- worked on printer class: wrote tests, wrote big clunky working method, and then refactored
- fixed bug in Account class (exposed by feature test): was sending current balance to transaction before adding/subtracting the current transaction
- (temporarily?) added nil returns on deposit, withdraw, and statement methods in Account to prevent transaction array being logged in the terminal
- have provided messages for withdraw and deposite methods instead of nil return
- have learned about and implemented BigDecimal to handle floating point calculations owing to Ruby float inaccuracies (try `1.40 + 1.60` in irb!): I have decided to use BigDecimal in Transaction class despite earlier thoughts as it seems more straightforward to 'read' the code if BigDecimal used here. May involve extracting some balance logic from Account though.
- have made tests for account more robust - now checks that current balance is sent to a new Transaction instance
- Transaction now calculates balance based on the current_balance sent from Account plus or minus the deposit/withdraw value: this makes it easier to follow the logic
- the only calculation now performed in the Account class is the sum of the transactions array: which is populated with BigDecimal values

### Day 3

- aiming to get this finished today: need to implement non-valid input handling; better time freezing; and general refactoring.
- did some refactoring based on Rubocop's suggestions
- edge cases handled: account class checks if input Numeric, if it is above 0 (using `positive?`, and if it is a valid currency decimal - i.e. no more than two decimal points)
- have added timecop gem to gemfile and added time freezing to feature test and transaction test - really like timecop - very straightforward
- finished up by updating this readme with instructions and reflections
