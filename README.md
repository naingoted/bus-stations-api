## Quick start ddev

copy .env.example to .env file

install [ddev](https://www.ddev.com/get-started/) and docker desktop

cd into application root dir then run `ddev start`

to find sql port and urls of your local setup type `ddev describe` in your application route folder

type `ddev ssh` to get into applcation container and run following laravel commands

`php artisan migrate && php artisan passport:install`

use db.sql to import data.

You may have to update .env file if you wanna use laravel sail.

## Api Docs

### login

payload `{ "email" : "bradly.vandervort@example.com", "password" : "password" } ` 
post  `https://bus-api.ddev.site/api/v1/login`

### get bus list by bus stop

payload `{ "stationId" : "9" }`
bearer token `access_token` from login
post  `https://bus-api.ddev.site/api/v1/busList`

### create bus
payload `{ "busCode" : "string", "status", "1", "routeId" : "numeric", "stationId" : "numeric"}`
bearer token `access_token` from login
post `https://bus-api.ddev.site/api/v1/buses`

the rest of the routes are in /routes/api.php

### @todo 
validate unique keys pair ['busRouteId', 'stationId'] from BusRouteStation API before inserting into db
db transactions commit and rollback for creating new buses with route and station ids on BusController
