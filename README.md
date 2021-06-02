# EasyDataTables

This gem provides a way to create fast tables based on the models of your db. It will expose a helper method `easy_data_table(columns, rows, grouping)`that will output a datatable with the rows and the columns you indicated.

Two links above and below the table will allow you to export it on csv format

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'easy_data_tables'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install easy_data_tables

## Usage

### Helper Method

You will have a method available once you install this gem: `easy_data_table(columns, rows, grouping)` in order to expose it, you need to add `helper EasyDataTables::Engine.helpers` to your app's ApplicationController. You can call this helper method in any view and it will output a table with the data you provide.

### Style
In order to access the style of the application add: 
`@import "easy_data_tables/application";`

to your `application.scss`

### Parameters

#### Columns

Columns are an array of hashes. There are two types of columns: 'normal' and 'combined'

Normal column hashes accept the following keys: 

- **label**: string, default: '' => will inform the label of the column on the table
- **type**: string, default: 'Integer', options: 'Integer', 'Currency', 'Percentage' => will inform the formating of the column
- **default**: any, default: 0 => Will inform the default when a value is not found
- **collection**: ActiveRecord::Relation, **required** => The data of the column (e.g. User.where(active: true)- -
- **agregate_function**: Array of symbols OR symbol, **required** => aggregate function to run (e.g. [:average, :expense] OR :count)
- **column_type**: string => will inform the type of column to use

Cobmbined column hashes accept the following keys: 

- **label**: string, default: '' => will inform the label of the column on the table
- **type**: string, default: 'Integer', options: 'Integer', 'Currency', 'Percentage' => will inform the formating of the column
- **columns**: Array, **required** => Will inform the columns to combine (e.g. ['expenditure', 'user_count'])
- **method**: string, options: 'rate', 'substract', **required** => how to combine the columns to produce the data cell value
- **column_type**: string, **must be set to 'combined'** => will inform the type of column to use

### Rows

Here you must pass an Array of strings to inform the label of each row.

### Grouping

Array of strings where the first string is the grouping method you are calling and the rest are the arguments of said method **e.g.** ['group', 'users.full_name'}



### Example: 

```ruby
easy_data_table(
    [
        {
            label: 'user_count',
            type: 'Integer',
            collection: User.all,
            agregate_function: :count
         },
         {
            label: 'active_user_count',
            type: 'Integer',
            collection: User.where(active: true),
            agregate_function: :count
         },
         {
            label: 'active_user_expense',
            type: 'Currency',
            collection: Expense.joins(:user).where(users: {active: true})
            agregate_function: [:sum, :total]
          },
          {
            column_type: 'combined',
            columns: ['active_user_count', 'user_count'],
            method: 'rate',
            label: 'active_user_rate'
          }
    ],
    User.all.pluck(:status).uniq,
    ['group', 'users.status']
)
            
```
will generate a table that looks like this: 

|            | User count | Active user count | Active user expense | Active User Rate |
|------------|------------|-------------------|---------------------|------------------|
| Premium    | 10         | 8                 | 90 $                | 80 %             |
| Freemium   | 5          | 3                 | 0 $                 | 60 %             |
| Premium ++ | 3          | 1                 | 150 $               | 33.33 %          |

The table has the classes : "table" and "datatable"

in order to have correct looking column labels you must have a I18n file that will have: 

```yaml
en:
  easy_data_tables: 
    data_table:
      user_count: User count
      user_count_title: "Count of all the users that have the row's status"
      active_user_count: Active User Count
      active_user_count_title: Active users for each status
      active_user_expense: Active User Expense
      active_user_expense_title: Sum of the expenses for the active users of each status
      active_user_rate: Active User Rate
      active_user_rate_title: % of active users over total users per status
    download_links:
      download_formated_csv: Download Formated CSV
      download_unformated_csv:  Download Unformated CSV
    
```

On hover on a column label, you will have the title that appears as a tooltip. 



## Contributing

In order to contribute, do not hesitate to fork the repository and submit a pull request. 

Known to-dos: 

- Test the codebase
- Add more methods to combined columns
- Add more types
- As is now, a TOTAL row will be appended at the end, ideally we should be able to provide our own total if we want to overwrite it.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pablocm90/easy_data_tables.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Changelog

### v 0.2.0
- added possibility of downloading the table as a csv (both formated and unformated)
