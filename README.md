# Money Box Rails Backend API

**Money Box** is a web application designed to help you track and manage your stock portfolios all in one place. Equipped with real-time trade data, news and historical stock data, managing your portfolios just got easier.

This is the Ruby on Rails Backend API for **Money Box**. You can access the Frontend [here](https://github.com/PeaWarrior/MoneyBox-front).


## Prerequisites

1. Install [Homebrew](https://brew.sh/)

    ```console
   $ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    ```

2. Install [Ruby](https://www.ruby-lang.org/en/)

    ```console
    $ brew install ruby
    ```

3. Install [Ruby on Rails](https://rubyonrails.org/)

    ```console
    $ gem install rails
    ```

4. Install [PostgreSQL](https://www.postgresql.org/)

    ```console
    $ brew install postgresql
    ```

## Getting Started

1. Clone this repository and `cd` into the directory

2. Install dependencies

    ```console
    $ bundle install
    ```
    
3. Initiate the database and migrate

    ```console
    $ rails db:create db:migrate
    ```

## Initial Configuration
In order to take advantage of all features of **Money Box**, you must secure your own API keys for the following APIs for use.

1. Register for developer API keys for the following:
    * [Finnhub](https://finnhub.io/)
    * [IEX](https://iexcloud.io/)
    * [TD Ameritrade](https://developer.tdameritrade.com/)

2. Create a new `.env` file in the root directory of this project API.

    ```console
    $ touch .env
    ```

3. Add the API keys to your `.env` file by copying the following and replacing the `<...>` with the corrent corresponding key.

    ```env
    IEX_API_KEY=<IEX API KEY HERE>
    FINNHUB_API_KEY=<FINNHUB API KEY HERE>
    TD_AMERITRADE_API_KEY=<TD AMERITRADE API KEY HERE>
    ```
4. Remember to add the `.env` file to your `.gitignore`.

## Starting the Server

```console
$ rails s -p 3001
```

This will start the server on port 3001.