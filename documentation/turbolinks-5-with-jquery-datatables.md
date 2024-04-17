# Turbolinks 5 with jquery-datatables

## Installation

```shell
# add the necessary gems to your gemfile
gem 'turbolinks', '~>5.0'
gem 'jquery-datatables-rails', '~>3.4'
```

## Fix duplicated fields when browser back button is clicked
###### (especially important when upgrading from an old turbolinks version)

In all concerning javascript or coffeescript files add a "turbolinks:before-cache"
event that destroys the Datatable(coffeescript in this example):

``` coffee
$(document).on "turbolinks:before-cache", ->
  $('{id-or-class-of-your-datatable}').DataTable().destroy()

```
It's important to mention that this will only work if you don't try to remove
custom fields after the table is initialized again or it will throw an exception:

```
Warning: table id={your-datatable-id} - Cannot reinitialise DataTable.
For more information about this error, please see http://datatables.net/tn/3
```
If you additionally need to keep the last "state" of the table you can
add the following line to the DataTable config it concerns:

``` coffee
stateSave: true
```


Other ways to fix this and further(qualified) explanations can be found in this
[article](https://m.phillydevshop.com/turbolinks-5-and-datatables-a882c29d6eff).
