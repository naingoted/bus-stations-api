Mac

install [ddev](https://www.ddev.com/get-started/) and docker desktop

cd into application root dir then run `ddev start`

to find sql port and urls of your local setup type `ddev describe` in your application route folder

type `ddev ssh` to get into applcation container and run following laravel commands

`php artisan migrate && php artisan db:seed && php artisan passport:install`


## Api Logic

        find nearest station 
        getBusStationNearBy(lat,lon)
                DB::table("station")
                ->select("station.id"
                    ,DB::raw("6371 * acos(cos(radians(" . $lat . ")) 
                    * cos(radians(posts.lat)) 
                    * cos(radians(posts.lon) - radians(" . $lon . ")) 
                    + sin(radians(" .$lat. ")) 
                    * sin(radians(posts.lat))) AS distance"))
                    ->groupBy("station.id")
                    ->get();
                forEach Station
                    getBusRouteByStationId(id)
                        get busroutestationid from bus_route_stations where station id = id 
                        getBusListByRouteId
                        forEach Bus
                            get arrival time from Get bus_run_actual where busroutestationid= busroutestationid and busId = Bus.id and arrivalTime > now and min(arriavlTime)
                            
                        select busRouteId from bus_route_station where stationId 
                        getBusCode




    once the station is expanded load bus routes
        
    each bus have estimate time of arrival and next bus arrival time.

    
